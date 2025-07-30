CREATE TABLE IF NOT EXISTS daily_expense_stats (
  trip_id               UUID       NOT NULL,
  day                   DATE       NOT NULL,
  expense_count         INTEGER    NOT NULL DEFAULT 0,
  total_spent_original  NUMERIC    NOT NULL DEFAULT 0,
  total_spent_converted NUMERIC    NOT NULL DEFAULT 0,
  avg_spent_original    NUMERIC    NOT NULL DEFAULT 0,
  avg_spent_converted   NUMERIC    NOT NULL DEFAULT 0,
  max_spent_original    NUMERIC    NOT NULL DEFAULT 0,
  max_spent_converted   NUMERIC    NOT NULL DEFAULT 0,
  top_category          TEXT,
  PRIMARY KEY (trip_id, day)
);

INSERT INTO daily_expense_stats (
  trip_id,
  day,
  expense_count,
  total_spent_original,
  total_spent_converted,
  avg_spent_original,
  avg_spent_converted,
  max_spent_original,
  max_spent_converted,
  top_category
)
SELECT
  sd.trip_id,
  sd.day,
  sd.expense_count,
  sd.total_spent_original,
  sd.total_spent_converted,
  sd.avg_spent_original,
  sd.avg_spent_converted,
  sd.max_spent_original,
  sd.max_spent_converted,
  top.category_label
FROM (
  SELECT
    trip_id,
    date_trunc('day', date)::date AS day,
    COUNT(*)                   AS expense_count,
    SUM(original_amount)       AS total_spent_original,
    SUM(converted_amount)      AS total_spent_converted,
    AVG(original_amount)       AS avg_spent_original,
    AVG(converted_amount)      AS avg_spent_converted,
    MAX(original_amount)       AS max_spent_original,
    MAX(converted_amount)      AS max_spent_converted
  FROM expenses
  GROUP BY trip_id, date_trunc('day', date)::date
) sd
LEFT JOIN LATERAL (
  SELECT c.label AS category_label
  FROM expenses e2
  JOIN categories c
    ON c.id = e2.category_id
  WHERE e2.trip_id = sd.trip_id
    AND date_trunc('day', e2.date)::date = sd.day
  GROUP BY c.label
  ORDER BY SUM(e2.converted_amount) DESC
  LIMIT 1
) top ON true
ON CONFLICT (trip_id, day) DO UPDATE
  SET
    expense_count         = EXCLUDED.expense_count,
    total_spent_original  = EXCLUDED.total_spent_original,
    total_spent_converted = EXCLUDED.total_spent_converted,
    avg_spent_original    = EXCLUDED.avg_spent_original,
    avg_spent_converted   = EXCLUDED.avg_spent_converted,
    max_spent_original    = EXCLUDED.max_spent_original,
    max_spent_converted   = EXCLUDED.max_spent_converted,
    top_category          = EXCLUDED.top_category;

CREATE OR REPLACE FUNCTION fn_update_daily_stats()
RETURNS TRIGGER AS $$
DECLARE
  target_day DATE;
  t_trip     UUID;
  rec        RECORD;
BEGIN
  IF TG_OP = 'DELETE' THEN
    target_day := date_trunc('day', OLD.date)::date;
    t_trip     := OLD.trip_id;
  ELSE
    target_day := date_trunc('day', NEW.date)::date;
    t_trip     := NEW.trip_id;
  END IF;

  WITH day_agg AS (
    SELECT
      COUNT(*)                   AS expense_count,
      SUM(original_amount)       AS total_spent_original,
      SUM(converted_amount)      AS total_spent_converted,
      AVG(original_amount)       AS avg_spent_original,
      AVG(converted_amount)      AS avg_spent_converted,
      MAX(original_amount)       AS max_spent_original,
      MAX(converted_amount)      AS max_spent_converted,
      (
        SELECT c.label
        FROM expenses e2
        JOIN categories c ON c.id = e2.category_id
        WHERE e2.trip_id = t_trip
          AND date_trunc('day', e2.date)::date = target_day
        GROUP BY c.label
        ORDER BY SUM(e2.converted_amount) DESC
        LIMIT 1
      ) AS top_category
    FROM expenses
    WHERE trip_id = t_trip
      AND date_trunc('day', date)::date = target_day
  )
  INSERT INTO daily_expense_stats AS d
    (trip_id, day, expense_count, total_spent_original, total_spent_converted,
     avg_spent_original, avg_spent_converted, max_spent_original, max_spent_converted, top_category)
  SELECT
    t_trip, target_day,
    expense_count, total_spent_original, total_spent_converted,
    avg_spent_original, avg_spent_converted,
    max_spent_original, max_spent_converted, top_category
  FROM day_agg
  ON CONFLICT (trip_id, day) DO UPDATE
    SET
      expense_count         = EXCLUDED.expense_count,
      total_spent_original  = EXCLUDED.total_spent_original,
      total_spent_converted = EXCLUDED.total_spent_converted,
      avg_spent_original    = EXCLUDED.avg_spent_original,
      avg_spent_converted   = EXCLUDED.avg_spent_converted,
      max_spent_original    = EXCLUDED.max_spent_original,
      max_spent_converted   = EXCLUDED.max_spent_converted,
      top_category          = EXCLUDED.top_category;

  RETURN NULL; 
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_daily_stats_insert
AFTER INSERT ON expenses
FOR EACH ROW
EXECUTE FUNCTION fn_update_daily_stats();

CREATE TRIGGER trg_daily_stats_update
AFTER UPDATE ON expenses
FOR EACH ROW
EXECUTE FUNCTION fn_update_daily_stats();

CREATE TRIGGER trg_daily_stats_delete
AFTER DELETE ON expenses
FOR EACH ROW
EXECUTE FUNCTION fn_update_daily_stats();