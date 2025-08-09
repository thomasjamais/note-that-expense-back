DO $$ BEGIN
  CREATE TYPE budget_scope AS ENUM ('total','monthly');
EXCEPTION WHEN duplicate_object THEN NULL; END $$;

CREATE TABLE budgets (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  trip_id UUID NOT NULL REFERENCES trips(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  amount NUMERIC(12,2) NOT NULL,
  currency_id UUID NOT NULL REFERENCES currencies(id),
  scope budget_scope NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  CONSTRAINT uniq_budget_per_trip UNIQUE (trip_id)
);

CREATE OR REPLACE FUNCTION set_updated_at() RETURNS TRIGGER AS $$
BEGIN NEW.updated_at = now(); RETURN NEW; END; $$ LANGUAGE plpgsql;

CREATE TRIGGER trg_budgets_updated_at
BEFORE UPDATE ON budgets
FOR EACH ROW EXECUTE FUNCTION set_updated_at();

CREATE OR REPLACE VIEW budget_usage_current AS
SELECT
  b.id              AS budget_id,
  b.trip_id,
  b.name,
  b.scope,
  b.amount          AS budget_amount,
  b.currency_id,
  CASE 
    WHEN b.scope = 'monthly' THEN date_trunc('month', CURRENT_DATE)::date
    ELSE t.start_date::date
  END AS period_start,
  CASE 
    WHEN b.scope = 'monthly' THEN (date_trunc('month', CURRENT_DATE) + INTERVAL '1 month - 1 day')::date
    ELSE COALESCE(t.end_date::date, CURRENT_DATE)
  END AS period_end,
  COALESCE(
    SUM(e.converted_amount) FILTER (
      WHERE e.trip_id = b.trip_id
        AND e.date::date BETWEEN
          CASE 
            WHEN b.scope = 'monthly' THEN date_trunc('month', CURRENT_DATE)::date
            ELSE t.start_date::date
          END
          AND
          CASE 
            WHEN b.scope = 'monthly' THEN (date_trunc('month', CURRENT_DATE) + INTERVAL '1 month - 1 day')::date
            ELSE COALESCE(t.end_date::date, CURRENT_DATE)
          END
    ), 0
  ) AS spent_converted
FROM budgets b
JOIN trips t ON t.id = b.trip_id
LEFT JOIN expenses e ON e.trip_id = b.trip_id
GROUP BY b.id, t.start_date, t.end_date;
