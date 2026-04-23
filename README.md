# PC Sales Data Engineering Project

Overview
This project simulates a real-world enterprise data platform implementation for a computer hardware retailer using SQL Server. The objective is to design, build, and automate a complete batch data pipeline consisting of:

-  A **Staging Layer** for raw data ingestion.

-  A **Data Warehouse** Layer modeled as a Star Schema for optimized analytics.

-  T-SQL Automation using parameterized stored procedures to load the warehouse.
  
-  Idempotent Pipeline Design ensuring safe, repeatable execution without data duplication.

-  Role-based access control (RBAC) and Analytical Views for business reporting.

The dataset represents transactional PC sales, tracking hardware specifications, store performance, customer details, and complex financial metrics like finance amounts, repair costs, and market prices.

----------------------------------------------------------------------------------------------------
## Architecture

<img width="1340" height="781" alt="data_architecture" src="https://github.com/user-attachments/assets/e10d8da2-fc69-4617-8375-e42b2d7ea75d" />

## Databases

1. **Staging Layer**
   -  Stores raw CSV PC data
   -  No transformations allowed at this ingestion layer.
   -  Used purely as the landing zone for raw operational data.

2. **Data Warehouse Layer** 
   -  Implements a fully normalized Star Schema design.
   -  Contains 9 dimension tables and 1 central fact table.
   -  Used as the single source of truth for reporting and analytics.

----------------------------------------------------------------------------------------------------
## Data Model (Star Schema)
### Fact Table

-  **fact_pc_sales**
   - Cost Price
   - Sale Price
   - Discount Amount
   - Finance Amount
   - Credit Score
   - Cost of Repairs
   - Total Sales per Employee
   - PC Market Price
   - Foreign Keys:
     - LocationID
     - StoreID
     - PcspecID
     - CustomerID
     - SalespersonID
     - PaymentID
     - ChannelID
     - PriorityID
     - DateID

### Dimension Tables
-  dim_location (Continent, Country, Province/City)
-  dim_store (Shop Name, Age)
-  dim_pcspec (Make, Model, RAM, Storage Type/Capacity)
-  dim_customer (Name, Contact, Email)
-  dim_salesperson (Name, Department)
-  dim_payment (Payment Method)
-  dim_channel (Sales Channel)
-  dim_priority (Order Priority)
-  dim_date (Cleaned Purchase & Ship Dates)
  
----------------------------------------------------------------------------------------------------

## ETL Process (T-SQL Automation)

All data loading is automated using SQL Server Stored Procedures. The execution flow follows a strict dependency order:

-  Schema Setup (01_staging_tables.sql): Defines the DDL for all staging, dimension, and fact tables, including Primary and Foreign key constraints.

-  Procedure Deployment (02_stored_procedures.sql): Populate dimension tables and Populate fact table
-  Idempotent Execution: The pipeline requires a pre-load script (DELETE FROM) that clears fact and dimension tables before execution to prevent Cartesian explosions and ensure re-runnable data loads.
-  Include logging and error handling

Manual BULK INSERT statements are not allowed.

----------------------------------------------------------------------------------------------------

## Security & Roles 

### DatabaseAdmin: 
-  Full control
-  Can insert, update, delete
-  Execute stored procedures

### DataAnalyst: 
-  Read-only access to the Data Warehouse
-  Can create analytical views
-  Cannot modify tables
-  Cannot access the staging layer.

### CustomerUser (External): 
-  Read-only access for online shopping

### SalespersonUser (Cashier):
-  Strictly read-only access limited via Row-Level Security (RLS)
-  Can only query `vw_CustomerPurchaseHistory` to view their own past receipts.
-  Blocked from all aggregate business intelligence views and underlying tables.
----------------------------------------------------------------------------------------------------

## Required Analytical Views 
-  vw_DailyHardwareSales: Tracks daily revenue and units sold.
-  vw_StoreProfitability: Analyzes net profit (Sale_Price - Cost_Price - Cost_of_Repairs) by store.
-  vw_PCSpecPopularity: Aggregates sales volume by RAM and Storage capacity configurations.
-  vw_SalespersonPerformance: Ranks employees by total sales and discount amounts given.
-  vw_FinanceAndCreditRisk: Correlates customer credit scores with finance amounts and payment methods.
-  vw_RegionalChannelRevenue: Cross-references sales channels with geographic locations.
