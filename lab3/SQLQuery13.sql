USE [sbmcguire]
GO
/****** Object:  StoredProcedure [dbo].[SelectFromImportedxls]    Script Date: 9/18/2019 7:32:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[SelectFromImportedxls]
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	use DessertDelights
update DessertDelights.dbo.AllImportedData
set Product = 'Stickie bun' where Product = 'stickiebun'

update DessertDelights.dbo.AllImportedData
set Product = 'cupcakes' where Product = 'cup cakes'


update DessertDelights.dbo.AllImportedData
set Product = 'Check' where Product = 'Chek'


update DessertDelights.dbo.AllImportedData
set Product = 'CC' where Product = 'CreditCard'
	select * from [dbo].[importedxls]
    -- Insert statements for procedure here
	
END
