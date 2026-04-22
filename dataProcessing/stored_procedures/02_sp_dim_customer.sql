USE [computer_std];
GO
--2. Load dim_customer
CREATE OR ALTER PROCEDURE [dbo].[Load_Dim_Customer]
AS
BEGIN
    INSERT INTO [dbo].[dim_customer] (Customer_Name, Customer_Surname, Customer_Contact_Number, Customer_Email_Address)
    SELECT DISTINCT Customer_Name, Customer_Surname, Customer_Contact_Number, Customer_Email_Address 
    FROM [dbo].[raw_pc_data]
    WHERE Customer_Name IS NOT NULL;
END;
GO
