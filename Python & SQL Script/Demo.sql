
---Query 1: Viewing the first 100 rows of the table
select * from `workspace`.`default`.`bcoffee_8pm` limit 100;


---Query 2: Viewing distinct store locations
SELECT DISTINCT store_location
FROM `workspace`.`default`.`bcoffee_8pm`;


---Query 3: Selecting specific columns
SELECT transaction_id,
       product_category,
       unit_price
FROM `workspace`.`default`.`bcoffee_8pm`;


---Query 4: Using a column alias
SELECT product_category AS Catergory_of_Products,
       unit_price AS Price_of_Products
FROM `workspace`.`default`.`bcoffee_8pm`;
       
 

 ---Query 5: Filtering using WHERE
 SELECT *
 FROM `workspace`.`default`.`bcoffee_8pm`
 WHERE product_category = 'Coffee';


---Query 6: Filtering using WHERE and AND 
SELECT *
FROM `workspace`.`default`.`bcoffee_8pm`
WHERE product_category = 'Coffee'
AND store_location = 'Lower Manhattan';


---Query 7: Filtering using WHERE and  OR
SELECT *
FROM `workspace`.`default`.`bcoffee_8pm`
WHERE product_category = 'Tea'
OR store_location = 'Lower Manhattan';


---Query 8: Filtering using WHERE and IN
SELECT *
FROM `workspace`.`default`.`bcoffee_8pm`
WHERE product_category IN ('Coffee', 'Tea','Bakery');






























































