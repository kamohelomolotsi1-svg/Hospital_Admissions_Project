-- select distinct admision status details from dwh table

SELECT DISTINCT [patient_id],
				[admission_status]
FROM [stg_hospital_admissions].[dbo].[hospital_admissions_raw]
-------------------------------------------------------------------------

USE dwh_hospital_admissions;
GO

-- 1.6 load dwh fact admissions status
--DROP TABLE IF EXISTS [dwh_hospital_admissions].[dbo].[dwh_fact_admission_status]
IF OBJECT_ID(N'[dwh_hospital_admissions].[dbo].[dwh_fact_admission_status]', N'U') IS NULL
CREATE TABLE [dwh_hospital_admissions].[dbo].[dwh_fact_admission_status] (
    [Admissions_ID] INT IDENTITY(1, 1) PRIMARY KEY,
    [Patient_ID] VARCHAR(255),

    [Customer_ID] INT,

    [Date_of_Birth_ID] INT,
    [Admission_Date_ID] INT,
    [Discharge_Date_ID] INT,

    [Disease_ID] INT,
    [Severity_ID] INT,
    [Ward_ID] INT,

    [Admission_Status] VARCHAR(255),


   CONSTRAINT FK_Fact_Admission_Status_Customer
   FOREIGN KEY([Customer_ID])
   REFERENCES [dwh_hospital_admissions].[dbo].[dwh_dim_customer]([Customer_ID]),

  
   CONSTRAINT FK_FactHospitalAdmissions_DateOfBirth
   FOREIGN KEY ([Date_of_Birth_ID])
   REFERENCES [dwh_hospital_admissions].[dbo].[dwh_dim_date]([date_id]),

   CONSTRAINT FK_Fact_AdmissionDate
   FOREIGN KEY ([Admission_Date_ID])
   REFERENCES [dwh_hospital_admissions].[dbo].[dwh_dim_date]([date_id]),

   CONSTRAINT FK_Fact_DischargeDate
   FOREIGN KEY ([Discharge_Date_ID])
   REFERENCES [dwh_hospital_admissions].[dbo].[dwh_dim_date]([date_id]),

   CONSTRAINT FK_Fact_Admission_Disease
   FOREIGN KEY([Disease_ID])
   REFERENCES [dwh_hospital_admissions].[dbo].[dwh_dim_disease]([Disease_ID]),

   CONSTRAINT FK_Fact_Admission_Severity
   FOREIGN KEY([Severity_ID])
   REFERENCES [dwh_hospital_admissions].[dbo].[dwh_dim_severity]([Severity_ID]),

   CONSTRAINT FK_Fact_Admission_Ward
   FOREIGN KEY([Ward_ID])
   REFERENCES [dwh_hospital_admissions].[dbo].[dwh_dim_ward]([Ward_ID])

);
GO

