CREATE INDEX idx_users_phone ON users(phone_number);
CREATE INDEX idx_transactions_date ON transactions(transaction_date);
CREATE INDEX idx_transactions_category ON transactions(category_id);
CREATE INDEX idx_participants_user ON transaction_participants(user_id);
CREATE INDEX idx_logs_created ON system_logs(created_at);
