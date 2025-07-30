SELECT
    trip_id,
    day_count,
    total_spent_original,
    total_spent_converted,
    avg_daily_spent_original,
    avg_daily_spent_converted,
    max_daily_spent_original,
    max_daily_spent_converted
  FROM trip_expense_stats
  WHERE trip_id = $1::uuid;