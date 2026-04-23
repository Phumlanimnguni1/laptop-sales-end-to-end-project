USE [computer_std];
GO

-- ====================================================================
-- 1. Salesperson Performance View
-- ====================================================================
CREATE OR ALTER VIEW [dbo].[vw_SalespersonPerformance]
AS
SELECT 
    sp.Sales_Person_Name AS Salesperson_Name,
    sp.Sales_Person_Department AS Department,
    COUNT(f.PcspecID) AS Total_PCs_Sold,
    SUM(f.Sale_Price) AS Total_Revenue,
    SUM(f.Discount_Amount) AS Total_Discounts_Given,
    AVG(f.Sale_Price) AS Average_Sale_Value
FROM 
    [dbo].[fact_pc_sales] f
INNER JOIN 
    [dbo].[dim_salesperson] sp ON f.SalespersonID = sp.SalespersonID
GROUP BY 
    sp.Sales_Person_Name, 
    sp.Sales_Person_Department;
GO

-- ====================================================================
-- 2. Store Profitability View
-- ====================================================================
CREATE OR ALTER VIEW [dbo].[vw_StoreProfitability]
AS
SELECT 
    st.Shop_Name,
    loc.Province_or_City AS Province_City,
    loc.Country_or_State AS Country,
    SUM(f.Sale_Price) AS Gross_Revenue,
    SUM(f.Cost_Price) AS Total_Hardware_Cost,
    SUM(f.Cost_of_Repairs) AS Total_Repair_Costs,
    SUM(f.Sale_Price - f.Cost_Price - f.Cost_of_Repairs) AS Net_Profit,
    -- Avoid division by zero by using NULLIF
    (SUM(f.Sale_Price - f.Cost_Price - f.Cost_of_Repairs) / NULLIF(SUM(f.Sale_Price), 0)) * 100 AS Profit_Margin_Percentage
FROM 
    [dbo].[fact_pc_sales] f
INNER JOIN 
    [dbo].[dim_store] st ON f.StoreID = st.StoreID
INNER JOIN 
    [dbo].[dim_location] loc ON f.LocationID = loc.LocationID
GROUP BY 
    st.Shop_Name, 
    loc.Province_or_City, 
    loc.Country_or_State;
GO

-- ====================================================================
-- 3. PC Spec Popularity View
-- ====================================================================
CREATE OR ALTER VIEW [dbo].[vw_PCSpecPopularity]
AS
SELECT 
    pc.PC_Make AS Make,
    pc.PC_Model AS Model,
    pc.RAM,
    pc.Storage_Type,
    pc.Storage_Capacity,
    COUNT(f.PcspecID) AS Total_Units_Sold,
    SUM(f.Sale_Price) AS Total_Revenue_Generated
FROM 
    [dbo].[fact_pc_sales] f
INNER JOIN 
    [dbo].[dim_pcspec] pc ON f.PcspecID = pc.PcspecID
GROUP BY 
    pc.PC_Make, 
    pc.PC_Model, 
    pc.RAM, 
    pc.Storage_Type, 
    pc.Storage_Capacity;
GO

-- ====================================================================
-- 4. Financial Risk & Credit View
-- ====================================================================
CREATE OR ALTER VIEW [dbo].[vw_FinanceAndCreditRisk]
AS
SELECT 
    pm.Payment_Method,
    COUNT(f.PaymentID) AS Number_of_Transactions,
    SUM(f.Sale_Price) AS Total_Sales_Volume,
    SUM(f.Finance_Amount) AS Total_Amount_Financed,
    AVG(f.Credit_Score) AS Average_Customer_Credit_Score
FROM 
    [dbo].[fact_pc_sales] f
INNER JOIN 
    [dbo].[dim_payment] pm ON f.PaymentID = pm.PaymentID
GROUP BY 
    pm.Payment_Method;
GO

-- ====================================================================
-- 5. Daily Hardware Sales View
-- ====================================================================
CREATE OR ALTER VIEW [dbo].[vw_DailyHardwareSales]
AS
SELECT 
    d.Purchase_Date,
    COUNT(f.PcspecID) AS Daily_Units_Sold,
    SUM(f.Sale_Price) AS Daily_Revenue,
    SUM(f.Sale_Price - f.Cost_Price) AS Daily_Gross_Profit
FROM 
    [dbo].[fact_pc_sales] f
INNER JOIN 
    [dbo].[dim_date] d ON f.DateID = d.DateID
GROUP BY 
    d.Purchase_Date;
GO

-- ====================================================================
-- 6. Regional Channel Revenue View
-- Purpose: Cross-references sales channels with geographic locations
-- it reveals exactly how different areas prefer to shop
-- ====================================================================
CREATE OR ALTER VIEW [dbo].[vw_RegionalChannelRevenue]
AS
SELECT 
    loc.Continent,
    loc.Country_or_State AS Country,
    loc.Province_or_City AS Province_City,
    ch.Channel AS Sales_Channel,
    COUNT(f.SalesID) AS Total_Transactions,
    SUM(f.Sale_Price) AS Total_Revenue,
    AVG(f.Sale_Price) AS Average_Transaction_Value
FROM 
    [dbo].[fact_pc_sales] f
INNER JOIN 
    [dbo].[dim_location] loc ON f.LocationID = loc.LocationID
INNER JOIN 
    [dbo].[dim_channel] ch ON f.ChannelID = ch.ChannelID
GROUP BY 
    loc.Continent,
    loc.Country_or_State,
    loc.Province_or_City,
    ch.Channel;
GO