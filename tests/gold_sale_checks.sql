-- Gold Layer 
-- Sales View Test

SELECT * FROM gold.fact_sales



-- Foreign key integrity check
SELECT * FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON c.customer_id = f.customer_id
--WHERE c.customer_id IS NULL

LEFT JOIN gold.dim_products p
ON p.product_key = f.product_key
WHERE p.product_key IS NULL
