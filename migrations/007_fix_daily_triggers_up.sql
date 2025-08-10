-- =========================================================
-- 0) Supprimer tout ce qui peut dépendre des anciennes fns
-- =========================================================

-- (A) Les triggers "trip" posés sur daily_expense_stats (migration 004)
DROP TRIGGER IF EXISTS trg_trip_stats_after_insert ON daily_expense_stats;
DROP TRIGGER IF EXISTS trg_trip_stats_after_update ON daily_expense_stats;
DROP TRIGGER IF EXISTS trg_trip_stats_after_delete ON daily_expense_stats;

-- (B) Les triggers "daily" posés sur expenses (migration 003/006)
DROP TRIGGER IF EXISTS trg_daily_stats_insert ON expenses;
DROP TRIGGER IF EXISTS trg_daily_stats_update ON expenses;
DROP TRIGGER IF EXISTS trg_daily_stats_delete ON expenses;

-- (C) Les triggers "trip" posés sur expenses (si déjà tentés par 006)
DROP TRIGGER IF EXISTS trg_trip_stats_insert ON expenses;
DROP TRIGGER IF EXISTS trg_trip_stats_update ON expenses;
DROP TRIGGER IF EXISTS trg_trip_stats_delete ON expenses;

-- (D) Supprimer les anciennes fonctions trigger
DROP FUNCTION IF EXISTS fn_update_daily_stats();
DROP FUNCTION IF EXISTS fn_update_trip_stats();

-- =========================================================
-- 1) Fonctions PURES (paramétrées) — appelables pendant la migration
-- =========================================================

-- (1.1) Recalcule/supprime la ligne (trip, day) de daily_expense_stats
CREATE OR REPLACE FUNCTION refresh_daily_expense_stats_for(p_trip UUID, p_day DATE)
RETURNS VOID AS $$
DECLARE
  v_count        INTEGER;
  v_total_o      NUMERIC;
  v_total_c      NUMERIC;
  v_avg_o        NUMERIC;
  v_avg_c        NUMERIC;
  v_max_o        NUMERIC;
  v_max_c        NUMERIC;
  v_top_category TEXT;
BEGIN
  SELECT
    COUNT(*)::int,
    SUM(original_amount),
    SUM(converted_amount),
    AVG(original_amount),
    AVG(converted_amount),
    MAX(original_amount),
    MAX(converted_amount)
  INTO
    v_count, v_total_o, v_total_c, v_avg_o, v_avg_c, v_max_o, v_max_c
  FROM expenses
  WHERE trip_id = p_trip
    AND date_trunc('day', date)::date = p_day;

  IF COALESCE(v_count, 0) = 0 THEN
    DELETE FROM daily_expense_stats
    WHERE trip_id = p_trip AND day = p_day;
    RETURN;
  END IF;

  SELECT c.label
  INTO v_top_category
  FROM expenses e2
  LEFT JOIN categories c ON c.id = e2.category_id
  WHERE e2.trip_id = p_trip
    AND date_trunc('day', e2.date)::date = p_day
  GROUP BY c.label
  ORDER BY SUM(e2.converted_amount) DESC NULLS LAST
  LIMIT 1;

  INSERT INTO daily_expense_stats AS d
    (trip_id, day, expense_count, total_spent_original, total_spent_converted,
     avg_spent_original, avg_spent_converted, max_spent_original, max_spent_converted, top_category)
  VALUES
    (p_trip, p_day, v_count, v_total_o, v_total_c,
     v_avg_o, v_avg_c, v_max_o, v_max_c, v_top_category)
  ON CONFLICT (trip_id, day) DO UPDATE
    SET expense_count         = EXCLUDED.expense_count,
        total_spent_original  = EXCLUDED.total_spent_original,
        total_spent_converted = EXCLUDED.total_spent_converted,
        avg_spent_original    = EXCLUDED.avg_spent_original,
        avg_spent_converted   = EXCLUDED.avg_spent_converted,
        max_spent_original    = EXCLUDED.max_spent_original,
        max_spent_converted   = EXCLUDED.max_spent_converted,
        top_category          = EXCLUDED.top_category;
END;
$$ LANGUAGE plpgsql;

-- (1.2) Table trip_expense_stats (si pas déjà là avec FK)
CREATE TABLE IF NOT EXISTS trip_expense_stats (
  trip_id                   UUID PRIMARY KEY REFERENCES trips(id) ON DELETE CASCADE,
  day_count                 INTEGER    NOT NULL DEFAULT 0,
  total_spent_original      NUMERIC    NOT NULL DEFAULT 0,
  total_spent_converted     NUMERIC    NOT NULL DEFAULT 0,
  avg_daily_spent_original  NUMERIC    NOT NULL DEFAULT 0,
  avg_daily_spent_converted NUMERIC    NOT NULL DEFAULT 0,
  max_daily_spent_original  NUMERIC    NOT NULL DEFAULT 0,
  max_daily_spent_converted NUMERIC    NOT NULL DEFAULT 0
);

-- (1.3) Recalcule/supprime la ligne du trip dans trip_expense_stats
CREATE OR REPLACE FUNCTION refresh_trip_expense_stats(p_trip UUID)
RETURNS VOID AS $$
DECLARE
  rec RECORD;
BEGIN
  WITH per_day AS (
    SELECT
      date_trunc('day', e.date)::date AS day,
      SUM(e.original_amount)  AS total_o,
      SUM(e.converted_amount) AS total_c
    FROM expenses e
    WHERE e.trip_id = p_trip
    GROUP BY 1
  )
  SELECT
    COUNT(*)::int                 AS day_count,
    COALESCE(SUM(total_o), 0)     AS total_spent_original,
    COALESCE(SUM(total_c), 0)     AS total_spent_converted,
    COALESCE(AVG(total_o), 0)     AS avg_daily_spent_original,
    COALESCE(AVG(total_c), 0)     AS avg_daily_spent_converted,
    COALESCE(MAX(total_o), 0)     AS max_daily_spent_original,
    COALESCE(MAX(total_c), 0)     AS max_daily_spent_converted
  INTO rec
  FROM per_day;

  IF rec.day_count IS NULL OR rec.day_count = 0 THEN
    DELETE FROM trip_expense_stats WHERE trip_id = p_trip;
    RETURN;
  END IF;

  INSERT INTO trip_expense_stats AS t
    (trip_id, day_count, total_spent_original, total_spent_converted,
     avg_daily_spent_original, avg_daily_spent_converted,
     max_daily_spent_original, max_daily_spent_converted)
  VALUES
    (p_trip, rec.day_count, rec.total_spent_original, rec.total_spent_converted,
     rec.avg_daily_spent_original, rec.avg_daily_spent_converted,
     rec.max_daily_spent_original, rec.max_daily_spent_converted)
  ON CONFLICT (trip_id) DO UPDATE
  SET day_count                 = EXCLUDED.day_count,
      total_spent_original      = EXCLUDED.total_spent_original,
      total_spent_converted     = EXCLUDED.total_spent_converted,
      avg_daily_spent_original  = EXCLUDED.avg_daily_spent_original,
      avg_daily_spent_converted = EXCLUDED.avg_daily_spent_converted,
      max_daily_spent_original  = EXCLUDED.max_daily_spent_original,
      max_daily_spent_converted = EXCLUDED.max_daily_spent_converted;
END;
$$ LANGUAGE plpgsql;

-- =========================================================
-- 2) Backfill (n’utilise QUE les fonctions pures)
-- =========================================================

-- Daily : purge d’orphelines puis rebuild
DELETE FROM daily_expense_stats d
WHERE NOT EXISTS (
  SELECT 1 FROM expenses e
  WHERE e.trip_id = d.trip_id
    AND date_trunc('day', e.date)::date = d.day
);

WITH pairs AS (
  SELECT DISTINCT e.trip_id, date_trunc('day', e.date)::date AS day
  FROM expenses e
  WHERE e.trip_id IS NOT NULL
)
SELECT refresh_daily_expense_stats_for(trip_id, day) FROM pairs;

-- Trip : rebuild depuis expenses
WITH trips_with_expenses AS (
  SELECT DISTINCT trip_id FROM expenses WHERE trip_id IS NOT NULL
)
SELECT refresh_trip_expense_stats(trip_id) FROM trips_with_expenses;

-- =========================================================
-- 3) Nouvelles fonctions trigger + triggers sur expenses uniquement
-- =========================================================

-- Daily trigger function
CREATE OR REPLACE FUNCTION fn_update_daily_stats()
RETURNS TRIGGER AS $$
DECLARE
  old_day DATE;
  new_day DATE;
BEGIN
  IF TG_OP = 'INSERT' THEN
    PERFORM refresh_daily_expense_stats_for(NEW.trip_id, date_trunc('day', NEW.date)::date);
  ELSIF TG_OP = 'DELETE' THEN
    PERFORM refresh_daily_expense_stats_for(OLD.trip_id, date_trunc('day', OLD.date)::date);
  ELSIF TG_OP = 'UPDATE' THEN
    old_day := date_trunc('day', OLD.date)::date;
    new_day := date_trunc('day', NEW.date)::date;
    PERFORM refresh_daily_expense_stats_for(OLD.trip_id, old_day);
    IF (NEW.trip_id, new_day) IS DISTINCT FROM (OLD.trip_id, old_day) THEN
      PERFORM refresh_daily_expense_stats_for(NEW.trip_id, new_day);
    END IF;
  END IF;
  RETURN NULL;
END;
$$ LANGUAGE plpgsql;

-- Trip trigger function
CREATE OR REPLACE FUNCTION fn_update_trip_stats()
RETURNS TRIGGER AS $$
BEGIN
  IF TG_OP = 'INSERT' THEN
    PERFORM refresh_trip_expense_stats(NEW.trip_id);
  ELSIF TG_OP = 'DELETE' THEN
    PERFORM refresh_trip_expense_stats(OLD.trip_id);
  ELSIF TG_OP = 'UPDATE' THEN
    PERFORM refresh_trip_expense_stats(OLD.trip_id);
    IF NEW.trip_id IS DISTINCT FROM OLD.trip_id THEN
      PERFORM refresh_trip_expense_stats(NEW.trip_id);
    END IF;
  END IF;
  RETURN NULL;
END;
$$ LANGUAGE plpgsql;

-- Triggers sur expenses
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

CREATE TRIGGER trg_trip_stats_insert
AFTER INSERT ON expenses
FOR EACH ROW
EXECUTE FUNCTION fn_update_trip_stats();

CREATE TRIGGER trg_trip_stats_update
AFTER UPDATE ON expenses
FOR EACH ROW
EXECUTE FUNCTION fn_update_trip_stats();

CREATE TRIGGER trg_trip_stats_delete
AFTER DELETE ON expenses
FOR EACH ROW
EXECUTE FUNCTION fn_update_trip_stats();
