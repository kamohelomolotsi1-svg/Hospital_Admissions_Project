-- 01. Create stg hospital admissions db

IF NOT EXISTS(SELECT * FROM sys.databases WHERE name = 'stg_hospital_admissions')
  BEGIN
    CREATE DATABASE stg_hospital_admissions

END
GO