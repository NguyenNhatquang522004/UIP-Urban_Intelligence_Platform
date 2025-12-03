--Module: scripts/database/init-stellio-dbs-timescale.sql
--Author: nguyễn Nhật Quang
--Created: 2025-11-29
--Version: 1.0.0
-- Initialize Stellio databases with TimescaleDB extension
-- Stellio requires TimescaleDB for time-series data hypertables

-- Create databases for Stellio services
CREATE DATABASE stellio_search;
CREATE DATABASE stellio_subscription;
CREATE DATABASE stellio;  -- Required by TimescaleDB background workers

-- Connect to stellio_search and enable TimescaleDB + PostGIS
\c stellio_search
CREATE EXTENSION IF NOT EXISTS timescaledb CASCADE;
CREATE EXTENSION IF NOT EXISTS postgis;

-- Connect to stellio_subscription and enable TimescaleDB + PostGIS  
\c stellio_subscription
CREATE EXTENSION IF NOT EXISTS timescaledb CASCADE;
CREATE EXTENSION IF NOT EXISTS postgis;

-- Connect to stellio and enable TimescaleDB (required by background workers)
\c stellio
CREATE EXTENSION IF NOT EXISTS timescaledb CASCADE;
