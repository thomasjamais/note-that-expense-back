DELETE FROM expenses
WHERE user_id = $1
AND trip_id = $2
AND id = $3
RETURNING
    id;