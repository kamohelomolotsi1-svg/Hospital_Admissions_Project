-- select distinct severity details from raw table

SELECT DISTINCT [severity]
FROM [stg_hospital_admissions].[dbo].[hospital_admissions_raw]
---------------------------------------------------------------------

-- 044 create_stg_dim_severity

USE stg_hospital_admissions
GO

IF OBJECT_ID(N'[stg_hospital_admissions].[dbo].[stg_dim_severity]', N'U') IS NULL
CREATE TABLE [stg_hospital_admissions].[dbo].[stg_dim_severity] (
    [Severity_ID] INT IDENTITY(1, 1) PRIMARY KEY,
    [Severity] VARCHAR(255)
    );
GO