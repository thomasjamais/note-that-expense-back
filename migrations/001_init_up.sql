-- Schéma PostgreSQL pour une marketplace

-- Utilisateur
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash TEXT NOT NULL,
    lastname VARCHAR(100),
    firstname VARCHAR(100),
    is_seller BOOLEAN DEFAULT FALSE,
    is_active BOOLEAN DEFAULT TRUE,
    phone_number VARCHAR(50),
    address_line1 VARCHAR(255),
    address_line2 VARCHAR(255),
    city VARCHAR(100),
    zipcode VARCHAR(20),
    country VARCHAR(100),
    profile_picture_url TEXT,
    birth_date DATE,
    last_login TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Adresse de livraison
CREATE TABLE shipping_adress (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES users(id),
    line1 VARCHAR(255),
    line2 VARCHAR(255),
    city VARCHAR(100),
    zipcode VARCHAR(20),
    country VARCHAR(100),
    phone_number VARCHAR(50)
);

-- Catégorie
CREATE TABLE categories (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(100) NOT NULL,
    slug VARCHAR(100) UNIQUE NOT NULL,
    description TEXT
);

-- Table des sous-catégories
CREATE TABLE subcategories (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  category_id UUID NOT NULL REFERENCES categories(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  description TEXT NOT NULL,
  slug VARCHAR(100) UNIQUE NOT NULL
);

-- Produit
CREATE TABLE products (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    seller_id UUID REFERENCES users(id),
    title VARCHAR(255) NOT NULL,
    description TEXT,
    price INTEGER NOT NULL CHECK (price >= 0),
    stock INTEGER DEFAULT 1 CHECK (stock >= 0),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    category_id UUID REFERENCES categories(id),
    subcategory_id UUID REFERENCES subcategories(id),
    actif BOOLEAN DEFAULT TRUE,
    approuve BOOLEAN DEFAULT FALSE
);

-- Images associées au produit
CREATE TABLE product_pictures (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    product_id UUID REFERENCES products(id),
    url TEXT NOT NULL
);

-- Avis sur un produit
CREATE TABLE product_review (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    product_id UUID REFERENCES products(id),
    user_id UUID REFERENCES users(id),
    note INTEGER CHECK (note BETWEEN 1 AND 5),
    comment TEXT,
    date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Commande
CREATE TABLE orders (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    buyer_id UUID REFERENCES users(id),
    shipping_adress_id UUID REFERENCES shipping_adress(id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(50) DEFAULT 'en_attente'
);

-- Ligne de commande
CREATE TABLE line_orders (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    order_id UUID REFERENCES orders(id),
    product_id UUID REFERENCES products(id),
    quantite INTEGER NOT NULL CHECK (quantite > 0),
    price INTEGER NOT NULL CHECK (price >= 0)
);

-- Paiement
CREATE TABLE paiements (
    id SERIAL PRIMARY KEY,
    order_id UUID REFERENCES orders(id),
    amount INTEGER NOT NULL CHECK (amount >= 0),
    method VARCHAR(50),
    status VARCHAR(50) DEFAULT 'en_attente',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    transaction_ref VARCHAR(255)
);
