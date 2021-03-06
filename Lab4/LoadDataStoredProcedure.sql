/*    ==Scripting Parameters==

    Source Server Version : SQL Server 2014 (12.0.2269)
    Source Database Engine Edition : Microsoft SQL Server Standard Edition
    Source Database Engine Type : Standalone SQL Server

    Target Server Version : SQL Server 2017
    Target Database Engine Edition : Microsoft SQL Server Standard Edition
    Target Database Engine Type : Standalone SQL Server
*/

USE [DessertDelights]
GO
/****** Object:  StoredProcedure [Reporting].[TruncateAndPopulateAll]    Script Date: 9/18/2019 7:32:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [Reporting].[TruncateAndPopulateAll]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	/*
	Update [DessertDelights].[dbo].[AllImportedData]
	Set Product = 'Stickie bun' where Product = 'stickiebun'

	Update [DessertDelights].[dbo].[AllImportedData]
	Set Product = 'cupcakes' where Product = 'cup cakes'

	Update [DessertDelights].[dbo].[AllImportedData]
	Set PaymentType='Check' where PaymentType = 'Chek'

	Update [DessertDelights].[dbo].[AllImportedData]
	Set PaymentType='CC' where PaymentType = 'CreditCard'
	*/

	Truncate Table DessertDelights.Reporting.customer

	INSERT into DessertDelights.Reporting.Customer
	SELECT distinct 
		[FirstName]
		  ,[LastName]
		  ,[email]
		  ,[gender]
		  ,[Phone]
		  ,[BillingStreet]
		  ,[BillingCity]
		  ,[BillingState]
		  ,[BillingZip]
		  ,[Id]
	  FROM [DessertDelights].[dbo].[AllImportedData]
	

	Truncate Table DessertDelights.Reporting.Orders
	insert into DessertDelights.Reporting.Orders
	SELECT 
		  [OrderNum]
		  ,[OrderDate]
		  ,[Product]
		  ,[TotalBill]/Qty
		  ,[SaleType]
		  ,[PaymentType]
		  ,[Qty]
		  ,[TotalBill]
		  ,[DeliveryStreet]
		  ,[DeliveryCity]
		  ,[DeliveryState]
		  ,[DeliveryZip]
	FROM [DessertDelights].[dbo].[AllImportedData]
	
END
