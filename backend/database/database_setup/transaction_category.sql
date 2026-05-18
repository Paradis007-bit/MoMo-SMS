CREATE TABLE Transaction_Categories (
    category_id   INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(50)  NOT NULL,
    description   VARCHAR(200)
);

INSERT INTO Transaction_Categories(category_name,description) VALUES
('Incoming Money', 'Money received from another user'),
('Transfer', 'Money sent to another user'),
('Payment', 'Payment made to a merchant'),
('Airtime', 'Airtime purchase for a phone number'),
('Withdrawal', 'Cash withdrawn at a MoMo agent');
