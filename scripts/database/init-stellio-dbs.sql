--Module: scripts/database/init-stellio-dbs.sql
--Author: nguyễn Nhật Quang
--Created: 2025-11-29
--Version: 1.0.0
-- PostgreSQL init script for Stellio databases
-- Creates separate databases for each Stellio microservice with TimescaleDB and PostGIS extensions

-- Create stellio_search database
CREATE DATABASE stellio_search;
GRANT ALL PRIVILEGES ON DATABASE stellio_search TO stellio;

-- Create stellio_subscription database  
CREATE DATABASE stellio_subscription;
GRANT ALL PRIVILEGES ON DATABASE stellio_subscription TO stellio;

-- Enable TimescaleDB and PostGIS extensions in all databases
\c stellio_test
CREATE EXTENSION IF NOT EXISTS timescaledb;
CREATE EXTENSION IF NOT EXISTS postgis;

\c stellio_search
CREATE EXTENSION IF NOT EXISTS timescaledb;
CREATE EXTENSION IF NOT EXISTS postgis;

\c stellio_subscription
CREATE EXTENSION IF NOT EXISTS timescaledb;
CREATE EXTENSION IF NOT EXISTS postgis;
