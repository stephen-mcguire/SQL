
-- run some queries
Use DessertDelights

select top 10 * 
from DessertDelights.normalization.customer 
where BillingState='TN'

select distinct billingstate
from Normalization.customer
ORDER BY BillingState desc

select billingcity, billingstate
from Normalization.Customer
order by BillingState

select distinct billingcity, billingstate
from Normalization.Customer
order by BillingState

select count(*) AS NumberOfAddresses
from Normalization.DeliveryAddress

-- show orders for the customers
select * 
from Normalization.Customer c 
	INNER JOIN Normalization.Orders o 
	ON c.customerid = o.customerid 
order by c.customerid
		 
-- show the delivery addresses for each customer
select c.customerid AS [Customer Identification], c.FirstName, c.Lastname, 
       d.DeliveryStreet, d.DeliveryCity, d.DeliveryState, d.DeliveryZip
from Normalization.Customer c 
	INNER JOIN Normalization.Orders o ON c.customerid = o.customerid
		INNER JOIN Normalization.DeliveryAddress d ON o.DelAddressid = d.AddressId
order by c.customerid

-- how many order do we have per customer
select c.customerid, c.FirstName, c.LastName, count(*) AS [Number of Orders]
from Normalization.Customer c INNER JOIN Normalization.Orders o ON c.customerid = o.customerid 
group by c.customerid, c.FirstName, c.LastName
order by c.customerid


-- Create the tables through DDL
USE [Test]
GO

Create Schema SaleCo

drop table SaleCo.customer
GO
CREATE TABLE SaleCo.[CUSTOMER](
	[CUST_NUMBER] [int] NULL,
	[CUST_LNAME] [varchar](15) NULL,
	[CUST_FNAME] [varchar](15) NULL,
	[CUST_INITIAL] [varchar](1) NULL,
	[CUST_AREACODE] [varchar](3) NULL,
	[CUST_PHONE] [varchar](8) NULL,
	[CUST_BALANCE] [real] NULL
)
GO

drop table SaleCo.Product
GO
CREATE TABLE SaleCo.[PRODUCT](
	[PROD_CODE] [varchar](10) NOT NULL,
	[PROD_DESCRIPT] [varchar](35) NULL,
	[PROD_INDATE] [datetime] NULL,
	[PROD_QOH] [int] NULL,
	[PROD_MIN] [int] NULL,
	[PROD_PRICE] [real] NULL,
	[PROD_DISCOUNT] [real] NULL,
	[VEND_NUMBER] [int] NULL,
 ) 
GO

DROP TABLE SaleCo.Invoice
GO
CREATE TABLE SaleCo.[INVOICE](
	[INV_NUMBER] [int] NOT NULL,
	[CUST_NUMBER] [int] NULL,
	[INV_DATE] [datetime] NULL,
	[INV_SUBTOTAL] [real] NULL,
	[INV_TAX] [real] NULL,
	[INV_TOTAL] [real] NULL,
	[INV_PAY_TYPE] [varchar](5) NULL,
	[INV_PAY_AMOUNT] [real] NULL,
	[INV_BALANCE] [real] NULL
)
GO

DROP TABLE SaleCo.LINE
GO
CREATE TABLE SaleCo.[LINE](
	[INV_NUMBER] [int] NULL,
	[LINE_NUMBER] [int] NULL,
	[PROD_CODE] [varchar](10) NULL,
	[LINE_UNITS] [real] NULL,
	[LINE_PRICE] [real] NULL,
	[LINE_AMOUNT] [real] NULL
)
GO

DROP TABLE SaleCo.[VENDOR]
GO
CREATE TABLE SaleCo.[VENDOR](
	[VEND_NUMBER] [int] NULL,
	[VEND_NAME] [varchar](15) NULL,
	[VEND_CONTACT] [varchar](50) NULL,
	[VEND_AREACODE] [varchar](3) NULL,
	[VEND_PHONE] [varchar](8) NULL,
	[VEND_STATE] [varchar](2) NULL,
	[VEND_ORDER] [varchar](1) NULL
)
GO

-- stop and show diagram

-- constraint to make sure orders are not created with bogus productids and that no one will delete a product that is in an existing order
ALTER TABLE NormalizationFall2019.Orders drop constraint FK_ProductRecord
ALTER TABLE SaleCo.LINE
	ADD CONSTRAINT FK_InvNum
	FOREIGN KEY(INV_NUMBER) 
	REFERENCES SaleCo.Invoice(INV_NUMBER)

-- constraint to make sure nobody deletes a deliveryaddress that is being used by an order
Alter table [SaleCo].[INVOICE]
	ADD CONSTRAINT FK_CustNum
	FOREIGN KEY ([CUST_NUMBER])
	REFERENCES [SaleCo].[CUSTOMER]([CUST_NUMBER])

-- load the data from the staging table

-- import the saleco spreadsheet

-- Populate the tables for the SaleCo database
insert into [SaleCo].Customer
select DISTINCT CUST_Number, CUST_LNAME, CUST_FNAME,cust_initial, cust_areacode,cust_phone, cust_balance
FROM importedxls

insert into [SaleCo].PRODUCT
select distinct prod_code, PROD_DESCRIPT, PROD_INDATE, PROD_QOH, PROD_MIN, PROD_PRICE, PROD_DISCOUNT, VEND_NUMBER
FROM importedxls


insert into [SaleCo].vendor
select distinct vend_number, vend_name, vend_contact, vend_areacode, vend_phone, vend_state, VEND_ORDER
from importedxls

-- this one has a surrogate key so we skip the inv number, try it with customer number and show error
insert into [SaleCo].invoice
select distinct  INV_Number, cust_number, inv_date, INV_SUBTOTAL, INV_TAX, INV_TOTAL, INV_PAY_TYPE, INV_PAY_AMOUNT, INV_BALANCE
from importedxls

-- will show you in the future how to populate the line table

-- should hit foreign key constraint when deleting in this order.
delete from TestJan2.SaleCo.Customer
delete from TestJan2.SaleCo.product
delete from TestJan2.SaleCo.vendor
delete from TestJan2.SaleCo.invoice
