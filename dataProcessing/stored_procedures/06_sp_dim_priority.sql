USE [computer_std];
GO
--6. Load dim_priority
CREATE OR ALTER PROCEDURE [dbo].[Load_Dim_Priority]
AS
BEGIN
    INSERT INTO [dbo].[dim_priority] (Priority)
    SELECT DISTINCT Priority 
    FROM [dbo].[raw_pc_data]
    WHERE Priority IS NOT NULL;
END;
GO
