[![Postgres](https://img.shields.io/badge/Postgres-17.5+-blue?logo=postgres)](https://www.postgres.org/)
[![Status](https://img.shields.io/badge/Status-In%20Progress-yellow)]()
# 📘 SQL Learning

Welcome to my SQL learning repository. This is a personal space where I practice and organize everything I learn about SQL, especially advanced topics. I use simple examples, real-world projects, and clear comments in the code to help me understand each concept step by step. My goal is to improve my SQL skills, learn how to write better queries. You will find topics like window functions, subqueries, joins, functions, triggers, and more.

## 🧩 Contents
- [x] [`🛢️ Game Store Project`](#-game-store-project)
- [ ] [`🧩 Postgres Command`](#-postgres-command)
- [ ] [`🧩 Constraints in PostgreSQL`](#-constraints-in-postgreSQL)
- [x] [`🧩 Window Functions`](#-window-functions)
- [x] [`🧩 Subqueries and CTEs`](#-sql-subqueries)
- [x] [`🧩 CTE - Common Table Expressions`](#-sql-ctes-common-table-expressions)
- [x] [`🧩 Set Operations`](#-sql-set-operations)
- [x] [`🧩 Function and Procedure Structure`](#-function-and-procedure-structure)
- [x] [`🧩 Trigger`](#-trigger)
- [x] [`🧩 Conditional Logic`](#-conditional-logic) 
- [x] [`🧩 Text and Cleaning Functions`](#-text-and-cleaning-functions)
- [x] [`🧩 Query Performance`](#-query-optimization)
- [x] [`🧩 Views`](#-sql-views)
- [x] [`🧩 Regex`](#-regular-expression-pattern)
- [x] [`🧩 DBA`](#-dba-in-postgres)
- [x] [`📊 Analysis`](#-analysis)
- [x] [`🛠️ Tools Used`](#-tools-used)
- [x] [`🎯 My Goal`](#-my-goal)
- [x] [`🤝 Contributing`](#-contributing)

------------------------------------------------------------------------------------------------

## 🧑‍💻 Source of Study
- [Data with Baraa](https://www.youtube.com/@DataWithBaraa)
- [SQL for Data Analysis - Book](https://www.oreilly.com/library/view/sql-for-data/9781492088776/)
- Technology websites

------------------------------------------------------------------------------------------------

## 🗄️ Game Store Project

The Game Store Project is a small database I created to help me learn SQL in a practical way. It simulates a simple video game store, with tables for customers, employees, products, purchases, and categories. I use this project to practice creating tables, writing queries, using foreign keys, and analyzing data like sales and customer behavior. This project helps me apply what I learn in real situations and makes studying more interesting.

### Database Diagram
<p align="left">
  <img src="./Game Store Project/Bronze/Model/game_store_model.png" width="85%" alt="Game Store Database Model"/>
</p>


### Tables in the Project

- `Customer` – People who buy games  
- `Address` – Customer address  
- `Employee` – Store workers  
- `Purchase` – Orders from customers  
- `Purchase_item` – Items in each order  
- `Product` – Games in the store  
- `Category` – Type of game (Action, Adventure, etc.)

You can find the SQL code in the [Game Store folder](./Game%20Store%20Project) <!-- Edite se o nome da pasta for diferente -->

[`⬆️Back to Top`](#-Contents)

------------------------------------------------------------------------------------------------

## 🧩 PostgreSQL Commands

### Databases
- `SELECT datname FROM pg_database;` → List all database names.
- `\l` → List databases (psql command line).

### Schemas
- `SELECT schema_name FROM information_schema.schemata;` → List schema names.
- `SELECT * FROM information_schema.schemata;` → List schema details.
- `SELECT * FROM information_schema.schemata WHERE catalog_name = 'mercado_y';` → List schema details for a specific catalog.
- `SELECT nspname FROM pg_catalog.pg_namespace;` → List schema names from `pg_catalog`.
- `CREATE SCHEMA schema_name;` → Create a new schema.
- `ALTER SCHEMA old_schema_name RENAME TO new_schema_name;` → Rename a schema.
- `DROP SCHEMA schema_name;` → Delete a schema.
- List the constraints existing in a specific schema:
  ```sql
  SELECT 
  	*
  FROM 
  	pg_catalog.pg_constraint con
  	INNER JOIN pg_catalog.pg_class rel ON rel.oid = con.conrelid
  	INNER JOIN pg_catalog.pg_namespace nsp ON nsp.oid = con.connamespace
  WHERE 
  	nsp.nspname = 'produto';
  ```

### Create and Drop Tables

```sql
CREATE TABLE <schema_name>.<table_name>;
DROP TABLE <schema_name>.<table_name>;
```
### Rename Tables and Fields
```sql
ALTER TABLE <schema_name>.<table_name> RENAME TO <new_table_name>;
ALTER TABLE <schema_name>.<table_name> RENAME COLUMN <column_name> TO <new_column_name>;
```
### Add or Delete Columns
```sql
ALTER TABLE <table_name> ADD COLUMN <new_column> <data_type>;
ALTER TABLE <table_name> DROP COLUMN <column_name>;
```
### Create a sequence
```sql
CREATE SEQUENCE produto.sequence_x_1 INCREMENT 100 START 10000;

CREATE TABLE produto.test_1(
	id_test_1 int default nextval('produto.sequence_x_1') primary key,
	test varchar(100)
);
```
### UPDATE DATA
```sql
UPDATE <schema_name>.<table_name> SET <column_name> = <value> WHERE <id> = <value>;
```

You can find the SQL code in the [Mercado Y](./Mercado_y_DB)

[`⬆️Back to Top`](#-Contents)

------------------------------------------------------------------------------------------------

## 🧩 Constraints in PostgreSQL

### What is a Constraint?

A constraint is a rule applied to a column or table to enforce data integrity.
They ensure that the data inserted into the database follows specific rules, preventing invalid or inconsistent values.

### Main Types of Constraints:

  - *PRIMARY KEY* → Ensures that each row is unique and not null. 
  - *FOREIGN KEY* → Creates a relationship between two tables.
  - *UNIQUE* → Ensures that columns values are all different.
  - *NOT NULL* → Prevents empty values.
  - *CHECK* → Validates a conditon for each value. 
  - *ENUM* → Not technically a constraint, but acts like one because it restricts values to  a predefined list.

### Definindo Constraints: CREATE vs ALTER TABLE

| Constraint Type | Durante Criação da Tabela (`CREATE TABLE`) | Após Criação da Tabela (`ALTER TABLE`)                        |
|-----------------|--------------------------------------------|---------------------------------------------------------------|
| **PRIMARY KEY** | `CREATE TABLE users (id SERIAL PRIMARY KEY,name TEXT);`                        | `ALTER TABLE users ADD CONSTRAINT users_pkey PRIMARY KEY (id);`|                  
| **FOREIGN KEY** | `CREATE TABLE orders (id SERIAL PRIMARY KEY,user_id INT REFERENCES users(id);` | `ALTER TABLE orders ADD CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES users(id);`|
| **UNIQUE**      | `CREATE TABLE employees (email TEXT UNIQUE);`                                  | `ALTER TABLE employees ADD CONSTRAINT email_unique UNIQUE (email);` 
| **NOT NULL**    | `CREATE TABLE products (name TEXT NOT NULL);`                                  | `ALTER TABLE products ALTER COLUMN name SET NOT NULL;` 
| **CHECK**       | `CREATE TABLE accounts balance NUMERIC CHECK (balance >= 0);`                  | `ALTER TABLE accounts ADD CONSTRAINT balance_check CHECK (balance >= 0);` |
| **DEFAULT**     | `CREATE TABLE tasks (status TEXT DEFAULT 'pending');`                          | `ALTER TABLE tasks ALTER COLUMN status SET DEFAULT 'pending';`|
| **ENUM**        | `CREATE TYPE task_status AS ENUM ('pending','done'); <br> CREATE TABLE tasks (id SERIAL PRIMARY KEY,status task_status DEFAULT 'pending';`| `ALTER TABLE tasks ADD COLUMN status task_status DEFAULT 'pending';` |
------------------------------------------------------------------------------------------------

## 🧩 Window Functions
A window function is a special SQL function.
It does a calculation across rows, but it keeps all the rows in the result.

It does not reduce the number of rows like `GROUP BY` does.

### When to Use Window Functions

Use a window function when you want to:

- Give a row number to each row → `ROW_NUMBER()`
- Find the rank of each row → `RANK()`, `DENSE_RANK()`, `PERCENT_RANK()`
- Find the relative position inside a group → `CUME_DIST()`, `NTILE()`
- Compare a row to the next or previous → `LEAD()`, `LAG()`
- Get the first or last value in a group → `FIRST_VALUE()`, `LAST_VALUE()`
- Make a running total → `SUM() OVER(...)`
- Find a running average → `AVG() OVER(...)`
- Get the highest or lowest value in a group → `MAX() OVER(...)`, `MIN() OVER(...)`
- Count how many rows in a group → COUNT() OVER(...)
- Use aggregate functions but keep row details → any function with `OVER(...)`

### Windows Function Syntax
<p align="center">
  <img src="./assets/window-syntax.png" width="70%" alt="window syntax"/>
</p>

<p align="center">
  <img src="./assets/frame-syntax.png" width="70%" alt="frame syntax"/>
</p>


#### This code is an example of how to use window functions in SQL.
```sql
SELECT
  purchase_id,
  purchase_date,
  
  -- Previous and next values
  LAG(total_price, 2, 0) OVER (ORDER BY purchase_date, purchase_id) AS total_2_rows_before,
  total_price AS total_per_purchase,
  LEAD(total_price, 1, 0) OVER (ORDER BY purchase_date, purchase_id) AS total_1_row_after,
  
  -- Total per date
  SUM(total_price) OVER (PARTITION BY purchase_date) AS total_per_day,
  ROW_NUMBER() OVER (PARTITION BY purchase_date ORDER BY total_price DESC) AS rank_by_daily_total,
  
  -- Cumulative total up to the current row
  SUM(total_price) OVER (
    ORDER BY purchase_date, purchase_id 
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
  ) AS cumulative_total,
  
  -- Grand total
  SUM(total_price) OVER () AS grand_total
  
FROM purchase
WHERE purchase_date >= '2024-01-01'
ORDER BY purchase_date, purchase_id
LIMIT 1000;
```
![](./assets/example.png)

🔎 Find the code [here](./window-functions)

🧑‍💻 Lear more about in [Data with Baraa](https://datawithbaraa.substack.com/p/your-guide-to-sql-window-functions?utm_source=publication-search)


[`⬆️Back to Top`](#-Contents)

------------------------------------------------------------------------------------------------

## 🧩 SQL Subqueries

### Overview
Subqueries are queries written inside other queries. They work like nested boxes - the inner query (subquery) runs first and provides results to the outer query (main query).

### Basic Concept
```sql
  SELECT column_name 
  FROM table_name 
  WHERE column_name > (SELECT AVG(column_name) FROM table_name);
```
### Types of Subqueries
#### Single Value Subqueries
- Return one result (number, text, date)
- Used with operators: =, >, <, >=, <=, <>
- Example: Find products above average price

#### Multiple Value Subqueries
- Return multiple results
- Used with: IN, ANY, ALL, EXISTS
- Example: Find customers in cities with stores

#### Common Locations
|Location  | Purpose                   | Example Use                |
| -------- | ------------------------- | -----------                |
|WHERE     | Filter data               | Find records above average |
|SELECT    | Add calculated columns    | Show percentage of total   | 
|FROM      | Use results as temp table | Complex data combinations  |

### Key Points
- Subqueries execute before the main query
- Can be nested multiple levels deep
- May impact performance with large datasets
- Often replaceable with JOINs for better speed
- Useful for breaking complex problems into steps

### Best Practices
- Keep subqueries simple when possible
- Consider JOIN alternatives for performance
- Test with small data sets first
- Use meaningful aliases for readability

<p align="center">
  <img src="./assets/subquery.png" width="75%" alt="subquery"/>
</p>

🔎 Find the code [here](./subqueries)

🧑‍💻 Lear more about in [Data with Baraa](https://datawithbaraa.substack.com/p/sql-subqueries-a-comprehensive-guide?utm_source=publication-search)

[`⬆️Back to Top`](#-Contents)

------------------------------------------------------------------------------------------------

## 🧩 SQL CTEs (Common Table Expressions)

### Overview
CTEs stands for "Common Table Expressions." They are a useful feature in SQL databases that let you create temporary named result sets within a query.
Used to simplify writing complex queries, it helps break down logic into smaller parts making them easier to understand.

Basic Concept
```sql
  WITH cte_name AS (
    SELECT column1, column2
    FROM table_name
  )
  SELECT *
  FROM cte_name;
```

### Types of CTEs:
 - Non-Recursive CTE: Used to structure and simplify queries.
 - Recursive CTE: Used for hierarchical or tree-structured data.
 - Nested CTE: When a CTE dependend on the other CTE

### Use Cases
|Purpose	| Example Use |
|-------- | ----------- |
| Simplify complex queries | Break down into readable steps|
| Reuse a result set | Join same result multiple times |
| Recursive queries |	Hierarchical data like org charts, trees. |
| Temporary aggregations |	Pre-compute totals, counts, rankings |

### Key Points
- CTE is temporary, valid only for that query
- Defined with WITH keyword before the main query
- Can use multiple CTEs, separated by commas
- Recursive CTEs must include UNION ALL
- CTEs often replace subqueries or derived tables

### Best Practices
- Rethink and refactor your CTEs before starting a new one.
- Don't use more than 5 CTEs in one query; otherside, your code will be hard to understand and maintain.
- Favor CTEs over deeply nested subqueries.
- Test performance with large datasets.
- Use descriptive names for CTEs.
  
### ❌ Attention
We don’t use the ORDER BY clause directly in CTEs unless it's combined with a TOP or LIMIT clause, or you're using it inside a subquery that supports ordering.

<p align="center">
  <img src="./assets/cte_query.drawio.png" width="50%" alt="cte_query"/>
</p>

🔎 Find the code [here](./cte-common-table-expressions)

🧑‍💻 Learn more about it in [Data with Baraa](https://datawithbaraa.substack.com/p/sql-ctes-a-comprehensive-guide?utm_source=publication-search)

[`⬆️Back to Top`](#-Contents)

------------------------------------------------------------------------------------------------

## 🧩 SQL Set Operations

SQL set operations allow you to combine results from multiple SELECT statements into a single result set. These operations work similarly to mathematical set operations and are used to merge data from different queries

### Main SQL Set Operations

1. **UNION**
  - Combines results from two or more SELECT statements
  - Removes duplicate rows
  - Syntax:
  ```sql
    SELECT column1, column2 FROM table1
    UNION
    SELECT column1, column2 FROM table2;
  ```
2. **UNION ALL**
  - Combines results from multiple SELECT statements
  - Includes all rows, including duplicates
  - More efficient than UNION if duplicates are acceptable
  - Syntax:
  ```sql
    SELECT column1, column2 FROM table1
    UNION ALL
    SELECT column1, column2 FROM table2;
  ```
3. **INTERSECT**
  - Returns only rows that appear in both result sets.
  - Removes duplicates.
  - Syntax:
  ```sql
    SELECT column1, column2 FROM table1
    INTERSECT
    SELECT column1, column2 FROM table2;
  ```
4. **EXCEPT** (or MINUS in some databases)
  - Returns rows from the first query that aren't in the second query.
  - Removes duplicates.
  - Syntax:
  ```sql
    SELECT column1, column2 FROM table1
    EXCEPT
    SELECT column1, column2 FROM table2;
  ```
### Requirements for Set Operations
- All SELECT statements must have the same number of columns
- Corresponding columns must have compatible data types
- Column names in the result set are taken from the first query

🔎 Find the code [here](./set-operations)

[`⬆️Back to Top`](#-Contents)

------------------------------------------------------------------------------------------------

## 🧩 Function and Procedure Structure
  Functions and procedures are both database objects that contain reusable SQL code, but they have important differences in how they work and when to use them.

### Function

#### Characteristics:
- Must return a value (can be scalar or table-valued)
- Can be used in SQL statements (SELECT, WHERE, HAVING, etc.)
- Cannot modify database state (with some exceptions)
- Run within the calling transaction
- No transaction control (cannot COMMIT/ROLLBACK)
- Syntax:
```sql
 CREATE OR REPLACE FUNCTION function_name()
 RETURNS return_type AS 
 $body$
 BEGIN
     -- function logic here
     RETURN ...;
 END;
 $body$ 
 LANGUAGE plpgslq;
```
#### Use functions when you need to:
- Return a single value or table
- Use the result in a larger SQL query
- Need read-only operations

### Procedure

#### Characteristics:
- Don't return values (but can have OUT parameters)
- Can modify database state
- Can control transactions (COMMIT/ROLLBACK allowed)
- Called with EXECUTE or CALL
- Cannot be used directly in SQL statements
- Syntax:
```sql
 CREATE OR REPLACE PROCEDURE procedure_name(parameters)
AS 
$body$
DECLARE -- optional
BEGIN
    -- Procedure logic
END;
$body$ 
LANGUAGE plpgsql;
```

#### Use procedures when you need to:
- Perform data modification with transaction control
- Execute multiple SQL statements as a unit
- Don't need to use the result in a SQL statement

### Key Differences
| Feature             | Function      | Procedure   |
| ------------------- | ------------- | ----------- |
| Return value        | Required	    | Optional    |
| SQL statement use   |	Yes	          | No          |
| Transaction control |	No	          | Yes         |
| Calling syntax	    | SELECT func() |	CALL proc() |
| Exception handling	| Yes	          | Yes         |

🔎 Find the code [here](./Functions_and_Procedures/)

[`⬆️Back to Top`](#-Contents)

------------------------------------------------------------------------------------------------
 
## 🧩 Trigger

### Trigger
A trigger is a database object that automatically executes (or "fires") in response to specific events on a table or view, such as ``INSERT``, ``UPDATE``, ``DELETE``, or ``TRUNCATE``. Triggers are used to enforce business rules, maintain data integrity, audit changes, and automate tasks.

Triggers are powerful tools for automating database actions, but they should be used carefully to avoid performance issues and maintainability problems.

#### Types of Triggers
1. *Based on Timing*
- ``BEFORE``: Execute before the triggering event (e.g., before a row is inserted). 
- ``AFTER``: Execute after the triggering event (e.g., after a row is updated)
- ``INTEAD OF``: Used with views to modify data when direct DML operations are not possible.

2.  *Based on Event*
- ``INSERT``: Fires when a new row is inserted.
- ``UPDATE``: Fires when a row is modified.
- ``DELETE``:Fires when a row is deleted.
- ``TRUNCATE``: Fires when a table is truncated (not supported in all databases)

Trigger Syntax (PostgreSQL Example)
```sql
CREATE OR REPLACE TRIGGER trigger_name
{BEFORE | AFTER | INSTEAD OF} {INSERT | UPDATE | DELETE | TRUNCATE}
ON table_name
[FOR EACH ROW | FOR EACH STATEMENT]
[WHEN (condition)]
EXECUTE FUNCTION trigger_function();
```
#### Key Components
- ``trigger_name``: Name of the trigger.
- ``BEFORE/AFTER/INSTEAD OF``: When the trigger executes.
- ``INSERT/UPDATE/DELETE/TRUNCATE``: The event that fires the trigger.
- ``FOR EACH ROW``: Executes once per affected row.
- ``FOR EACH STATEMENT``: Executes once per SQL statement (default).
- ``WHEN (condition)``: Optional condition to control trigger execution.
- ``EXECUTE FUNCTION`` Calls a function that contains the trigger logic.

🔎 Find the code [here](./Triggers/)

[`⬆️Back to Top`](#-Contents)

------------------------------------------------------------------------------------------------

## 🧩 Conditional Logic
Conditional logic allows you to control the flow of your SQL queries based on specified conditions. PostgreSQL offers several constructs for this:

1. **CASE Statement**

- The ``CASE`` expression allows conditional logic similar to if-then-else.

- Syntax:
```sql
CASE
    WHEN condition1 THEN result1
    WHEN condition2 THEN result2
    ...
    ELSE resultN
END
```
2. **COALESCE**
- Returns the first ``non-null`` value in the list.
- Syntax:
```sql
  COALESCE(valor1, valor2, ..., valorN)
```
3. **NULLIF**
- Returns ``NULL`` if the two arguments are equal; otherwise returns the first argument.
- Syntax:
```sql
NULLIF(valor1, valor2)
```

4. **IF-THEN-ELSE**
- Inside functions or stored procedures, you can use ``IF-THEN-ELSE`` logic.
- Syntax:
```sql
IF condição THEN
    -- comandos
ELSIF outra_condição THEN
    -- comandos
ELSE
    -- comandos
END IF;
```

5. **Boolean Expressions**
- Used directly in WHERE, JOIN, ON, etc.
- Syntax:
```sql
SELECT ...
FROM tabela
WHERE condição_booleana;
```

🔎 Find the code [here](./Conditional%20Logic/)

[`⬆️Back to Top`](#-Contents)

------------------------------------------------------------------------------------------------

## 🧩 Text and Cleaning Functions

Text and cleaning functions in PostgreSQL help standardize and prepare string data for querying, analysis, and reporting. These functions are especially useful when working with product names, customer records, or address fields.

### Common Functions

| Function	                         | Description	                             | Example
| ---------------------------------- | ----------------------------------------- | ----------------------------------------------------- |
| ``UPPER(text)``	                   | Converts text to uppercase	               | ``UPPER('gamepad')`` → 'GAMEPAD'                      |
| ``LOWER(text)``	                   | Converts text to lowercase	               | ``LOWER('GAMER')`` → 'gamer'                          |
| ``INITCAP(text)``	                 | Capitalizes the first letter of each word | ``INITCAP('john doe')`` → 'John Doe'                  |
| ``TRIM(text)``	                   | Removes spaces from both ends	           | ``TRIM(' game ')`` → 'game'                           |
| ``REPLACE(text, from, to)``	       | Replaces all occurrences of a substring	 | ``REPLACE('XBOX_ONE', '_', ' ')`` → 'XBOX ONE'        |
| ``SUBSTRING(text, from, len)``	   | Extracts a substring	                     | ``SUBSTRING('controller', 1, 4)`` → 'cont'            |
| ``SPLIT_PART(text, delimiter, n)`` | Returns the n-th part of a split string   | ``SPLIT_PART('PS5-DUALSENSE', '-', 2)`` → 'DUALSENSE' | 
| ``LENGTH(text)``	                 | Returns length of string	                 | ``LENGTH('keyboard')`` → 8                            | 
| ``REGEXP_REPLACE``	               | Replace using regular expressions         | ``REGEXP_REPLACE('a1b2', '[0-9]', '', 'g')`` → 'ab'   |
| ``REGEXP_MATCHES``	               | Search using regular expressions	         | ``REGEXP_MATCHES('abc123', '\d+')``                   |
| ``POSITION(sub IN text)``	         | Find position of a substring              | ``POSITION('b' IN 'abc')`` → 2                        |


🔎 Find the code [here](./Text%20and%20Cleaning%20Functions/)

[`⬆️Back to Top`](#-Contents)

------------------------------------------------------------------------------------------------

## 🧩 Query Optimization

SQL query optimization is the process of improving the efficiency of SQL queries to achieve faster execution times and reduce resource consumption, thereby enhancing overall database performance. This is crucial for ensuring applications run smoothly, especially as data volumes grow and queries become more complex

### Why SQL Query Optimization Matters
- Faster Query Execution: Optimized queries retrieve and manipulate data more quickly, improving application responsiveness and user experience.
- Reduced Resource Usage: Efficient queries minimize CPU, memory, and I/O load, enabling the database to handle more concurrent users.
- Cost Savings and Scalability: Optimized queries reduce infrastructure costs and ensure performance remains stable as data grows.
- Improved Productivity: Faster queries allow developers and analysts to work more effectively without long wait times

### Key Techniques for SQL Query Optimization

#### 1. Indexing:
Creating indexes on columns frequently used in ``WHERE``, ``JOIN``, ``ORDER BY``, and ``GROUP BY`` clauses drastically reduces data scanning time. However, over-indexing can slow down write operations and consume extra storage, so indexes should be applied judiciously on critical columns.
```sql
  CREATE INDEX nome_do_indice
  ON nome_da_tabela (coluna1 [, coluna2, ...]);
```

#### 2. Selective Column Retrieval:
Avoid using ``SELECT *``; instead, specify only the necessary columns. This reduces the volume of data processed and transferred, speeding up query execution.

#### 3. Optimizing Joins:
Choosing the right type of join (e.g., ``INNER JOIN`` vs. ``LEFT JOIN``) based on the data retrieval needs can improve performance. ``INNER JOIN``s are generally faster when only matching rows are needed.

#### 4. Query Rewriting and Simplification:
Techniques such as predicate pushdown (applying filters early), subquery unnesting (replacing subqueries with joins), join elimination, and expression simplification help the query optimizer generate better execution plans.

#### 5. Using Execution Plans and Tools:
Analyzing execution plans (e.g., via ``EXPLAIN``) helps identify bottlenecks and inefficiencies in queries, guiding targeted optimizations.
```sql
  EXPLAIN
  SELECT coluna1, coluna2
  FROM tabela
  WHERE condição; 
```

#### 6. Stored Procedures:
Precompiled stored procedures reduce parsing and compilation overhead for frequently executed queries, improving performance.

#### 7. Database Design and Structure:
Proper normalization reduces data redundancy, while strategic denormalization can speed up complex queries. Table partitioning can also help by limiting data access to relevant partitions.

#### 8. Limiting and Pagination:
Using clauses like ``LIMIT`` or `TOP` restricts the number of rows returned, which is especially useful for large datasets and improves response times.

#### 9. Updating Statistics:
Keeping database statistics current ensures the query optimizer makes informed decisions, avoiding suboptimal execution plans.

#### 10. Query Caching:
Caching frequent query results reduces database load and speeds up response times


🧑‍💻 Learn more about it in [DataCamp](https://www.datacamp.com/blog/sql-query-optimization), [AccelData](https://www.acceldata.io/blog/query-optimization-in-sql-essential-techniques-tools-and-best-practices), [SeveralNines](https://severalnines.com/blog/using-explain-improve-sql-query-performance/)

[`⬆️Back to Top`](#-Contents)

## 🧩 SQL Views

Views are virtual tables in SQL that don't store data themselves but instead display data from one or more underlying tables. They act as saved SQL queries that you can reference like regular tables.

### Key Characteristics of Views
- Virtual Tables: Views don't physically store data (except materialized views)
- Dynamic: Data is fetched from base tables when the view is queried
- Customizable: Can show selected columns, calculated fields, or filtered data
- Security Layer: Can restrict access to sensitive data

### Basic syntax:
```sql
  CREATE VIEW view_name AS
  SELECT column1, column2, ...
  FROM table_name
  WHERE condition;
```
### Modifying and Dropping Views
#### Update a view:
```sql
  CREATE OR REPLACE VIEW view_name AS
  SELECT new_columns...
  FROM tables...
  WHERE new_conditions...;
```
#### Drop a view:
```sql
  DROP VIEW view_name;
```

🔎 Find the code [here](./views)

🧑‍💻 Learn more about it in [Data with Baraa](https://datawithbaraa.substack.com/p/sql-views-the-hidden-gem-of-database?utm_source=publication-search)

[`⬆️Back to Top`](#-Contents)


-----------------------------------------------------------------------------------------------

## 🧩 Regular Expression Pattern

|Expession| What do it do?|
|----------|---------------|
|    .     | Any single character
|    *     | 0 or more 
|    +     | 1 or more
|    ^     | Beginning of string
|    $     | End of string
|  [^ab]   | Not `a` or `b`
|  [ab]    | Only `a`or `b`
|  [A-Z]   | All uppercase letters
|  [a-z]   | All lowercase letters
|  [0-9]   | All numbers
|  {n}     | `n` instance of
|  {m,n}   | Between `m` or `n`
|  m|n     | Match `m` or `n`

[`⬆️Back to Top`](#-Regex)

------------------------------------------------------------------------------------------------

## 📊 Analysis

This project aims to build a Data Warehouse using PostgreSQL to support sales analysis for a video game store. The architecture follows an **ETL pipeline** and a **Star Schema dimensional model**, allowing data visualization through BI tools like Power BI or Tableau.

### Business Objectives (Logistics)

- Identify the best-selling products
- Evaluate shipping performance (delivery time, delays)
- Understand customer behavior
- Explore regional sales performance (region)

### Project Steps

- [x] Bronze: raw - normalized relational database.
- [x] Silver: Extract, Transform and Load the data into the data warehouse. 
- [x] Gold Layer: Star Schema with fact and dimension tables.
- [x] Analisy the data and Ask the question.
- [x] BI: Dashboard built with Power BI / Tableau.

### Dashboard
<p align="left">
  <img src="./assets/dashboard.png" width="70%" alt="window syntax"/>
</p>

Explore the SQL scripts [here](./Analysis)

[`⬆️Back to Top`](#-Contents)


------------------------------------------------------------------------------------------------

## 🧩 DBA In Postgres

### 🧠 Understanding “SETTINGS MANIPULATION CONTEXT” in PostgreSQL

PostgresSQL settings (or configuration parameters) can be change in different **contexts** - each defining **where and how** a parameter can be modified.

Each parameter belongs to one these categories (contexts), wich controls *when* and *by whom* it can be change.

**🔒 1. INTERNAL**

**- Meaing:** These are parameters that cannot be changed at all. They are hardcoded inside PostgresSQL's source code and exist only for internal use.
  
**- Examples:** Internal debugging or system constants.
  
**- How to access:**
  You can view them with:
  ```sql
  SHOW ALL;
  ```
  but you cannot modify them in any way.
**- Modification:** Not possible.


**⚙️ 2. POSTMASTER**

**- Meaning:** These parameters **can only be set at server start-up**.
To change them, you must edit the configuration file (`postgresql.conf`) or use the sql command `ALTER SYSTEM`, then restart the PostgresSQL server.
	
**- Examples:**
 	- `max_connections`
 	- `shared_buffers`
 	- `listen_addresses`
	
**- How to access/modify:**
	- To view:
	```sql
	SHOW max_connections;
	Or
	ALTER SYSTEM SET max_connections = 200;
	```
	- To modify:
	```bash
	# Edit postgresql.conf
	max_connections = 200;
	Or
	sudo systemctl restart postgresql
	```
	
**- Modification:** Requires restart.

**🔁 3. SIGHUP**

**- Meaning:**
Parameters taht **can be reloaded** without restarting the server.
After modification, you only need to reload the configuration(send a `SIGHUP` signal).

**- Examples:**
- `log_directory`
- `log_min_duration_statement`
  
**- How to access/modify:**
```bash
# Edit postgresql.sql
log_directory = '/var/log/postgresql'

# Reload configuration (no restart needed)
sudo systemctl reload postgresql
```
or in SQL
```sql
SELECT pg_reload_conf();
```
**- Modification:** Reload only (no restart).

   
**🧑‍💼 4. SUPERUSER**

**- Meaning:**
Can be changed by a superuser at runtime using the `SET` command.
Affects only the current session or until the database disconnects.

**- Examples:**
- `log_statement`
- `session_preload_libraries`

**- How to access/modify:**
```sql
SET log_statement = 'all';
SHOW log_statement;
```
To make it permanent:
```sql
ALTER SYSTEM SET log_statement = 'all';
```

**- Modification:**Allowed only by superuser.


**👤 5. USER**

**- Meaning:**
These parameters can be changed by any user, for their own session.


**- Examples:**
- `search_path`
- `work_mem`
  
**- How to access/modify:**
```sql
SET search_path = public, sales;
SHOW search_path;
```
Or make it default for the user:
```sql
ALTER ROLE username SET work_mem = '64MB';
```

**- Modification:** Allowed for normal users (session/local)


**🧑‍💼 6. SUPERUSER-BACKEND**

**- Meaning:**
These settings can only be changed by a superuser, and only when starting the server (using the command line or config file).
You cannot modify them with `ALTER SYSTEM` or `SET`.

**- Examples:**
- `allow_system_table_mods`
- `data_directory`

**- How to access/modify:**
In `postgresql.conf` or by command line:
```bash
postgres -D /data --allow-system-table-mods
```

**- Modification:** Only at backend start, by superuser.


**⚙️ 7. BACKEND**
   
**- Meaning:**
Parameters that can be set only when a backend process starts (for example, by pg_ctl or connection parameters).
They cannot be changed later inside a session.

**- Examples:**
- `client_encoding`
- `application_name`
  
**- How to access/modify:**
Set during connection:
```sql
psql "dbname=mydb user=postgres application_name=myapp"
```

**- Modification:** Only at connection start.

### 🔍 Checking the Context of Any Parameter
You can check the context of any configuration variable using:
```sql
SELECT name, context FROM pg_settings WHERE name = 'max_connections';
```
### 🧾 Summary Table
| Context           | Who Can Change It        | When It Takes Effect  | Requires Restart | Example Parameters        |
| ----------------- | ------------------------ | --------------------- | ---------------- | ------------------------- |
| INTERNAL          | Nobody                   | Never                 | —                | —                         |
| POSTMASTER        | Superuser / Config file  | On next restart       | ✅ Yes            | `max_connections`         |
| SIGHUP            | Superuser / Config file  | On reload             | ⚙️ No            | `log_directory`           |
| SUPERUSER         | Superuser                | Immediately (session) | ❌ No             | `log_statement`           |
| USER              | Any user                 | Immediately (session) | ❌ No             | `work_mem`, `search_path` |
| SUPERUSER-BACKEND | Superuser (server start) | At backend start      | ✅ Yes            | `allow_system_table_mods` |
| BACKEND           | Superuser or client      | At backend start      | ✅ Yes            | `application_name`        |



[`⬆️Back to Top`](#-Contents)

------------------------------------------------------------------------------------------------


## 🛠️ Tools Used

- **PostgreSQL** – SQL database
- **DBeaver / pgAdmin** – Tools to manage the database
- **VS Code** – Editor for SQL code

------------------------------------------------------------------------------------------------

## 🎯 My Goal

I want to:

- Practice English and SQL
- Create small but real projects
- Learn step by step with fun ideas

------------------------------------------------------------------------------------------------

## 🤝 Contributing

This is a study project.  
But you can give ideas or tips.  
Feel free to open an issue!

------------------------------------------------------------------------------------------------

[`⬆️Back to Top`](#-Contents)
