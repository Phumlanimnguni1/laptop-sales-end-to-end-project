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