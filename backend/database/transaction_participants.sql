CREATE TABLE transaction_participants (
    id               INT AUTO_INCREMENT PRIMARY KEY,
    transaction_id   INT NOT NULL,
    user_id          INT NOT NULL,
    participant_role VARCHAR(20) NOT NULL,
    FOREIGN KEY (transaction_id) REFERENCES transactions(transaction_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

INSERT INTO transaction_participants (transaction_id, user_id, participant_role) VALUES
(1, 2, 'sender'),
(1, 1, 'receiver'),
(2, 2, 'sender'),
(2, 3, 'receiver'),
(3, 3, 'sender');