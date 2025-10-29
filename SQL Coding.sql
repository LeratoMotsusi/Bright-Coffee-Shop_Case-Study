SELECT *
FROM Prac2.Data.Customer_;

SELECT *
FROM Prac2.Data.Product_;

SELECT *
FROM Prac2.Data.Order_;


---Question 1
---INNER JOIN: Orders with Customer and Product Names
---List all orders along with the customer name and product name.
---Expected Output Columns:OrderID, OrderDate, CustomerName, ProductName, Quantity

SELECT A.OrderID,
       A.OrderDate,
       B.CustomerName,
       C.ProductName,
       A.Quantity
FROM Prac2.Data.Order_ AS A
INNER JOIN Prac2.Data.Customer_ AS B ON A.CustomerID=B.CustomerID
INNER JOIN Prac2.Data.Product_ AS C ON A.ProductID=C.ProductID;



---Question 2
---INNER JOIN: Customers Who Placed Orders
---Which customers have placed at least one order?
---Expected Output Columns:CustomerID, CustomerName, Country, OrderID, OrderDate

SELECT B.CustomerID,
       B.CustomerName,
       B.Country,
       A.OrderID,
       A.OrderDate
FROM Prac2.Data.Order_ AS A
INNER JOIN Prac2.Data.Customer_ AS B
ON A.CustomerID=B.CustomerID
WHERE A.Quantity>=1;


---Question 3
---LEFT JOIN: All Customers and Their Orders
---List all customers and any orders they might have placed. Include customers who have not placed any orders.
---Expected Output Columns:CustomerID, CustomerName, Country, OrderID, OrderDate, ProductID, Quantity

SELECT A.CustomerID, 
       A.CustomerName, 
       A.Country, 
       B.OrderID, 
       B.OrderDate, 
       B.ProductID, 
       B.Quantity
FROM Prac2.Data.Customer_ AS A
LEFT JOIN Prac2.Data.Order_ AS B
ON A.CustomerID=B.CustomerID;

---Question 4
---LEFT JOIN: Product Order Count
---List all products and how many times each was ordered (if any).
---Expected Output Columns:ProductID, ProductName, TotalOrders (TotalOrders is the count of how many times the product appears in orders)

SELECT A.ProductID,
       A.ProductName,
       COUNT(DISTINCT OrderID) AS TotalOrders
FROM Prac2.Data.Product_ AS A
LEFT JOIN Prac2.Data.Order_ AS B
ON A.ProductID=B.ProductID
GROUP BY A.ProductID,
         A.ProductName;
         






       


    













































