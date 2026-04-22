USE [computer_std];
GO
CREATE OR ALTER PROCEDURE [dbo].[Load_Fact_PC_Sales]
AS
BEGIN
    INSERT INTO [dbo].[fact_pc_sales](
        [LocationID], 
        [StoreID], 
        [PcspecID], 
        [CustomerID], 
        [SalespersonID], 
        [PaymentID], 
        [ChannelID], 
        [PriorityID], 
        [DateID],
        [Cost_Price], 
        [Sale_Price], 
        [Discount_Amount], 
        [Finance_Amount], 
        [Credit_Score], 
        [Cost_of_Repairs], 
        [Total_Sales_per_Employee], 
        [PC_Market_Price]
    )
    SELECT 
        loc.LocationID,
        st.StoreID,
        pc.PcspecID,
        cus.CustomerID,
        sp.SalespersonID,
        pay.PaymentID,
        ch.ChannelID,
        pr.PriorityID,
        d.DateID,
        raw.[Cost_Price], 
        raw.[Sale_Price], 
        raw.[Discount_Amount], 
        raw.[Finance_Amount], 
        raw.[Credit_Score], 
        raw.[Cost_of_Repairs], 
        raw.[Total_Sales_per_Employee], 
        raw.[PC_Market_Price]
    FROM [dbo].[raw_pc_data] raw
    LEFT JOIN [dbo].[dim_location] loc 
        ON raw.Continent = loc.Continent 
        AND raw.Country_or_State = loc.Country_or_State 
        AND raw.Province_or_City = loc.Province_or_City
    LEFT JOIN [dbo].[dim_store] st 
        ON raw.Shop_Name = st.Shop_Name 
        AND raw.Shop_Age = st.Shop_Age
    LEFT JOIN [dbo].[dim_pcspec] pc 
        ON raw.PC_Make = pc.PC_Make 
        AND raw.PC_Model = pc.PC_Model 
        AND raw.Storage_Type = pc.Storage_Type 
        AND raw.RAM = pc.RAM 
        AND raw.Storage_Capacity = pc.Storage_Capacity
    LEFT JOIN [dbo].[dim_customer] cus 
        ON raw.Customer_Name = cus.Customer_Name 
        AND raw.Customer_Surname = cus.Customer_Surname 
        AND raw.Customer_Contact_Number = cus.Customer_Contact_Number 
        AND raw.Customer_Email_Address = cus.Customer_Email_Address
    LEFT JOIN [dbo].[dim_salesperson] sp 
        ON raw.Sales_Person_Name = sp.Sales_Person_Name 
        AND raw.Sales_Person_Department = sp.Sales_Person_Department
    LEFT JOIN [dbo].[dim_payment] pay 
        ON raw.Payment_Method = pay.Payment_Method
    LEFT JOIN [dbo].[dim_channel] ch 
        ON raw.Channel = ch.Channel
    LEFT JOIN [dbo].[dim_priority] pr 
        ON raw.Priority = pr.Priority
    LEFT JOIN [dbo].[dim_date] d 
        ON raw.Purchase_Date = d.Purchase_Date 
        AND raw.Ship_Date = d.Ship_Date;
END;
GO
-- EXECUTION BLOCK
/*
USE [computer_std]
GO
A. Delete data inside the tables
-- 1. Delete the Fact table data first to release the foreign key locks
DELETE FROM [dbo].[fact_pc_sales];

-- 2. Delete the Dimension tables data
DELETE FROM [dbo].[dim_location];
DELETE FROM [dbo].[dim_customer];
DELETE FROM [dbo].[dim_payment];
DELETE FROM [dbo].[dim_pcspec];
DELETE FROM [dbo].[dim_salesperson];
DELETE FROM [dbo].[dim_priority];
DELETE FROM [dbo].[dim_channel];
DELETE FROM [dbo].[dim_date];
DELETE FROM [dbo].[dim_store];

B. Load data inside the tables

EXEC [dbo].[Load_Dim_Location];
EXEC [dbo].[Load_Dim_Customer];
EXEC [dbo].[Load_Dim_Payment];
EXEC [dbo].[Load_Dim_PCSpec];
EXEC [dbo].[Load_Dim_Salesperson];
EXEC [dbo].[Load_Dim_Priority];
EXEC [dbo].[Load_Dim_Channel];
EXEC [dbo].[Load_Dim_Date];
EXEC [dbo].[Load_Dim_Store];
EXEC [dbo].[Load_Fact_PC_Sales];
*/