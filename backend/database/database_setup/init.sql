-- this runs all the files in the database_setup folder to create the database and tables, and insert the initial data.

CREATE DATABASE IF NOT EXISTS momo_sms;
USE momo_sms;

SOURCE database_setup/roles.sql;
SOURCE database_setup/users.sql;
SOURCE database_setup/transaction_category.sql;
SOURCE database_setup/transactions.sql;
SOURCE database_setup/transaction_participants.sql;
SOURCE database_setup/system_logs.sql;
SOURCE database_setup/indexes.sql;
