-- ====================================================================
-- HAMROMART GROCERY SEED SCRIPT (MAX EXPANDED INVENTORY WITH INGREDIENTS)
-- ====================================================================

-- 1. Turn off foreign key checks temporarily
SET FOREIGN_KEY_CHECKS = 0;

-- 2. Clear out existing data cleanly
TRUNCATE TABLE order_items;
DELETE FROM products;
DELETE FROM categories;

-- 3. Reset ID counters back to 1
ALTER TABLE categories AUTO_INCREMENT = 1;
ALTER TABLE products AUTO_INCREMENT = 1;

-- 4. Restore constraint checks
SET FOREIGN_KEY_CHECKS = 1;

-- 5. Seed Expanded Categories List
INSERT INTO categories (id, name, description) VALUES
(1, 'Fruits & Vegetables', 'Fresh organic farm produce and seasonal greens handpicked daily.'),
(2, 'Snacks & Instant Food', 'Local snacks, instant noodles, biscuits, and quick pantry treats.'),
(3, 'Dairy & Eggs', 'Fresh pasteurized milk, local artisanal cheese, pure ghee, and farm eggs.'),
(4, 'Bakery & Bread', 'Freshly baked daily breads, buns, cakes, and breakfast bakery staples.'),
(5, 'Meat & Seafood', 'Premium quality fresh cuts of local chicken, mutton, and fresh water fish.');

-- 6. Seed Detailed Products List (Matching columns: stock and image_url)
INSERT INTO products (name, description, price, stock, unit, category_id, image_url) VALUES
-- ==========================================
-- CATEGORY 1: FRUITS & VEGETABLES (Ingredients: N/A for single whole foods)
-- ==========================================
-- (Already handled previously)
('Fresh Organic Tomatoes', 'Locally sourced fresh red tomatoes from the farms of Kathmandu valley. Perfect for dynamic curries, salads, and pickles.', 120.00, 50, 'kg', 1, 'tomatoes.png'),
('Local Apples (Marpha)', 'Sweet and crispy high-altitude organic apples sourced directly from the orchards of Marpha, Mustang.', 280.00, 35, 'kg', 1, 'apples.png'),
('Fresh Green Spinach (Palungo)', 'Nutrient-rich, iron-dense, freshly harvested local green leafy spinach (Palungo).', 60.00, 40, 'bunch', 1, 'spinach.png'),
('Local Bananas (Malbhog)', 'Sweet, creamy, and completely naturally ripened local Malbhog bananas from Chitwan.', 140.00, 30, 'dozen', 1, 'bananas.png'),
('Organic Potatoes', 'Freshly dug firm potatoes sourced directly from Mude. High starch content, excellent for frying or boiling.', 70.00, 120, 'kg', 1, 'potatoes.png'),
-- (New Items)
('Fresh Green Chilies', 'Fiery and sharp local green chilies. Essential seasoning for authentic Nepali dishes.', 160.00, 25, 'kg', 1, 'green_chilies.png'),
('Local Seedless Lemons', 'Juicy, highly acidic fresh local lemons, perfect for citrus dressups and refreshing juice.', 150.00, 30, 'kg', 1, 'lemons.png'),

-- ==========================================
-- CATEGORY 2: SNACKS & INSTANT FOOD (With Detailed Ingredients)
-- ==========================================
-- (Updated with Ingredients)
('Wai Wai Instant Noodles', 'Classic Nepali brown noodles. Eat it raw or cook it. [Ingredients: Wheat Flour, Palm Oil, Salt, Wheat Gluten, Garlic Powder, Onion, Soy Sauce, Monosodium Glutamate, Chili, Mixed Spices].', 20.00, 150, 'piece', 2, 'waiwai.png'),
('Current Hot & Spicy Noodles', 'Extra fiery premium instant noodles. [Ingredients: Wheat Flour, Refined Palm Oil, Tapioca Starch, Salt, Chili Powder, Sichuan Pepper, Monosodium Glutamate, Dehydrated Vegetables, Yeast Extract].', 50.00, 120, 'piece', 2, 'current_noodles.png'),
('Kurmure Spicy Snacks', 'Crunchy twisty savory snacks. [Ingredients: Corn Meal, Rice Meal, Edible Vegetable Oil, Gram Meal, Salt, Chili Powder, Dry Mango Powder, Garlic, Ginger, Mixed Spices].', 25.00, 85, 'packet', 2, 'kurmure.png'),
('Good Day Cashew Biscuits', 'Rich and buttery crisp tea cookies. [Ingredients: Wheat Flour, Sugar, Vegetable Oil, Cashew Nuts (4.5%), Milk Solids, Ammonium Bicarbonate, Salt, Artificial Butter Flavor].', 40.00, 100, 'packet', 2, 'good_day.png'),
-- (New Items)
('Century Mixed Pickle', 'Tangy and hot traditional mixed pickle. [Ingredients: Mango, Lime, Carrot, Green Chili, Mustard Oil, Salt, Fenugreek, Turmeric, Fennel, Acidity Regulator (E260)].', 135.00, 45, '400g jar', 2, 'mixed_pickle.png'),
('Choco Fun Roll', 'Crisp wafer rolls filled with smooth chocolate cream. [Ingredients: Sugar, Wheat Flour, Hydrogenated Vegetable Fat, Cocoa Powder, Milk Solids, Soy Lecithin, Iodized Salt].', 10.00, 300, 'piece', 2, 'choco_fun.png'),

-- ==========================================
-- CATEGORY 3: DAIRY & EGGS (With Detailed Ingredients)
-- ==========================================
-- (Updated with Ingredients)
('DDC Pure Milk 500ml', 'Standard pasteurized liquid milk from Dairy Development Corporation. [Ingredients: 100% Pasteurized Cow and Buffalo Milk standardized to 3.0% Milk Fat].', 50.00, 200, 'packet', 3, 'ddc_milk.png'),
('Kanchan Cheese', 'Authentic hard table cheese with mild nutty notes. [Ingredients: Pasteurized Whole Cow Milk, Bacterial Culture, Microbial Rennet, Salt].', 350.00, 25, '200g pack', 3, 'kanchan_cheese.png'),
('Fresh Farm Eggs', 'Nutritious farm-fresh brown eggs packed securely in protective cartons. High protein content.', 180.00, 60, 'half dozen', 3, 'eggs.png'),
('DDC Pure Ghee 1L', 'Premium traditional clarified butter. [Ingredients: 100% Pure Milk Fat clarified from sweet cream butter].', 1250.00, 40, 'tin', 3, 'ddc_ghee.png'),
-- (New Items)
('Fresh Paneer', 'Fresh cottage cheese blocks, soft and porous. Perfect for vegetarian grills and curries. [Ingredients: Pasteurized Milk, Citric Acid (Coagulant)].', 240.00, 30, '200g pack', 3, 'paneer.png'),

-- ==========================================
-- CATEGORY 4: BAKERY & BREAD (With Detailed Ingredients)
-- ==========================================
('Fresh Milk White Bread', 'Soft slice sandwich bread baked daily. [Ingredients: Premium Wheat Flour, Water, Sugar, Yeast, Vegetable Shortening, Iodized Salt, Calcium Propionate (Preservative)].', 65.00, 40, 'packet', 4, 'white_bread.png'),
('Brown Wheat Bread', 'High-fiber whole wheat sandwich bread. [Ingredients: Whole Wheat Flour, Water, Molasses, Yeast, Wheat Gluten, Vegetable Oil, Sea Salt].', 80.00, 25, 'packet', 4, 'brown_bread.png'),
('Cream Doughnut', 'Fluffy sugar-glazed fried yeast doughnut with fresh cream filling. [Ingredients: Wheat Flour, Milk, Butter, Eggs, Sugar, Yeast, Heavy Dairy Cream, Vanilla Essence].', 45.00, 30, 'piece', 4, 'doughnut.png'),

-- ==========================================
-- CATEGORY 5: MEAT & SEAFOOD (Ingredients: N/A for single fresh proteins)
-- ==========================================
('Fresh Skinless Chicken', 'Premium farm-raised broiler chicken meat, skinless, neatly cleaned, and custom cut.', 410.00, 35, 'kg', 5, 'chicken_meat.png'),
('Premium Buff Keema', 'Lean, finely minced buffalo meat, perfect for making momos, meatballs, and patties.', 480.00, 20, 'kg', 5, 'buff_keema.png'),
('Fresh Water Rahu Fish', 'Fresh river Rahu fish caught locally, scaled, gutted, and sliced into clean steakhanks.', 380.00, 15, 'kg', 5, 'rahu_fish.png');