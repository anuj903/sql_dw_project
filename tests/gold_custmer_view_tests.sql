-- Gold Layer View
-- Coustomer view

---Checks Before the View 


-- checking the primary key is not duplicated after the joins
Select cst_id, count(*)	 From
	(Select
		ci.cst_id,
		ci.cst_key,
		ci.cst_firstname,
		ci.cst_lastname,
		ci.cst_material_status,
		ci.cst_gndr,
		ci.cst_create_date,
		ca.bdate,
		ca.gen,
		la.cntry
	from silver.crm_cust_info ci
	LEFT JOIN silver.erp_cust_az12 ca
	ON		ci.cst_key = ca.cid
	LEFT JOIN silver.erp_loc_a101 la
	ON		ci.cst_key = la.cid
)t GROUP by cst_id
Having COUNT(*) > 1




-- gender Column check, data validation

Select DISTINCT
		ci.cst_gndr,
		ca.gen,
		Case WHEN ci.cst_gndr != 'n/a' THEN ci.cst_gndr -- CRM is the Master for gender Info
			 ELSE COALESCE(ca.gen, 'n/a')
		END AS new_gen
from silver.crm_cust_info ci
LEFT JOIN silver.erp_cust_az12 ca
ON		ci.cst_key = ca.cid
LEFT JOIN silver.erp_loc_a101 la
ON		ci.cst_key = la.cid
Order By 1,2



-- CHECKS AFTER THE VIEW
select Distinct gender from gold.dim_customers