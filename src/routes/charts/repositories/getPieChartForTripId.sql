SELECT
    user_id,
    trip_id,
    category_id,
    category_label,
    category_color,
    SUM(total_amount) AS total_amount
FROM category_totals_by_trip_per_user
WHERE user_id = $1
  AND trip_id = $2
  AND (
        $3 = 'total'
        OR ($3 = 'week' AND day >= CURRENT_DATE - INTERVAL '7 days')
        OR ($3 = 'month' AND day >= date_trunc('month', CURRENT_DATE))
        OR ($3 = 'custom' AND day BETWEEN $4::date AND $5::date)
      )
GROUP BY user_id, trip_id, category_id, category_label, category_color
ORDER BY total_amount DESC;