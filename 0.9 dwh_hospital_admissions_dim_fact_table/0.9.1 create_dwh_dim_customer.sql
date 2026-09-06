-- 091 create_dwh_dim_customer

USE dwh_hospital_admissions
GO

--DROP TABLE IF EXISTS [clean_hospital_admissions].[dbo].[stg_dim_customer]
IF OBJECT_ID(N'[dwh_hospital_admissions].[dbo].[dwh_dim_customer]', N'U') IS NULL
CREATE TABLE [dwh_hospital_admissions].[dbo].[dwh_dim_customer] (
    [Customer_ID] INT IDENTITY(1, 1) PRIMARY KEY,
    [First_Name] VARCHAR(255),
    [Surname] VARCHAR(255),
    [National_ID] FLOAT
    );
GO