
-- Only used to simplify replication test with debezium

CREATE USER debezium WITH REPLICATION LOGIN PASSWORD 'password';
GRANT CONNECT ON DATABASE api TO debezium;
GRANT USAGE ON SCHEMA public TO debezium;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO debezium;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO debezium;

-- CREATE TABLE debezium_signal (id VARCHAR(42) PRIMARY KEY, type VARCHAR(32) NOT NULL, data VARCHAR(2048) NULL);
CREATE TABLE debezium_signal (id VARCHAR(42) PRIMARY KEY, type VARCHAR(32) NOT NULL, data VARCHAR(2048) NULL);
CREATE TABLE debezium_heartbeat (message VARCHAR(32) NOT NULL, heartbeat timestamp NOT NULL);

CREATE PUBLICATION my_publication FOR ALL TABLES WITH (publish = 'insert, update, delete, truncate');
SELECT PG_CREATE_LOGICAL_REPLICATION_SLOT ('my_replication_slot', 'pgoutput');
