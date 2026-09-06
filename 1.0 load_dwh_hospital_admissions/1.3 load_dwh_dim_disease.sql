USE dwh_hospital_admissions;
GO


-- 1.3 load dwh dim disease

CREATE PROCEDURE dbo.usp_Load_dwh_dim_disease
AS
BEGIN

    SET NOCOUNT ON;

    DECLARE @BatchID UNIQUEIDENTIFIER = NEWID();
    DECLARE @StartTime DATETIME = GETDATE();
    DECLARE @RowsInserted INT;

    BEGIN TRY

        INSERT INTO [dwh_hospital_admissions].[dbo].[dwh_dim_disease]
        (
            [Disease]
        )
        SELECT DISTINCT
          [Disease]
        FROM [clean_hospital_admissions].[dbo].[clean_dim_disease];

        SET @RowsInserted = @@ROWCOUNT;

        INSERT INTO [dwh_hospital_admissions].[dbo].[etl_audit_log]
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
            'usp_Load_dwh_dim_disease',
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
            'usp_Load_dwh_dim_disease',
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

--------------------------------------------------------------------

EXEC dbo.usp_Load_dwh_dim_disease