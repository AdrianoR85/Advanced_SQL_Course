-- Create Roles with login permission
CREATE ROLE triss LOGIN PASSWORD 'tris123';
CREATE ROLE yennefer LOGIN PASSWORD '1234' VALID UNTIL '2025-10-10 12:00:00';
CREATE ROLE ciri LOGIN PASSWORD '4123' VALID UNTIL '2025-10-10 12:00:00' CREATEDB CREATEROLE;
CREATE ROLE gerald LOGIN PASSWORD '415263' SUPERUSER;


-- Drop a role
DROP ROLE yennefer;

-- Update a role
ALTER ROLE fernanda RENAME TO dandelion;
ALTER ROLE gerald WITH PASSWORD '4152';
ALTER ROLE gerald VALID UNTIL '2025-10-10 12:00:00';
ALTER ROLE dandelion VALID UNTIL 'infinity';
ALTER ROLE ciri NOCREATEDB NOCREATEROLE;
ALTER ROLE gerald NOSUPERUSER;
ALTER ROLE triss SUPERUSER;

-- Listando todos os usuarios(roles)
-- Listing all users(roles)
SELECT * FROM pg_catalog.pg_roles WHERE rolcanlogin = true;
SELECT * FROM pg_catalog.pg_user;
/* CTL
\du or \du+
*/

-- Onde os privilégios das roles estão armazenadas
-- Where the roles privileges are records
SELECT DISTINCT(grantor) FROM information_schema.table_privileges;
SELECT DISTINCT(grantee) FROM information_schema.table_privileges;
