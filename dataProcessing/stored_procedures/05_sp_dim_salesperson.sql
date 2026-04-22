USE [computer_std];
GO
--5. Load dim_salesperson
CREATE OR ALTER PROCEDURE [dbo].[Load_Dim_Salesperson]
AS
BEGIN
    INSERT INTO [dbo].[dim_salesperson] (Sales_Person_Name, Sales_Person_Department)
    SELECT DISTINCT Sales_Person_Name, Sales_Person_Department 
    FROM [dbo].[raw_pc_data]
    WHERE Sales_Person_Name IS NOT NULL;
END;
GO