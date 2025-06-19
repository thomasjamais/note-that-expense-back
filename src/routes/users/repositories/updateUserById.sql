UPDATE users
SET
    email = LOWER(COALESCE($2, email)),
    firstname = LOWER(COALESCE($3, firstname)),
    lastname = LOWER(COALESCE($4, lastname)),
    phone_number = LOWER(COALESCE($5, phone_number)),
    address_line1 = LOWER(COALESCE($6, address_line1)),
    address_line2 = LOWER(COALESCE($7,   address_line2)),
    city = LOWER(COALESCE($8, city)),
    zipcode = LOWER(COALESCE($9, zipcode)),
    country = LOWER(COALESCE($10, country))
WHERE id = $1
RETURNING
    id,
    email,
    firstname,
    lastname,
    is_seller,
    is_active,
    phone_number,
    address_line1,
    address_line2,
    city,
    zipcode,
    country,
    profile_picture_url,
    birth_date,
    last_login,
    created_at;