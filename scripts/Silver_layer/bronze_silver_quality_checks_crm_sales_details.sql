SELECT sls_ord_num,
	sls_prd_key,
    sls_cust_id,
    sls_order_dt,
    sls_ship_dt,
    sls_due_dt
    sls_sales,
    sls_quantity,
    sls_price
  FROM bronze.crm_sales_details
-- WHERE sls_ord_num != TRIM(sls_ord_num)		Quality check column sls_ord_num
-- WHERE sls_prd_key NOT IN (SELECT prd_key FROM silver.crm_prd_info)
 WHERE sls_cust_id NOT IN (SELECT cst_id FROM silver.crm_cust_info);

 SELECT sls_order_dt
 from bronze.crm_sales_details 
 WHERE sls_order_dt <= 0 OR LEN(sls_order_dt) !=8;				-- values which not Date or zeros in DATE column

 
 --sls_order_dt date column checks
 SELECT nullif(sls_order_dt, 0)sls_order_dt
 FROM bronze.crm_sales_details
 WHERE sls_order_dt <=0 
 OR LEN(sls_order_dt) != 8 
 OR sls_order_dt > 20500101 
 OR sls_order_dt < 19900101


 
 --sls_due_dt date column checks
 SELECT nullif(sls_due_dt, 0)sls_due_dt
 FROM bronze.crm_sales_details
 WHERE sls_due_dt <=0 
 OR LEN(sls_due_dt) != 8 
 OR sls_due_dt > 20500101 
 OR sls_due_dt < 19900101

 --Invalid Date Orders
SELECT *  FROM bronze.crm_sales_details
WHERE sls_order_dt > sls_ship_dt OR sls_order_dt > sls_due_dt; 


-- Business rules
-- sales = quantity * price

SELECT DISTINCT
sls_price AS old_sls_price,
sls_quantity AS old_sls_quantity, 
sls_sales AS old_sls_sales,

CASE WHEN sls_sales IS NULL OR sls_sales <=0 OR sls_sales != sls_quantity * ABS(sls_price)
	THEN sls_quantity * ABS(sls_price)
	ELSE sls_sales
END AS sls_sales,

CASE WHEN sls_price IS NULL OR sls_price <=0
	THEN sls_sales / NULLIF(sls_quantity, 0)
	ELSE sls_price
END AS sls_price

FROM bronze.crm_sales_details
WHERE sls_sales != sls_quantity * sls_price
OR sls_sales IS NULL OR sls_quantity IS NULL OR sls_price IS NULL
OR sls_sales <=0 OR sls_quantity <0 OR sls_price <= 0
ORDER BY sls_sales;




---------------silver table checks AFTER

SELECT sls_ord_num,
	sls_prd_key,
    sls_cust_id,
    sls_order_dt,
    sls_ship_dt,
    sls_due_dt
    sls_sales,
    sls_quantity,
    sls_price
  FROM silver.crm_sales_details
-- WHERE sls_ord_num != TRIM(sls_ord_num)		Quality check column sls_ord_num
-- WHERE sls_prd_key NOT IN (SELECT prd_key FROM silver.crm_prd_info)
 WHERE sls_cust_id NOT IN (SELECT cst_id FROM silver.crm_cust_info);

 SELECT sls_order_dt
 from silver.crm_sales_details 
 WHERE sls_order_dt <= 0 OR LEN(sls_order_dt) !=8;				-- values which not Date or zeros in DATE column

 
 --sls_order_dt date column checks
 SELECT nullif(sls_order_dt, 0)sls_order_dt
 FROM silver.crm_sales_details
 WHERE sls_order_dt <=0 
 OR LEN(sls_order_dt) != 8 
 OR sls_order_dt > 20500101 
 OR sls_order_dt < 19900101


 
 --sls_due_dt date column checks
 SELECT nullif(sls_due_dt, 0)sls_due_dt
 FROM bronze.crm_sales_details
 WHERE sls_due_dt <=0 
 OR LEN(sls_due_dt) != 8 
 OR sls_due_dt > 20500101 
 OR sls_due_dt < 19900101

 --Invalid Date Orders
SELECT *  FROM silver.crm_sales_details
WHERE sls_order_dt > sls_ship_dt OR sls_order_dt > sls_due_dt; 


-- Business rules
-- sales = quantity * price

SELECT DISTINCT
sls_price AS old_sls_price,
sls_quantity AS old_sls_quantity, 
sls_sales AS old_sls_sales,

CASE WHEN sls_sales IS NULL OR sls_sales <=0 OR sls_sales != sls_quantity * ABS(sls_price)
	THEN sls_quantity * ABS(sls_price)
	ELSE sls_sales
END AS sls_sales,

CASE WHEN sls_price IS NULL OR sls_price <=0
	THEN sls_sales / NULLIF(sls_quantity, 0)
	ELSE sls_price
END AS sls_price

FROM silver.crm_sales_details
WHERE sls_sales != sls_quantity * sls_price
OR sls_sales IS NULL OR sls_quantity IS NULL OR sls_price IS NULL
OR sls_sales <=0 OR sls_quantity <0 OR sls_price <= 0
ORDER BY sls_sales;

