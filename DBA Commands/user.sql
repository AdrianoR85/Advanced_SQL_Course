-- ========================================
-- USER MANAGEMENT
-- ========================================

-- Create a new user with a password
CREATE USER username WITH PASSWORD 'secure_password';

-- Delete a user
DROP USER username;

-- Temporarily assume the role of another user (session-level)
SET ROLE lara;

-- Reset to the original role after SET ROLE
RESET ROLE;

-- Show the current active user
SELECT current_user;

-- Also shows the current user (alias for current_user)
SELECT user;

-- Show the user who started the session (doesn’t change with SET ROLE)
SELECT session_user;
SHOW session_user;

-- ========================================
-- VIEW USER PRIVILEGES
-- ========================================

-- Show all table-level permissions granted to a user
SELECT * FROM information_schema.role_table_grants 
WHERE grantee = 'lara';

-- ========================================
-- DATABASE-LEVEL PERMISSIONS
-- ========================================

-- Grant permission to connect to a specific database
GRANT CONNECT ON DATABASE "database_name" TO username;

-- Revoke permission to connect to a specific database
REVOKE CONNECT ON DATABASE "database_name" FROM username;

-- ========================================
-- SCHEMA-LEVEL PERMISSIONS
-- ========================================

-- Allow user to access objects inside the 'public' schema
GRANT USAGE ON SCHEMA public TO username;

-- Revoke usage access from the schema
REVOKE USAGE ON SCHEMA schema_name FROM username;

-- ========================================
-- TABLE-LEVEL PERMISSIONS (All tables in a schema)
-- ========================================

-- Grant SELECT on all tables in a schema
GRANT SELECT ON ALL TABLES IN SCHEMA schema_name TO username;

-- Revoke SELECT on all tables in a schema
REVOKE SELECT ON ALL TABLES IN SCHEMA schema_name FROM username;

-- ========================================
-- TABLE-LEVEL PERMISSIONS (Specific tables)
-- ========================================

-- Grant all privileges on a specific table
GRANT ALL PRIVILEGES ON TABLE table_name TO username;

-- Revoke all privileges on a specific table
REVOKE ALL PRIVILEGES ON TABLE table_name FROM username;

-- Grant SELECT, INSERT, UPDATE on specific tables
GRANT SELECT, INSERT, UPDATE ON TABLE employees, departments TO username;

-- Revoke SELECT, INSERT, UPDATE on specific tables
REVOKE SELECT, INSERT, UPDATE ON TABLE employees, departments FROM username;

-- ========================================
-- FUNCTION-LEVEL PERMISSIONS
-- ========================================

-- Grant permission to execute a specific function
GRANT EXECUTE ON FUNCTION function_name(argtypes) TO username;

-- Revoke permission to execute a specific function
REVOKE EXECUTE ON FUNCTION function_name(argtypes) FROM username;

-- ========================================
-- ROLE MEMBERSHIP
-- ========================================

-- Grant role membership (e.g., make 'lara' a member of 'postgres' role)
GRANT existing_user TO username;

-- Revoke role membership
REVOKE existing_user FROM username;

-- ========================================
-- DEFAULT PRIVILEGES FOR FUTURE OBJECTS
-- ========================================

-- Set default privileges for future tables created in a schema
ALTER DEFAULT PRIVILEGES IN SCHEMA public
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO username;

-- ========================================
-- CREATE PERMISSIONS ON SCHEMA & DATABASE
-- ========================================

-- Allow user to create objects in a schema
GRANT CREATE ON SCHEMA public TO username;

-- Revoke permission to create objects in a schema
REVOKE CREATE ON SCHEMA public FROM username;

-- Allow user to create new databases (requires superuser privileges)
GRANT CREATE ON DATABASE template1 TO username;
