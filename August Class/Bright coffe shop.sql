
--Stating which database and schema to be used 
USE brightcoffee.shop;

SELECT DISTINCT product_category
FROM brightcoffee.shop.sales;

--Running the full table
SELECT*
FROM brightcoffee.shop.sales;

-- This is to check my data, how it looks like before I start processing
SELECT * 
FROM workspace.default.bright_coffee_shop 
LIMIT 100;

-- How many stores do we have?
-- to check the name of the stores locations that i have
SELECT DISTINCT store_location
FROM brightcoffee.shop.sales;

-- What is the period of this data?
-- when did we start collecting this data, and when last did we collect the last record
SELECT MIN(transaction_date) AS start_dt,
       MAX(transaction_date) AS last_dt 
FROM brightcoffee.shop.sales;

-- What are the business hours of the shop?
SELECT MIN(transaction_time) AS opening_time,
       MAX(transaction_time) AS closing_time 
FROM brightcoffee.shop.sales;

-- how many different products are we selling in total?
SELECT  COUNT(DISTINCT product_id)AS number_of_products
FROM brightcoffee.shop.sales;

-- How many products are we selling per store?
SELECT  store_location,
        COUNT(DISTINCT product_id)AS number_of_products
FROM brightcoffee.shop.sales
GROUP BY store_location;

-- What are the different product category we have?
SELECT DISTINCT product_category, product_type, product_detail
FROM brightcoffee.shop.sales
WHERE product_category IN ('Coffee')
ORDER BY product_type;







  ---Big Code
  SELECT 
    transaction_date,
      ---From original table
    DAYNAME(transaction_date) AS Day_name, ---DAYNAME gives the name of a specific date. This will be a new column
    MONTHNAME(transaction_date) AS Month_name, ---MONTHNAME gives the name of a month. This will be a new column
    COUNT(transaction_id) AS number_of_sales, ---Counting all the rows. This will be a new column
    SUM(transaction_qty) AS units_sold, ---Calculating total units sold. This will be a new column
    COUNT(DISTINCT product_id) AS unique_products, ---Counting the number of unique products. New column
    COUNT(store_id) AS number_of_stores, ---Counts all the rows. New column
    ROUND(transaction_qty * CAST(REPLACE(unit_price, ',', '.') AS DOUBLE),2) AS total_amount,---Calculating the total revenue using Trans qty x unit price. New column

---1. Case statements always create buckets for enhaced analyses
---This case statement is classifying the DAYNAME column into day classification buckets. This is a new column  
    CASE 
        WHEN DAYNAME(transaction_date) IN ('Saturday','Sunday') THEN 'Weekend'
        WHEN DAYNAME(transaction_date) IN ('Monday','Tuesday','Wednesday','Thursday','Friday') THEN 'Weekday'
    END AS day_classification,

---This case statement is classifying the transaction time column into day time buckets. This is a new column
    -- CASE 
    --     WHEN transaction_time BETWEEN '06:00:00' AND '11:59:59' THEN 'Morning'
    --     WHEN transaction_time BETWEEN '12:00:00' AND '17:59:59' THEN 'Afternoon'
    --     WHEN transaction_time BETWEEN '18:00:00' AND '20:59:59' THEN 'Evening'
    -- END AS time_classification,  

        CASE
            WHEN HOUR(transaction_time) BETWEEN 6 AND 11 THEN 'Morning'
            WHEN HOUR(transaction_time) BETWEEN 12 AND 16 THEN 'Afternoon'
            WHEN HOUR(transaction_time) BETWEEN 17 AND 20 THEN 'Evening'
            ELSE 'Night'
        END AS time_of_day,

    store_location,
    product_category,
    product_type,
    product_detail

FROM sales

GROUP BY 
    transaction_date,
    month_name,
    store_location,
    product_category,
    product_type,
    product_detail
    transaction_time;




    CASE 
        WHEN DAYNAME(transaction_date) IN ('Saturday','Sunday') THEN 'Weekend'
        WHEN DAYNAME(transaction_date) IN ('Monday','Tuesday','Wednesday','Thursday','Friday') THEN 'Weekday'
    END,

    --CASE 
        --WHEN transaction_time BETWEEN '06:00:00' AND '11:59:59' THEN 'Morning'
        --WHEN transaction_time BETWEEN '12:00:00' AND '17:59:59'  THEN 'Afternoon'
        --WHEN transaction_time BETWEEN '18:00:00' AND '20:59:59' THEN 'Evening'
    ---END

-----------------------------------------------------------------------------------------------------------------------------------------

---Corrected Big Code
    SELECT 
    transaction_date,-- From original table
    DAYNAME(transaction_date) AS day_name,
    MONTHNAME(transaction_date) AS month_name,

    -- Sales metrics
    COUNT(transaction_id) AS number_of_sales,
    SUM(transaction_qty) AS units_sold,
    COUNT(DISTINCT product_id) AS unique_products,
    COUNT(DISTINCT store_id) AS number_of_stores,

    -- Total revenue
    ROUND(SUM(transaction_qty * CAST(REPLACE(unit_price, ',', '.') AS DOUBLE)),2) AS total_amount,

    -- Classifying the day
    CASE 
        WHEN DAYNAME(transaction_date) IN ('Sat', 'Sun') 
            THEN 'Weekend'
            WHEN DAYNAME(transaction_date) IN ('Mon','Tue','Wed','Thu','Fri') 
            THEN 'Weekday'
    END AS day_classification,

    -- Classifying the transaction time
    CASE
        WHEN HOUR(transaction_time) BETWEEN 6 AND 11 THEN 'Morning'
        WHEN HOUR(transaction_time) BETWEEN 12 AND 16 THEN 'Afternoon'
        WHEN HOUR(transaction_time) BETWEEN 17 AND 20 THEN 'Evening'
        ELSE 'Night'
    END AS time_of_day,

    store_location,
    product_category,
    product_type,
    product_detail

FROM brightcoffee.shop.sales

GROUP BY

    transaction_date,
    store_location,
    product_category,
    product_type,
    product_detail,
    CASE
        WHEN HOUR(transaction_time) BETWEEN 6 AND 11 
            THEN 'Morning'
        WHEN HOUR(transaction_time) BETWEEN 12 AND 16 
            THEN 'Afternoon'
        WHEN HOUR(transaction_time) BETWEEN 17 AND 20 
            THEN 'Evening'
        ELSE 'Night'
    END;
