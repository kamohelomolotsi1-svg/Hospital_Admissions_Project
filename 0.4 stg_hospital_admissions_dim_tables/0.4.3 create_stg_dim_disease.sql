-- select distinct disease details from raw table

SELECT DISTINCT [disease]
FROM [stg_hospital_admissions].[dbo].[hospital_admissions_raw]
---------------------------------------------------------------------

-- 043 create_stg_dim_disease

USE stg_hospital_admissions
GO

IF OBJECT_ID(N'[stg_hospital_admissions].[dbo].[stg_dim_disease]', N'U') IS NULL
CREATE TABLE [stg_hospital_admissions].[dbo].[stg_dim_disease] (
    [Disease_ID] INT IDENTITY(1, 1) PRIMARY KEY,
    [Disease] VARCHAR(255)
    );
GO
