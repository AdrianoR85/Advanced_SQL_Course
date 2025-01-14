-- Find the total sales for each product
-- Find the total sales for each product, additonally provide details such order id & order date

-- GROUP BY
-- OBS: In group by we need to add all dimension 
-- OBS: Can't do aggregation and provide details at same time
select
	OrderID,
	OrderDate,
	ProductID,
	sum(Sales) as TotalSales
from Sales.Orders
group by 
	OrderID,
	OrderDate,
	ProductID
go

-- WINDOW FUNCTION
-- OBS:
-- Window Function returns a result for each row

select
	OrderID,
	OrderDate,
	ProductID,
	Sales,
	sum(Sales) over(partition by ProductID) as TotalSalesByProducts
from Sales.Orders
go