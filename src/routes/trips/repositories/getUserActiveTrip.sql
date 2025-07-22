SELECT
    trips.id as id,
    user_id,
    label,
    local_currency_id,
    home_currency_id,
    local_currency.symbol AS local_currency_symbol,
    home_currency.symbol AS home_currency_symbol,
    local_currency.name AS local_currency_name,
    home_currency.name AS home_currency_name,
    is_active,
    start_date,
    end_date,
    trips.created_at as created_at,
    trips.updated_at as updated_at
FROM
    trips
INNER JOIN currencies AS local_currency ON trips.local_currency_id = local_currency.id
INNER JOIN currencies AS home_currency ON trips.home_currency_id = home_currency.id
WHERE
    user_id = $1
    AND is_active = TRUE;