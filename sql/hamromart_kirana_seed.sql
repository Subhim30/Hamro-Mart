-- ============================================================
--  HamroMart — Kirana Pasal Full Seed Data
--  Compatible with: hamromart_db (setup_schema.sql already run)
--  Run: mysql -u root -p hamromart_db < hamromart_kirana_seed.sql
-- ============================================================

USE hamromart_db;

-- ============================================================
-- 1. CLEAN EXISTING DATA (safe re-run)
-- ============================================================
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE order_items;
TRUNCATE TABLE orders;
TRUNCATE TABLE products;
TRUNCATE TABLE categories;
TRUNCATE TABLE messages;
-- Keep users table intact; only re-insert if missing
DELETE FROM users WHERE email IN ('admin@hamromart.com', 'rubina@gmail.com', 'ram@gmail.com');
SET FOREIGN_KEY_CHECKS = 1;


-- ============================================================
-- 2. USERS  (SHA-256 hashed passwords)
--    admin123  → 240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9
--    user123   → e606e38b0d8c19b24cf0ee3808183162ea7cd63ff7912dbb22b5e803286b4446
-- ============================================================
INSERT INTO users (name, email, password, role, phone, address) VALUES
('Admin User',    'admin@hamromart.com', '240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9', 'ADMIN',    '+977-9801234567', 'Kathmandu, Nepal'),
('Rubina Gurung', 'rubina@gmail.com',   'e606e38b0d8c19b24cf0ee3808183162ea7cd63ff7912dbb22b5e803286b4446', 'CUSTOMER', '+977-9812345678', 'Lalitpur, Nepal'),
('Ram Bahadur',   'ram@gmail.com',      'e606e38b0d8c19b24cf0ee3808183162ea7cd63ff7912dbb22b5e803286b4446', 'CUSTOMER', '+977-9823456789', 'Bhaktapur, Nepal');


-- ============================================================
-- 3. CATEGORIES  (12 kirana pasal categories)
-- ============================================================
INSERT INTO categories (id, name, description, icon) VALUES
(1,  'Staples & Grains',        'Rice, lentils, flour, atta, poha and everyday cooking essentials.',     'fa-seedling'),
(2,  'Cooking Oils & Ghee',     'Mustard oil, sunflower oil, refined oil, vanaspati and pure ghee.',      'fa-bottle-droplet'),
(3,  'Spices & Masala',         'Whole spices, ground powders, ready masala blends and salt.',            'fa-mortar-pestle'),
(4,  'Dairy & Eggs',            'Milk, curd, butter, paneer, cheese and farm-fresh eggs.',                'fa-cheese'),
(5,  'Fruits & Vegetables',     'Fresh seasonal fruits and farm-picked vegetables.',                       'fa-carrot'),
(6,  'Beverages & Drinks',      'Tea, coffee, cold drinks, juices, energy drinks and mineral water.',     'fa-mug-hot'),
(7,  'Biscuits & Snacks',       'Biscuits, chips, namkeen, noodles, popcorn and light bites.',            'fa-cookie-bite'),
(8,  'Bread & Bakery',          'Sliced bread, pav, rusk, buns and sweet bakery items.',                  'fa-bread-slice'),
(9,  'Packed & Canned Foods',   'Canned vegetables, instant soups, pickles, jams and ready-to-eat.',      'fa-box-archive'),
(10, 'Meat & Fish',             'Fresh chicken, mutton, pork, eggs and seasonal fish.',                   'fa-drumstick-bite'),
(11, 'Soaps & Cleaning',        'Dishwashing bars, detergents, toilet cleaners and surface cleaners.',    'fa-soap'),
(12, 'Personal Care & Hygiene', 'Shampoo, toothpaste, body lotion, sanitizer and personal hygiene.',     'fa-pump-soap');


-- ============================================================
-- 4. PRODUCTS
--    Prices in NPR (Nepali Rupees)
--    image_url → Unsplash CDN (free, no auth required)
-- ============================================================
INSERT INTO products (name, description, price, stock, unit, category_id, image_url) VALUES

-- -------------------------------------------------------
-- Category 1: Staples & Grains
-- -------------------------------------------------------
('Basmati Rice (5 kg)',
 'Long-grain aromatic basmati rice perfect for pulao and biryani. Aged for superior fragrance.',
 750.00, 80, 'bag', 1,
 'https://images.unsplash.com/photo-1586201375761-83865001e31c?w=500&q=80'),

('Sona Masoori Rice (5 kg)',
 'Medium-grain everyday cooking rice. Ideal for dal-bhat. Lightweight and fluffy when cooked.',
 620.00, 100, 'bag', 1,
 'https://images.unsplash.com/photo-1536304929831-ee1ca9d44906?w=500&q=80'),

('Whole Wheat Atta (5 kg)',
 'Stone-ground 100% whole wheat atta for soft rotis and chapatis.',
 520.00, 90, 'bag', 1,
 'https://images.unsplash.com/photo-1574323347407-f5e1ad6d020b?w=500&q=80'),

('Maida / All-Purpose Flour (1 kg)',
 'Fine-milled refined flour for making puri, halwa, and bakery items.',
 85.00, 120, 'pkt', 1,
 'https://images.unsplash.com/photo-1607631568010-a87245c0daf8?w=500&q=80'),

('Masoor Dal / Red Lentils (1 kg)',
 'Split red lentils that cook quickly. High in protein. Great for everyday dal.',
 160.00, 140, 'kg', 1,
 'https://images.unsplash.com/photo-1615361200141-f45040f367be?w=500&q=80'),

('Moong Dal / Yellow Split (500 g)',
 'Skinned split mung beans. Light, easy to digest. Used in khichdi and dal.',
 95.00, 110, 'pkt', 1,
 'https://images.unsplash.com/photo-1603833665858-e61d17a86dbe?w=500&q=80'),

('Chana Dal / Split Chickpea (1 kg)',
 'Hulled and split black chickpeas. Nutty flavour. Ideal for dal tadka and snacks.',
 145.00, 100, 'kg', 1,
 'https://images.unsplash.com/photo-1606756790138-261d2b21cd75?w=500&q=80'),

('Kabuli Chana / Chickpeas (500 g)',
 'Large white dried chickpeas. Used in chhole, salads and curries.',
 120.00, 80, 'pkt', 1,
 'https://images.unsplash.com/photo-1628771065518-0d82f1938462?w=500&q=80'),

('Poha / Flattened Rice (500 g)',
 'Thin flattened rice flakes. Staple breakfast ingredient for poha and chivda.',
 75.00, 130, 'pkt', 1,
 'https://images.unsplash.com/photo-1589301760014-d929f3979dbc?w=500&q=80'),

('Suji / Semolina (1 kg)',
 'Coarse-ground semolina for halwa, upma, idli and porridge.',
 90.00, 100, 'pkt', 1,
 'https://images.unsplash.com/photo-1587334274328-64186a80aeee?w=500&q=80'),

-- -------------------------------------------------------
-- Category 2: Cooking Oils & Ghee
-- -------------------------------------------------------
('Pure Mustard Oil (1 ltr)',
 'Cold-pressed traditional yellow mustard oil. Pungent aroma. Best for everyday Nepali cooking.',
 295.00, 90, 'ltr', 2,
 'https://images.unsplash.com/photo-1474979266404-7eaacbcd87c5?w=500&q=80'),

('Sunflower Cooking Oil (1 ltr)',
 'Light, neutral sunflower oil with high smoke point. Ideal for frying and sautéing.',
 250.00, 100, 'ltr', 2,
 'https://images.unsplash.com/photo-1558769132-cb1aea458c5e?w=500&q=80'),

('Refined Soybean Oil (2 ltr)',
 'Refined soybean cooking oil — light taste, suitable for all types of cooking.',
 420.00, 60, 'btl', 2,
 'https://images.unsplash.com/photo-1620706857370-e1b9770e8bb1?w=500&q=80'),

('Pure Desi Ghee (500 g)',
 'Clarified pure cow butter ghee. Rich nutty aroma. Used in dal, rice, rotis and sweets.',
 950.00, 40, 'jar', 2,
 'https://images.unsplash.com/photo-1631450261897-0b6994b7a387?w=500&q=80'),

('Coconut Oil (500 ml)',
 'Cold-pressed virgin coconut oil. Good for cooking, hair and skin.',
 480.00, 50, 'btl', 2,
 'https://images.unsplash.com/photo-1598440947619-2c35fc9aa908?w=500&q=80'),

-- -------------------------------------------------------
-- Category 3: Spices & Masala
-- -------------------------------------------------------
('Turmeric Powder / Haldi (200 g)',
 'Bright yellow ground turmeric with earthy flavour. Essential in every Nepali kitchen.',
 120.00, 150, 'pkt', 3,
 'https://images.unsplash.com/photo-1615485290382-441e4d049cb5?w=500&q=80'),

('Cumin Seeds / Jeera (100 g)',
 'Whole dried cumin seeds. Earthy, warming flavour for tempering dals and curries.',
 90.00, 200, 'pkt', 3,
 'https://images.unsplash.com/photo-1601600576337-c1d8a0d1373c?w=500&q=80'),

('Coriander Powder / Dhania (200 g)',
 'Finely ground roasted coriander seeds. Adds citrusy, mild warmth to curries.',
 85.00, 180, 'pkt', 3,
 'https://images.unsplash.com/photo-1599909533730-e4f52a6bac32?w=500&q=80'),

('Chilli Powder / Khursani (100 g)',
 'Medium-hot ground red chilli powder. Bright colour and bold heat for all curries.',
 75.00, 200, 'pkt', 3,
 'https://images.unsplash.com/photo-1583119022894-919a68a3d0e3?w=500&q=80'),

('Garam Masala Blend (100 g)',
 'Premium blend of 12 whole spices — clove, cardamom, cinnamon, bay leaf and more.',
 130.00, 120, 'pkt', 3,
 'https://images.unsplash.com/photo-1596040033229-a9821ebd058d?w=500&q=80'),

('Black Mustard Seeds / Rai (100 g)',
 'Small whole black mustard seeds for tempering and pickling.',
 55.00, 180, 'pkt', 3,
 'https://images.unsplash.com/photo-1638444752504-25c65ced2e6e?w=500&q=80'),

('Iodised Salt / Noon (1 kg)',
 'Fine iodised rock salt. Fortified with iodine for health.',
 40.00, 300, 'pkt', 3,
 'https://images.unsplash.com/photo-1526434426615-1abe81efcb0b?w=500&q=80'),

('Bay Leaves / Tejpatta (20 g)',
 'Dried whole bay leaves for flavouring rice, curries and soups.',
 30.00, 250, 'pkt', 3,
 'https://images.unsplash.com/photo-1610348725531-843dff563e2c?w=500&q=80'),

-- -------------------------------------------------------
-- Category 4: Dairy & Eggs
-- -------------------------------------------------------
('Full Cream Milk (1 ltr)',
 'Pasteurised and homogenised full-fat cow milk. Fresh daily from local dairy.',
 100.00, 120, 'ltr', 4,
 'https://images.unsplash.com/photo-1563636619-e9143da7973b?w=500&q=80'),

('Fresh Curd / Dahi (400 g)',
 'Thick, creamy set curd made from full-fat milk. Ideal for raita and lassi.',
 90.00, 80, 'cup', 4,
 'https://images.unsplash.com/photo-1488477181946-6428a0291777?w=500&q=80'),

('Amul Butter Salted (100 g)',
 'Classic salted table butter made from fresh cream. Perfect for bread and rotis.',
 75.00, 100, 'pkt', 4,
 'https://images.unsplash.com/photo-1589985270826-4b7bb135bc9d?w=500&q=80'),

('Fresh Paneer (200 g)',
 'Soft, crumbly fresh cottage cheese made daily. Great for paneer curry and wraps.',
 220.00, 50, 'pkt', 4,
 'https://images.unsplash.com/photo-1631452180519-c014fe946bc7?w=500&q=80'),

('Farm Fresh Eggs (12 pcs)',
 'Dozen brown cage-free farm eggs. Rich yolk, high protein.',
 180.00, 150, 'dozen', 4,
 'https://images.unsplash.com/photo-1516448620398-c5f44bf9f441?w=500&q=80'),

('Condensed Milk (400 g)',
 'Sweetened condensed full-cream milk in tin. Used in kheer, halwa and desserts.',
 155.00, 60, 'tin', 4,
 'https://images.unsplash.com/photo-1550411294-8c4a49e9c0d1?w=500&q=80'),

-- -------------------------------------------------------
-- Category 5: Fruits & Vegetables
-- -------------------------------------------------------
('Red Tomatoes (1 kg)',
 'Juicy, ripe local red tomatoes. Essential ingredient for curries, chutneys and salads.',
 80.00, 200, 'kg', 5,
 'https://images.unsplash.com/photo-1595855759920-86582396756a?w=500&q=80'),

('Yellow Onions (1 kg)',
 'Medium-sized farm-fresh yellow onions. Sweet and pungent base for all Nepali dishes.',
 70.00, 250, 'kg', 5,
 'https://images.unsplash.com/photo-1618512496248-a07fe83aa8cb?w=500&q=80'),

('Garlic (250 g)',
 'Fresh whole garlic bulbs. Pungent and aromatic. Used in almost every savoury dish.',
 120.00, 180, 'pkt', 5,
 'https://images.unsplash.com/photo-1615485290382-441e4d049cb5?w=500&q=80'),

('Ginger / Aduwa (250 g)',
 'Fresh young ginger root. Used in cooking, tea and herbal remedies.',
 90.00, 160, 'pkt', 5,
 'https://images.unsplash.com/photo-1601961405399-45c9bc7f8e9c?w=500&q=80'),

('Green Chillies (100 g)',
 'Fresh medium-hot green chillies. Adds heat and flavour to curries and chutneys.',
 40.00, 180, 'pkt', 5,
 'https://images.unsplash.com/photo-1582979512210-99b6a53386f9?w=500&q=80'),

('Potatoes (1 kg)',
 'Versatile yellow potatoes for aloo curry, chips, chaat and everyday cooking.',
 65.00, 300, 'kg', 5,
 'https://images.unsplash.com/photo-1518977676601-b53f82aba655?w=500&q=80'),

('Cauliflower (1 pc)',
 'Fresh white cauliflower. Great for gobi curry, stir fry and pickled preparations.',
 80.00, 100, 'pcs', 5,
 'https://images.unsplash.com/photo-1568584711075-3d021a7c3ca3?w=500&q=80'),

('Mustang Apples (1 kg)',
 'Sweet, crisp apples from Mustang Valley, Nepal. Seasonal and naturally grown.',
 350.00, 80, 'kg', 5,
 'https://images.unsplash.com/photo-1560806887-1e4cd0b6cbd6?w=500&q=80'),

('Bananas — Cavendish (1 dozen)',
 'Ripe, sweet Cavendish bananas. Excellent source of potassium. Ideal for snacking.',
 120.00, 200, 'dozen', 5,
 'https://images.unsplash.com/photo-1571771894821-ce9b6c11b08e?w=500&q=80'),

('Fresh Lemon (6 pcs)',
 'Juicy fresh lemons. Used for juice, pickle and flavouring curries.',
 60.00, 220, 'pcs', 5,
 'https://images.unsplash.com/photo-1590502593747-42a996133562?w=500&q=80'),

-- -------------------------------------------------------
-- Category 6: Beverages & Drinks
-- -------------------------------------------------------
('Ilam Black Tea (250 g)',
 'Premium Nepali CTC black tea from Ilam district. Full-bodied, rich and aromatic.',
 280.00, 100, 'pkt', 6,
 'https://images.unsplash.com/photo-1567922045116-2a00fae2ed03?w=500&q=80'),

('Nescafé Classic Instant Coffee (100 g)',
 'World-famous smooth instant coffee. Bold taste, easy to prepare.',
 380.00, 60, 'jar', 6,
 'https://images.unsplash.com/photo-1559056199-641a0ac8b55e?w=500&q=80'),

('Mineral Water Bottle (1 ltr)',
 'Pure, natural spring mineral water. Sealed and certified safe to drink.',
 40.00, 400, 'btl', 6,
 'https://images.unsplash.com/photo-1548839140-29a749e1cf4d?w=500&q=80'),

('Coca-Cola (1.5 ltr)',
 'Classic Coca-Cola chilled soft drink. Refreshing carbonated beverage.',
 120.00, 150, 'btl', 6,
 'https://images.unsplash.com/photo-1554866585-cd94860890b7?w=500&q=80'),

('Mango Juice Drink (1 ltr)',
 'Real mango juice drink with pulp. No artificial colours. Refreshing tropical taste.',
 120.00, 120, 'btl', 6,
 'https://images.unsplash.com/photo-1546173159-315724a31696?w=500&q=80'),

('Horlicks Health Drink (500 g)',
 'Classic malt-based nutritional health drink for children and adults.',
 650.00, 50, 'jar', 6,
 'https://images.unsplash.com/photo-1611080626919-7cf5a9dbab12?w=500&q=80'),

-- -------------------------------------------------------
-- Category 7: Biscuits & Snacks
-- -------------------------------------------------------
('Britannia Marie Gold Biscuits (250 g)',
 'Light, crisp whole wheat biscuits. Perfect with tea. Classic everyday snack.',
 55.00, 200, 'pkt', 7,
 'https://images.unsplash.com/photo-1558961363-fa8fdf82db35?w=500&q=80'),

('Cream Biscuits (200 g)',
 'Sandwich biscuits with sweet vanilla cream filling. Kids favourite.',
 60.00, 180, 'pkt', 7,
 'https://images.unsplash.com/photo-1499636136210-6f4ee915583e?w=500&q=80'),

('Wai Wai Instant Noodles (75 g)',
 'Nepal''s most loved instant noodles. Spicy masala flavour. Ready in 3 minutes.',
 35.00, 500, 'pkt', 7,
 'https://images.unsplash.com/photo-1585032226651-759b368d7246?w=500&q=80'),

('Classic Potato Chips (90 g)',
 'Thin, crunchy salted potato chips. Fried to golden perfection.',
 70.00, 250, 'pkt', 7,
 'https://images.unsplash.com/photo-1566478989037-eec170784d0b?w=500&q=80'),

('Mixture Namkeen (200 g)',
 'Crunchy Nepali-style savoury mixture with chana, sev and fried peas.',
 90.00, 180, 'pkt', 7,
 'https://images.unsplash.com/photo-1604908176997-125f25cc6f3d?w=500&q=80'),

('Microwave Popcorn (90 g)',
 'Butter-flavoured microwave ready popcorn. Perfect movie-night snack.',
 150.00, 100, 'pkt', 7,
 'https://images.unsplash.com/photo-1506802913710-8b73e338ba50?w=500&q=80'),

('Dark Chocolate Bar 70% (80 g)',
 'Premium 70% cacao dark chocolate. Rich, smooth and slightly bitter.',
 380.00, 80, 'bar', 7,
 'https://images.unsplash.com/photo-1511381939415-e44015466834?w=500&q=80'),

-- -------------------------------------------------------
-- Category 8: Bread & Bakery
-- -------------------------------------------------------
('Sliced Brown Bread (400 g)',
 'Whole wheat sliced sandwich loaf. Soft and fresh baked daily.',
 90.00, 60, 'pkt', 8,
 'https://images.unsplash.com/photo-1509440159596-0249088772ff?w=500&q=80'),

('White Sandwich Bread (400 g)',
 'Soft, fluffy white sandwich bread. Great for toast and sandwiches.',
 80.00, 70, 'pkt', 8,
 'https://images.unsplash.com/photo-1585478259715-876acc5be8eb?w=500&q=80'),

('Rusk Toast (200 g)',
 'Double-baked crispy rusk. Classic accompaniment for morning tea.',
 85.00, 90, 'pkt', 8,
 'https://images.unsplash.com/photo-1617611647086-3a3a85ed7e0b?w=500&q=80'),

('Burger Buns (4 pcs)',
 'Soft, lightly toasted burger buns with sesame seeds on top.',
 95.00, 50, 'pkt', 8,
 'https://images.unsplash.com/photo-1571748982800-fa51082c2224?w=500&q=80'),

-- -------------------------------------------------------
-- Category 9: Packed & Canned Foods
-- -------------------------------------------------------
('Achar / Mixed Pickle (400 g)',
 'Tangy traditional Nepali mixed vegetable pickle in mustard oil. Ready to serve.',
 185.00, 100, 'jar', 9,
 'https://images.unsplash.com/photo-1603133872878-684f208fb84b?w=500&q=80'),

('Tomato Ketchup (500 g)',
 'Smooth, tangy tomato ketchup made with ripe tomatoes and spices.',
 175.00, 90, 'btl', 9,
 'https://images.unsplash.com/photo-1614432745117-1a9e1f640ecf?w=500&q=80'),

('Strawberry Jam (250 g)',
 'Sweet strawberry fruit jam. Perfect spread for bread and rotis.',
 195.00, 70, 'jar', 9,
 'https://images.unsplash.com/photo-1488900128323-21503983a07e?w=500&q=80'),

('Canned Sweet Corn (400 g)',
 'Whole kernel sweet corn in brine. Ready to use in salads and curries.',
 180.00, 60, 'tin', 9,
 'https://images.unsplash.com/photo-1598511757337-fe2cafc31ba0?w=500&q=80'),

('Instant Pea Soup (55 g)',
 'Tasty green pea instant soup mix. Add hot water and stir. Ready in 1 minute.',
 120.00, 80, 'pkt', 9,
 'https://images.unsplash.com/photo-1547592166-23ac45744acd?w=500&q=80'),

('Mayonnaise (200 g)',
 'Creamy, rich egg mayonnaise. Used in sandwiches, dips and salads.',
 195.00, 75, 'jar', 9,
 'https://images.unsplash.com/photo-1558598584-e3ef79ce9bc3?w=500&q=80'),

-- -------------------------------------------------------
-- Category 10: Meat & Fish
-- -------------------------------------------------------
('Fresh Chicken (whole, 1 kg)',
 'Fresh farm-raised whole chicken, cleaned and dressed. No preservatives.',
 380.00, 40, 'kg', 10,
 'https://images.unsplash.com/photo-1604503468506-a8da13d82791?w=500&q=80'),

('Boneless Chicken Breast (500 g)',
 'Lean, skinless boneless chicken breast. Ideal for grilling, stir fry or curry.',
 320.00, 50, 'pkt', 10,
 'https://images.unsplash.com/photo-1604503468506-a8da13d82791?w=500&q=80'),

('Mutton / Khasi (500 g)',
 'Tender bone-in goat mutton. Freshly cut on order. Best for khasi ko masu.',
 850.00, 25, 'pkt', 10,
 'https://images.unsplash.com/photo-1544025162-d76694265947?w=500&q=80'),

('Fresh Rohu Fish (500 g)',
 'Whole fresh river Rohu fish — popular and affordable freshwater catch.',
 350.00, 30, 'pkt', 10,
 'https://images.unsplash.com/photo-1510130387422-82bed34b37e9?w=500&q=80'),

('Dried Fish / Sukuti (200 g)',
 'Traditional sun-dried and smoked fish. A Nepali delicacy for achar and side dishes.',
 320.00, 45, 'pkt', 10,
 'https://images.unsplash.com/photo-1580822184713-fc5400e7fe10?w=500&q=80'),

-- -------------------------------------------------------
-- Category 11: Soaps & Cleaning
-- -------------------------------------------------------
('Dishwash Bar (200 g)',
 'Lemon-scented concentrated dishwashing bar soap. Removes grease effectively.',
 65.00, 200, 'bar', 11,
 'https://images.unsplash.com/photo-1607006342411-92fc46485959?w=500&q=80'),

('Dishwash Liquid (500 ml)',
 'Concentrated dishwashing liquid soap. Gentle on hands, tough on grease.',
 175.00, 150, 'btl', 11,
 'https://images.unsplash.com/photo-1600857544200-b2f666a9a2ec?w=500&q=80'),

('Laundry Detergent Powder (1 kg)',
 'Active enzyme-formula laundry powder. Effective stain removal in cold water.',
 280.00, 120, 'pkt', 11,
 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=500&q=80'),

('Toilet Cleaner (500 ml)',
 'Thick, bleach-based toilet bowl cleaner with disinfectant and fresh pine fragrance.',
 145.00, 100, 'btl', 11,
 'https://images.unsplash.com/photo-1585421514284-efb74c2b69ba?w=500&q=80'),

('Multipurpose Floor Cleaner (1 ltr)',
 'Disinfectant floor cleaner with floral fragrance. Kills 99.9% of germs.',
 220.00, 80, 'btl', 11,
 'https://images.unsplash.com/photo-1563453392212-326f5e854473?w=500&q=80'),

('Steel Wool Scrub Pad (4 pcs)',
 'Heavy-duty steel wool scouring pads for pots, pans and stubborn stains.',
 85.00, 160, 'pkt', 11,
 'https://images.unsplash.com/photo-1585421514738-01a8016c0d3c?w=500&q=80'),

-- -------------------------------------------------------
-- Category 12: Personal Care & Hygiene
-- -------------------------------------------------------
('Hand Sanitizer Aloe (200 ml)',
 '70% alcohol-based hand sanitizer with soothing aloe vera. Kills 99.9% germs.',
 175.00, 150, 'btl', 12,
 'https://images.unsplash.com/photo-1584483766114-2cea6facdf57?w=500&q=80'),

('Colgate Toothpaste (150 g)',
 'Fluoride toothpaste with active whitening and cavity protection formula.',
 185.00, 180, 'tube', 12,
 'https://images.unsplash.com/photo-1570126618953-d437176e8c79?w=500&q=80'),

('Dove Shampoo (180 ml)',
 'Intensive moisture repair shampoo. Nourishes dry and damaged hair.',
 395.00, 100, 'btl', 12,
 'https://images.unsplash.com/photo-1526947425960-945c6e72858f?w=500&q=80'),

('Bathing Soap (75 g)',
 'Classic moisturising bathing bar with milk cream. For soft and smooth skin.',
 65.00, 300, 'bar', 12,
 'https://images.unsplash.com/photo-1607006344380-b6775a0824a7?w=500&q=80'),

('Sanitary Pads (8 pcs)',
 'Ultra-thin overnight sanitary pads with leak-guard wings. Cottony soft cover.',
 155.00, 120, 'pkt', 12,
 'https://images.unsplash.com/photo-1567360425618-1594206637d2?w=500&q=80'),

('Vaseline Body Lotion (200 ml)',
 'Intensive care body lotion with petroleum jelly. Heals and protects dry skin.',
 320.00, 90, 'btl', 12,
 'https://images.unsplash.com/photo-1556229010-6c3f2c9ca5f8?w=500&q=80'),

('Talcum Powder (200 g)',
 'Classic fresh talc powder. Keeps skin dry and fresh all day.',
 145.00, 130, 'pkt', 12,
 'https://images.unsplash.com/photo-1609840114035-3c981b782dfe?w=500&q=80');


-- ============================================================
-- 5. SAMPLE CONTACT MESSAGE
-- ============================================================
INSERT INTO messages (name, email, subject, message) VALUES
('Suresh Thapa', 'suresh.thapa@gmail.com',
 'Bulk Order Inquiry',
 'Namaste! Do you provide wholesale delivery for local hotels and restaurants in Kathmandu?');


-- ============================================================
-- DONE ✔
-- Total: 12 categories | 70 products | 3 users
-- ============================================================
SELECT 'Seed complete!' AS status,
       (SELECT COUNT(*) FROM categories) AS categories,
       (SELECT COUNT(*) FROM products)   AS products,
       (SELECT COUNT(*) FROM users)      AS users;
