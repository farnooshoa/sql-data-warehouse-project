
/*
=====================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
======================================================
Script Purpose:
	This stored procedure loads data into 'bronze' schema from external CSV files.
	It performs the follwing actions:
		- turncate the bronze tables before laoding data.
		- Uses the 'BULK INSERT' command to load data from csv Files to bronze tables.

Parameters: 
	None
	This stored procedure does not accept any parameters or erturn any valuses
		
Usage Example:
	EXEC bronze.load_bronze;

*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN 
	DECLARE @start_time DATETIME, @end_time DATETIME,@batch_start_time DATETIME, @batch_end_time DATETIME;
	BEGIN TRY
		SET @batch_start_time=GETDATE();
		PRINT '========================================';
		PRINT 'Loading Bronze Layer';
		PRINT '========================================';


		Print'------------------------------------------';
		PRINT 'Loading CRM Table';
		PRINT'------------------------------------------';

		SET @start_time =GETDATE();
		PRINT '>> Truncating Table: bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info;
		PRINT '>> Inserting Data Into: bronze.crm_cust_info';
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\Farnoosh\Desktop\SQL\dwh-project\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK 
		);
		SET @end_time =GETDATE();
		PRINT '>> LOAD DURATION:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' second';
		PRINT'>>------'

		SET @start_time =GETDATE();
		PRINT '>> Truncating Table: bronze.crm_prd_info';
		TRUNCATE TABLE bronze.crm_prd_info;
		PRINT '>> Inserting Data Into: bronze.crm_prd_info';
		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\Farnoosh\Desktop\SQL\dwh-project\datasets\source_crm\prd_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK 
		);
		SET @end_time =GETDATE();
		PRINT '>> LOAD DURATION:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' second';
		PRINT'>>------'

		SET @start_time =GETDATE();
		PRINT '>> Truncating Table: bronze.crm_sales_details';
		TRUNCATE TABLE bronze.crm_sales_details;
		PRINT '>> Inserting Data Into: bronze.crm_sales_details';
		BULK INSERT bronze.crm_sales_details
		FROM 'C:\Users\Farnoosh\Desktop\SQL\dwh-project\datasets\source_crm\sales_details.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK 
		);
		SET @end_time =GETDATE();
		PRINT '>> LOAD DURATION:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' second';
		PRINT'>>------'


		Print'------------------------------------------';
		PRINT 'Loading ERP Table';
		PRINT'------------------------------------------';

		SET @start_time =GETDATE();
		PRINT '>> Truncating Table: bronze.erp_cust_az12';
		TRUNCATE TABLE bronze.erp_cust_az12;

		PRINT '>> Inserting Data Into: bronze.erp_cust_az12';
		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\Users\Farnoosh\Desktop\SQL\dwh-project\datasets\source_erp\CUST_AZ12.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK 
		);
		SET @end_time =GETDATE();
		PRINT '>> LOAD DURATION:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' second';
		PRINT'>>------'


		SET @start_time =GETDATE();
		PRINT '>> Truncating Table: bronze.erp_loc_a101';
		TRUNCATE TABLE bronze.erp_loc_a101;
 
 		PRINT '>> Inserting Data Into: bronze.erp_loc_a101';
		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\Users\Farnoosh\Desktop\SQL\dwh-project\datasets\source_erp\LOC_A101.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK 
		);
		SET @end_time =GETDATE();
		PRINT '>> LOAD DURATION:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' second';
		PRINT'>>------'



		SET @start_time =GETDATE();
		PRINT '>> Truncating Table: bronze.erp_px_cat_g1v2';
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;

		PRINT '>> Inserting Data Into: bronze.crm_cust_info';
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\Users\Farnoosh\Desktop\SQL\dwh-project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK 
		);
		SET @end_time =GETDATE();
		PRINT '>> LOAD DURATION:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' second';
		PRINT'>>------'


		SET @batch_end_time = GETDATE();
		PRINT'=================================================='
		PRINT'Loading Bronze Layer is Completes';
		PRINT'     -Total Load Duration: ' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' second';
		PRINT'=================================================='
	END TRY
BEGIN CATCH
	PRINT '======================================='
	PRINT 'ERRPR OCCURED DURING LOADING BRONZE LAYER'
	PRINT 'Error Message' + ERROR_MESSAGE();
	PRINT 'Error Message' + CAST(ERROR_NUMBER() AS NVARCHAR);
	PRINT 'Error Message' + CAST(ERROR_STATE() AS NVARCHAR);
	PRINT '======================================='
END CATCH
END
GO 

