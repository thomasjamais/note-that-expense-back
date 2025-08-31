UPDATE trips
SET is_active = FALSE
WHERE user_id = $1::uuid 
  AND id != $2::uuid
  AND is_active = TRUE;

