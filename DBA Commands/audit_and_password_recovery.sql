/*
=====================================================
			 Audit and password recovery
=====================================================
it usually means analyzing and enforcing password security 
for database users. This can cover a few different things, like:

-> Checking password strength or policy compliance — For example, 
ensuring that user passwords meet minimum length, complexity, or 
expiration rules. PostgreSQL doesn’t enforce these rules by default, 
but you can add them using extensions or custom functions 
(like check_password in pgcrypto or custom passwordcheck hooks).

-> Auditing password changes — Logging who changed which passwords 
and when, often through PostgreSQL’s audit logging features 
(like pgaudit) or custom triggers.

-> Reviewing authentication methods — Looking at pg_hba.conf to see 
which users or IPs use password authentication vs. peer, scram-sha-256, 
or md5, and making sure everything aligns with security policies.

-> Reporting — Generating a report that summarizes users, roles, and 
password-related attributes (like whether they’re expired, locked, etc.).
*/

-- The md5 encryption algorithm (one-away)
-- It is not possible to decrypt with it.
SELECT md5('test'); -- OUT: 098f6bcd4621d373cade4e832627b4f6

SELECT * FROM pg_shadow;
SELECT * FROM pg_authid;
SELECT * FROM pg_roles;

-----------------------------------------------------------------------------

/* PASSWORD RECOVERY */

-- 1. Access the pg_hba.conf file and add a new line like exemple below.
# TYPE  DATABASE        USER            ADDRESS                 METHOD
  host    all          postgres         127.0.0.1/32             trust     
-- 2. Create a new password
ALTER ROLE postregres WITH PASSWORD '1234';
-- 3. Access the pg_hba.config file again and delete the line that you've created.
  host    all          postgres         127.0.0.1/32             trust 
