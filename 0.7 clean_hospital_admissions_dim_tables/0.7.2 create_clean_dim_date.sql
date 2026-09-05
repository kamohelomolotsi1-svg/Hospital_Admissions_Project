-- 072 create_clean_dim_date

USE clean_hospital_admissions
GO

--DROP TABLE IF EXISTS [stg_hospital_admissions].[dbo].[stg_dim_date]

IF OBJECT_ID('[clean_hospital_admissions].[dbo].[clean_dim_date]', 'U') IS NULL
BEGIN
    CREATE TABLE [clean_hospital_admissions].[dbo].[clean_dim_date]
    (
        [date_id] INT IDENTITY(1, 1) PRIMARY KEY,
        [date_key] INT,
        [full_date] DATE,
        [day_number] TINYINT,
        [day_name] VARCHAR(20),
        [month_number] TINYINT,
        [month_name] VARCHAR(20),
        [quarter_number] TINYINT,
        [year_number] SMALLINT,
        [week_number] TINYINT,
        [day_of_week] TINYINT
    );
END;
GO