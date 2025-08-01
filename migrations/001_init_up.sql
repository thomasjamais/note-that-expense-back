CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash TEXT NOT NULL,
    lastname VARCHAR(100),
    firstname VARCHAR(100),
    last_login TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE currencies (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    code VARCHAR(10) UNIQUE NOT NULL,
    symbol VARCHAR(10) NOT NULL,
    name VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO public.currencies (id,code,symbol,"name",created_at,updated_at) VALUES
	 ('0d8665a7-7f2b-4545-8e32-15cc87adbca0'::uuid,'EUR','€','Euro','2025-07-18 08:59:32.341','2025-07-18 08:59:32.341'),
	 ('c8a72f2c-846e-4848-b7e2-8d0787444af0'::uuid,'USD','$','United States Dollar','2025-07-18 08:59:32.341','2025-07-18 08:59:32.341'),
	 ('6e48d643-3865-4158-b3a4-ea793df83281'::uuid,'GBP','£','British Pound Sterling','2025-07-18 08:59:32.341','2025-07-18 08:59:32.341'),
	 ('f2d70811-94bc-450d-9d1b-cb88fc7d9491'::uuid,'JPY','¥','Japanese Yen','2025-07-18 08:59:32.341','2025-07-18 08:59:32.341'),
	 ('39de70bc-1b78-4459-a51b-4dda3384ff13'::uuid,'CNY','¥','Chinese Yuan Renminbi','2025-07-18 08:59:32.341','2025-07-18 08:59:32.341'),
	 ('5e8af290-9f61-443d-863c-67cdc1f3401a'::uuid,'INR','₹','Indian Rupee','2025-07-18 08:59:32.341','2025-07-18 08:59:32.341'),
	 ('b266edf1-ec89-47e0-b006-21ec4b1f0b09'::uuid,'AUD','$','Australian Dollar','2025-07-18 08:59:32.341','2025-07-18 08:59:32.341'),
	 ('1b0baf5d-f486-4dd8-a7a8-71099396bc74'::uuid,'CAD','$','Canadian Dollar','2025-07-18 08:59:32.341','2025-07-18 08:59:32.341'),
	 ('99d92a11-77af-4e16-95cf-16dc973aca23'::uuid,'CHF','Fr.','Swiss Franc','2025-07-18 08:59:32.341','2025-07-18 08:59:32.341'),
	 ('fbe7d15e-8286-46e2-a7b5-08b36b62e3cd'::uuid,'NZD','$','New Zealand Dollar','2025-07-18 08:59:32.341','2025-07-18 08:59:32.341');
INSERT INTO public.currencies (id,code,symbol,"name",created_at,updated_at) VALUES
	 ('b860fec3-e55b-4d35-b0ae-89519e6d14f2'::uuid,'RUB','₽','Russian Ruble','2025-07-18 08:59:32.341','2025-07-18 08:59:32.341'),
	 ('5c397bde-2229-4c27-acba-af2708eb0fd0'::uuid,'ZAR','R','South African Rand','2025-07-18 08:59:32.341','2025-07-18 08:59:32.341'),
	 ('a46fc4a5-f12e-4bb0-bbca-9f8d31c5b302'::uuid,'BRL','R$','Brazilian Real','2025-07-18 08:59:32.341','2025-07-18 08:59:32.341'),
	 ('1c6701af-53dc-4d7e-bfde-935ea20cc005'::uuid,'MXN','$','Mexican Peso','2025-07-18 08:59:32.341','2025-07-18 08:59:32.341'),
	 ('129111ff-fcd7-4382-8af8-26536a827648'::uuid,'KRW','₩','South Korean Won','2025-07-18 08:59:32.341','2025-07-18 08:59:32.341'),
	 ('fb45a4eb-fead-4369-9ce0-da480e666b74'::uuid,'SGD','$','Singapore Dollar','2025-07-18 08:59:32.341','2025-07-18 08:59:32.341'),
	 ('e786ddf7-a224-4589-9ad0-938d38a3e447'::uuid,'HKD','$','Hong Kong Dollar','2025-07-18 08:59:32.341','2025-07-18 08:59:32.341'),
	 ('aff4362b-3262-4f96-b201-bf0d9e20ec04'::uuid,'SEK','kr','Swedish Krona','2025-07-18 08:59:32.341','2025-07-18 08:59:32.341'),
	 ('0996f7aa-dcb7-4f16-9064-18d7b163e162'::uuid,'NOK','kr','Norwegian Krone','2025-07-18 08:59:32.341','2025-07-18 08:59:32.341'),
	 ('8e902cd3-baac-4646-8f7f-beded1b6181b'::uuid,'DKK','kr.','Danish Krone','2025-07-18 08:59:32.341','2025-07-18 08:59:32.341');
INSERT INTO public.currencies (id,code,symbol,"name",created_at,updated_at) VALUES
	 ('88ec213f-21d5-4807-9d90-3d2faeda3b3e'::uuid,'PLN','zł','Polish Zloty','2025-07-18 08:59:32.341','2025-07-18 08:59:32.341'),
	 ('98e09e73-8dc6-4cfd-8ff3-dc9fb9574d27'::uuid,'TRY','₺','Turkish Lira','2025-07-18 08:59:32.341','2025-07-18 08:59:32.341'),
	 ('2adc3a76-ef1b-48a8-b920-76393c5a8037'::uuid,'AED','د.إ','United Arab Emirates Dirham','2025-07-18 08:59:32.341','2025-07-18 08:59:32.341'),
	 ('55337f1a-ec3e-4995-8b5b-f06724974626'::uuid,'SAR','ر.س','Saudi Riyal','2025-07-18 08:59:32.341','2025-07-18 08:59:32.341'),
	 ('4ee3e3cf-a082-406c-afd8-fe6de342f6ab'::uuid,'EGP','ج.م','Egyptian Pound','2025-07-18 08:59:32.341','2025-07-18 08:59:32.341'),
	 ('c9c3e612-a211-4a26-b47f-5695ffb4cbc8'::uuid,'THB','฿','Thai Baht','2025-07-18 08:59:32.341','2025-07-18 08:59:32.341'),
	 ('fae0cde3-bd52-4af8-9605-9bc3fe3b4394'::uuid,'MYR','RM','Malaysian Ringgit','2025-07-18 08:59:32.341','2025-07-18 08:59:32.341'),
	 ('55981b53-e9cd-4b40-a101-c84c983b77f9'::uuid,'IDR','Rp','Indonesian Rupiah','2025-07-18 08:59:32.341','2025-07-18 08:59:32.341'),
	 ('d77c05f5-1707-4166-98aa-877004e6649b'::uuid,'PHP','₱','Philippine Peso','2025-07-18 08:59:32.341','2025-07-18 08:59:32.341'),
	 ('391d831a-ae9d-4e79-8d8f-1d86bdc180b7'::uuid,'VND','₫','Vietnamese Dong','2025-07-18 08:59:32.341','2025-07-18 08:59:32.341');


CREATE TABLE trips (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,
    label VARCHAR(255),
    local_currency_id UUID REFERENCES currencies(id) ON DELETE CASCADE,
    home_currency_id UUID REFERENCES currencies(id) ON DELETE CASCADE,
    is_active BOOLEAN DEFAULT TRUE,
    start_date TIMESTAMP,
    end_date TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE categories (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,
    label VARCHAR(255),
    color VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP

);

CREATE TABLE expenses (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,
    category_id UUID REFERENCES categories(id) ON DELETE SET NULL,
    trip_id UUID REFERENCES trips(id) ON DELETE CASCADE,
    original_amount NUMERIC(10, 2) NOT NULL,
    converted_amount NUMERIC(10, 2) NOT NULL,
    label TEXT,
    date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO public.users (id,email,password_hash,lastname,firstname,last_login,created_at) VALUES
	 ('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid,'thomas.jamais95@gmail.com','$2b$10$LhZqopHYgN2NILBFL15GHuCf5lQZZKwEiV7hvV2jDmi9kFQuO0fPi',NULL,NULL,NULL,'2025-07-17 08:41:48.802505');

INSERT INTO public.trips (id,user_id,"label",local_currency_id,home_currency_id,is_active,start_date,end_date,created_at,updated_at) VALUES
	 ('8a36e869-9a16-4c35-8e33-867801f66b88'::uuid,'239c53e2-5fd9-479b-bec0-c72c28500757'::uuid,'Thaïlande ','c9c3e612-a211-4a26-b47f-5695ffb4cbc8'::uuid,'0d8665a7-7f2b-4545-8e32-15cc87adbca0'::uuid,true,'2025-07-03 06:42:00.000',NULL,'2025-07-17 08:42:52.032','2025-07-17 08:42:52.032');

INSERT INTO public.categories (id, user_id, "label", color, created_at, updated_at) VALUES
  ('625f6f71-217d-48ed-8bd0-02c7a713213b'::uuid, '239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, 'Drogue', '#F28B82', '2025-07-18 05:22:18.986', '2025-07-18 05:22:18.986'),
  ('6acefde7-26c5-4cf5-b4c7-f5df03f3c307'::uuid, '239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, 'Transport', '#81C995', '2025-07-18 05:24:36.113', '2025-07-18 05:24:36.113');

INSERT INTO public.categories (id, user_id, label, color, created_at, updated_at) VALUES
  ('36fd01f4-e2cd-4216-9e62-6aeb1efbcf4b'::uuid, '239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, 'Hébergement', '#AECBFA', '2025-07-19 09:32:00', '2025-07-19 09:32:00'),
  ('2ad06a32-16e8-4e4e-b10e-b15c4b68a0fd'::uuid, '239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, 'Nouriture', '#FBCB8B', '2025-07-19 09:32:00', '2025-07-19 09:32:00'),
  ('0118f56e-73fc-4602-a798-64bb46c0d084'::uuid, '239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, 'Boisson', '#A7FFEB', '2025-07-19 09:32:00', '2025-07-19 09:32:00'),
  ('8d2e22c2-c0d2-4658-8c90-b0b3d070e40f'::uuid, '239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, 'Gourmandise', '#FFCDD2', '2025-07-19 09:32:00', '2025-07-19 09:32:00'),
  ('d8983857-b466-4455-b1c9-5aa5df3e9e55'::uuid, '239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, 'Activité', '#D7AEFB', '2025-07-19 09:32:00', '2025-07-19 09:32:00'),
  ('c0c158d3-0168-4cc3-b74b-94c0d06182b8'::uuid, '239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, 'Diver', '#E0E0E0', '2025-07-19 09:32:00', '2025-07-19 09:32:00');

INSERT INTO public.expenses (user_id, category_id, trip_id, original_amount, converted_amount, label, date)
VALUES
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '36fd01f4-e2cd-4216-9e62-6aeb1efbcf4b'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 1024, 26.62, 'Bonita House', '2025-07-03 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '6acefde7-26c5-4cf5-b4c7-f5df03f3c307'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 402, 10.45, 'Grab for hotel', '2025-07-03 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '2ad06a32-16e8-4e4e-b10e-b15c4b68a0fd'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 14, 0.36, 'Eau', '2025-07-03 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '625f6f71-217d-48ed-8bd0-02c7a713213b'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 380, 9.88, 'Beuh', '2025-07-03 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '2ad06a32-16e8-4e4e-b10e-b15c4b68a0fd'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 140, 3.64, 'Repas soir + bière', '2025-07-03 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '0118f56e-73fc-4602-a798-64bb46c0d084'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 50, 1.3, 'Jus pastèque', '2025-07-03 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '0118f56e-73fc-4602-a798-64bb46c0d084'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 60, 1.56, 'Jus mangoustan', '2025-07-04 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '6acefde7-26c5-4cf5-b4c7-f5df03f3c307'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 1391, 36.17, 'Voyage Koh Tao', '2025-07-04 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '36fd01f4-e2cd-4216-9e62-6aeb1efbcf4b'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 562, 14.61, 'Hostel Koh Tao', '2025-07-04 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '0118f56e-73fc-4602-a798-64bb46c0d084'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 75, 1.95, 'café', '2025-07-04 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '0118f56e-73fc-4602-a798-64bb46c0d084'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 22, 0.57, 'eau', '2025-07-04 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '0118f56e-73fc-4602-a798-64bb46c0d084'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 90, 2.34, 'café', '2025-07-04 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '2ad06a32-16e8-4e4e-b10e-b15c4b68a0fd'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 180, 4.68, 'repas soir', '2025-07-04 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '8d2e22c2-c0d2-4658-8c90-b0b3d070e40f'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 25, 0.65, 'Mango sticky rice', '2025-07-04 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '0118f56e-73fc-4602-a798-64bb46c0d084'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 65, 1.69, 'café', '2025-07-05 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '8d2e22c2-c0d2-4658-8c90-b0b3d070e40f'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 65, 1.69, 'café latte', '2025-07-05 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '625f6f71-217d-48ed-8bd0-02c7a713213b'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 430, 11.18, 'beuh et grinder', '2025-07-05 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '0118f56e-73fc-4602-a798-64bb46c0d084'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 84, 2.18, 'eau et café', '2025-07-05 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '2ad06a32-16e8-4e4e-b10e-b15c4b68a0fd'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 50, 1.3, 'diner', '2025-07-05 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '8d2e22c2-c0d2-4658-8c90-b0b3d070e40f'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 85, 2.21, 'latte', '2025-07-05 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '0118f56e-73fc-4602-a798-64bb46c0d084'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 14, 0.36, 'eau', '2025-07-05 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '2ad06a32-16e8-4e4e-b10e-b15c4b68a0fd'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 150, 3.9, 'noix de cajou', '2025-07-06 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, 'c0c158d3-0168-4cc3-b74b-94c0d06182b8'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 342, 8.89, 'Amazon, frai fixe', '2025-07-06 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '8d2e22c2-c0d2-4658-8c90-b0b3d070e40f'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 70, 1.82, 'latte', '2025-07-06 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '6acefde7-26c5-4cf5-b4c7-f5df03f3c307'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 750, 19.5, '3 jours scooter', '2025-07-06 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '625f6f71-217d-48ed-8bd0-02c7a713213b'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 400, 10.4, 'beuh', '2025-07-06 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '6acefde7-26c5-4cf5-b4c7-f5df03f3c307'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 100, 2.6, 'essence', '2025-07-06 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '2ad06a32-16e8-4e4e-b10e-b15c4b68a0fd'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 180, 4.68, 'midi', '2025-07-06 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '2ad06a32-16e8-4e4e-b10e-b15c4b68a0fd'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 250, 6.5, 'soir', '2025-07-06 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '8d2e22c2-c0d2-4658-8c90-b0b3d070e40f'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 170, 4.42, 'latte', '2025-07-07 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '625f6f71-217d-48ed-8bd0-02c7a713213b'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 380, 9.88, 'tabac', '2025-07-07 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '2ad06a32-16e8-4e4e-b10e-b15c4b68a0fd'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 120, 3.12, 'eau mélange cacahuètes', '2025-07-07 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '2ad06a32-16e8-4e4e-b10e-b15c4b68a0fd'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 60, 1.56, 'mangue', '2025-07-07 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '0118f56e-73fc-4602-a798-64bb46c0d084'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 85, 2.21, 'latte', '2025-07-08 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '8d2e22c2-c0d2-4658-8c90-b0b3d070e40f'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 85, 2.21, 'latte', '2025-07-08 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, 'd8983857-b466-4455-b1c9-5aa5df3e9e55'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 8000, 208, 'open water plongée', '2025-07-08 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '36fd01f4-e2cd-4216-9e62-6aeb1efbcf4b'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 900, 23.4, 'carabao', '2025-07-08 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '2ad06a32-16e8-4e4e-b10e-b15c4b68a0fd'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 150, 3.9, 'repas soir', '2025-07-08 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '625f6f71-217d-48ed-8bd0-02c7a713213b'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 200, 5.2, 'bières', '2025-07-08 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '0118f56e-73fc-4602-a798-64bb46c0d084'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 25, 0.65, 'eau', '2025-07-08 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '6acefde7-26c5-4cf5-b4c7-f5df03f3c307'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 500, 13.0, 'scooter', '2025-07-09 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '625f6f71-217d-48ed-8bd0-02c7a713213b'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 800, 20.8, 'beuh', '2025-07-09 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '0118f56e-73fc-4602-a798-64bb46c0d084'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 90, 2.34, 'latte', '2025-07-09 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '6acefde7-26c5-4cf5-b4c7-f5df03f3c307'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 100, 2.6, 'essence', '2025-07-09 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '2ad06a32-16e8-4e4e-b10e-b15c4b68a0fd'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 35, 0.91, 'mango', '2025-07-09 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '2ad06a32-16e8-4e4e-b10e-b15c4b68a0fd'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 340, 8.84, 'repas soir', '2025-07-09 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '625f6f71-217d-48ed-8bd0-02c7a713213b'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 280, 7.28, 'feuilles à rouler', '2025-07-09 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '0118f56e-73fc-4602-a798-64bb46c0d084'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 70, 1.82, 'Latte', '2025-07-10 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '8d2e22c2-c0d2-4658-8c90-b0b3d070e40f'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 85, 2.21, 'ice latte', '2025-07-10 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '0118f56e-73fc-4602-a798-64bb46c0d084'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 160, 4.16, 'mango juices', '2025-07-10 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, 'd8983857-b466-4455-b1c9-5aa5df3e9e55'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 100, 2.6, 'top koh tao viewpoint', '2025-07-10 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '0118f56e-73fc-4602-a798-64bb46c0d084'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 25, 0.65, 'eau', '2025-07-10 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '2ad06a32-16e8-4e4e-b10e-b15c4b68a0fd'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 100, 2.6, 'repas soir', '2025-07-10 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '2ad06a32-16e8-4e4e-b10e-b15c4b68a0fd'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 40, 1.04, 'mangue', '2025-07-10 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, 'd8983857-b466-4455-b1c9-5aa5df3e9e55'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 8000, 208, 'advanced diving', '2025-07-11 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '36fd01f4-e2cd-4216-9e62-6aeb1efbcf4b'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 500, 13.0, 'carabao', '2025-07-11 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '0118f56e-73fc-4602-a798-64bb46c0d084'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 85, 2.21, 'latte', '2025-07-11 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '0118f56e-73fc-4602-a798-64bb46c0d084'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 85, 2.21, 'latte', '2025-07-11 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '2ad06a32-16e8-4e4e-b10e-b15c4b68a0fd'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 330, 8.58, 'kebab', '2025-07-11 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '0118f56e-73fc-4602-a798-64bb46c0d084'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 25, 0.65, 'eau', '2025-07-11 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '625f6f71-217d-48ed-8bd0-02c7a713213b'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 76, 1.98, 'cloppe', '2025-07-11 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '2ad06a32-16e8-4e4e-b10e-b15c4b68a0fd'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 230, 5.98, 'latte + smoothie prot', '2025-07-12 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '6acefde7-26c5-4cf5-b4c7-f5df03f3c307'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 700, 18.2, 'scooter et essence', '2025-07-12 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, 'c0c158d3-0168-4cc3-b74b-94c0d06182b8'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 250, 6.5, 'chaussures ouvertes', '2025-07-12 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '625f6f71-217d-48ed-8bd0-02c7a713213b'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 20, 0.52, 'briquet', '2025-07-12 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '0118f56e-73fc-4602-a798-64bb46c0d084'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 60, 1.56, 'mango juice', '2025-07-12 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '2ad06a32-16e8-4e4e-b10e-b15c4b68a0fd'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 170, 4.42, 'repas soir', '2025-07-12 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '625f6f71-217d-48ed-8bd0-02c7a713213b'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 190, 4.94, 'soju', '2025-07-12 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '625f6f71-217d-48ed-8bd0-02c7a713213b'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 76, 1.98, 'cigarette', '2025-07-12 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '0118f56e-73fc-4602-a798-64bb46c0d084'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 250, 6.5, 'latte', '2025-07-13 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, 'd8983857-b466-4455-b1c9-5aa5df3e9e55'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 1600, 41.6, 'carabao diving', '2025-07-13 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '6acefde7-26c5-4cf5-b4c7-f5df03f3c307'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 100, 2.6, 'essence', '2025-07-13 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, 'c0c158d3-0168-4cc3-b74b-94c0d06182b8'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 750, 19.5, 'masque tuba', '2025-07-13 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '6acefde7-26c5-4cf5-b4c7-f5df03f3c307'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 20, 0.52, 'parking', '2025-07-13 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '0118f56e-73fc-4602-a798-64bb46c0d084'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 20, 0.52, 'eau', '2025-07-13 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '2ad06a32-16e8-4e4e-b10e-b15c4b68a0fd'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 30, 0.78, 'cacahuètes', '2025-07-13 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, 'c0c158d3-0168-4cc3-b74b-94c0d06182b8'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 100, 2.6, 'lessive', '2025-07-13 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '0118f56e-73fc-4602-a798-64bb46c0d084'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 25, 0.65, 'eau', '2025-07-13 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '625f6f71-217d-48ed-8bd0-02c7a713213b'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 76, 1.98, 'cigarette', '2025-07-13 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '625f6f71-217d-48ed-8bd0-02c7a713213b'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 250, 6.5, 'bières', '2025-07-13 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '6acefde7-26c5-4cf5-b4c7-f5df03f3c307'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 624, 16.22, 'ferry koh phangan', '2025-07-14 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '0118f56e-73fc-4602-a798-64bb46c0d084'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 85, 2.21, 'ice latte', '2025-07-14 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '36fd01f4-e2cd-4216-9e62-6aeb1efbcf4b'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 246, 6.4, 'hostel Koh phangan', '2025-07-14 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '0118f56e-73fc-4602-a798-64bb46c0d084'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 180, 4.68, 'mango juice and latte', '2025-07-14 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '625f6f71-217d-48ed-8bd0-02c7a713213b'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 155, 4.03, 'cigarette', '2025-07-14 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '0118f56e-73fc-4602-a798-64bb46c0d084'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 50, 1.3, 'smoothie', '2025-07-14 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '2ad06a32-16e8-4e4e-b10e-b15c4b68a0fd'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 140, 3.64, 'repas soir', '2025-07-14 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '0118f56e-73fc-4602-a798-64bb46c0d084'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 170, 4.48, 'latte', '2025-07-15 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '625f6f71-217d-48ed-8bd0-02c7a713213b'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 1600, 42.23, 'beuh', '2025-07-15 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '0118f56e-73fc-4602-a798-64bb46c0d084'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 25, 0.66, 'eau', '2025-07-15 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '2ad06a32-16e8-4e4e-b10e-b15c4b68a0fd'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 200, 5.28, 'pizza', '2025-07-15 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '8d2e22c2-c0d2-4658-8c90-b0b3d070e40f'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 100, 2.64, 'ice latte', '2025-07-15 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '6acefde7-26c5-4cf5-b4c7-f5df03f3c307'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 600, 15.82, 'scooter+ essence', '2025-07-15 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '625f6f71-217d-48ed-8bd0-02c7a713213b'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 152, 4.01, 'tabac', '2025-07-15 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '0118f56e-73fc-4602-a798-64bb46c0d084'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 18, 0.47, 'eau', '2025-07-15 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '2ad06a32-16e8-4e4e-b10e-b15c4b68a0fd'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 220, 5.81, 'repas soir', '2025-07-15 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '0118f56e-73fc-4602-a798-64bb46c0d084'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 140, 3.71, 'latte x2', '2025-07-16 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, 'd8983857-b466-4455-b1c9-5aa5df3e9e55'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 3500, 92.71, 'kite 1st session', '2025-07-16 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '6acefde7-26c5-4cf5-b4c7-f5df03f3c307'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 100, 2.65, 'essence', '2025-07-16 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '0118f56e-73fc-4602-a798-64bb46c0d084'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 18, 0.48, 'eau', '2025-07-16 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '625f6f71-217d-48ed-8bd0-02c7a713213b'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 18, 0.48, 'briquet', '2025-07-16 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '2ad06a32-16e8-4e4e-b10e-b15c4b68a0fd'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 240, 6.35, 'repas soir', '2025-07-17 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '625f6f71-217d-48ed-8bd0-02c7a713213b'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 76, 2.01, 'cigarette', '2025-07-17 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '36fd01f4-e2cd-4216-9e62-6aeb1efbcf4b'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 1050, 27.82, 'hebergement', '2025-07-17 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '0118f56e-73fc-4602-a798-64bb46c0d084'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 240, 6.37, 'café x3', '2025-07-17 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '0118f56e-73fc-4602-a798-64bb46c0d084'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 18, 0.48, 'eau', '2025-07-17 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '6acefde7-26c5-4cf5-b4c7-f5df03f3c307'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 350, 9.28, 'scooter + essence', '2025-07-17 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '2ad06a32-16e8-4e4e-b10e-b15c4b68a0fd'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 200, 5.3, 'repas soir', '2025-07-17 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '2ad06a32-16e8-4e4e-b10e-b15c4b68a0fd'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 76, 2.02, 'encas', '2025-07-17 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '625f6f71-217d-48ed-8bd0-02c7a713213b'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 95, 2.52, 'bière', '2025-07-17 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '0118f56e-73fc-4602-a798-64bb46c0d084'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 210, 5.57, 'latte x3', '2025-07-18 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '625f6f71-217d-48ed-8bd0-02c7a713213b'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 155, 4.11, 'tabac feuille', '2025-07-18 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, 'd8983857-b466-4455-b1c9-5aa5df3e9e55'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 3500, 92.86, 'kite 2nd session', '2025-07-18 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '0118f56e-73fc-4602-a798-64bb46c0d084'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 120, 0, 'eau and mango smoothie', '2025-07-18 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '2ad06a32-16e8-4e4e-b10e-b15c4b68a0fd'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 90, 2.39, 'repas soir', '2025-07-18 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '0118f56e-73fc-4602-a798-64bb46c0d084'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 50, 1.33, 'watermelon shake', '2025-07-18 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '2ad06a32-16e8-4e4e-b10e-b15c4b68a0fd'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 100, 2.65, 'brochettes', '2025-07-18 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '0118f56e-73fc-4602-a798-64bb46c0d084'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 20, 0.53, 'eau', '2025-07-19 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '0118f56e-73fc-4602-a798-64bb46c0d084'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 220, 5.84, 'latte x3', '2025-07-19 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, 'd8983857-b466-4455-b1c9-5aa5df3e9e55'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 3000, 79.66, 'kite 3rd session', '2025-07-19 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '6acefde7-26c5-4cf5-b4c7-f5df03f3c307'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 850, 22.57, 'scooter et essence', '2025-07-19 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '2ad06a32-16e8-4e4e-b10e-b15c4b68a0fd'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 200, 5.31, 'repas soir', '2025-07-19 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '625f6f71-217d-48ed-8bd0-02c7a713213b'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 80, 2.12, 'feuilles', '2025-07-19 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '6acefde7-26c5-4cf5-b4c7-f5df03f3c307'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 100, 2.66, 'essence', '2025-07-20 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '36fd01f4-e2cd-4216-9e62-6aeb1efbcf4b'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 750, 19.92, 'logement koh phangan', '2025-07-20 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '36fd01f4-e2cd-4216-9e62-6aeb1efbcf4b'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 750, 19.92, 'logement koh phangan', '2025-07-20 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, 'd8983857-b466-4455-b1c9-5aa5df3e9e55'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 1000, 26.55, 'kite 4th session', '2025-07-20 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '0118f56e-73fc-4602-a798-64bb46c0d084'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 140, 3.72, 'latte x2', '2025-07-20 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '0118f56e-73fc-4602-a798-64bb46c0d084'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 70, 1.86, 'lime and orange shake', '2025-07-20 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '2ad06a32-16e8-4e4e-b10e-b15c4b68a0fd'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 130, 3.45, 'nourriture thai', '2025-07-20 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '0118f56e-73fc-4602-a798-64bb46c0d084'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 18, 0.48, 'eau', '2025-07-20 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '625f6f71-217d-48ed-8bd0-02c7a713213b'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 76, 2.02, 'tabac', '2025-07-20 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '2ad06a32-16e8-4e4e-b10e-b15c4b68a0fd'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 80, 2.12, 'plat du soir', '2025-07-20 00:00:00'),
	('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '2ad06a32-16e8-4e4e-b10e-b15c4b68a0fd'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 40, 1.06, 'mangue', '2025-07-20 00:00:00');

INSERT INTO public.expenses (user_id, category_id, trip_id, original_amount, converted_amount, label, date)
VALUES
  -- 21/07/2025
  ('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '0118f56e-73fc-4602-a798-64bb46c0d084'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 150, 3.98, 'mango shake', '2025-07-21 00:00:00'),
  ('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '8d2e22c2-c0d2-4658-8c90-b0b3d070e40f'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 140, 3.72, 'ice latte', '2025-07-21 00:00:00'),
  ('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '625f6f71-217d-48ed-8bd0-02c7a713213b'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 76, 2.02, 'tabac', '2025-07-21 00:00:00'),
  ('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '0118f56e-73fc-4602-a798-64bb46c0d084'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 18, 0.48, 'eau', '2025-07-21 00:00:00'),
  ('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, 'd8983857-b466-4455-b1c9-5aa5df3e9e55'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 2500, 66.36, 'kitesurf 5th session', '2025-07-21 00:00:00'),
  ('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '2ad06a32-16e8-4e4e-b10e-b15c4b68a0fd'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 170, 4.51, 'repas soir', '2025-07-21 00:00:00'),

  -- 22/07/2025
  ('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '0118f56e-73fc-4602-a798-64bb46c0d084'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 160, 4.23, 'latte x2', '2025-07-22 00:00:00'),
  ('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '625f6f71-217d-48ed-8bd0-02c7a713213b'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 110, 2.91, 'feuilles tonc', '2025-07-22 00:00:00'),
  ('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '625f6f71-217d-48ed-8bd0-02c7a713213b'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 76, 2.01, 'tabac', '2025-07-22 00:00:00'),
  ('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '0118f56e-73fc-4602-a798-64bb46c0d084'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 13, 0.34, 'eau', '2025-07-22 00:00:00'),
  ('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '6acefde7-26c5-4cf5-b4c7-f5df03f3c307'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 100, 2.65, 'essence', '2025-07-22 00:00:00'),
  ('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, 'd8983857-b466-4455-b1c9-5aa5df3e9e55'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 3000, 79.40, 'kitesurf 6th session', '2025-07-22 00:00:00'),
  ('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '8d2e22c2-c0d2-4658-8c90-b0b3d070e40f'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 280, 7.42, 'latte x2', '2025-07-22 00:00:00'),
  ('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '6acefde7-26c5-4cf5-b4c7-f5df03f3c307'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 750, 19.89, 'scooter', '2025-07-22 00:00:00'),
  ('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '36fd01f4-e2cd-4216-9e62-6aeb1efbcf4b'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 1100, 29.17, 'hébergement koh phangan', '2025-07-22 00:00:00'),
  ('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '0118f56e-73fc-4602-a798-64bb46c0d084'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 30, 0.80, 'thai tea', '2025-07-22 00:00:00'),
  ('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '2ad06a32-16e8-4e4e-b10e-b15c4b68a0fd'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 120, 3.18, 'repas soir', '2025-07-22 00:00:00'),
  ('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '6acefde7-26c5-4cf5-b4c7-f5df03f3c307'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 365, 9.69, 'koh phangan to koh Samui', '2025-07-22 00:00:00'),
  ('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '2ad06a32-16e8-4e4e-b10e-b15c4b68a0fd'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 60, 1.59, 'brochettes', '2025-07-22 00:00:00'),
  ('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '8d2e22c2-c0d2-4658-8c90-b0b3d070e40f'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 50, 1.32, 'mango mangosteen shake', '2025-07-22 00:00:00'),

  -- 23/07/2025
  ('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '0118f56e-73fc-4602-a798-64bb46c0d084'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 160, 4.24, 'latte x2', '2025-07-23 00:00:00'),
  ('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '8d2e22c2-c0d2-4658-8c90-b0b3d070e40f'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 140, 3.71, 'latte', '2025-07-23 00:00:00'),
  ('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '36fd01f4-e2cd-4216-9e62-6aeb1efbcf4b'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 516, 13.66, '2 nuits koh samui', '2025-07-23 00:00:00'),
  ('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, 'd8983857-b466-4455-b1c9-5aa5df3e9e55'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 3000, 79.17, 'kitesurf last session', '2025-07-23 00:00:00'),
  ('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '0118f56e-73fc-4602-a798-64bb46c0d084'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 15, 0.40, 'eau', '2025-07-23 00:00:00'),
  ('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '625f6f71-217d-48ed-8bd0-02c7a713213b'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 76, 2.01, 'tabac', '2025-07-23 00:00:00'),
  ('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '8d2e22c2-c0d2-4658-8c90-b0b3d070e40f'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 30, 0.79, 'pois aux piments', '2025-07-23 00:00:00'),
  ('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '2ad06a32-16e8-4e4e-b10e-b15c4b68a0fd'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 160, 4.22, 'repas soir', '2025-07-23 00:00:00'),
  ('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '0118f56e-73fc-4602-a798-64bb46c0d084'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 50, 1.32, 'mango mangosteen shake', '2025-07-23 00:00:00'),

  -- 24/07/2025
  ('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '0118f56e-73fc-4602-a798-64bb46c0d084'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 140, 3.69, 'latte x2', '2025-07-24 00:00:00'),
  ('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '6acefde7-26c5-4cf5-b4c7-f5df03f3c307'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 150, 3.95, 'déplacement hotel', '2025-07-24 00:00:00'),
  ('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '6acefde7-26c5-4cf5-b4c7-f5df03f3c307'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 400, 10.56, 'scooter', '2025-07-24 00:00:00'),

  -- 25/07/2025
  ('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '625f6f71-217d-48ed-8bd0-02c7a713213b'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 360, 9.48, 'bieres x3', '2025-07-25 00:00:00'),
  ('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '6acefde7-26c5-4cf5-b4c7-f5df03f3c307'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 100, 2.63, 'essence', '2025-07-25 00:00:00'),
  ('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '0118f56e-73fc-4602-a798-64bb46c0d084'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 15, 0.40, 'eau', '2025-07-25 00:00:00'),
  ('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '625f6f71-217d-48ed-8bd0-02c7a713213b'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 76, 2.00, 'tabac', '2025-07-25 00:00:00'),
  ('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '0118f56e-73fc-4602-a798-64bb46c0d084'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 80, 2.11, 'latte', '2025-07-25 00:00:00'),
  ('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '625f6f71-217d-48ed-8bd0-02c7a713213b'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 76, 2.00, 'clope', '2025-07-25 00:00:00'),
  ('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '2ad06a32-16e8-4e4e-b10e-b15c4b68a0fd'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 49, 1.29, 'lait protéines', '2025-07-25 00:00:00'),
  ('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '625f6f71-217d-48ed-8bd0-02c7a713213b'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 12, 0.32, 'briquet', '2025-07-25 00:00:00'),
  ('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '2ad06a32-16e8-4e4e-b10e-b15c4b68a0fd'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 58, 1.53, 'bao x2', '2025-07-25 00:00:00'),
  ('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '2ad06a32-16e8-4e4e-b10e-b15c4b68a0fd'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 300, 7.91, 'repas soir+ coconut', '2025-07-25 00:00:00'),
  ('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '8d2e22c2-c0d2-4658-8c90-b0b3d070e40f'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 50, 1.32, 'mango lime shake', '2025-07-25 00:00:00'),
  ('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '6acefde7-26c5-4cf5-b4c7-f5df03f3c307'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 80, 2.11, 'essence', '2025-07-25 00:00:00'),

  -- 26/07/2025
  ('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '6acefde7-26c5-4cf5-b4c7-f5df03f3c307'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 600, 15.80, 'scooter', '2025-07-26 00:00:00'),
  ('239c53e2-5fd9-479b-bec0-c72c28500757'::uuid, '36fd01f4-e2cd-4216-9e62-6aeb1efbcf4b'::uuid, '8a36e869-9a16-4c35-8e33-867801f66b88'::uuid, 600, 15.80, 'logement koh samui', '2025-07-26 00:00:00');

CREATE TABLE IF NOT EXISTS exchange_rates (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    base_currency_id UUID NOT NULL REFERENCES currencies(id),
    target_currency_id UUID NOT NULL REFERENCES currencies(id),
    rate NUMERIC(12,6) NOT NULL,
    updated_at TIMESTAMP NOT NULL DEFAULT NOW(),
    UNIQUE (base_currency_id, target_currency_id)
);
