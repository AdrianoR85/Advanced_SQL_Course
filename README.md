# 📘 SQL Learning

Welcome to my SQL learning repository!  
Here I share my SQL code, small projects, and data analysis.

## 🧩 Contents

- [`🕹️ Game Store Project`](#-game-store-project)
- [`🪟 Window Functions`](#-window-functions)
- [`📊 Analysis`](#-analysis)
- [`🛠️ Tools Used`](#-tools-used)
- [`🎯 My Goal`](#-my-goal)
- [`🤝 Contributing`](#-contributing)

---

## 🎮 Game Store Project

This is a simple database for a fake game store.  
I use it to learn how to:

- Create tables
- Use foreign keys
- Write SELECT queries
- Analyze sales and customers

### 🗺️ Database Diagram

![Game Store Database](./Game%20Store%20Project/Model/game_store_model.png)

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

### Windows Function Syntax
![](./assets/window-syntax.png)

This folder has code examples using:

- `ROW_NUMBER()`
- `RANK()`
- `DENSE_RANK()`
- `LEAD()` and `LAG()`

These are advanced SQL functions.  
They help to compare rows and make better analysis.

Find the code [here](./window-functions) <!-- Edite conforme o caminho real -->

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
 
