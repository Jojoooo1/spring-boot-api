
-- Only used to simplify replication test with debezium
ALTER ROLE "user" WITH REPLICATION;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO "user";

CREATE PUBLICATION dbz_publication FOR ALL TABLES;

-- CREATE TABLE debezium_signal (id VARCHAR(42) PRIMARY KEY, type VARCHAR(32) NOT NULL, data VARCHAR(2048) NULL);
CREATE TABLE debezium_signal (id VARCHAR(42) PRIMARY KEY, type VARCHAR(32) NOT NULL, data VARCHAR(2048) NULL);
CREATE TABLE debezium_heartbeat (message VARCHAR(32) NOT NULL, heartbeat timestamp NOT NULL);

CREATE PUBLICATION my_publication FOR ALL TABLES WITH (publish = 'insert, update, delete, truncate');
SELECT PG_CREATE_LOGICAL_REPLICATION_SLOT ('my_replication_slot', 'pgoutput');
