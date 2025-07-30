CREATE TABLE IF NOT EXISTS trip_expense_stats (
  trip_id                     UUID    NOT NULL PRIMARY KEY,
  day_count                   INTEGER NOT NULL DEFAULT 0,
  total_spent_original        NUMERIC NOT NULL DEFAULT 0,
  total_spent_converted       NUMERIC NOT NULL DEFAULT 0,
  avg_daily_spent_original    NUMERIC NOT NULL DEFAULT 0,
  avg_daily_spent_converted   NUMERIC NOT NULL DEFAULT 0,
  max_daily_spent_original    NUMERIC NOT NULL DEFAULT 0,
  max_daily_spent_converted   NUMERIC NOT NULL DEFAULT 0
);

INSERT INTO trip_expense_stats (
  trip_id,
  day_count,
  total_spent_original,
  total_spent_converted,
  avg_daily_spent_original,
  avg_daily_spent_converted,
  max_daily_spent_original,
  max_daily_spent_converted
)
SELECT
  trip_id,
  COUNT(*)                                        AS day_count,
  SUM(total_spent_original)                       AS total_spent_original,
  SUM(total_spent_converted)                      AS total_spent_converted,
  AVG(total_spent_original)                       AS avg_daily_spent_original,
  AVG(total_spent_converted)                      AS avg_daily_spent_converted,
  MAX(total_spent_original)                       AS max_daily_spent_original,
  MAX(total_spent_converted)                      AS max_daily_spent_converted
FROM daily_expense_stats
GROUP BY trip_id
ON CONFLICT (trip_id) DO UPDATE
  SET
    day_count                 = EXCLUDED.day_count,
    total_spent_original      = EXCLUDED.total_spent_original,
    total_spent_converted     = EXCLUDED.total_spent_converted,
    avg_daily_spent_original  = EXCLUDED.avg_daily_spent_original,
    avg_daily_spent_converted = EXCLUDED.avg_daily_spent_converted,
    max_daily_spent_original  = EXCLUDED.max_daily_spent_original,
    max_daily_spent_converted = EXCLUDED.max_daily_spent_converted
;

CREATE OR REPLACE FUNCTION fn_update_trip_stats()
RETURNS TRIGGER AS $$
DECLARE
  rec RECORD;
BEGIN
  SELECT
    COUNT(*)                AS day_count,
    SUM(total_spent_original)    AS total_spent_original,
    SUM(total_spent_converted)   AS total_spent_converted,
    AVG(total_spent_original)    AS avg_daily_spent_original,
    AVG(total_spent_converted)   AS avg_daily_spent_converted,
    MAX(total_spent_original)    AS max_daily_spent_original,
    MAX(total_spent_converted)   AS max_daily_spent_converted
  INTO rec
  FROM daily_expense_stats
  WHERE trip_id = NEW.trip_id;

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
    NEW.trip_id,
    rec.day_count,
    rec.total_spent_original,
    rec.total_spent_converted,
    rec.avg_daily_spent_original,
    rec.avg_daily_spent_converted,
    rec.max_daily_spent_original,
    rec.max_daily_spent_converted
  )
  ON CONFLICT (trip_id) DO UPDATE
    SET
      day_count                 = EXCLUDED.day_count,
      total_spent_original      = EXCLUDED.total_spent_original,
      total_spent_converted     = EXCLUDED.total_spent_converted,
      avg_daily_spent_original  = EXCLUDED.avg_daily_spent_original,
      avg_daily_spent_converted = EXCLUDED.avg_daily_spent_converted,
      max_daily_spent_original  = EXCLUDED.max_daily_spent_original,
      max_daily_spent_converted = EXCLUDED.max_daily_spent_converted
  ;

  RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_trip_stats_after_insert
AFTER INSERT ON daily_expense_stats
FOR EACH ROW EXECUTE FUNCTION fn_update_trip_stats();

CREATE TRIGGER trg_trip_stats_after_update
AFTER UPDATE ON daily_expense_stats
FOR EACH ROW EXECUTE FUNCTION fn_update_trip_stats();

CREATE TRIGGER trg_trip_stats_after_delete
AFTER DELETE ON daily_expense_stats
FOR EACH ROW
  EXECUTE FUNCTION fn_update_trip_stats();
