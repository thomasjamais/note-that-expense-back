DELETE FROM trips
WHERE id = $1 AND user_id = $2
RETURNING id, label, local_currency_id, home_currency_id, is_active, start_date, end_date;