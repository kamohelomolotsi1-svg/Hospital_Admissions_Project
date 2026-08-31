-- 02. Create clean hospital admissions db

IF NOT EXISTS(SELECT * FROM sys.databases WHERE name = 'clean_hospital_admissions')
  BEGIN
    CREATE DATABASE clean_hospital_admissions

END
GO