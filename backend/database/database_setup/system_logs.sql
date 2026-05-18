CREATE TABLE system_logs (
    log_id       INT AUTO_INCREMENT PRIMARY KEY,
    action       VARCHAR(100) NOT NULL,
    message      TEXT,
    status       VARCHAR(20) DEFAULT 'success',
    performed_by INT,
    created_at   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (performed_by) REFERENCES users(user_id)
);
INSERT INTO system_logs (action, message, status, performed_by) VALUES
('ETL_PROCESSED', 'momo.xml parsed and loaded successfully', 'success', 1),
('ETL_PROCESSED', 'Transaction categorized as Transfer', 'success', 1),
('ETL_ERROR', 'Could not parse one SMS record', 'failed', 1),
('ETL_PROCESSED', 'Database tables created successfully', 'success', 1),
('ETL_PROCESSED', 'Sample data inserted into all tables', 'success', 1);