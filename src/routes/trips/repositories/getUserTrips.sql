SELECT
    id,
    user_id,
    label,
    local_currency_id,
    home_currency_id,
    is_active,
    start_date,
    end_date,
    created_at,
    updated_at
FROM
    trips
WHERE
    user_id = $1
ORDER BY
    start_date DESC;