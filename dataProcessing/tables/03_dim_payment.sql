  --dim payment method
CREATE TABLE [computer_std].[dbo].[dim_payment](
[PaymentID] INT IDENTITY(1,1) PRIMARY KEY,
[Payment_Method] [nvarchar](50) NOT NULL
);
--2 insert data into payment table
INSERT INTO [computer_std].[dbo].[dim_payment](Payment_Method)

--3 populate the data for dim payment from raw pc data
SELECT DISTINCT Payment_Method FROM [computer_std].[dbo].[raw_pc_data]
