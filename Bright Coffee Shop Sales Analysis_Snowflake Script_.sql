SELECT*FROM "BRIGHTCOFFEESHOP"."PUBLIC"."BRIGHTCOFFEESHOP"
LIMIT 10;

---Syntax to see the datatypes of all the columns
DESCRIBE TABLE "BRIGHTCOFFEESHOP"."PUBLIC"."BRIGHTCOFFEESHOP";


---Syntax to count the number of rows in the table
SELECT COUNT(*) AS total_rows
FROM "BRIGHTCOFFEESHOP"."PUBLIC"."BRIGHTCOFFEESHOP";


---Syntax to count the number of unique transactions
SELECT COUNT(DISTINCT Transaction_ID) AS Unique_Transactions
FROM "BRIGHTCOFFEESHOP"."PUBLIC"."BRIGHTCOFFEESHOP";


---Checking for full rows that are duplicated 
SELECT *, COUNT(*)
FROM "BRIGHTCOFFEESHOP"."PUBLIC"."BRIGHTCOFFEESHOP"
GROUP BY ALL
HAVING COUNT(*) > 1;


---Checking for Nulls in all the coloums
 SELECT 
    COUNT(*) AS total_rows,
    SUM(CASE WHEN Transaction_ID IS NULL THEN 1 ELSE 0 END) AS Transaction_ID_nulls,
    SUM(CASE WHEN Store_ID IS NULL THEN 1 ELSE 0 END) AS Store_ID_nulls,
    SUM(CASE WHEN Transaction_time IS NULL THEN 1 ELSE 0 END) AS Transaction_time_nulls,
    SUM(CASE WHEN Transaction_date IS NULL THEN 1 ELSE 0 END) AS Transaction_date_nulls,
    SUM(CASE WHEN Transaction_qty IS NULL THEN 1 ELSE 0 END) AS Transaction_qty_nulls,
    SUM(CASE WHEN Store_location IS NULL THEN 1 ELSE 0 END) AS Store_location_nulls,
    SUM(CASE WHEN Product_ID IS NULL THEN 1 ELSE 0 END) AS Product_ID_nulls,
    SUM(CASE WHEN Unit_price IS NULL THEN 1 ELSE 0 END) AS Unit_price_nulls,
    SUM(CASE WHEN Product_category IS NULL THEN 1 ELSE 0 END) AS Product_category_nulls,
    SUM(CASE WHEN Product_type IS NULL THEN 1 ELSE 0 END) AS Product_type_nulls,
    SUM(CASE WHEN Product_detail IS NULL THEN 1 ELSE 0 END) AS Product_detail_nulls
FROM "BRIGHTCOFFEESHOP"."PUBLIC"."BRIGHTCOFFEESHOP";
    


  ---Earliest time of a sale
  SELECT MIN(Transaction_Time)
  FROM
  "BRIGHTCOFFEESHOP"."PUBLIC"."BRIGHTCOFFEESHOP";
  

  
---Latest time of a sale
   SELECT MAX(Transaction_Time)
  FROM
  "BRIGHTCOFFEESHOP"."PUBLIC"."BRIGHTCOFFEESHOP";
  
  
---Adding a new permanent column called Time Buckets
ALTER TABLE "BRIGHTCOFFEESHOP"."PUBLIC"."BRIGHTCOFFEESHOP"
ADD COLUMN Time_Buckets STRING;


  ---Time buckets on Hourly intervals
  UPDATE "BRIGHTCOFFEESHOP"."PUBLIC"."BRIGHTCOFFEESHOP"
  SET Time_Buckets = CASE
    WHEN CAST(Transaction_time AS TIME) BETWEEN '06:00:00' AND '08:59:59' THEN 'Peak Morning Rush'
    WHEN CAST(Transaction_time AS TIME) BETWEEN '09:00:00' AND '11:59:59' THEN 'Mid Morning'
    WHEN CAST(Transaction_time AS TIME) BETWEEN '12:00:00' AND '15:59:59' THEN 'Afternoon'
    WHEN CAST(Transaction_time AS TIME) BETWEEN '16:00:00' AND '17:59:59' THEN 'Peak Afternoon Rush'
    WHEN CAST(Transaction_time AS TIME) BETWEEN '18:00:00' AND '21:00:00' THEN 'Evening'
    ELSE 'Night'
END;


---Checking new updated table with Time Buckets as a new permanent column
SELECT*
FROM "BRIGHTCOFFEESHOP"."PUBLIC"."BRIGHTCOFFEESHOP";

---Adding a new permanent column called Total Sales
ALTER TABLE "BRIGHTCOFFEESHOP"."PUBLIC"."BRIGHTCOFFEESHOP"
ADD COLUMN Total_Sales DECIMAL(10,2);

---Calculating Total Sales
UPDATE "BRIGHTCOFFEESHOP"."PUBLIC"."BRIGHTCOFFEESHOP"
SET Total_Sales = transaction_qty * unit_price;

---Adding a new permanent column called Total Sales2 to take into account cents
ALTER TABLE "BRIGHTCOFFEESHOP"."PUBLIC"."BRIGHTCOFFEESHOP"
ADD COLUMN Total_Sales2 DECIMAL(10,2);

---Calculating Total Sales to include cents
UPDATE "BRIGHTCOFFEESHOP"."PUBLIC"."BRIGHTCOFFEESHOP"
SET Total_Sales2 = transaction_qty * unit_price;

---Checking new updated table with Total Sales as a new permanent column
SELECT*
FROM "BRIGHTCOFFEESHOP"."PUBLIC"."BRIGHTCOFFEESHOP";


---Adding a new permanent column called Month ID
ALTER TABLE "BRIGHTCOFFEESHOP"."PUBLIC"."BRIGHTCOFFEESHOP"
ADD COLUMN Month_ID STRING;

---Updating the Month ID column from the Transaction date column
UPDATE "BRIGHTCOFFEESHOP"."PUBLIC"."BRIGHTCOFFEESHOP"
SET Month_ID = TO_CHAR(transaction_date, 'YYYYMM');

---Checking new updated table with Month ID as a new permanent column
SELECT*
FROM "BRIGHTCOFFEESHOP"."PUBLIC"."BRIGHTCOFFEESHOP";

ALTER TABLE
  brightcoffeeshop DROP COLUMN total_sales;

  SELECT*
FROM "BRIGHTCOFFEESHOP"."PUBLIC"."BRIGHTCOFFEESHOP";



