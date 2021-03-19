/*
How to use a CTE in SQL Server. Common Table Expression.

it is a temporary result set that is given a name. A name that you can reference 
from a select

https://www.red-gate.com/simple-talk/sql/t-sql-programming/sql-server-cte-basics/

*/

-- Nested select
select *
from saleco.dbo.INVOICE
where CUST_NUMBER in (select CUST_NUMBER
						from saleco.dbo.CUSTOMER where CUST_AREACODE = 615)


-- Let's say I have a rollup of quantities by customer last name
Select c.LastName, sum(o.qty) as TotalQtyPurchased
FROM [Normalization].[Customer] c
	inner join [Normalization].[Orders] o on c.customerid = o.CustomerId
GROUP BY c.LastName

-- instead of creating a temp table, I can use a CTE
WITH 
  ctePurchasesByCustomer (CustomerLastName, TotalPurchased)
  AS
  (
		Select c.LastName, sum(o.qty) as TotalQtyPurchased
		FROM [Normalization].[Customer] c
			inner join [Normalization].[Orders] o on c.customerid = o.CustomerId
		GROUP BY c.LastName
  )
SELECT *
FROM ctePurchasesByCustomer
Order by CustomerLastName Desc

-- Yes I can do this with a subselect but with the CTE, I can do joins, etc. etc.
-- cannot build indexes on a CTE like a temp table
-- Create a CTE that produces CustomerId, TotalQuantity the join that to Reps



