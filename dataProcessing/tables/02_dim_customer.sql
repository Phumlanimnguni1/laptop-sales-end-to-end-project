 --dim customer
CREATE TABLE [computer_std].[dbo].[dim_customer](
[CustomerID] INT IDENTITY(1,1) PRIMARY KEY,
[Customer_Name] [nvarchar](50) NOT NULL,
[Customer_Surname] [nvarchar](50) NOT NULL,
[Customer_Contact_Number] [nvarchar](50) NOT NULL,
[Customer_Email_Address] [nvarchar](100) NOT NULL
);
--2 insert data into customer table

INSERT INTO [computer_std].[dbo].[dim_customer](Customer_Name, Customer_Surname, Customer_Contact_Number, Customer_Email_Address)

--3 populate the data for dim customer from raw pc data
SELECT DISTINCT Customer_Name, Customer_Surname, Customer_Contact_Number, Customer_Email_Address FROM [computer_std].[dbo].[raw_pc_data]