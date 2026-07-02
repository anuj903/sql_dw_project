-- Gold View Products

-- Quality Checks

-- Product Key is Unique and we dont have any duplicates
SELECT prd_key, count(*) FROM (
SELECT 
	pn.prd_id,
    pn.cat_id,
    pn.prd_key,
    pn.prd_nm,
    pn.prd_cost,
    pn.prd_line,
    pn.prd_start_dt,
    pn.prd_end_dt,
	pc.cat,
	pc.subcat,
	pc.maintenance
FROM silver.crm_prd_info pn
LEFT JOIN  silver.erp_px_cat_g1v2 pc
ON			pn.cat_id = pc.id
WHERE prd_end_dt IS NULL		-- Filter out all historical data and keep the current data only
)t GROUP BY prd_key
HAVING COUNT(*) > 1;


-- AFTER Checks

SELECT * FROM gold.dim_products