SELECT
  budget_id,
  name,
  trip_id,
  scope,
  budget_amount,
  currency_id,
  period_start,
  period_end,
  spent_converted
FROM budget_usage_current
WHERE trip_id = $1
  AND (
    scope = 'total'
    OR (scope = 'monthly' AND CURRENT_DATE BETWEEN period_start AND period_end)
  );