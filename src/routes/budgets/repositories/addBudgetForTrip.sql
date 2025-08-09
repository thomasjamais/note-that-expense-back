INSERT INTO budgets (
   trip_id,
   name,
   amount,
   currency_id,
   scope,
   created_at,
   updated_at
 ) VALUES (
   $1, $2, $3, $4, $5, now(), now()
 )
RETURNING id;