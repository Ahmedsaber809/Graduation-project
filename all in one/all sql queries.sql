-- Retrieves the total sales from the order_table.
SELECT 
    ROUND(SUM(sales), 2) AS total_sales
FROM 
    order_table;

-----------------------------------------------------

-- Retrieves the total number of distinct orders from the order_table.
SELECT 
    COUNT(DISTINCT order_id) AS total_orders
FROM 
    order_table;

-----------------------------------------------------

-- Retrieves the total number of customers from the customer_table.
SELECT 
    COUNT(customer_id) AS total_customer
FROM 
    customer_table;

-----------------------------------------------------

-- Retrieves the total number of products from the product_table.
SELECT 
    COUNT(product_id) AS total_products
FROM 
    product_table;

-----------------------------------------------------

-- Retrieves the total sales for each year from the order_table.
SELECT 
    YEAR(order_date) AS order_year,
    ROUND(SUM(o.sales), 2) AS total_sales
FROM 
    order_table o
GROUP BY 
    YEAR(order_date)
ORDER BY 
    order_year;

-----------------------------------------------------

-- Retrieves the total sales by region from the order_table, ordered by sales in descending order.
SELECT  
    o.region,
    ROUND(SUM(o.sales), 2) AS total_sales
FROM 
    order_table AS o
GROUP BY 
    o.region
ORDER BY 
    total_sales DESC;

-----------------------------------------------------

-- Retrieves the total sales by state from the order_table, ordered by sales in descending order.
SELECT 
    o.state,
    ROUND(SUM(o.sales), 2) AS total_sales
FROM 
    order_table AS o
GROUP BY 
    o.state
ORDER BY 
    total_sales DESC;

-----------------------------------------------------

-- Retrieves the total sales by product category, ordered by sales in descending order.
SELECT  
    p.category,
    ROUND(SUM(o.sales), 2) AS total_sales
FROM 
    order_table AS o
LEFT JOIN 
    product_table AS p
    ON o.product_id = p.product_id
GROUP BY 
    p.category 
ORDER BY 
    total_sales DESC;

-----------------------------------------------------

-- Retrieves the total sales by customer segment, ordered by sales in descending order.
SELECT 
    c.segment,
    ROUND(SUM(o.sales), 2) AS total_sales
FROM 
    order_table AS o
LEFT JOIN 
    customer_table AS c
    ON o.customer_id = c.customer_id
GROUP BY 
    c.segment
ORDER BY 
    total_sales DESC;

-----------------------------------------------------

-- Retrieves the total number of distinct customer segments from the customer_table.
SELECT 
    COUNT(DISTINCT segment) AS number_of_segments
FROM 
    customer_table;

-----------------------------------------------------

-- Retrieves the total number of distinct product categories from the product_table.
SELECT 
    COUNT(DISTINCT category) AS number_of_category
FROM 
    product_table;

-----------------------------------------------------

-- Retrieves the total number of distinct product sub-categories from the product_table.
SELECT 
    COUNT(DISTINCT sub_category) AS number_of_sub_category
FROM 
    product_table;

-----------------------------------------------------

-- Retrieves the total number of customers for each customer segment.
SELECT 
    segment,
    COUNT(customer_id) AS total_customer
FROM 
    customer_table
GROUP BY 
    segment;

-----------------------------------------------------

-- Retrieves the total number of distinct sub-categories for each product category, ordered by sub-category count in descending order.
SELECT 
    category,
    COUNT(DISTINCT sub_category) AS total_sub_category
FROM 
    product_table
GROUP BY 
    category
ORDER BY 
    total_sub_category DESC;

-----------------------------------------------------

-- Retrieves the total number of products for each product category and sub-category, ordered by the number of products in descending order.
SELECT 
    category,
    sub_category,
    COUNT(product_id) AS total_products
FROM 
    product_table
GROUP BY 
    category, sub_category
ORDER BY 
    total_products DESC;

-----------------------------------------------------

-- Retrieves the total number of orders, minimum sale, maximum sale, and average sale from the order_table.
WITH total_sales_per_order AS (
    SELECT 
        order_id,
        ROUND(SUM(sales), 2) AS total_sales
    FROM 
        order_table
    GROUP BY 
        order_id
)
SELECT 
    COUNT(DISTINCT order_id) AS total_orders,
    MIN(total_sales) AS minimum_sale,
    MAX(total_sales) AS maximum_sale,
    ROUND(AVG(total_sales), 2) AS average_sale
FROM 
    total_sales_per_order;

-----------------------------------------------------

-- Retrieves the total sales and total number of distinct orders for each region, ordered by total sales in descending order.
SELECT  
    o.region,
    ROUND(SUM(o.sales), 2) AS total_sales,
    COUNT(DISTINCT order_id) AS total_orders
FROM 
    order_table AS o
GROUP BY 
    o.region
ORDER BY 
    total_sales DESC;

-----------------------------------------------------

-- Retrieves the top 10 states with the highest total sales, ordered by total sales in descending order.
SELECT TOP 10
    o.state,
    ROUND(SUM(o.sales), 2) AS total_sales
FROM 
    order_table AS o
GROUP BY 
    o.state
ORDER BY 
    total_sales DESC;

-----------------------------------------------------

-- Retrieves the top 10 states with the highest number of distinct orders, ordered by total orders in descending order.
SELECT TOP 10
    o.state,
    COUNT(DISTINCT order_id) AS total_orders
FROM 
    order_table AS o
GROUP BY 
    o.state
ORDER BY 
    total_orders DESC;

-----------------------------------------------------

-- Retrieves the top 10 cities with the highest total sales, ordered by total sales in descending order.
SELECT TOP 10
    o.city,
    ROUND(SUM(o.sales), 2) AS total_sales
FROM 
    order_table AS o
GROUP BY 
    o.city
ORDER BY 
    total_sales DESC;

-----------------------------------------------------

-- Retrieves the top 10 cities with the highest number of distinct orders, ordered by total orders in descending order.
SELECT TOP 10
    o.city,
    COUNT(DISTINCT order_id) AS total_orders
FROM 
    order_table AS o
GROUP BY 
    o.city
ORDER BY 
    total_orders DESC;

-----------------------------------------------------

-- Retrieves the total sales and the number of distinct orders for each product category, ordered by total sales in descending order.
SELECT  
    p.category,
    ROUND(SUM(o.sales), 2) AS total_sales,
    COUNT(DISTINCT o.order_id) AS number_of_orders
FROM 
    order_table AS o
LEFT JOIN 
    product_table AS p ON o.product_id = p.product_id
GROUP BY 
    p.category 
ORDER BY  
    total_sales DESC;

-----------------------------------------------------

-- Retrieves the total sales and the number of distinct orders for each product category by year, ordered by category.
SELECT  
    p.category,
    YEAR(o.order_date) AS order_year,
    ROUND(SUM(o.sales), 2) AS total_sales,
    COUNT(DISTINCT o.order_id) AS number_of_orders
FROM 
    order_table AS o
LEFT JOIN 
    product_table AS p ON o.product_id = p.product_id
GROUP BY 
    p.category, YEAR(o.order_date)
ORDER BY 
    p.category;

-----------------------------------------------------

-- Retrieves the total sales for each product sub-category, ordered by total sales in descending order.
SELECT  
    p.sub_category,
    ROUND(SUM(o.sales), 2) AS total_sales
FROM 
    order_table AS o
LEFT JOIN 
    product_table AS p ON o.product_id = p.product_id
GROUP BY 
    p.sub_category 
ORDER BY  
    total_sales DESC;

-----------------------------------------------------

-- Retrieves the number of distinct orders for each product sub-category, ordered by the number of orders in descending order.
SELECT  
    p.sub_category,
    COUNT(DISTINCT o.order_id) AS number_of_orders
FROM 
    order_table AS o
LEFT JOIN 
    product_table AS p ON o.product_id = p.product_id
GROUP BY 
    p.sub_category 
ORDER BY  
    number_of_orders DESC;

-----------------------------------------------------

-- Retrieves the top 10 products with the highest total sales, ordered by total sales in descending order.
SELECT TOP 10
    p.product_name,
    ROUND(SUM(o.sales), 2) AS total_sales
FROM 
    order_table AS o
LEFT JOIN 
    product_table AS p ON o.product_id = p.product_id
GROUP BY 
    p.product_name 
ORDER BY  
    total_sales DESC;

-----------------------------------------------------

-- Retrieves the top 10 products with the highest number of distinct orders, ordered by the number of orders in descending order.
SELECT TOP 10
    p.product_name,
    COUNT(DISTINCT o.order_id) AS number_of_orders
FROM 
    order_table AS o
LEFT JOIN 
    product_table AS p ON o.product_id = p.product_id
GROUP BY 
    p.product_name 
ORDER BY  
    number_of_orders DESC;

-----------------------------------------------------

-- Retrieves the total sales and the number of distinct orders for each customer segment, ordered by total sales in descending order.
SELECT 
    c.segment,
    ROUND(SUM(o.sales), 2) AS total_sales,
    COUNT(DISTINCT o.order_id) AS total_orders
FROM 
    order_table AS o
LEFT JOIN 
    customer_table AS c ON o.customer_id = c.customer_id
GROUP BY 
    c.segment
ORDER BY 
    total_sales DESC;

-----------------------------------------------------

-- Retrieves the top 10 customers with the highest total sales, ordered by total sales in descending order.
SELECT TOP 10
    c.customer_name,
    ROUND(SUM(o.sales), 2) AS total_sales
FROM 
    order_table AS o
LEFT JOIN 
    customer_table AS c ON o.customer_id = c.customer_id
GROUP BY 
    c.customer_name
ORDER BY 
    total_sales DESC;

-----------------------------------------------------

-- Retrieves the top 10 customers with the highest number of distinct orders, ordered by total orders in descending order.
SELECT TOP 10
    c.customer_name,
    COUNT(DISTINCT o.order_id) AS total_orders
FROM 
    order_table AS o
LEFT JOIN 
    customer_table AS c ON o.customer_id = c.customer_id
GROUP BY 
    c.customer_name
ORDER BY 
    total_orders DESC;

-----------------------------------------------------

-- Retrieves the average waiting time (in days) for each shipping mode, ordered by average waiting time in ascending order.
SELECT 
    o.ship_mode,
    AVG(DATEDIFF(DAY, o.order_date, o.ship_date)) AS average_waiting_time
FROM 
    order_table o
WHERE 
    o.ship_mode IN ('First Class', 'Same Day', 'Second Class', 'Standard Class')
GROUP BY 
    o.ship_mode
ORDER BY 
    average_waiting_time ASC;

-----------------------------------------------------

-- Retrieves the total sales for each shipping mode, ordered by total sales in descending order.
SELECT 
    ship_mode,
    ROUND(SUM(sales), 2) AS total_sales 
FROM 
    order_table
GROUP BY 
    ship_mode
ORDER BY 
    total_sales DESC;

-----------------------------------------------------

-- Retrieves the total number of distinct orders for each shipping mode, ordered by total orders in descending order.
SELECT 
    ship_mode,
    COUNT(DISTINCT order_id) AS total_orders 
FROM 
    order_table
GROUP BY 
    ship_mode
ORDER BY 
    total_orders DESC;

-----------------------------------------------------

-- Retrieves the total number of distinct customers for each shipping mode, 
-- and calculates the remaining customers by subtracting the number of customers for that ship mode from the total customer count, ordered by total customers in descending order.
WITH total_customers AS (
    SELECT COUNT(DISTINCT customer_id) AS total_customer_count
    FROM order_table
)
SELECT 
    o.ship_mode, 
    COUNT(DISTINCT o.customer_id) AS total_customers,
    (tc.total_customer_count - COUNT(DISTINCT o.customer_id)) AS remaining_customers
FROM 
    order_table AS o
CROSS JOIN 
    total_customers AS tc
GROUP BY 
    o.ship_mode, tc.total_customer_count
ORDER BY 
    total_customers DESC;

-----------------------------------------------------

-- Retrieves the number of distinct customers who use only one shipping mode, 
-- grouped by the shipping mode they use.
WITH x AS (
    SELECT customer_id,
           COUNT(DISTINCT ship_mode) AS no_of_ship_mode
    FROM order_table
    GROUP BY customer_id
),
y AS (
    SELECT customer_id
    FROM x
    WHERE no_of_ship_mode = 1
)
SELECT o.ship_mode,
       COUNT(DISTINCT o.customer_id) AS nu_o_cus
FROM order_table AS o
WHERE o.customer_id IN (SELECT customer_id FROM y)
GROUP BY o.ship_mode;

-----------------------------------------------------

-- Retrieves the total sales for each combination of shipping mode, product category, and region, ordered by ship mode, product category, and region.
SELECT 
    o.ship_mode,
    p.category,
    o.region,
    ROUND(SUM(o.sales), 2) AS total_sales
FROM 
    order_table o
JOIN 
    product_table p ON o.product_id = p.product_id
JOIN 
    customer_table c ON o.customer_id = c.customer_id
GROUP BY 
    o.ship_mode, p.category, o.region
ORDER BY 
    o.ship_mode, p.category, o.region;

-----------------------------------------------------

-- Retrieves the total sales for each product category by year, along with the previous year's sales and the sales change (difference), ordered by category and year.
WITH sales_trend AS (
    SELECT  
        YEAR(o.order_date) AS order_year,
        p.category,
        ROUND(SUM(o.sales), 2) AS total_sales
    FROM 
        order_table AS o
    LEFT JOIN 
        product_table AS p ON o.product_id = p.product_id
    GROUP BY 
        p.category, YEAR(o.order_date)
)

SELECT 
    order_year,
    category,
    total_sales,
    LAG(total_sales) OVER (PARTITION BY category ORDER BY order_year) AS previous_year_sales,
    ROUND((total_sales - LAG(total_sales) OVER (PARTITION BY category ORDER BY order_year)), 2) AS sales_change
FROM 
    sales_trend
ORDER BY 
    category, order_year;

-----------------------------------------------------

-- Retrieves the total number of orders, total sales amount, and average sales per order grouped by the number of items per order, ordered by the number of items.
WITH OrderItems AS (
    SELECT 
        order_id,
        COUNT(product_id) AS number_of_items,
        SUM(sales) AS total_sales
    FROM 
        order_table
    GROUP BY 
        order_id
)

SELECT 
    number_of_items,
    COUNT(order_id) AS total_orders,
    ROUND(SUM(total_sales), 2) AS total_sales_amount,
    ROUND(AVG(total_sales), 2) AS average_sales_per_order
FROM 
    OrderItems
GROUP BY 
    number_of_items
ORDER BY 
    number_of_items;

-----------------------------------------------------

-- Retrieves the count of co-purchases between product categories and sub-categories, 
-- showing how often pairs of products from different categories and sub-categories are purchased together, 
-- ordered by the number of purchases in descending order.
WITH CoPurchased AS (
    SELECT 
        o1.order_id,
        p1.category AS category_1,
        p1.sub_category AS sub_category_1,
        p2.category AS category_2,
        p2.sub_category AS sub_category_2
    FROM 
        order_table o1
    JOIN 
        product_table p1 ON o1.product_id = p1.product_id
    JOIN 
        order_table o2 ON o1.order_id = o2.order_id
    JOIN 
        product_table p2 ON o2.product_id = p2.product_id
    WHERE 
        p1.product_id <> p2.product_id  
)

SELECT 
    category_1,
    sub_category_1,
    category_2,
    sub_category_2,
    COUNT(*) AS purchase_count
FROM 
    CoPurchased
GROUP BY 
    category_1, sub_category_1, category_2, sub_category_2
ORDER BY 
    purchase_count DESC;

-----------------------------------------------------

-- Retrieves the total number of new and returning customers, 
-- along with the total sales generated by each group (new and returning customers).
WITH CustomerOrders AS (
    SELECT 
        o.customer_id,
        COUNT(o.order_id) AS order_count,
        ROUND(SUM(o.sales), 2) AS total_sales
    FROM 
        order_table o
    GROUP BY 
        o.customer_id
),
NewCustomers AS (
    SELECT 
        customer_id,
        total_sales
    FROM 
        CustomerOrders
    WHERE 
        order_count = 1  
),
ReturningCustomers AS (
    SELECT 
        customer_id,
        total_sales
    FROM 
        CustomerOrders
    WHERE 
        order_count > 1  
)

SELECT 
    (SELECT COUNT(*) FROM NewCustomers) AS new_customer_count,
    (SELECT SUM(total_sales) FROM NewCustomers) AS new_customer_sales,
    (SELECT COUNT(*) FROM ReturningCustomers) AS returning_customer_count,
    (SELECT SUM(total_sales) FROM ReturningCustomers) AS returning_customer_sales;

-----------------------------------------------------

-- Retrieves the Recency, Frequency, and Monetary (RFM) scores for each customer, 
-- categorizing them based on the recency of their last purchase, the frequency of their orders, 
-- and the total amount they have spent. The results are sorted by the highest RFM scores.
WITH RFM_CTE AS (
    SELECT 
        o.customer_id,
        DATEDIFF(DAY, MAX(o.order_date), (SELECT MAX(order_date) FROM order_table)) AS recency, 
        COUNT(o.order_id) AS frequency,  
        ROUND(SUM(o.sales), 2) AS monetary  
    FROM 
        order_table o
    GROUP BY 
        o.customer_id
)

SELECT 
    r.customer_id,
    r.recency,
    r.frequency,
    r.monetary,
    CASE 
        WHEN r.recency <= 2 THEN '5'  
        WHEN r.recency BETWEEN 2 AND 7 THEN '4'
        WHEN r.recency BETWEEN 7 AND 30 THEN '3'
        WHEN r.recency BETWEEN 30 AND 60 THEN '2'
        ELSE '1'  
    END AS recency_score,
    CASE 
        WHEN r.frequency >= 30 THEN '5'  
        WHEN r.frequency BETWEEN 20 AND 30 THEN '4'
        WHEN r.frequency BETWEEN 10 AND 20 THEN '3'
        WHEN r.frequency BETWEEN 5 AND 10 THEN '2'
        ELSE '1'  
    END AS frequency_score,
    CASE 
        WHEN r.monetary >= 15000 THEN '5'  
        WHEN r.monetary BETWEEN 10000 AND 15000 THEN '4'
        WHEN r.monetary BETWEEN 5000 AND 10000 THEN '3'
        WHEN r.monetary BETWEEN 1000 AND 5000 THEN '2'
        ELSE '1'  
    END AS monetary_score
FROM 
    RFM_CTE r
ORDER BY 
    recency_score DESC, frequency_score DESC, monetary_score DESC;

-----------------------------------------------------


