USE AP;

--CH 6 CLASS NOTES/DEMOS

--p.161
--Return all invoices where invoiceTotal > Avg invoiceTotal

SELECT InvoiceNumber, InvoiceDate, InvoiceTotal
	FROM Invoices
	WHERE InvoiceTotal > 
		(SELECT AVG(invoicetotal)
			FROM Invoices)
	ORDER BY InvoiceTotal DESC

--163 query inner join
-- join invoices and vendors, show inv#, invdate, invtotal for invoice vendors from california

SELECT InvoiceNumber, InvoiceDate, InvoiceTotal
	FROM Invoices i 
	JOIN Vendors v ON v.VendorID = i.VendorID
	WHERE VendorState = 'CA'
	ORDER BY InvoiceDate;

SELECT InvoiceNumber, InvoiceDate, InvoiceTotal
	FROM Invoices i 
	WHERE VendorID IN  
		(SELECT VendorID 
			FROM Vendors 
			WHERE VendorState = 'CA')
	ORDER BY InvoiceDate
--same query As a subquery ^^

--p.165
-- Vendors without invoices subquery

SELECT VendorID, VendorName, VendorState
	FROM Vendors
	WHERE VendorID NOT IN 
		(SELECT DISTINCT VendorID 
			FROM Invoices);
--join query
SELECT i.VendorID, VendorName, VendorState
	FROM Vendors v
	LEFT JOIN Invoices i ON v.VendorID = i.VendorID
	WHERE i.VendorID IS NULL;

--p. 167 Invoice payment details, see Balance due where BD is less than avd BD

SELECT InvoiceNumber, InvoiceDate, InvoiceTotal, InvoiceTotal - PaymentTotal - CreditTotal AS BD
	FROM Invoices
	WHERE (InvoiceTotal - PaymentTotal - CreditTotal) > 0
	AND (InvoiceTotal - PaymentTotal - CreditTotal) <
	(SELECT AVG(InvoiceTotal - PaymentTotal - CreditTotal)
		FROM Invoices
		WHERE (InvoiceTotal - PaymentTotal - CreditTotal) > 0)
	ORDER BY InvoiceTotal DESC

--p169 all keyword
SELECT InvoiceTotal
	FROM Invoices
	WHERE VendorID = 34;
--all invoices whose totals are > vendor is 34's invoices

SELECT VendorName, InvoiceNumber, InvoiceTotal
	FROM Invoices i
	JOIN Vendors v ON v.VendorID = i.VendorID
	WHERE InvoiceTotal > ALL
		(SELECT InvoiceTotal
	FROM Invoices
	WHERE VendorID = 34)
	ORDER BY VendorName DESC

--171
--invoice totals for vendorid 115

SELECT InvoiceTotal
	FROM Invoices
	WHERE VendorID = 115;

--Invoices < (less) any of vendor 115's

SELECT *
	FROM Vendors v
	JOIN Invoices i ON i.VendorID = v.VendorID
	WHERE InvoiceTotal < ANY 
		(SELECT InvoiceTotal
			FROM Invoices
			WHERE VendorID = 115)

--p. 173 a query that uses a correlated subquery

--Show vendor Invoices that are above their OWN average of invoices
SELECT VendorID, InvoiceNumber, InvoiceTotal
	FROM Invoices i1
	WHERE i1.InvoiceTotal > 
	(SELECT AVG(InvoiceTotal)
		FROM Invoices i2
		WHERE i2.VendorID = i1.VendorID)
	ORDER BY VendorID, InvoiceTotal

-- p175 WHERE EXISTS / NOT EXISTS
-- vendors w.out invoices

SELECT VendorID, VendorName, VendorState
	FROM Vendors v
	WHERE NOT EXISTS 
	(SELECT *
		FROM Invoices i 
		WHERE i.VendorID = v.VendorID)
