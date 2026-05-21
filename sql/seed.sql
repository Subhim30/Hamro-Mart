USE hamromart_db;

-- Seed Admin and Customer accounts
-- The passwords here are represented in plain text but will be hashed in the Java code via PasswordUtil (e.g. SHA-256 / SHA-256 with salt)
-- Let's insert standard accounts. We will seed pre-hashed passwords if PasswordUtil implements hashing.
-- If PasswordUtil uses standard SHA-256 for "admin123" it is: '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918'
-- If PasswordUtil uses standard SHA-256 for "user123" it is: '5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8'
INSERT INTO users (name, email, password, role, phone, address) VALUES
('Admin User', 'admin@hamromart.com', '240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9', 'ADMIN', '+977-9801234567', 'Kathmandu, Nepal'),
('Rubina Gurung', 'rubina@gmail.com', 'e606e38b0d8c19b24cf0ee3808183162ea7cd63ff7912dbb22b5e803286b4446', 'CUSTOMER', '+977-9812345678', 'Lalitpur, Nepal');

-- Seed Categories
INSERT INTO categories (id, name, description, icon) VALUES
(1, 'Fruits & Vegetables', 'Fresh farm-picked organic fruits and vegetables.', 'fa-carrot'),
(2, 'Dairy & Eggs', 'Milk, butter, cheese, yogurt, and fresh eggs.', 'fa-cheese'),
(3, 'Bakery & Bread', 'Freshly baked breads, pastries, cookies, and cakes.', 'fa-bread-slice'),
(4, 'Beverages', 'Juices, soda, tea, coffee, and energy drinks.', 'fa-coffee'),
(5, 'Meat & Seafood', 'Fresh chicken, mutton, fish, and pork.', 'fa-drumstick-bite'),
(6, 'Organic Grains & Spices', 'Pure Basmati rice, mustard oils, and rich local spices.', 'fa-seedling'),
(7, 'Snacks & Confectionery', 'Crunchy potato chips, dark chocolates, and freshly baked cookies.', 'fa-cookie'),
(8, 'Household & Hygiene', 'Dishwashing liquids, laundry soaps, sanitizers, and home supplies.', 'fa-pump-soap');

-- Seed Products
INSERT INTO products (name, description, price, stock, unit, category_id, image_url) VALUES
-- Fruits & Vegetables (Category 1)
('Organic Red Apples', 'Sweet and crisp organic red apples imported from Mustang.', 250.00, 100, 'kg', 1, 'https://images.unsplash.com/photo-1560806887-1e4cd0b6cbd6?w=400&q=80'),
('Fresh Organic Carrots', 'Crisp, nutritious organic carrots harvested from local farms.', 90.00, 150, 'kg', 1, 'https://images.unsplash.com/photo-1598170845058-32b9d6a5da37?w=400&q=80'),
('Fresh Cavendish Bananas', 'Sweet and perfectly ripe Cavendish bananas.', 120.00, 200, 'dozen', 1, 'https://images.unsplash.com/photo-1571771894821-ce9b6c11b08e?w=400&q=80'),
('Organic Spinach', 'Fresh green spinach leaves, washed and ready to cook.', 40.00, 50, 'bundle', 1, 'https://images.unsplash.com/photo-1576045057995-568f588f82fb?w=400&q=80'),
('Fresh Avocado', 'Creamy, nutrient-rich organic avocados.', 320.00, 60, 'kg', 1, 'https://images.unsplash.com/photo-1523049673857-eb18f1d7b578?w=400&q=80'),
('Local Red Tomatoes', 'Juicy and fresh local farm-picked red tomatoes.', 80.00, 120, 'kg', 1, 'https://images.unsplash.com/photo-1595855759920-86582396756a?w=400&q=80'),

-- Dairy & Eggs (Category 2)
('Fresh Whole Milk', 'Pasteurized high-cream whole cow milk.', 95.00, 80, 'ltr', 2, 'https://images.unsplash.com/photo-1563636619-e9143da7973b?w=400&q=80'),
('Salted Butter', 'Premium creamy salted table butter.', 180.00, 60, 'pkt', 2, 'https://images.unsplash.com/photo-1589985270826-4b7bb135bc9d?w=400&q=80'),
('Farm Fresh Eggs', 'Dozen premium quality farm fresh brown eggs.', 160.00, 120, 'dozen', 2, 'https://images.unsplash.com/photo-1516448620398-c5f44bf9f441?w=400&q=80'),
('Greek Yogurt', 'Fresh, rich, and creamy natural Greek yogurt.', 140.00, 50, 'cup', 2, 'https://images.unsplash.com/photo-1488477181946-6428a0291777?w=400&q=80'),

-- Bakery & Bread (Category 3)
('Brown Sliced Bread', 'Freshly baked whole wheat sliced sandwich bread.', 75.00, 40, 'pkt', 3, 'https://images.unsplash.com/photo-1509440159596-0249088772ff?w=400&q=80'),
('Chocolate Chip Cookies', 'Delicious oven-fresh cookies loaded with chocolate chips.', 150.00, 30, 'pkt', 3, 'https://images.unsplash.com/photo-1499636136210-6f4ee915583e?w=400&q=80'),

-- Beverages (Category 4)
('Orange Juice', '100% natural, freshly squeezed, no sugar added orange juice.', 199.00, 50, 'ltr', 4, 'https://images.unsplash.com/photo-1613478223719-2ab802602423?w=400&q=80'),
('Premium Green Tea', 'Organic green tea leaves rich in antioxidants.', 220.00, 75, 'pkt', 4, 'https://images.unsplash.com/photo-1627435601361-ec25f5b1d0e5?w=400&q=80'),

-- Meat & Seafood (Category 5)
('Fresh Chicken Breast', 'Skinless and boneless fresh chicken breast.', 420.00, 35, 'kg', 5, 'https://images.unsplash.com/photo-1604503468506-a8da13d82791?w=400&q=80'),
('Fresh Salmon Fillet', 'Premium wild-caught fresh salmon fillet.', 1500.00, 15, 'kg', 5, 'https://images.unsplash.com/photo-1519708227418-c8fd9a32b7a2?w=400&q=80'),
('Fresh Mutton Keema', 'Freshly ground lean mutton mince meat.', 1100.00, 25, 'kg', 5, 'https://images.unsplash.com/photo-1544025162-d76694265947?w=400&q=80'),

-- Organic Grains & Spices (Category 6)
('Premium Basmati Rice', 'Fragrant long-grain premium basmati rice for daily meals.', 1650.00, 40, '5kg', 6, 'https://images.unsplash.com/photo-1586201375761-83865001e31c?w=400&q=80'),
('Pure Mustard Oil', 'Cold-pressed traditional pure mustard cooking oil.', 290.00, 90, 'ltr', 6, 'https://images.unsplash.com/photo-1474979266404-7eaacbcd87c5?w=400&q=80'),
('Organic Turmeric Powder', 'Rich and aromatic ground local turmeric powder.', 120.00, 100, '200g', 6, 'https://images.unsplash.com/photo-1615485290382-441e4d049cb5?w=400&q=80'),

-- Snacks & Confectionery (Category 7)
('Potato Chips (Classic)', 'Crisp salted potato chips packed fresh.', 60.00, 150, 'pkt', 7, 'https://images.unsplash.com/photo-1566478989037-eec170784d0b?w=400&q=80'),
(' Nepali Selroti', 'Freshly fried traditional sweet selroti.', 150.00, 40, 'box', 7, 'https://images.unsplash.com/photo-1541532713592-79a0317b6b77?w=400&q=80'),
('Premium Dark Chocolate', '70% cocoa rich smooth dark chocolate bar.', 350.00, 80, 'bar', 7, 'https://images.unsplash.com/photo-1511381939415-e44015466834?w=400&q=80'),

-- Household & Hygiene (Category 8)
('Hand Sanitizer (Aloe)', 'Aloe vera scented antibacterial hand rubbing gel.', 180.00, 100, '200ml', 8, 'https://images.unsplash.com/photo-1584483766114-2cea6facdf57?w=400&q=80'),
('Dishwashing Liquid Soap', 'Concentrated lemon scent dish washing cleaner.', 145.00, 70, '500ml', 8, 'https://images.unsplash.com/photo-1607006342411-92fc46485959?w=400&q=80');

-- Seed Contact Message
INSERT INTO messages (name, email, subject, message) VALUES
('John Doe', 'john@gmail.com', 'Wholesale Inquiry', 'Do you offer bulk delivery options for local restaurants?');
