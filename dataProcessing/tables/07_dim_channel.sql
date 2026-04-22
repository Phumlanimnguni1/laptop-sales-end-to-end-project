  --dim channel
CREATE TABLE [computer_std].[dbo].[dim_channel](
[ChannelID] INT IDENTITY(1,1) PRIMARY KEY,
[Channel] [nvarchar](50) NOT NULL
);
--2 insert data into channel table

INSERT INTO [computer_std].[dbo].[dim_channel](channel)

--3 populate the data for dim channel table from raw pc data
SELECT DISTINCT channel FROM [computer_std].[dbo].[raw_pc_data]