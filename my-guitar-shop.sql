USE MyGuitarShop
SELECT *
	FROM Categories;
--Disc Am (calc), price (calc)
SELECT ProductName, ListPrice, DiscountPercent, 
		(ListPrice * (DiscountPercent/100)) AS DiscountAmount, 
		(ListPrice - (ListPrice * (DiscountPercent/100))) AS DiscountPrice
	FROM Products
	ORDER BY DiscountPrice DESC;

