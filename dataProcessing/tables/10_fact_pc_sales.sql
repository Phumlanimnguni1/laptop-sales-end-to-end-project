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