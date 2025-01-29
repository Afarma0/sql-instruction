USE MyGuitarShop;


--CH4 HOMEWORK
--3
SELECT *
	FROM Customers
SELECT *
	FROM Addresses


SELECT FirstName, LastName, Line1, City, State, ZipCode
	FROM Customers c
	JOIN Addresses a ON a.CustomerID = c.CustomerID
	WHERE ShippingAddressID = AddressID

--5
SELECT p1.ProductName, p1.ListPrice
	FROM Products p1
	JOIN Products p2 ON p1.ListPrice = p2.ListPrice
	WHERE p1.ProductID <> p2.ProductID
	AND p1.ListPrice = p2.ListPrice

