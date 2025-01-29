USE AP;

--CH 5 CLasswork

--pg 137 - total rows of invoices, sum of total due where total due > 0
SELECT InvoiceNumber, InvoiceTotal - PaymentTotal - CreditTotal as TotalDue
	FROM Invoices

--how many invoices have a balance due
SELECT COUNT(*) AS NumberOfInvoices, SUM(InvoiceTotal - PaymentTotal - CreditTotal) AS TotalDue
	FROM Invoices
	WHERE InvoiceTotal - PaymentTotal - CreditTotal > 0

--how many total invoices, avg inv total, total inv amount for invoices after 7/1/22

SELECT 'After 7/1/2022' AS selectionDate,
	COUNT(*) AS NoI,
	AVG(InvoiceTotal) AS AvgIA,
	SUM(InvoiceTotal) AS TotIA
	FROM Invoices
	WHERE InvoiceDate > '2022-07-01';

--139 MIN and MAX
--why not 0?????????????????????????????????????????????????????????????????????????????????????????
SELECT 'After 7/1/2022' AS selectionDate,
	COUNT(*) AS NoI,
	MAX(InvoiceTotal) AS MaxIA,
	MIN(InvoiceTotal) AS MinIA
	FROM Invoices
	WHERE InvoiceDate > '2022-07-01';

SELECT MIN(VendorName) as FirstVendor,
		MAX(VendorName) as LastVendor,
		COUNT(VendorName) AS NumberVendors
	FROM Vendors

--139 DISTINCT (unique) # of vendors
SELECT COUNT(DISTINCT VendorID) as numberofinvoicedvendors,
	COUNT(*) AS NoInvoices,
	AVG(InvoiceTotal) AS AvgIAmount,
	SUM(InvoiceTotal) AS TotIAmount
	FROM Invoices

--141 average invoice amount for a given vendor, we want avgs over 2000

SELECT VendorID, AVG(InvoiceTotal) AS AvgInvAmt
	FROM Invoices
	GROUP BY VendorID
	ORDER BY AvgInvAmt DESC;

SELECT VendorID, AVG(InvoiceTotal) AS AvgInvAmt
	FROM Invoices
	GROUP BY VendorID
	HAVING AVG(InvoiceTotal) > 2000
	ORDER BY AvgInvAmt DESC;

--p 143 # of invoices by vendor

SELECT VendorID, COUNT(*) AS invoiceQty
	FROM Invoices
	GROUP BY VendorID

--p 143 vendors by state and city, inv qty and inv avg

SELECT VendorState, VendorCity, COUNT(*) AS InvoiceQty, AVG(InvoiceTotal) AS InvAvg
	FROM Invoices i
	JOIN Vendors v ON i.VendorID = v.VendorID
	GROUP BY VendorState, VendorCity
	ORDER BY VendorState, VendorCity

--p 145 limit the results using having clause

SELECT VendorState, VendorCity, COUNT(*) AS InvoiceQty, AVG(InvoiceTotal) AS InvAvg
	FROM Invoices i
	JOIN Vendors v ON i.VendorID = v.VendorID
	GROUP BY VendorState, VendorCity
	HAVING COUNT(*) >=2
	ORDER BY VendorState, VendorCity

--p145 search condition in HAVING clause
SELECT VendorName, COUNT(*) AS Invoiceqty, AVG(InvoiceTotal) AS InvoiceAvg
	FROM Vendors v
	JOIN Invoices i on v.VendorID = i.VendorID
	GROUP BY VendorName
	HAVING AVG (InvoiceTotal) > 500
	ORDER BY Invoiceqty DESC;

--search condition in the where clause



SELECT VendorName, COUNT(*) AS Invoiceqty, AVG(InvoiceTotal) AS InvoiceAvg
	FROM Vendors v
	JOIN Invoices i on v.VendorID = i.VendorID
	WHERE (InvoiceTotal) > 500
	GROUP BY VendorName
	ORDER BY Invoiceqty DESC;

---149 invoices by vendor, grouped, to get inv count and inv total with summary row
SELECT COUNT(*) as invoiceqty, VendorID, SUM(InvoiceTotal) as InvoiceSum
	FROM Invoices
	GROUP BY ROLLUP(VendorID)

--rollup multiple columns: vendors from IA and NJ rollup by vendorstate and vendorcity
SELECT VendorState, VendorCity, COUNT(*) AS qtyvendors
	FROM Vendors
	WHERE VendorState IN ('IA', 'NJ')
	GROUP BY ROLLUP(VendorState, VendorCity)
	ORDER BY VendorState DESC, VendorCity DESC;

SELECT VendorID, 
COUNT(*) as invoiceCount,
SUM(InvoiceTotal) as InvoiceSum
	FROM Invoices
	GROUP BY CUBE(VendorID);