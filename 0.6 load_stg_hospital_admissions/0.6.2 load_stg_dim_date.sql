USE stg_hospital_admissions;
GO


-- 062 load stg dim date
CREATE PROCEDURE dbo.usp_Load_stg_dim_date
AS
BEGIN

    SET NOCOUNT ON;

    DECLARE @BatchID UNIQUEIDENTIFIER = NEWID();
    DECLARE @StartTime DATETIME = GETDATE();
    DECLARE @RowsInserted INT;

    BEGIN TRY

        INSERT INTO [stg_hospital_admissions].[dbo].[stg_dim_date]
        (
            date_key,
            full_date,
            day_number,
            day_name,
            month_number,
            month_name,
            quarter_number,
            year_number,
            week_number,
            day_of_week
        )

        SELECT DISTINCT
            CONVERT(INT, CONVERT(CHAR(8), d.full_date, 112)) AS date_key,
            d.full_date,
            DAY(d.full_date) AS day_number,
            DATENAME(WEEKDAY, d.full_date) AS day_name,
            MONTH(d.full_date) AS month_number,
            DATENAME(MONTH, d.full_date) AS month_name,
            DATEPART(QUARTER, d.full_date) AS quarter_number,
            YEAR(d.full_date) AS year_number,
            DATEPART(WEEK, d.full_date) AS week_number,
            DATEPART(WEEKDAY, d.full_date) AS day_of_week

        FROM
        (
            SELECT CAST(date_of_birth AS DATE) AS full_date
            FROM [stg_hospital_admissions].[dbo].[hospital_admissions_raw]
            WHERE date_of_birth IS NOT NULL

            UNION

            SELECT CAST(admission_date AS DATE)
            FROM [stg_hospital_admissions].[dbo].[hospital_admissions_raw]
            WHERE admission_date IS NOT NULL

            UNION

            SELECT CAST(discharge_date AS DATE)
            FROM [stg_hospital_admissions].[dbo].[hospital_admissions_raw]
            WHERE discharge_date IS NOT NULL
        ) d;

        SET @RowsInserted = @@ROWCOUNT;

        INSERT INTO [stg_hospital_admissions].[dbo].[etl_audit_log]
        (
            batch_id,
            procedure_name,
            start_time,
            end_time,
            rows_inserted,
            status,
            error_message
        )
        VALUES
        (
            @BatchID,
            'usp_Load_stg_dim_date',
            @StartTime,
            GETDATE(),
            @RowsInserted,
            'SUCCESS',
            NULL
        );

    END TRY

    BEGIN CATCH

        INSERT INTO [stg_hospital_admissions].[dbo].[etl_audit_log]
        (
            batch_id,
            procedure_name,
            start_time,
            end_time,
            rows_inserted,
            status,
            error_message
        )
        VALUES
        (
            @BatchID,
            'usp_Load_stg_dim_date',
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

----------------------------------------------------------

EXEC dbo.usp_Load_stg_dim_date;