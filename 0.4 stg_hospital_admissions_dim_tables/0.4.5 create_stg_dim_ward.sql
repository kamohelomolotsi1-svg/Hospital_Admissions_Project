-- select distinct ward details from raw table

SELECT DISTINCT [ward]
FROM [stg_hospital_admissions].[dbo].[hospital_admissions_raw]
---------------------------------------------------------------------

-- 045 create_stg_dim_ward

USE stg_hospital_admissions
GO

IF OBJECT_ID(N'[stg_hospital_admissions].[dbo].[stg_dim_ward]', N'U') IS NULL
CREATE TABLE [stg_hospital_admissions].[dbo].[stg_dim_ward] (
    [Ward_ID] INT IDENTITY(1, 1) PRIMARY KEY,
    [Ward] VARCHAR(255)
    );
GO