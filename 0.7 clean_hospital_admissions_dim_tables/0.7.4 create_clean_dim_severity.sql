-- 074 create_clean_dim_severity

USE clean_hospital_admissions
GO

IF OBJECT_ID(N'[clean_hospital_admissions].[dbo].[clean_dim_severity]', N'U') IS NULL
CREATE TABLE [clean_hospital_admissions].[dbo].[clean_dim_severity] (
    [Severity_ID] INT IDENTITY(1, 1) PRIMARY KEY,
    [Severity] VARCHAR(255)
    );
GO