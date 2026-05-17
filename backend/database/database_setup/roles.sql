
CREATE TABLE roles (
    role_id     INT AUTO_INCREMENT PRIMARY KEY,
    role_name   VARCHAR(50) NOT NULL UNIQUE,
    description VARCHAR(200)
);


INSERT INTO roles (role_name, description) VALUES
('admin', 'Full system access'),
('user',  'Standard user access');
