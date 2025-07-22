DELETE FROM categories 
WHERE id = $1
AND user_id = $2
RETURNING id, user_id, label, color, created_at, updated_at;