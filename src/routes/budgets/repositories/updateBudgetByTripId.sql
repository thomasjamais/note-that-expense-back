UPDATE budgets
SET
  name = $2,
  amount = $3,
  scope = $4,
  updated_at = now()
WHERE trip_id = $1
RETURNING id, trip_id, name, amount, scope, updated_at;