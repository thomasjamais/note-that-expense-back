-- 1) Drop des triggers ajoutés par 007 sur expenses
DROP TRIGGER IF EXISTS trg_daily_stats_insert ON expenses;
DROP TRIGGER IF EXISTS trg_daily_stats_update ON expenses;
DROP TRIGGER IF EXISTS trg_daily_stats_delete ON expenses;

DROP TRIGGER IF EXISTS trg_trip_stats_insert ON expenses;
DROP TRIGGER IF EXISTS trg_trip_stats_update ON expenses;
DROP TRIGGER IF EXISTS trg_trip_stats_delete ON expenses;

-- 2) Drop des fonctions trigger & pures créées par 007
DROP FUNCTION IF EXISTS fn_update_daily_stats();
DROP FUNCTION IF EXISTS fn_update_trip_stats();
DROP FUNCTION IF EXISTS refresh_daily_expense_stats_for(UUID, DATE);
DROP FUNCTION IF EXISTS refresh_trip_expense_stats(UUID);

-- 3) Recréation de l’ancienne fn_update_trip_stats() (style 004)
CREATE OR REPLACE FUNCTION fn_update_trip_stats()
RETURNS TRIGGER AS $$
DECLARE
  rec RECORD;
  v_trip UUID;
BEGIN
  IF TG_OP = 'DELETE' THEN
    v_trip := OLD.trip_id;
  ELSE
    v_trip := NEW.trip_id;
  END IF;

  SELECT
    COUNT(*)                       AS day_count,
    COALESCE(SUM(total_spent_original), 0)  AS total_spent_original,
    COALESCE(SUM(total_spent_converted), 0) AS total_spent_converted,
    COALESCE(AVG(total_spent_original), 0)  AS avg_daily_spent_original,
    COALESCE(AVG(total_spent_converted), 0) AS avg_daily_spent_converted,
    COALESCE(MAX(total_spent_original), 0)  AS max_daily_spent_original,
    COALESCE(MAX(total_spent_converted), 0) AS max_daily_spent_converted
  INTO rec
  FROM daily_expense_stats
  WHERE trip_id = v_trip;

  IF rec.day_count IS NULL OR rec.day_count = 0 THEN
    DELETE FROM trip_expense_stats WHERE trip_id = v_trip;
    RETURN NULL;
  END IF;

  INSERT INTO trip_expense_stats (
    trip_id,
    day_count,
    total_spent_original,
    total_spent_converted,
    avg_daily_spent_original,
    avg_daily_spent_converted,
    max_daily_spent_original,
    max_daily_spent_converted
  ) VALUES (
    v_trip,
    rec.day_count,
    rec.total_spent_original,
    rec.total_spent_converted,
    rec.avg_daily_spent_original,
    rec.avg_daily_spent_converted,
    rec.max_daily_spent_original,
    rec.max_daily_spent_converted
  )
  ON CONFLICT (trip_id) DO UPDATE
    SET day_count                 = EXCLUDED.day_count,
        total_spent_original      = EXCLUDED.total_spent_original,
        total_spent_converted     = EXCLUDED.total_spent_converted,
        avg_daily_spent_original  = EXCLUDED.avg_daily_spent_original,
        avg_daily_spent_converted = EXCLUDED.avg_daily_spent_converted,
        max_daily_spent_original  = EXCLUDED.max_daily_spent_original,
        max_daily_spent_converted = EXCLUDED.max_daily_spent_converted;

  RETURN NULL;
END;
$$ LANGUAGE plpgsql;

-- 4) Ré-attache les triggers sur daily_expense_stats (design 004)
CREATE TRIGGER trg_trip_stats_after_insert
AFTER INSERT ON daily_expense_stats
FOR EACH ROW EXECUTE FUNCTION fn_update_trip_stats();

CREATE TRIGGER trg_trip_stats_after_update
AFTER UPDATE ON daily_expense_stats
FOR EACH ROW EXECUTE FUNCTION fn_update_trip_stats();

CREATE TRIGGER trg_trip_stats_after_delete
AFTER DELETE ON daily_expense_stats
FOR EACH ROW EXECUTE FUNCTION fn_update_trip_stats();
