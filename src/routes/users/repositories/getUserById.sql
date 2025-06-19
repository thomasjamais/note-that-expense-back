SELECT id, email, firstname, lastname, created_at
FROM users
WHERE id = $1;