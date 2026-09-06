-- 093 create_dwh_dim_disease

USE dwh_hospital_admissions
GO

IF OBJECT_ID(N'[dwh_hospital_admissions].[dbo].[dwh_dim_disease]', N'U') IS NULL
CREATE TABLE [dwh_hospital_admissions].[dbo].[dwh_dim_disease] (
    [Disease_ID] INT IDENTITY(1, 1) PRIMARY KEY,
    [Disease] VARCHAR(255)
    );
GO