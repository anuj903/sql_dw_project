--Check for nullor duplicates in Primary Key
-- expectation: No result

SELECT prd_id, count(*)
FROM bronze.crm_prd_info
group by prd_id
HAVING count(*) > 1 OR prd_id IS NULL

-- check for unwanted spaces
-- Expectation 
select prd_nm
FROM bronze.crm_prd_info
WHERE prd_nm != TRIM(prd_nm)

-- check for Negative numbers
-- Expectation 
select prd_cost
FROM bronze.crm_prd_info
WHERE prd_cost < 0 OR prd_cost IS NULL

-- Data Standardization and consistensy
-- Expectation 
select DISTINCT prd_line
FROM bronze.crm_prd_info

-- Invalid Date checks
-- Expectation 
select *
FROM bronze.crm_prd_info
WHERE prd_end_dt < prd_start_dt

SELECT 
prd_id,
prd_key, 
prd_nm, 
prd_start_dt, 
prd_end_dt,
LEAD(prd_start_dt) OVER(PARTITION BY prd_key ORDER BY prd_start_dt)-1 AS prd_end_date_test
FROM bronze.crm_prd_info
WHERE prd_key IN ('AC-HE-HL-U509-R', 'AC-HE-HL-U509')


--Silver Table CHecks

--Check for nullor duplicates in Primary Key
-- expectation: No result

SELECT prd_id, count(*)
FROM silver.crm_prd_info
group by prd_id
HAVING count(*) > 1 OR prd_id IS NULL

-- check for unwanted spaces
-- Expectation 
select prd_nm
FROM silver.crm_prd_info
WHERE prd_nm != TRIM(prd_nm)

-- check for Negative numbers
-- Expectation 
select prd_cost
FROM silver.crm_prd_info
WHERE prd_cost < 0 OR prd_cost IS NULL

-- Data Standardization and consistensy
-- Expectation 
select DISTINCT prd_line
FROM silver.crm_prd_info

-- Invalid Date checks
-- Expectation 
select *
FROM silver.crm_prd_info
WHERE prd_end_dt < prd_start_dt

SELECT * FROM silver.crm_prd_info


