SELECT 
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
FROM daily_expense_stats
WHERE trip_id = $1::uuid
  AND day = COALESCE($2::date, CURRENT_DATE);