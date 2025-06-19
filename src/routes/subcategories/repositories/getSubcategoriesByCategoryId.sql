SELECT * FROM subcategories
WHERE category_id = $1
ORDER BY name;