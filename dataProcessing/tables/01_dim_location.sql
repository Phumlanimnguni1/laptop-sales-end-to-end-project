--dim location
CREATE TABLE [computer_std].[dbo].[dim_location](
[LocationID] INT IDENTITY(1,1) PRIMARY KEY,
[Continent] [nvarchar](50) NOT NULL,
[Country_or_State] [nvarchar](50) NOT NULL,
[Province_or_City] [nvarchar](100) NOT NULL
);
--2 insert data into location table
INSERT INTO [Computer_std].[dbo].[dim_location](Continent, Country_or_State, Province_or_City)
--3 populate the data for dim location from raw pc data
SELECT DISTINCT Continent, Country_or_State, Province_or_City FROM [computer_std].[dbo].[raw_pc_data]
