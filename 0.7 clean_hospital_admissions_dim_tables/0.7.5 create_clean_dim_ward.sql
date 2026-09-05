-- 075 create_clean_dim_ward

USE clean_hospital_admissions
GO

IF OBJECT_ID(N'[clean_hospital_admissions].[dbo].[clean_dim_ward]', N'U') IS NULL
CREATE TABLE [clean_hospital_admissions].[dbo].[clean_dim_ward] (
    [Ward_ID] INT IDENTITY(1, 1) PRIMARY KEY,
    [Ward] VARCHAR(255)
    );
GO