SELECT
    expenses.id,
    expenses.user_id,
    category_id,
    categories.label AS category_label,
    categories.color AS category_color,
    trip_id,
    original_amount,
    converted_amount,
    expenses.label,
    date,
    expenses.created_at,
    expenses.updated_at
FROM expenses
INNER JOIN categories ON expenses.category_id = categories.id
WHERE trip_id = $2
AND expenses.user_id = $1
ORDER BY date DESC;