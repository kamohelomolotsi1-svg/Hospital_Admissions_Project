-- select distinct customer details from raw table

SELECT DISTINCT [first_name],
                [surname],
                [national_id]
FROM [stg_hospital_admissions].[dbo].[hospital_admissions_raw]

----------------------------------------------------------------------------

-- 041 create_stg_dim_customer

USE stg_hospital_admissions
GO

--DROP TABLE IF EXISTS [stg_hospital_admissions].[dbo].[stg_dim_customer]
IF OBJECT_ID(N'[stg_hospital_admissions].[dbo].[stg_dim_customer]', N'U') IS NULL
CREATE TABLE [stg_hospital_admissions].[dbo].[stg_dim_customer] (
    [Customer_ID] INT IDENTITY(1, 1) PRIMARY KEY,
    [First_Name] VARCHAR(255),
    [Surname] VARCHAR(255),
    [National_ID] FLOAT
    );
GO