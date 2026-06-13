-- Quality checks for bronze.erp_loc_a101

SELECT 
	REPLACE(cid, '-', '') cid,
	cntry
FROM bronze.erp_loc_a101
WHERE REPLACE(cid, '-', '') NOT IN (SELECT cst_key FROM silver.crm_cust_info);


-- Data Standardization and Consistency

SELECT Distinct 
cntry as Oldcntry,
CASE WHEN TRIM(cntry) = 'DE' THEN 'Germany'
	 WHEN TRIM(cntry) IN ('US' , 'USA') THEN 'United States'
	 WHEN TRIM(cntry) = '' OR cntry IS NULL THEN 'n/a'
	 ELSE TRIM(cntry)
End as cntry
FROM bronze.erp_loc_a101;





-- Insert INTO SIlver LAyer

Insert INTO silver.erp_loc_a101(cid,cntry)
SELECT 

	REPLACE(cid, '-', '') cid,

	CASE WHEN TRIM(cntry) = 'DE' THEN 'Germany'
		 WHEN TRIM(cntry) IN ('US' , 'USA') THEN 'United States'
		 WHEN TRIM(cntry) = '' OR cntry IS NULL THEN 'n/a'
		 ELSE TRIM(cntry)
	End as cntry

FROM bronze.erp_loc_a101;

SELECT * FROM SIlver.erp_loc_a101;

