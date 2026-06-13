-- Qaulity Checks for bronze erp_px_cat_g1v2

SELECT 
	id,
    cat,
    subcat,
    maintenance
  FROM bronze.erp_px_cat_g1v2;


-- CHECK FOR UNWANTED SPACES

  SELECT *
  FROM bronze.erp_px_cat_g1v2
  WHERE cat != TRIM(cat) OR subcat != TRIM(subcat) OR maintenance != TRIM(maintenance);

-- Data Standardization & consistency

SELECT DISTINCT cat
FROM bronze.erp_px_cat_g1v2

SELECT DISTINCT subcat
FROM bronze.erp_px_cat_g1v2

SELECT DISTINCT maintenance
FROM bronze.erp_px_cat_g1v2






-- INSERT INTO SILVER LAYER
Insert INTO silver.erp_px_cat_g1v2(id,cat,subcat,maintenance)
SELECT 
	id,
    cat,
    subcat,
    maintenance
  FROM bronze.erp_px_cat_g1v2;

 SELECT * FROM silver.erp_px_cat_g1v2