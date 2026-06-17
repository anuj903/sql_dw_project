select * FROM bronze.crm_cust_info;

-- Check for nulls or duplicates in Primary KEY
-- Expectation - No Results

SELECT cst_id, count(*)
FROM bronze.crm_cust_info
group by cst_id
having count(*) > 1 -- OR cst_id IS NULL;


-- CHECK for unwanted spaces
-- Expectation - No Results

SELECT 
	cst_firstname
FROM bronze.crm_cust_info
WHERE cst_firstname != trim(cst_firstname);

SELECT 
	cst_lastname
FROM bronze.crm_cust_info
WHERE cst_lastname != trim(cst_lastname);


-- Data Standardization & consistency 
Select DISTINCT cst_gndr
from bronze.crm_cust_info;

SELECT DISTINCT cst_material_status 
from bronze.crm_cust_info;