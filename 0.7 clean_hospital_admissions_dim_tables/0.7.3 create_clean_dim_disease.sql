-- 073 create_clean_dim_disease

USE clean_hospital_admissions
GO

IF OBJECT_ID(N'[clean_hospital_admissions].[dbo].[clean_dim_disease]', N'U') IS NULL
CREATE TABLE [clean_hospital_admissions].[dbo].[clean_dim_disease] (
    [Disease_ID] INT IDENTITY(1, 1) PRIMARY KEY,
    [Disease] VARCHAR(255)
    );
GO