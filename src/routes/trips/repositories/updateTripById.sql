UPDATE trips
SET
  label = $2,
  local_currency_id = $3,
  home_currency_id = $4,
  is_active = $5,
  start_date = $6,
  end_date = $7
WHERE id = $1 AND user_id = $8
RETURNING id, label, local_currency_id, home_currency_id, is_active, start_date, end_date;