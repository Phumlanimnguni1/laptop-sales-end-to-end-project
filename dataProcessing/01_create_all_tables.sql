-- create one database for staging and another database for cleaned dataset known as datawarehouse
--create database computer_std;
--create database computer_whd;

-- staging
--Creating Fact and Dim_tables

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

  --dim payment method
CREATE TABLE [computer_std].[dbo].[dim_payment](
[PaymentID] INT IDENTITY(1,1) PRIMARY KEY,
[Payment_Method] [nvarchar](50) NOT NULL
);
--2 insert data into payment table
INSERT INTO [computer_std].[dbo].[dim_payment](Payment_Method)

--3 populate the data for dim payment from raw pc data
SELECT DISTINCT Payment_Method FROM [computer_std].[dbo].[raw_pc_data]


  --dim pc spec
CREATE TABLE [computer_std].[dbo].[dim_pcspec](
[PcspecID] INT IDENTITY(1,1) PRIMARY KEY,
[PC_Make] [nvarchar](50) NOT NULL,
[PC_Model] [nvarchar](50) NOT NULL,
[Storage_Type] [nvarchar](50) NOT NULL,
[RAM] [nvarchar](50) NOT NULL,
[Storage_Capacity] [nvarchar](50) NOT NULL
);
--2 insert data into pc spec table

INSERT INTO [computer_std].[dbo].[dim_pcspec](PC_Make, PC_Model, Storage_Type, RAM, Storage_Capacity)

--3 populate the data for dim pc spec table from raw pc data
SELECT DISTINCT PC_Make, PC_Model, Storage_Type, RAM, Storage_Capacity FROM [computer_std].[dbo].[raw_pc_data]


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


  --dim priority
CREATE TABLE [computer_std].[dbo].[dim_priority](
[PriorityID] INT IDENTITY(1,1) PRIMARY KEY,
[Priority] [nvarchar](50) NOT NULL
);
--2 insert data into priority table

INSERT INTO [computer_std].[dbo].[dim_priority](Priority)

--3 populate the data for dim priority table from raw pc data
SELECT DISTINCT Priority FROM [computer_std].[dbo].[raw_pc_data]

  --dim channel
CREATE TABLE [computer_std].[dbo].[dim_channel](
[ChannelID] INT IDENTITY(1,1) PRIMARY KEY,
[Channel] [nvarchar](50) NOT NULL
);
--2 insert data into channel table

INSERT INTO [computer_std].[dbo].[dim_channel](channel)

--3 populate the data for dim channel table from raw pc data
SELECT DISTINCT channel FROM [computer_std].[dbo].[raw_pc_data]


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


--PC sales fact table
--insert sales_ID columns
CREATE TABLE [computer_std].[dbo].[fact_pc_sales](
[SalesID] INT IDENTITY(1,1) PRIMARY KEY,
[LocationID] INT,
[StoreID] INT,
[PcspecID] INT,
[CustomerID] INT,
[SalespersonID] INT,
[PaymentID] INT,
[ChannelID] INT,
[PriorityID] INT,
[DateID] INT,
[Cost_Price] decimal(10,2) NOT NULL, 
[Sale_Price] decimal(10,2) NOT NULL,
[Discount_Amount] decimal(10,2) NOT NULL,
[Finance_Amount] decimal(10,2) NOT NULL,
[Credit_Score] decimal(10,2) NOT NULL,
[Cost_of_Repairs] decimal(10,2) NOT NULL, 
[Total_Sales_per_Employee] decimal(10,2) NOT NULL,
[PC_Market_Price] decimal(10,2) NOT NULL, 
CONSTRAINT fk_LocationID
           foreign key (LocationID)
           references [computer_std].[dbo].[dim_location] (LocationID),
CONSTRAINT fk_StoreID
           foreign key (StoreID)
           references [computer_std].[dbo].[dim_store] (StoreID),
CONSTRAINT fk_PcspecID
           foreign key (PcspecID)
           references [computer_std].[dbo].[dim_pcspec] (PcspecID),
CONSTRAINT fk_SalespersonID
           foreign key (SalespersonID)
           references [computer_std].[dbo].[dim_salesperson] (SalespersonID),
CONSTRAINT fk_PaymentID
           foreign key (PaymentID)
           references [computer_std].[dbo].[dim_payment] (PaymentID),
CONSTRAINT fk_ChannelID
           foreign key (ChannelID)
           references [computer_std].[dbo].[dim_channel] (ChannelID),
CONSTRAINT fk_PriorityID
           foreign key (PriorityID)
           references [computer_std].[dbo].[dim_priority] (PriorityID),
CONSTRAINT fk_DateID
           foreign key (DateID)
           references [computer_std].[dbo].[dim_date] (DateID),
CONSTRAINT fk_CustomerID
           foreign key (CustomerID)
           references [computer_std].[dbo].[dim_customer] (CustomerID)
);

--Insert values into table from raw data
INSERT INTO [computer_std].[dbo].[fact_pc_sales](
    [LocationID], 
    [StoreID], 
    [PcspecID], 
    [CustomerID], 
    [SalespersonID], 
    [PaymentID], 
    [ChannelID], 
    [PriorityID], 
    [DateID],
    [Cost_Price], 
    [Sale_Price], 
    [Discount_Amount], 
    [Finance_Amount], 
    [Credit_Score], 
    [Cost_of_Repairs], 
    [Total_Sales_per_Employee], 
    [PC_Market_Price]
)
SELECT 
    loc.LocationID,
    st.StoreID,
    pc.PcspecID,
    cus.CustomerID,
    sp.SalespersonID,
    pay.PaymentID,
    ch.ChannelID,
    pr.PriorityID,
    d.DateID,
    raw.[Cost_Price], 
    raw.[Sale_Price], 
    raw.[Discount_Amount], 
    raw.[Finance_Amount], 
    raw.[Credit_Score], 
    raw.[Cost_of_Repairs], 
    raw.[Total_Sales_per_Employee], 
    raw.[PC_Market_Price]
FROM [computer_std].[dbo].[raw_pc_data] raw
-- You must join every dimension to match the raw text to the new ID
LEFT JOIN [computer_std].[dbo].[dim_location] loc 
    ON raw.Continent = loc.Continent 
    AND raw.Country_or_State = loc.Country_or_State 
    AND raw.Province_or_City = loc.Province_or_City
LEFT JOIN [computer_std].[dbo].[dim_store] st 
    ON raw.Shop_Name = st.Shop_Name 
    AND raw.Shop_Age = st.Shop_Age
LEFT JOIN [computer_std].[dbo].[dim_pcspec] pc 
    ON raw.PC_Make = pc.PC_Make 
    AND raw.PC_Model = pc.PC_Model 
    AND raw.Storage_Type = pc.Storage_Type 
    AND raw.RAM = pc.RAM 
    AND raw.Storage_Capacity = pc.Storage_Capacity
LEFT JOIN [computer_std].[dbo].[dim_customer] cus 
    ON raw.Customer_Name = cus.Customer_Name 
    AND raw.Customer_Surname = cus.Customer_Surname 
    AND raw.Customer_Contact_Number = cus.Customer_Contact_Number 
    AND raw.Customer_Email_Address = cus.Customer_Email_Address
LEFT JOIN [computer_std].[dbo].[dim_salesperson] sp 
    ON raw.Sales_Person_Name = sp.Sales_Person_Name 
    AND raw.Sales_Person_Department = sp.Sales_Person_Department
LEFT JOIN [computer_std].[dbo].[dim_payment] pay 
    ON raw.Payment_Method = pay.Payment_Method
LEFT JOIN [computer_std].[dbo].[dim_channel] ch 
    ON raw.Channel = ch.Channel
LEFT JOIN [computer_std].[dbo].[dim_priority] pr 
    ON raw.Priority = pr.Priority
LEFT JOIN [computer_std].[dbo].[dim_date] d 
    ON raw.Purchase_Date = d.Purchase_Date 
    AND raw.Ship_Date = d.Ship_Date;


--Show all the sales
SELECT *
FROM [computer_std].[dbo].[fact_pc_sales]