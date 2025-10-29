SELECT *
FROM Bright.Coffee.Shop;


---Exploratory Data Analysis----

---Checking number of coffee stores
SELECT DISTINCT store_location
FROM Bright.Coffee.Shop;

---Checking number of product categories
SELECT DISTINCT product_category
FROM Bright.Coffee.Shop;

---Checking number of pro



+duct type
SELECT DISTINCT product_type
FROM Bright.Coffee.Shop;

------Date & Time Functions
-----Checking the earliest transaction date
SELECT MIN (transaction_date) AS first_operating_date
FROM Bright.Coffee.Shop;

-----Checking the latest transaction date
SELECT MAX (transaction_date) AS last_operating_date
FROM Bright.Coffee.Shop;

-----Checking the earliest time
SELECT MIN (transaction_time) AS earliest_time
FROM Bright.Coffee.Shop;

-----Checking the earliest time
SELECT MAX (transaction_time) AS latest_time
FROM Bright.Coffee.Shop;

--------------------------------------------------------------------------------------------------------
SELECT *
FROM Bright.Coffee.Shop;


SELECT transaction_date,
       DAYNAME (transaction_date) AS day_name,
       CASE
            WHEN day_name IN ('Sat','Sun') THEN 'Weekend'
            ELSE 'Weekday'
       END AS day_classification,
       MONTHNAME(transaction_date) AS month_name, 
       ---transaction_time,
       CASE
            WHEN transaction_time BETWEEN '06:00:00' AND '11:59:00' THEN 'Morning'
            WHEN transaction_time BETWEEN '12:00:00' AND '16:59:00' THEN 'Afternoon'
            WHEN transaction_time >= '17:00:00' THEN 'Evening'
        END AS time_bucket,
        HOUR(transaction_time) AS hour_of_day,
        store_location,
        product_category,
        product_detail,
        product_type,    
        ---unit_price,
        ---transaction_qty,
        COUNT (DISTINCT transaction_id) AS Number_of_Sales,
        SUM(transaction_qty* unit_price) AS Revenue
FROM Bright.Coffee.Shop
GROUP BY ALL;




-----------------------------------------------------------------------------------------------------------------

SELECT 
transaction_date, 
        DAYNAME(transaction_date) AS day_name,
        CASE 
        WHEN day_name IN ('Sat','Sun') THEN 'Weekend'
        ELSE 'Weekday'
        END AS day_classification,
        MONTHNAME(transaction_date) AS month_name,
         -- transaction_time,
         CASE
             WHEN transaction_time BETWEEN '06:00:00' AND '11:59:00' THEN 'Morning'
             WHEN transaction_time BETWEEN '12:00:00' AND '16:59:00' THEN 'Afternoon'
             WHEN transaction_time >='17:00:00' THEN 'Evening'
         END AS time_classification,
         HOUR (transaction_time) AS hour_of_day,
          store_location,
          product_category,
          product_type,
          product_detail,
          -- unit_price, 
          -- transaction_date
          -- transaction_qty,
  COUNT(DISTINCT transaction_id) AS number_of_sales,
  SUM(transaction_qty*unit_price) AS Revenue
  FROM BRIGHT.coffee.shop
  GROUP BY ALL

----------------------------------------------------------------------------------------------------------------------------

SELECT TRANSACTION_DATE,
        DAYNAME(TRANSACTION_DATE)AS DAY_NAME,
        CASE
        WHEN DAY_NAME IN ('SUN','SAT')THEN 'WEEKEND' 
        ELSE 'WEEKDAY'
        END AS DAY_CLASSIFICATION,
        MONTHNAME(TRANSACTION_DATE)AS MONTH_NAME
       SELECT TRANSACTION_TIME, 
       CASE
       WHEN TRANSACTION_TIME BETWEEN '06:00:00'AND '11:59:59'THEN' MORNING' 
       WHEN TRANSACTION_TIME BETWEEN '12:00:00'AND '16:59:59'THEN 'AFTERNOON'
       WHEN TRANSACTION_TIME >='17:00:00'THEN 'EVENING'
       END AS TIME_CLASSIFICATION, 
       hour(TRANSACTIONS_TIME) AS HOUR_OF_DAY
       STORE_LOCATION,
       PRODUCT_CATEGORY,
       PRODUCT_DETAIL,
       PRODUCT_TYPE
FROM BRIGHT.coffee.shop;



  
