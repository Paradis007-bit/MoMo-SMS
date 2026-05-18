USE momo_sms;

-- USERS CRUD TEST
INSERT INTO users (phone_number, full_name, role_id) VALUES
('250789000001', 'Claudine Uwase', 2);
SELECT * FROM users;
UPDATE users
SET full_name = 'Claudine U. Mutesi'
WHERE phone_number = '250789000001';

SELECT * FROM users WHERE phone_number = '250789000001';
DELETE FROM users
WHERE phone_number = '250789000001';
SELECT * FROM users;

-- TRANSACTIONS CRUD TEST
INSERT INTO transactions (amount, fee, status, category_id, description) VALUES
(3000.00, 30.00, 'completed', 2, 'Test transfer');

SELECT * FROM transactions;
UPDATE transactions
SET amount = 3500.00
WHERE description = 'Test transfer';

SELECT * FROM transactions WHERE description = 'Test transfer';
DELETE FROM transactions
WHERE description = 'Test transfer';
SELECT * FROM transactions;

-- SYSTEM LOGS CRUD TEST
INSERT INTO system_logs (action, message, status, performed_by) VALUES
('ETL_TEST', 'Running test on system logs', 'success', 1);
SELECT * FROM system_logs;
UPDATE system_logs
SET message = 'Test completed successfully'
WHERE action = 'ETL_TEST';
SELECT * FROM system_logs WHERE action = 'ETL_TEST';
DELETE FROM system_logs
WHERE action = 'ETL_TEST';
SELECT * FROM system_logs;