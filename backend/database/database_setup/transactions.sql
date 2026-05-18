CREATE TABLE transactions (
    transaction_id   INT AUTO_INCREMENT PRIMARY KEY,
    amount           DECIMAL(10,2) NOT NULL CHECK (amount > 0),
    fee              DECIMAL(10,2) DEFAULT 0,
    status           VARCHAR(20) DEFAULT 'completed',
    transaction_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    category_id      INT,
    description      VARCHAR(255),
    FOREIGN KEY (category_id) REFERENCES Transaction_Categories(category_id)
);

INSERT INTO transactions (amount, fee, status, category_id, description) VALUES
(5000.00, 0.00, 'completed', 1, 'Received money from Samuel'),
(2000.00, 20.00, 'completed', 2, 'Sent money to Alex Doe'),
(1500.00, 0.00, 'completed', 3, 'Paid at Kigali Mart'),
(500.00, 0.00, 'completed', 4, 'Bought airtime'),
(10000.00, 100.00, 'completed', 5, 'Withdrew cash at agent');