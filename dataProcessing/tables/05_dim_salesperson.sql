  --dim sales person
CREATE TABLE [computer_std].[dbo].[dim_salesperson](
[SalespersonID] INT IDENTITY(1,1) PRIMARY KEY,
[Sales_Person_Name] [nvarchar](50) NOT NULL,
[Sales_Person_Department] [nvarchar](50) NOT NULL
);
--2 insert data into salesperson table

INSERT INTO [computer_std].[dbo].[dim_salesperson](Sales_Person_Name, Sales_Person_Department)

--3 populate the data for dim salesperson table from raw pc data
SELECT DISTINCT Sales_Person_Name, Sales_Person_Department FROM [computer_std].[dbo].[raw_pc_data]