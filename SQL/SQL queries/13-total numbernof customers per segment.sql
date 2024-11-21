SELECT 
    segment,
    COUNT(customer_id) AS total_customer
FROM 
    customer_table
GROUP BY 
    segment;