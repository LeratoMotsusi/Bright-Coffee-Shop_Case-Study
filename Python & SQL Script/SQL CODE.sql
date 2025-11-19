SELECT*
FROM
  BRIGHT.COFFEE.SALES;
  

SELECT
   COUNT(DISTINCT transaction_id) AS number_of_Sales,
   COUNT(DISTINCT product_id) AS number_of_unique_product,
   COUNT(DISTINCT store_id) AS number_of_shops,

 --Categories
    store_location,
    product_detail,
    product_category,
    product_type,
    

   TO_DATE(transaction_date) AS Purchase_date,
   DAYNAME(TO_DATE(transaction_date)) AS day_name,
   MONTHNAME(TO_DATE(transaction_date)) AS month_name,
   DAYOFMONTH(TO_DATE(transaction_date)) AS day_of_month,
   TO_CHAR(TO_DATE(transaction_date),'YYYYMM') AS month_id, 
   TO_CHAR(TO_DATE(transaction_date),'yyyy') AS YEAR,
   HOUR (transaction_time)AS Hour_of_Day,


  ROUND(SUM (IFNULL(transaction_qty,0)*IFNULL(unit_price,0)),0) AS avg_revenue,
  SUM(transaction_qty*UNIT_PRICE) AS total_revenue,
  SUM(Transaction_qty)AS number_of_Units_Sold,
  COUNT(*) AS transactions, 

 
CASE
   WHEN transaction_time BETWEEN '06:00:00' AND '11:59:59' THEN 'Morning'
   WHEN transaction_time BETWEEN '12:00:00' AND '15:59:59' THEN 'Afternoon'
   WHEN transaction_time BETWEEN '15:00:00' AND '19:59:59' THEN 'Evening'
   ELSE 'Night'
END AS Time_Buckets,


CASE
   
  WHEN DAYNAME(TO_DATE(transaction_date)) NOT IN ('Sat','Sun' ) THEN 'Weekday'
  ELSE 'Weekend'
END AS day_classification,

FROM BRIGHT.COFFEE.SALES
 GROUP BY ALL;
