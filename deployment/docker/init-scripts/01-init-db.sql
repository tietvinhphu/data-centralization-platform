-- =============================================================================
-- Data Centralization Platform - Database Initialization
-- =============================================================================

-- Create extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pg_trgm";
CREATE EXTENSION IF NOT EXISTS "btree_gin";

-- Create schemas
CREATE SCHEMA IF NOT EXISTS metadata;
CREATE SCHEMA IF NOT EXISTS audit;

-- Set search path
SET search_path TO metadata, public;

-- Grant permissions
GRANT ALL PRIVILEGES ON SCHEMA metadata TO dfp_user;
GRANT ALL PRIVILEGES ON SCHEMA audit TO dfp_user;

-- Create initial tables will be done via Alembic migrations
COMMENT ON SCHEMA metadata IS 'Schema for platform metadata and configuration';
COMMENT ON SCHEMA audit IS 'Schema for audit logs and data lineage';
