INSERT INTO expenses (
    user_id,
    category_id,
    trip_id,
    original_amount,
    converted_amount,
    label,
    date
)
VALUES (
    $1,
    $2,
    $3,
    $4,
    (
        $4 / COALESCE((
            SELECT er.rate
            FROM trips t
            JOIN exchange_rates er 
              ON er.target_currency_id = t.local_currency_id
             AND er.base_currency_id = t.home_currency_id
            WHERE t.id = $3
            LIMIT 1
        ), 1) -- fallback à 1 si pas de taux
    ),
    $5,
    $6 
)
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