CREATE TABLE users (
    user_id      INT AUTO_INCREMENT PRIMARY KEY,
    phone_number VARCHAR(15)  NOT NULL UNIQUE,
    full_name    VARCHAR(100),
    created_at   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(role_id),
    REFERENCES roles(role_id)
);

-- Sample data
INSERT INTO users (phone_number, full_name,role_id) VALUES 
('250790772377', 'Samuel Carter',2),
('250791666066', 'Alex Doe',2),
('250788999999', 'Robert Brown',2),
('250788994599', 'Linda Green',3),
('250791662166', 'Jane Smith',3);
