USE MyGuitarShop;

SELECT ProductCode, ProductName, DiscountPercent, ListPrice
	FROM Products;


SELECT ProductCode, ProductName, DiscountPercent, ListPrice
	FROM Products
	ORDER BY ListPrice DESC;

--2 full name

SELECT (LastName + ', ' + FirstName) AS FullName
	FROM Customers
	WHERE LastName LIKE '[M-Z]%'
	ORDER BY LastName;
	
--3
SELECT ProductName, ListPrice, DateAdded
	FROM Products
	WHERE ListPrice > 500.00
	AND ListPrice < 2000.00
	ORDER BY DateAdded DESC

--4

SELECT ProductName, ListPrice, DiscountPercent, (ListPrice * DiscountPercent/100) AS DiscountAmount, (ListPrice - (ListPrice * DiscountPercent/100)) AS DiscountPrice
	FROM Products
	ORDER BY DiscountPrice DESC

--6

SELECT OrderID, OrderDate, ShipDate
	FROM Orders

--7

SELECT 
	100 AS Price,
	0.07 AS TaxRate


--Ch 4 

SELECT CategoryName, ProductName, ListPrice
	FROM Products p
	JOIN Categories c ON c.CategoryID = p.CategoryID
	ORDER BY CategoryName, ProductName;

--2
SELECT FirstName, LastName, Line1, City, State, ZipCode
	FROM Addresses a
	JOIN Customers c ON c.CustomerID = a.CustomerID
	WHERE EmailAddress = 'allan.sherwood@yahoo.com'
	
--3
SELECT FirstName, LastName, Line1, City, State, ZipCode 
	FROM Addresses a
	JOIN Customers c ON c.CustomerID = a.CustomerID
	WHERE BillingAddressID = ShippingAddressID

--5

SELECT DISTINCT p1.ProductName, p1.ListPrice
	FROM Products p1
	JOIN Products p2 
	ON p1.ProductName <> p2.ProductName
	AND p1.ListPrice = p2.ListPrice

--6 
SELECT CategoryName, ProductID
	FROM Categories c
	LEFT JOIN Products p 
	ON c.CategoryID = p.CategoryID
	WHERE p.ProductID IS NULL
--help
SELECT *
	FROM Categories
	


	

--2

	