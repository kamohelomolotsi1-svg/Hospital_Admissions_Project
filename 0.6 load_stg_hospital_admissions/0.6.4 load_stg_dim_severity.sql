USE stg_hospital_admissions;
GO


-- 064 load stg dim severity

CREATE PROCEDURE dbo.usp_Load_stg_dim_severity
AS
BEGIN

    SET NOCOUNT ON;

    DECLARE @BatchID UNIQUEIDENTIFIER = NEWID();
    DECLARE @StartTime DATETIME = GETDATE();
    DECLARE @RowsInserted INT;

    BEGIN TRY

        INSERT INTO [stg_hospital_admissions].[dbo].[stg_dim_severity]
        (
            [Severity]
        )
        SELECT DISTINCT
          [Severity]
        FROM [stg_hospital_admissions].[dbo].[hospital_admissions_raw];

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
            'usp_Load_stg_dim_severity',
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
            'usp_Load_stg_dim_severity',
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

EXEC dbo.usp_Load_stg_dim_severity