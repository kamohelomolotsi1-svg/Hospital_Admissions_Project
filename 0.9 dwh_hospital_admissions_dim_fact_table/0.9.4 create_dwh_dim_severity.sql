-- 094 create_dwh_dim_severity

USE dwh_hospital_admissions
GO

IF OBJECT_ID(N'[dwh_hospital_admissions].[dbo].[dwh_dim_severity]', N'U') IS NULL
CREATE TABLE [dwh_hospital_admissions].[dbo].[dwh_dim_severity] (
    [Severity_ID] INT IDENTITY(1, 1) PRIMARY KEY,
    [Severity] VARCHAR(255)
    );
GO