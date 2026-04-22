  --dim store
CREATE TABLE [computer_std].[dbo].[dim_store](
[StoreID] INT IDENTITY(1,1) PRIMARY KEY,
[Shop_Name] [nvarchar](50) NOT NULL,
[Shop_Age] INT NOT NULL
);
--2 insert data into store table

INSERT INTO [computer_std].[dbo].[dim_store](Shop_Name, Shop_Age)

--3 populate the data for dim store table from raw pc data
SELECT DISTINCT Shop_Name, Shop_Age FROM [computer_std].[dbo].[raw_pc_data]