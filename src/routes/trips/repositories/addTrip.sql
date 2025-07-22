INSERT INTO trips (
    user_id, 
    label, 
    local_currency_id, 
    home_currency_id,
    is_active,
    start_date, 
    end_date) 
VALUES
($1::uuid, $2, $3::uuid, $4::uuid, $5, $6, $7)
RETURNING 
    id, 
    user_id, 
    label, 
    local_currency_id, 
    home_currency_id, 
    is_active, 
    start_date, 
    end_date, 
    created_at, 
    updated_at;