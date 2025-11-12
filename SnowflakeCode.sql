-- Checking all the available data columns
--To also check the data types in my data type
SELECT*
FROM casestudy.bright.coffee_shop;

-------------------------------
--Check my categorical columns

SELECT DISTINCT STORE_LOCATION
FROM CASESTUDY.bright.coffee_shop;

SELECT DISTINCT PRODUCT_CATEGORY
FROM CASESTUDY.bright.coffee_shop;

SELECT DISTINCT MIN(TRANSACTION_DATE) as First_oppening_date
FROM CASESTUDY.bright.coffee_shop;

SELECT DISTINCT MAX(TRANSACTION_DATE) as Last_openning_day
FROM CASESTUDY.bright.coffee_shop;

SELECT DISTINCT MIN(TRANSACTION_TIME) as min_oppening_hour
FROM CASESTUDY.bright.coffee_shop;

SELECT DISTINCT MAX(TRANSACTION_TIME) as max_oppening_hour
FROM CASESTUDY.bright.coffee_shop;

------------------------------------------------------------------------------
--Date Functions 

SELECT DISTINCT PRODUCT_CATEGORY
FROM CASESTUDY.bright.coffee_shop;
----------------------------------------------------------------------------------

SELECT TRANSACTION_DATE,
       DAYNAME(TRANSACTION_DATE) AS Day_name,
       CASE
         When Day_name IN ('Sun', 'Sat') THEN 'Weekend'
         ELSE 'Weekday'
       END as Day_classification,
       MONTHNAME(TRANSACTION_DATE) AS Month_name,

       --transaction_time,

         CASE
             WHEN TRANSACTION_TIME  BETWEEN '06:00:00' AND '11:59:59' THEN 'Morning'
             WHEN TRANSACTION_TIME BETWEEN '12:00:00' AND '16:59:59' THEN 'Afternoon'
             WHEN TRANSACTION_TIME >= '17:00:00' THEN 'Evening'
         END As time_classification,
         
        Hour(transaction_time) as hour_of_the_day,

        --categorical data
        store_location,
        product_category,
        product_detail,
        product_type,

        --ID'S
        COUNT(DISTINCT TRANSACTION_ID) AS number_of_Sales,

        --Revenue Calculations
          Sum(transaction_qty*unit_price) AS REVENUE
        
FROM CASESTUDY.bright.coffee_shop
GROUP BY ALL;
