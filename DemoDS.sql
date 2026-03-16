
---Query 1: Viewing first 10 rows of the table
select * from `workspace`.`default`.`bright_coffee_shop_sales_6pm` limit 10;


---Query 2: Viewing distinct store locations
SELECT DISTINCT store_location
FROM `workspace`.`default`.`bright_coffee_shop_sales_6pm`;


---Query 3: Select specific columns
SELECT transaction_id,
       product_category,
       unit_price
FROM `workspace`.`default`.`bright_coffee_shop_sales_6pm`;



---Query 4: Using a column alias
SELECT product_category AS Category,
       unit_price AS Product_Price
FROM `workspace`.`default`.`bright_coffee_shop_sales_6pm`;


















---Query 5: Filtering using WHERE
SELECT *
FROM `workspace`.`default`.`bright_coffee_shop_sales_6pm`
WHERE product_category = 'Coffee';


---Query 6: Filtering using WHERE and AND
SELECT *
FROM `workspace`.`default`.`bright_coffee_shop_sales_6pm`
WHERE product_category = 'Coffee'
AND unit_price > 10;

---Query 7: Finding minimum and  maximum values
SELECT MIN(unit_price) AS Lowest_price,
       MAX(unit_price) AS Highest_price
FROM `workspace`.`default`.`bright_coffee_shop_sales_6pm`;


---Query 8: Filtering using WHERE and OR
SELECT *
FROM `workspace`.`default`.`bright_coffee_shop_sales_6pm`
WHERE product_category = 'Coffee'
OR product_category = 'Tea';


---Query 9.1: Filtering using WHERE and OR
SELECT store_location
FROM `workspace`.`default`.`bright_coffee_shop_sales_6pm`
WHERE product_category = 'Coffee'
OR product_category = 'Tea';


---Query 9.2: Filtering using WHERE and OR
SELECT store_location,
       product_category
FROM `workspace`.`default`.`bright_coffee_shop_sales_6pm`
WHERE product_category = 'Coffee'
OR product_category = 'Tea';



---Query 10.1:Filtering using WHERE and IN
SELECT store_location,
        product_category,
        transaction_qty
FROM `workspace`.`default`.`bright_coffee_shop_sales_6pm`
WHERE product_category IN ('Coffee', 'Tea', 'Bakery');


---Query 10.2:Filtering using WHERE and IN
SELECT store_location,
        product_category,
        transaction_qty
FROM `workspace`.`default`.`bright_coffee_shop_sales_6pm`
WHERE product_category ='Coffee'
OR product_category = 'Tea'
OR product_category = 'Bakery';














































