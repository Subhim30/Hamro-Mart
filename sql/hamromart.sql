CREATE DATABASE hamromart;
USE hamromart;

-- USERS
CREATE TABLE users (
                       user_id INT PRIMARY KEY AUTO_INCREMENT,
                       name VARCHAR(100),
                       email VARCHAR(100) UNIQUE,
                       password VARCHAR(255),
                       profile_picture VARCHAR(255),
                       role ENUM('ADMIN','CUSTOMER') DEFAULT 'CUSTOMER'
);

-- ADDRESSES
CREATE TABLE addresses (
                           address_id INT PRIMARY KEY AUTO_INCREMENT,
                           user_id INT,
                           city VARCHAR(100),
                           address TEXT,
                           landmark VARCHAR(255),
                           FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- CATEGORIES
CREATE TABLE categories (
                            category_id INT PRIMARY KEY AUTO_INCREMENT,
                            name VARCHAR(100)
);

-- PRODUCTS
CREATE TABLE products (
                          product_id INT PRIMARY KEY AUTO_INCREMENT,
                          category_id INT,
                          name VARCHAR(100),
                          price DOUBLE,
                          stocks INT,
                          product_image VARCHAR(255),
                          description TEXT,
                          FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

-- ORDERS
CREATE TABLE orders (
                        order_id INT PRIMARY KEY AUTO_INCREMENT,
                        user_id INT,
                        address_id INT,
                        total_amount DOUBLE,
                        status ENUM('PENDING','CONFIRMED','SHIPPED','DELIVERED','CANCELLED') DEFAULT 'PENDING',
                        FOREIGN KEY (user_id) REFERENCES users(user_id),
                        FOREIGN KEY (address_id) REFERENCES addresses(address_id)
);

-- ORDER ITEMS
CREATE TABLE order_items (
                             order_item_id INT PRIMARY KEY AUTO_INCREMENT,
                             order_id INT,
                             product_id INT,
                             quantity INT,
                             price_at_purchase DOUBLE,
                             FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
                             FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- PAYMENTS
CREATE TABLE payments (
                          payment_id INT PRIMARY KEY AUTO_INCREMENT,
                          order_id INT,
                          payment_method VARCHAR(50),
                          amount DOUBLE,
                          payment_status ENUM('PENDING','SUCCESS','FAILED'),
                          transaction_id VARCHAR(100),
                          FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

-- DELIVERIES
CREATE TABLE deliveries (
                            delivery_id INT PRIMARY KEY AUTO_INCREMENT,
                            order_id INT,
                            delivery_status ENUM('PENDING','OUT_FOR_DELIVERY','DELIVERED'),
                            delivery_date DATE,
                            FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

-- BANNERS
CREATE TABLE banners (
                         banner_id INT PRIMARY KEY AUTO_INCREMENT,
                         title VARCHAR(100),
                         subtitle VARCHAR(255),
                         image_url VARCHAR(255),
                         redirect_url VARCHAR(255),
                         start_date DATE,
                         end_date DATE,
                         status BOOLEAN
);