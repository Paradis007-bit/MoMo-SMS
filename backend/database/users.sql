CREATE TABLE users (
    user_id      INT AUTO_INCREMENT PRIMARY KEY,
    phone_number VARCHAR(15)  NOT NULL UNIQUE,
    full_name    VARCHAR(100),
    created_at   TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Sample data
INSERT INTO users (phone_number, full_name) VALUES 
('250790772377', 'Samuel Carter'),
('250791666066', 'Alex Doe'),
('250788999999', 'Robert Brown'),
('250788994599', 'Linda Green'),
('250791662166', 'Jane Smith');
