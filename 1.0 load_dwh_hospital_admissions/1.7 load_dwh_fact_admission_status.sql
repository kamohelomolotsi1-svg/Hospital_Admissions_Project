USE dwh_hospital_admissions;
GO


-- 1.7 load dwh fact admission status 




CREATE OR ALTER PROCEDURE dbo.usp_Load_dwh_fact_admission_status
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @BatchID UNIQUEIDENTIFIER = NEWID();
    DECLARE @StartTime DATETIME = GETDATE();
    DECLARE @RowsInserted INT;

    BEGIN TRY

        INSERT INTO [dwh_hospital_admissions].[dbo].[dwh_fact_admission_status]
        (
            [Patient_ID],
            [Customer_ID],
            [Date_of_Birth_ID],
            [Admission_Date_ID],
            [Discharge_Date_ID],
            [Disease_ID],
            [Severity_ID],
            [Ward_ID],
            [Admission_Status]
        )
        SELECT DISTINCT
            r.[patient_id],
            c.[Customer_ID],

            dob.[date_id] AS [Date_of_Birth_ID],
            adm.[date_id] AS [Admission_Date_ID],
            dis.[date_id] AS [Discharge_Date_ID],

            d.[Disease_ID],
            s.[Severity_ID],
            w.[Ward_ID],

            r.[admission_status]

        FROM [stg_hospital_admissions].[dbo].[hospital_admissions_raw] r

        LEFT JOIN [dwh_hospital_admissions].[dbo].[dwh_dim_customer] c
            ON r.[First_Name] = c.[First_Name]
           AND r.[Surname] = c.[Surname]
            AND r.[National_ID] = c.[National_ID]

        LEFT JOIN [dwh_hospital_admissions].[dbo].[dwh_dim_date] dob
            ON CAST(r.[date_of_birth] AS DATE) = dob.[full_date]

        LEFT JOIN [dwh_hospital_admissions].[dbo].[dwh_dim_date] adm
            ON CAST(r.[admission_date] AS DATE) = adm.[full_date]

        LEFT JOIN [dwh_hospital_admissions].[dbo].[dwh_dim_date] dis
            ON CAST(r.[discharge_date] AS DATE) = dis.[full_date]

        LEFT JOIN [dwh_hospital_admissions].[dbo].[dwh_dim_disease] d
            ON r.[Disease] = d.[Disease]

        LEFT JOIN [dwh_hospital_admissions].[dbo].[dwh_dim_severity] s
            ON r.[Severity] = s.[Severity]

        LEFT JOIN [dwh_hospital_admissions].[dbo].[dwh_dim_ward] w
            ON r.[Ward] = w.[Ward];

        SET @RowsInserted = @@ROWCOUNT;

        INSERT INTO [dwh_hospital_admissions].[dbo].[etl_audit_log]
        (
            [batch_id],
            [procedure_name],
            [start_time],
            [end_time],
            [rows_inserted],
            [status],
            [error_message]
        )
        VALUES
        (
            @BatchID,
            'usp_Load_dwh_fact_admission_status',
            @StartTime,
            GETDATE(),
            @RowsInserted,
            'SUCCESS',
            NULL
        );

    END TRY

    BEGIN CATCH

        INSERT INTO [dwh_hospital_admissions].[dbo].[etl_audit_log]
        (
            [batch_id],
            [procedure_name],
            [start_time],
            [end_time],
            [rows_inserted],
            [status],
            [error_message]
        )
        VALUES
        (
            @BatchID,
            'usp_Load_dwh_fact_admission_status',
            @StartTime,
            GETDATE(),
            0,
            'FAILED',
            ERROR_MESSAGE()
        );

        THROW;

    END CATCH;
END;
GO


---------------------------------------------------------------------

EXEC dbo.usp_Load_dwh_fact_admission_status