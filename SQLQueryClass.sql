-- ruin some queries
-- view customers

select  top 10 *
from DessertDelights.Normalization.Customer
where BillingState = 'TN'

select distinct billingstate
from Normalization.Customer
order by BillingState desc

select billingcity, billingstate
from Normalization.Customer
order by BillingCity


select distinct billingcity, billingstate
from Normalization.Customer
order by BillingState

--count how many you have 
select COUNT (*) AS NumberOfAddresses
from Normalization.DeliveryAddress

-- how many customers do we habe
select count(*) from Normalization.Customer



--want to see all the orders from the customers 
select *
from Normalization.Customer c
	inner join Normalization.Orders o
	on c.customerid = o.CustomerId
	--this was added per the lecture
order by c.customerid


-- see delevery address from the customer 
select c.customerid, c.FirstName, c.Lastname, d.DeliveryStreet, d.DeliveryCity, d.DeliveryState, d.DeliveryZip
from Normalization.Customer c
	inner join Normalization.Orders o on c.customerid = o.CustomerId
		inner join Normalization.DeliveryAddress d on o.DelAddressId = d.AddressId
order by c.customerid

-- how many order do we have per customer
select c.customerid, c.FirstName, c.LastName, count(*) AS [Number of Orders]
from Normalization.Customer c inner join Normalization.Orders o on c.customerid = o.CustomerId
group by c.customerid, c.FirstName, c.LastName
order by 



-- populate the tables fo rthe salesco database
use sbmcguire
insert into [SalesCo].Customer
select distinct CUST_Number, CUST_LNAME, CUST_FNAME, cust_initial, cust_areacode, cust_phone, cust
from importedxls

insert into [SalesCo.].PRODUCT
select distinct vend_number, vend_name, 