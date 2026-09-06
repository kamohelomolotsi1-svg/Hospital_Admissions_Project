-- 095 create_dwh_dim_ward

USE dwh_hospital_admissions
GO

IF OBJECT_ID(N'[dwh_hospital_admissions].[dbo].[dwh_dim_ward]', N'U') IS NULL
CREATE TABLE [dwh_hospital_admissions].[dbo].[dwh_dim_ward] (
    [Ward_ID] INT IDENTITY(1, 1) PRIMARY KEY,
    [Ward] VARCHAR(255)
    );
GO