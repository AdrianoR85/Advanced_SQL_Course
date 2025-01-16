/*
RANK FUNCTIONS
 - ROW_NUMBER()
 - RANK()
 - DENSE_RANK()
 - CUME_DIST()
 - PERCENT_RANK()
 - NTILE(n)
*/

-- Rank each order based on their sales from highest to lowest 
-- Additonally provide details suck order Id, order date

select
	OrderID,
	OrderDate,
	Sales,
	RANK() over(order by sales desc) as RankSales
from Sales.Orders