  --dim date
CREATE TABLE [computer_std].[dbo].[dim_date](
[DateID] INT IDENTITY(1,1) PRIMARY KEY,
[Purchase_Date] [nvarchar](50) NOT NULL,
[Ship_Date] [nvarchar](50) NOT NULL
);
--2 insert data into date table

INSERT INTO [computer_std].[dbo].[dim_date](Purchase_Date, Ship_Date)

--3 populate the data for dim date table from raw pc data
SELECT DISTINCT Purchase_Date, Ship_Date FROM [computer_std].[dbo].[raw_pc_data]