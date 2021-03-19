-- ask about why this is pulling more than one person
SELECT DISTINCT /*sr.SalesRepID,*/ (sr.FirstName +' '+ sr.LastName) as SALES_REP, p.ProductID, od.Quantity  /*COUNT(*) as Sales_Per_Rep*/
FROM JJ.LAB3_SALES_REPS AS sr 
 JOIN JJ.LAB3_ORDER_DETAILS AS od
    ON (sr.SalesRepID = od.OrderID)
 join JJ.LAB3_PRODUCTS as p
	ON p.ProductID = od.OrderID
group by sr.SalesRepID, sr.FirstName, sr.LastName, od.Quantity, od.ProductID
--order by  Sales_Per_Rep sr.SalesRepID, sr.FirstName, sr.LastName, od.Quantity, p.ProductID;



select (sr.FirstName +' '+ sr.LastName) as Sales_Rep, p.ProductID, od.Quantity
from JJ.LAB3_SALES_REPS as sr
inner join JJ.LAB3_CUSTOMERS as c
	on c.SalesRepID = sr.SalesRepID
inner join JJ.LAB3_ORDERS as o 
	on c.CustomerID = o.CustomerID
inner join JJ.LAB3_ORDER_DETAILS as od
	on o.OrderID = od.OrderID
inner join JJ.LAB3_PRODUCTS as p
	on od.ProductID = p.ProductID
group by sr.FirstName, sr.LastName, p.ProductID, od.Quantity





-- come back to this when you ge to the school
use DessertDelights
select * from [Normalization].[DeliveryAddress]

use DessertDelights
select * from [DeNormalization].[DeliveryAddress]


-- for part 1 of the lab
use sbmcguire
select (sr.FirstName +' '+ sr.LastName) as Sales_Rep, count(od.Quantity) as Quantity
from JJ.LAB3_SALES_REPS as sr
inner join JJ.LAB3_CUSTOMERS as c
   on c.SalesRepID = sr.SalesRepID
inner join JJ.LAB3_ORDERS as o
   on c.CustomerID = o.CustomerID
inner join JJ.LAB3_ORDER_DETAILS as od
   on o.OrderID = od.OrderID
group by sr.FirstName, sr.LastName
-------------------------------------------------------------

--looking at the differet tables to determine what needs to change
use sbmcguire
select * from [JJ].[LAB3_ORDER_DETAILS]

select * from [JJ].[LAB3_ORDERS]

select * from [JJ].[LAB3_CUSTOMERS]









-------------------------------


-----------------------









select * from [JJ].[LAB3_ORDER_DETAILS]

select * from [JJ].[LAB3_ORDERS]

select * from [JJ].[LAB3_PRODUCTS]

select * from [JJ].[LAB3_CUSTOMERS]

select * from [JJ].[LAB3_SALES_REPS]

----------------------------------------------------------------------------------------------------------------------------------------------------


-- come back to this when you ge to the school
use DessertDelights
select * from [Normalization].[DeliveryAddress]
 
use DessertDelights
select * from [DeNormalization].[DeliveryAddress]
 
 
-- for part 1 of the lab
use sbmcguire
select (sr.FirstName +' '+ sr.LastName) as Sales_Rep, count(od.Quantity) as Quantity
from JJ.LAB3_SALES_REPS as sr
inner join JJ.LAB3_CUSTOMERS as c
   on c.SalesRepID = sr.SalesRepID
inner join JJ.LAB3_ORDERS as o
   on c.CustomerID = o.CustomerID
inner join JJ.LAB3_ORDER_DETAILS as od
   on o.OrderID = od.OrderID
group by sr.FirstName, sr.LastName
-------------------------------------------------------------
use sbmcguire
select (sr.FirstName +' '+ sr.LastName) as Sales_Rep, count(ao.Quantity) as Quantity
from JJ.LAB3_SALES_REPS as sr
inner join JJ.LAB3_CUSTOMERS as c
	on c.SalesRepID = sr.SalesRepID
inner join JJ.n_LAB3_ALL_ORDER as ao
	on c.CustomerID = ao.CustomerID
group by sr.FirstName, sr.LastName
 
--looking at the differet tables to determine what needs to change
use sbmcguire

 
select * from [JJ].[LAB3_CUSTOMERS]

select * from [JJ].[LAB3_SALES_REPS]

select * from jj.LAB3_ORDERS


--attemptig to merge the tables\
-- come back to go to this website --https://www.mssqltips.com/sqlservertip/1704/using-merge-in-sql-server-to-insert-update-and-delete-at-the-same-time/
use sbmcguire
merge JJ.n_LAB3_ALL_ORDER as target
using JJ.LAB3_ORDERS as source
	on (target.OrderID = source.OrderID)
when matched
	then update set  target.OrderID = source.OrderID, target.OrderDate = source.OrderDate, 
----------------------------------------------------------------------------------------------------------------------------------------------------

































