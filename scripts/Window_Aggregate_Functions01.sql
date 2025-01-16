-- AGGRAGATE FUNCTIONS:
	/* 
	- COUNT(expr)
	- SUM(expr)
	- AVG(expr)
	- MIN(expr)
	- MAX(expr)
	*/
-- Find the total sales across all orders
-- Find the total sales across for each product 
-- Find the total sales for each combination of product and order status
-- Additionally provide details such order id & order date
use SalesDB;
select
	OrderID,
	OrderDate,
	ProductID,
	OrderStatus,
	Sales,
	SUM(Sales) over() TotalSales,
	SUM(Sales) over(partition by ProductID) SalesByProduct,
	SUM(Sales) over(partition by ProductID, OrderStatus) SalesByProductAndStatus
from Sales.Orders


select
	OrderID,
	OrderDate,
	ProductID,
	OrderStatus,
	Sales,
	SUM(Sales) over (partition by OrderStatus order by OrderDate rows between current row and 2 following) TotalSales
from Sales.Orders

select
	OrderID,
	OrderDate,
	ProductID,
	OrderStatus,
	Sales,
	SUM(Sales) over (partition by OrderStatus order by OrderDate 
	rows between 2 preceding and current row) TotalSales
from Sales.Orders