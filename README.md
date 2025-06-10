[![Postgres](https://img.shields.io/badge/Postgres-17.5+-blue?logo=postgres)](https://www.postgres.org/)
[![Status](https://img.shields.io/badge/Status-In%20Progress-yellow)]()
# 📘 SQL Learning

Welcome to my SQL learning repository. This is a personal space where I practice and organize everything I learn about SQL, especially advanced topics. I use simple examples, real-world projects, and clear comments in the code to help me understand each concept step by step. My goal is to improve my SQL skills, learn how to write better queries, and practice English at the same time. You will find topics like window functions, subqueries, joins, functions, triggers, and more.

## 🧩 Contents
- [x] [`🕹️ Game Store Project`](#-game-store-project)
- [ ] 🔗 Joins
- [ ] 🔗 Union
- [x] [`🪟 Window Functions`](#-window-functions)
- [x] [`🧩 Subqueries and CTEs`](#-sql-subqueries)
- [ ] [`🧩 CTE - Common Table Expressions`](#-sql-ctes-common-table-expressions)
- [ ] 🔀 Set Operations
- [ ] 🧾 Expressions and Conditional Logic
- [ ] 🧹 Text and Cleaning Functions
- [ ] 🛠️ Function and Trigger Structure
- [ ] 🚀 Query Performance
- [ ] 🔒 Views and Security
- [ ] [`📊 Analysis`](#-analysis)
- [x] [`🛠️ Tools Used`](#-tools-used)
- [x] [`🎯 My Goal`](#-my-goal)
- [x] [`🤝 Contributing`](#-contributing)

## 🎮 Game Store Project

The Game Store Project is a small database I created to help me learn SQL in a practical way. It simulates a simple video game store, with tables for customers, employees, products, purchases, and categories. I use this project to practice creating tables, writing queries, using foreign keys, and analyzing data like sales and customer behavior. This project helps me apply what I learn in real situations and makes studying more interesting.

### 🗺️ Database Diagram
<p align="center">
  <img src="./Game Store Project/Model/game_store_model.png" width="85%" alt="Game Store Database Model"/>
</p>


### 🧱 Tables in the Project

- `Customer` – People who buy games  
- `Address` – Customer address  
- `Employee` – Store workers  
- `Purchase` – Orders from customers  
- `Purchase_item` – Items in each order  
- `Product` – Games in the store  
- `Category` – Type of game (Action, Adventure, etc.)

You can find the SQL code in the [Game Store folder](./Game%20Store%20Project) <!-- Edite se o nome da pasta for diferente -->

---

## 🪟 Window Functions
A window function is a special SQL function.
It does a calculation across rows, but it keeps all the rows in the result.

It does not reduce the number of rows like `GROUP BY` does.

### 📌 When to Use Window Functions

Use a window function when you want to:

- 🔢 Give a row number to each row → `ROW_NUMBER()`
- 🧜‍♂️ Find the rank of each row → `RANK()`, `DENSE_RANK()`, `PERCENT_RANK()`
- 🧗‍♂️ Find the relative position inside a group → `CUME_DIST()`, `NTILE()`
- 👀 Compare a row to the next or previous → `LEAD()`, `LAG()`
- 🎯 Get the first or last value in a group → `FIRST_VALUE()`, `LAST_VALUE()`
- ➕ Make a running total → `SUM() OVER(...)`
- ⚖️ Find a running average → `AVG() OVER(...)`
- 📈 Get the highest or lowest value in a group → `MAX() OVER(...)`, `MIN() OVER(...)`
- 🔁 Count how many rows in a group → COUNT() OVER(...)
- 🧶 Use aggregate functions but keep row details → any function with `OVER(...)`

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

Find the code [here](./window-functions) <!-- Edite conforme o caminho real -->

---
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

---
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

[`🔝Back to Top`](#-Contents)
---

## Function and Trigger Structure
### Function
```sql
 CREATE OR REPLACE FUNCTION function_name()
 RETURNS return_type AS $$
 BEGIN
     -- function logic here
     RETURN ...;
 END;
 $$ LANGUAGE plpgslq;
```

### Trigger
```sql
 CREATE TRIGGER trigger_name()
 { BEFORE | AFTER | INSTEAD OF }
 { INSERT OR UPDATE OR DELETE } ON table_name
 FOR EACH ROW
 EXECUTE { PROCEDURE | FUNCTION } name();
```

---
## 📊 Analysis

This directory contains descriptive and investigative analysis using SQL.  
Inside the `Description and Investigation` folder, you will find the SQL files used for deeper data exploration and reporting.

Explore the SQL scripts [here](./Analysis)

---

## 🛠️ Tools Used

- **PostgreSQL** – SQL database
- **DBeaver / pgAdmin** – Tools to manage the database
- **VS Code** – Editor for SQL code

---

## 🎯 My Goal

I want to:

- Practice English and SQL
- Create small but real projects
- Learn step by step with fun ideas

---

## 🤝 Contributing

This is a study project.  
But you can give ideas or tips.  
Feel free to open an issue!

---
