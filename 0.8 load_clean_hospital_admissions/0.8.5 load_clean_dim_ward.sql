USE clean_hospital_admissions;
GO


-- 085 load clean dim ward

CREATE PROCEDURE dbo.usp_Load_clean_dim_ward
AS
BEGIN

    SET NOCOUNT ON;

    DECLARE @BatchID UNIQUEIDENTIFIER = NEWID();
    DECLARE @StartTime DATETIME = GETDATE();
    DECLARE @RowsInserted INT;

    BEGIN TRY

        INSERT INTO [clean_hospital_admissions].[dbo].[clean_dim_ward]
        (
            [Ward]
        )
        SELECT DISTINCT
          [Ward]
        FROM [stg_hospital_admissions].[dbo].[stg_dim_ward];

        SET @RowsInserted = @@ROWCOUNT;

        INSERT INTO [clean_hospital_admissions].[dbo].[etl_audit_log]
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
            'usp_Load_clean_dim_ward',
            @StartTime,
            GETDATE(),
            @RowsInserted,
            'SUCCESS',
            NULL
        );

    END TRY

    BEGIN CATCH

        INSERT INTO [clean_hospital_admissions].[dbo].[etl_audit_log]
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
            'usp_Load_clean_dim_ward',
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

EXEC dbo.usp_Load_clean_dim_ward