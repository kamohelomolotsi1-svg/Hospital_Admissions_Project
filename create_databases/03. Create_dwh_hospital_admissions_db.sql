-- 03. Create dwh hospital admissions db

IF NOT EXISTS(SELECT * FROM sys.databases WHERE name = 'dwh_hospital_admissions')
  BEGIN
    CREATE DATABASE dwh_hospital_admissions

END
GO