CREATE DATABASE momo_sms;
USE momo_sms;

CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    phone_number VARCHAR(15) NOT NULL UNIQUE,
    full_name VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Transaction_Categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL ,
    description VARCHAR(200),
);

CREATE TABLE transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    category_id INT,
    transaction_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    description VARCHAR(255),
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (category_id) REFERENCES Transaction_Categories(category_id)
);

-- our sample data
INSERT INTO users (phone_number, full_name) VALUES 
('250790772377', 'Samuel Carter'),
('250791666066', 'Alex Doe'),
('250788999999', 'Robert Brown'),
('250788994599', 'Linda Green'),
('250791662166', 'Jane Smith');