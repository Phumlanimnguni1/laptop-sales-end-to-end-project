  --dim priority
CREATE TABLE [computer_std].[dbo].[dim_priority](
[PriorityID] INT IDENTITY(1,1) PRIMARY KEY,
[Priority] [nvarchar](50) NOT NULL
);
--2 insert data into priority table

INSERT INTO [computer_std].[dbo].[dim_priority](Priority)

--3 populate the data for dim priority table from raw pc data
SELECT DISTINCT Priority FROM [computer_std].[dbo].[raw_pc_data]