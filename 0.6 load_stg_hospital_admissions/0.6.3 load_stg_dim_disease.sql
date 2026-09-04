USE stg_hospital_admissions;
GO


-- 063 load stg dim disease
--DROP PROCEDURE IF EXISTS dbo.usp_Load_stg_dim_customer
CREATE PROCEDURE dbo.usp_Load_stg_dim_disease
AS
BEGIN

    SET NOCOUNT ON;

    DECLARE @BatchID UNIQUEIDENTIFIER = NEWID();
    DECLARE @StartTime DATETIME = GETDATE();
    DECLARE @RowsInserted INT;

    BEGIN TRY

        INSERT INTO [stg_hospital_admissions].[dbo].[stg_dim_disease]
        (
            [Disease]
        )
        SELECT DISTINCT
          [Disease]
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
            'usp_Load_stg_dim_disease',
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
            'usp_Load_stg_dim_disease',
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

EXEC dbo.usp_Load_stg_dim_disease