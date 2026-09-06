-- 092 create_dwh_dim_date

USE dwh_hospital_admissions
GO

--DROP TABLE IF EXISTS [stg_hospital_admissions].[dbo].[stg_dim_date]

IF OBJECT_ID('[dwh_hospital_admissions].[dbo].[dwh_dim_date]', 'U') IS NULL
BEGIN
    CREATE TABLE [dwh_hospital_admissions].[dbo].[dwh_dim_date]
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