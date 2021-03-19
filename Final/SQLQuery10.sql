




Select * into sbmcguire.Final.DIM_MinorGroups from dw_Sales.dbo.DIM_MinorGroups; 




USE [dw_Sales]
GO

/****** Object:  Table [dbo].[DIM_MinorGroups]    Script Date: 12/11/2019 8:08:27 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[DIM_MinorGroups](
	[MinorGroupDimId] [int] NULL,
	[MinorGroupId] [int] NULL,
	[MinorGroupName] [nvarchar](255) NULL,
	[MajorGroupId] [int] NULL
) ON [PRIMARY]
GO



--Write a stored procedure by the name spCopyMajorGroupsDimension: (20 pts)
---	Create the stored procedure in your Final schema.
--The stored procedure should insert into your sales fact table -of your final schema
-- sales records from the dw_sales’ sales fact table (FACT_StudentDailySales), 
--based on criteria below.
--Whenever the stored procedure runs, it should retrieve yesterday’s sales from the dw_sales fact table and insert them into your sales fact table.
--Hint: Use the following date to identify yesterday’s sales: convert(date, getdate()-1 ) 

select * into [Final].[FACT_DailySales] from [dw_Sales].[FACT_StudentDailySales];

use dw_Sales
select insert CONVERT(date, getdate()-1 ),[MenuItemDimId],[MajorGroupDimId],[MinorGroupDimId],[PaymentTypeDimId],[DineInSales]
from dw_sales

select CONVERT(date, getdate()-1 ) as SalesDate,[MenuItemDimId],[MajorGroupDimId],[MinorGroupDimId],
[PaymentTypeDimId],[DineInSales] 
into [Final].[FACT_DailySales] from dw_sales.dbo.FACT_StudentDailySales;



--Using the view v_SalesByProduct from the SaleCo database as a source, write a SQL statement 
--that you will include below- to display the total sales by pay type (cash, cc, ..) 
--for the products: [23109-HB], [54778-2T], [14-Q1/L3], and [1558-QW1] (15 pts). 
--The output of your query should look like the following: (15 pts)
--Pay_TYPE	23109-HB	54778-2T	14-Q1/L3	1558-QW1
--    cash		 NULL		9.98		NULL		NULL
--    cc		29.85		14.97		NULL		NULL
--    chk		  NULL		4.99		NULL		NULL
--    cred		19.90		NULL		NULL		NULL
select * from [dbo].[v_SalesByProduct];
use SaleCo
select * from line;
select * from [dbo].[v_SalesByProduct];



use SaleCo
select [INV_PAY_TYPE] as PAY_TYPE, p.[PROD_CODE], l.[LINE_AMOUNT] as SALE_AMOUNT
from INVOICE i
inner join LINE l on i.INV_NUMBER = l.INV_NUMBER
	inner join PRODUCT p on p.PROD_CODE = l.PROD_CODE
where p.PROD_CODE in ('23109-HB', '54778-2T', '14-Q1/L3', '1558-QW1')
order by PROD_CODE;



select * from INVOICE;
select * from PRODUCT;
select * from  LINE;