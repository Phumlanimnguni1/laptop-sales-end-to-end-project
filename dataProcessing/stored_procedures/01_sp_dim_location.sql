USE [computer_std];
GO
-- 1. Load dim_location
CREATE OR ALTER PROCEDURE [dbo].[Load_Dim_Location]
AS
BEGIN
    INSERT INTO [dbo].[dim_location] (Continent, Country_or_State, Province_or_City)
    SELECT DISTINCT Continent, Country_or_State, Province_or_City 
    FROM [dbo].[raw_pc_data]
    WHERE Continent IS NOT NULL; 
END;
GO