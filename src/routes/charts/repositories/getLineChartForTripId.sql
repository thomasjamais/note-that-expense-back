SELECT
    user_id,
    trip_id,
    category_id,
    category_label,
    category_color,
    day,
    total
FROM expense_category_daily_summary
WHERE user_id = $1
  AND trip_id = $2
  AND (
        ($3 = 'total') -- pas de filtre pour 'total'
        OR ($3 = 'week' AND day >= CURRENT_DATE - INTERVAL '6 days')
        OR ($3 = 'month' AND day >= CURRENT_DATE - INTERVAL '30 days')
        OR ($3 = 'custom' AND day BETWEEN $4 AND $5)
      )
ORDER BY day;
