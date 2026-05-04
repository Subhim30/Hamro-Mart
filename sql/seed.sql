-- ============================================================
-- Hamro Mart Database — Sample Data (seed.sql)
-- Run AFTER schema.sql
-- ============================================================

USE hamro_mart;

-- ==========================
-- Insert Users
-- ==========================
-- Passwords are sample (normally hashed using bcrypt)
INSERT INTO users (name, email, password, role) VALUES
                                                    ('Admin User', 'admin@hamromart.com', 'admin123', 'admin'),
                                                    ('Ram Bahadur', 'ram@gmail.com', 'ram123', 'customer'),
                                                    ('Sita Sharma', 'sita@gmail.com', 'sita123', 'customer');

-- ==========================
-- Insert Categories
-- ==========================
INSERT INTO categories (name) VALUES
                                  ('Rice & Grains'),
                                  ('Beverages'),
                                  ('Snacks'),
                                  ('Dairy'),
                                  ('Spices'),
                                  ('Household Items');

-- ==========================
-- Insert Products
-- ==========================
INSERT INTO products (name, description, price, stock, category_id) VALUES
                                                                        ('Basmati Rice 5kg', 'Premium quality rice', 1200.00, 50, 1),
                                                                        ('Wai Wai Noodles', 'Instant noodles pack', 25.00, 200, 3),
                                                                        ('Coca Cola 1L', 'Soft drink bottle', 120.00, 100, 2),
                                                                        ('Milk 1L', 'Fresh dairy milk', 90.00, 80, 4),
                                                                        ('Sugar 1kg', 'Refined white sugar', 110.00, 60, 1),
                                                                        ('Tea Powder 500g', 'Strong tea leaves', 250.00, 40, 2),
                                                                        ('Biscuits Pack', 'Crunchy biscuits', 50.00, 150, 3),
                                                                        ('Cooking Oil 1L', 'Sunflower oil', 300.00, 70, 6),
                                                                        ('Salt 1kg', 'Iodized salt', 30.00, 100, 5);

-- ==========================
-- Insert Cart Data
-- ==========================
INSERT INTO cart (user_id, product_id, quantity) VALUES
                                                     (2, 1, 1),
                                                     (2, 2, 3),
                                                     (3, 4, 2);

-- ==========================
-- Insert Orders
-- ==========================
INSERT INTO orders (user_id, total_amount, status) VALUES
                                                       (2, 1275.00, 'confirmed'),
                                                       (3, 180.00, 'pending');

-- ==========================
-- Insert Order Items
-- ==========================
INSERT INTO order_items (order_id, product_id, quantity, price) VALUES
                                                                    (1, 1, 1, 1200.00),
                                                                    (1, 2, 3, 25.00),
                                                                    (2, 4, 2, 90.00);