USE MyGuitarShop;

--ch 6
--1
SELECT DISTINCT CategoryName
FROM Categories c JOIN Products p
 ON c.CategoryID = p.CategoryID
ORDER BY CategoryNameSELECT CategoryName	FROM Categories c	WHERE CategoryID IN 		(SELECT DISTINCT CategoryID			FROM Products)	ORDER BY CategoryNameSELECT DISTINCT CategoryName
	FROM Categories c JOIN Products p
	ON c.CategoryID = p.CategoryID
	ORDER BY CategoryNameSELECT DISTINCT CategoryName	From Categories c	JOIN products p ON c.CategoryID = p.CategoryID	ORDER BY CategoryNameSELECT CategoryName	FROM Categories	WHERE CategoryID IN 	(SELECT DISTINCT CategoryID		FROM Products) 	ORDER BY CategoryNameSELECT * 	FROM Categories--2SELECT ProductName, ListPrice	FROM Products	WHERE ListPrice >		(SELECT AVG(ListPrice)			FROM Products)	ORDER BY ListPrice DESC;--3SELECT CategoryName	FROM Categories c	WHERE NOT EXISTS		(SELECT CategoryID			FROM Products p			WHERE p.CategoryID = c.CategoryID)	GROUP BY CategoryName--4--Write a SELECT statement that returns three columns: 
--EmailAddress,
--OrderID, 
--the order total for each order.
--To do this, you can group the result set by the 
--EmailAddress and OrderID columns. Then, you can calculate the order total from the 
--columns in the OrderItems table.

	SELECT SUM(((ItemPrice - DiscountAmount) * Quantity)) AS orderTotal,o.OrderID,EmailAddress	FROM OrderItems oi
	JOIN Orders o ON o.OrderID = oi.OrderID
	JOIN Customers c ON c.CustomerID = o.CustomerID
	GROUP BY EmailAddress, o.OrderID

	SELECT ItemPrice,DiscountAmount,quantity,o.OrderID,EmailAddress	FROM OrderItems oi
	JOIN Orders o ON o.OrderID = oi.OrderID
	JOIN Customers c ON c.CustomerID = o.CustomerID

--Write a second SELECT statement that uses the first SELECT statement in its FROM 
--clause. The main query should return two columns: the customer’s email address and 
--the largest order for that customer. To do this, you can group the result set by the 
--EmailAddress column.	SELECT SUM(((ItemPrice - DiscountAmount) * Quantity)) AS orderTotal,o.OrderID,EmailAddress	FROM OrderItems oi
	JOIN Orders o ON o.OrderID = oi.OrderID
	JOIN Customers c ON c.CustomerID = o.CustomerID
	GROUP BY EmailAddress, o.OrderID

	SELECT EmailAddress, MAX(orderTotal) AS highestorder
		FROM (		SELECT SUM(((ItemPrice - DiscountAmount) * Quantity)) AS orderTotal,o.OrderID,EmailAddress	FROM OrderItems oi
	JOIN Orders o ON o.OrderID = oi.OrderID
	JOIN Customers c ON c.CustomerID = o.CustomerID
	GROUP BY EmailAddress, o.OrderID
	) AS OrderTotals
	GROUP BY EmailAddress;