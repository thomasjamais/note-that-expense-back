SELECT
  b.id,
  b.trip_id,
  b.name,
  b.amount,
  b.currency_id,
  b.scope,
  b.created_at,
  b.updated_at
FROM budgets b
WHERE b.trip_id = $1