-- QUALITY CHECKS for erp_cust_az12
--Bronze Layer before insertion
-- primary key check from erp_cust_az12 & crm_cust_info
SELECT 
	cid,
	CASE WHEN cid LIKE 'NAS%' THEN SUBSTRING(cid, 4, LEN(cid))
		 ELSE cid
	END AS cid,
	bdate,
    gen
  FROM bronze.erp_cust_az12
  WHERE CASE WHEN cid LIKE 'NAS%' THEN SUBSTRING(cid, 4, LEN(cid))
		 ELSE cid
	END NOT IN (SELECT DISTINCT cst_key FROM silver.crm_cust_info)

-- Identify out of Range date
SELECT DISTinct 
bDate 
FROM bronze.erp_cust_az12
WHERE bdate < '1924-1-1' OR bdate > GETDATE()

-- Data Standerdization and Consitency

SELECT DISTINCT gen ,
	CASE WHEN UPPER(TRIM(gen )) IN ('F', 'FEMALE') THEN 'Female'
		 WHEN UPPER(TRIM(gen )) IN ('M', 'Male') THEN 'Male'
		 ELSE 'n/a'
	END as gen
FROM bronze.erp_cust_az12






--Silver Layer before insertion
-- primary key check from erp_cust_az12 & crm_cust_info
SELECT 
	cid,
	CASE WHEN cid LIKE 'NAS%' THEN SUBSTRING(cid, 4, LEN(cid))
		 ELSE cid
	END AS cid,
	bdate,
    gen
  FROM silver.erp_cust_az12
  WHERE CASE WHEN cid LIKE 'NAS%' THEN SUBSTRING(cid, 4, LEN(cid))
		 ELSE cid
	END NOT IN (SELECT DISTINCT cst_key FROM silver.crm_cust_info)

-- Identify out of Range date
SELECT DISTinct 
bDate 
FROM silver.erp_cust_az12
WHERE bdate < '1924-1-1' OR bdate > GETDATE()

-- Data Standerdization and Consitency

SELECT DISTINCT gen ,
	CASE WHEN UPPER(TRIM(gen )) IN ('F', 'FEMALE') THEN 'Female'
		 WHEN UPPER(TRIM(gen )) IN ('M', 'Male') THEN 'Male'
		 ELSE 'n/a'
	END as gen
FROM silver.erp_cust_az12