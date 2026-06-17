-- Transform and Insert INSERT DATA Into Silver Layer - silver.erp_cust_az12


INSERT INTO silver.erp_cust_az12(cid,bdate,gen)
SELECT 
	
	CASE WHEN cid LIKE 'NAS%' THEN SUBSTRING(cid, 4, LEN(cid))
		 ELSE cid
	END AS cid,

	CASE WHEN bdate > GETDATE() THEN NULL
		ELSE bdate
	END AS bdate,

    CASE WHEN UPPER(TRIM(gen )) IN ('F', 'FEMALE') THEN 'Female'
		 WHEN UPPER(TRIM(gen )) IN ('M', 'Male') THEN 'Male'
		 ELSE 'n/a'
	END as gen

  FROM bronze.erp_cust_az12




SELECT * FROM silver.erp_cust_az12