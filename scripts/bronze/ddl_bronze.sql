/*
===============================================================================
DDL Script: Create Bronze Tables
===============================================================================
Script Purpose:
    This script creates tables in the 'bronze' schema, dropping existing tables 
    if they already exist.
	  Run this script to re-define the DDL structure of 'bronze' Tables
===============================================================================
*/

IF OBJECT_ID('bronze.crm_cust_info', 'U') IS NOT NULL
    DROP TABLE bronze.crm_cust_info;
GO

CREATE TABLE bronze.crm_cust_info (
    cst_id              INT,
    cst_key             NVARCHAR(50),
    cst_firstname       NVARCHAR(50),
    cst_lastname        NVARCHAR(50),
    cst_marital_status  NVARCHAR(50),
    cst_gndr            NVARCHAR(50),
    cst_create_date     DATE
);
GO

IF OBJECT_ID('bronze.crm_prd_info', 'U') IS NOT NULL
    DROP TABLE bronze.crm_prd_info;
GO

CREATE TABLE bronze.crm_prd_info (
    prd_id       INT,
    prd_key      NVARCHAR(50),
    prd_nm       NVARCHAR(50),
    prd_cost     INT,
    prd_line     NVARCHAR(50),
    prd_start_dt DATETIME,
    prd_end_dt   DATETIME
);
GO

IF OBJECT_ID('bronze.crm_sales_details', 'U') IS NOT NULL
    DROP TABLE bronze.crm_sales_details;
GO

CREATE TABLE bronze.crm_sales_details (
    sls_ord_num  NVARCHAR(50),
    sls_prd_key  NVARCHAR(50),
    sls_cust_id  INT,
    sls_order_dt INT,
    sls_ship_dt  INT,
    sls_due_dt   INT,
    sls_sales    INT,
    sls_quantity INT,
    sls_price    INT
);
GO

IF OBJECT_ID('bronze.erp_loc_a101', 'U') IS NOT NULL
    DROP TABLE bronze.erp_loc_a101;
GO

CREATE TABLE bronze.erp_loc_a101 (
    cid    NVARCHAR(50),
    cntry  NVARCHAR(50)
);
GO

IF OBJECT_ID('bronze.erp_cust_az12', 'U') IS NOT NULL
    DROP TABLE bronze.erp_cust_az12;
GO

CREATE TABLE bronze.erp_cust_az12 (
    cid    NVARCHAR(50),
    bdate  DATE,
    gen    NVARCHAR(50)
);
GO

IF OBJECT_ID('bronze.erp_px_cat_g1v2', 'U') IS NOT NULL
    DROP TABLE bronze.erp_px_cat_g1v2;
GO

CREATE TABLE bronze.erp_px_cat_g1v2 (
    id           NVARCHAR(50),
    cat          NVARCHAR(50),
    subcat       NVARCHAR(50),
    maintenance  NVARCHAR(50)
);
GO

--- INSERT ---

BULK INSERT BRONZE.CRM_CUST_INFO
FROM 'D:\DOWNLOADS\DATA_WAREHOUSE_PROJECT\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
with(
	FIRSTROW=2, -- FIRSTROW IS HEADER, REAL DATA STARTS FROM 2
	FIELDTERMINATOR=',',--HOW VALUES ARE SPILTED
	TABLOCK
);

BULK INSERT BRONZE.crm_prd_info 
FROM 'D:\DOWNLOADS\DATA_WAREHOUSE_PROJECT\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
with(
	FIRSTROW=2, -- FIRSTROW IS HEADER, REAL DATA STARTS FROM 2
	FIELDTERMINATOR=',',--HOW VALUES ARE SPILTED
	TABLOCK
);

BULK INSERT BRONZE.crm_sales_details 
FROM 'D:\DOWNLOADS\DATA_WAREHOUSE_PROJECT\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
with(
	FIRSTROW=2, -- FIRSTROW IS HEADER, REAL DATA STARTS FROM 2
	FIELDTERMINATOR=',',--HOW VALUES ARE SPILTED
	TABLOCK
);

BULK INSERT BRONZE.erp_loc_a101 
FROM 'D:\DOWNLOADS\DATA_WAREHOUSE_PROJECT\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
with(
	FIRSTROW=2, -- FIRSTROW IS HEADER, REAL DATA STARTS FROM 2
	FIELDTERMINATOR=',',--HOW VALUES ARE SPILTED
	TABLOCK
);
BULK INSERT BRONZE.erp_cust_az12 
FROM 'D:\DOWNLOADS\DATA_WAREHOUSE_PROJECT\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
with(
	FIRSTROW=2, -- FIRSTROW IS HEADER, REAL DATA STARTS FROM 2
	FIELDTERMINATOR=',',--HOW VALUES ARE SPILTED
	TABLOCK
);
BULK INSERT BRONZE.erp_px_cat_g1v2 
FROM 'D:\DOWNLOADS\DATA_WAREHOUSE_PROJECT\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
with(
	FIRSTROW=2, -- FIRSTROW IS HEADER, REAL DATA STARTS FROM 2
	FIELDTERMINATOR=',',--HOW VALUES ARE SPILTED
	TABLOCK
);

