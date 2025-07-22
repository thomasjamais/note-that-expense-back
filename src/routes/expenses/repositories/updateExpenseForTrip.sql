UPDATE expenses
SET
  label = $4,
  original_amount = $5,
    converted_amount = (
        $5 / COALESCE((
        SELECT er.rate
        FROM trips t
        JOIN exchange_rates er 
            ON er.target_currency_id = t.local_currency_id
         AND er.base_currency_id = t.home_currency_id
        WHERE t.id = $2
        LIMIT 1
        ), 1) 
    ),
  category_id = $7,
  date = $6
WHERE
  id = $1
  AND trip_id = $2
  AND user_id = $3
RETURNING
  id,
  user_id,
  category_id,
  trip_id,
  original_amount,
  converted_amount,
  label,
  date,
  created_at,
  updated_at;
