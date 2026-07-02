-- Gold Layer

-- 1. View - Customer Information
-- Unique primary Key
-- data integration - gender column multiple column to unified one
-- proper naming for columns
-- sorting columns in proper order
-- Dimension Or Fact -- table clearly has descriptive data about customer so this is 
-- A DIM TABLE
-- since is dimension Table, Create A Surrgate Key - System Generated unique identifier assigned to each record in a table.
-- DDL based OR Window Function -- WF
-- Create Ovject -- View
CREATE VIEW gold.dim_customers AS
Select
		ROW_NUMBER() OVER (Order by cst_id) AS customer_key,
		ci.cst_id AS customer_id,
		ci.cst_key AS customer_number,
		ci.cst_firstname AS first_name,
		ci.cst_lastname AS last_name,
		la.cntry AS country,
		ci.cst_material_status AS marital_status,
		Case WHEN ci.cst_gndr != 'n/a' THEN ci.cst_gndr -- CRM is the Master for gender Info
			 ELSE COALESCE(ca.gen, 'n/a')
		END AS gender,
		ca.bdate AS birthdate,
		ci.cst_create_date AS create_date
from silver.crm_cust_info ci
LEFT JOIN silver.erp_cust_az12 ca
ON		ci.cst_key = ca.cid
LEFT JOIN silver.erp_loc_a101 la
ON		ci.cst_key = la.cid