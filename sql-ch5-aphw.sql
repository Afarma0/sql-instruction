USE AP;

--Write a SELECT statement that returns two columns from the Invoices table: 
--VendorID and PaymentSum, 
--where PaymentSum is the sum of the PaymentTotal column. 
--Group the result set by VendorID.
--111
SELECT VendorID, SUM(PaymentTotal) as PaymentSum
	FROM Invoices
	GROUP BY VendorID

--222 SAME AS Q1 With:
--Return only 10 rows, corresponding to the 10 vendors who’ve been paid the most. Hint: Use the TOP clause and join the Vendors table to the Invoices table.

SELECT TOP 20 VendorName, SUM(PaymentTotal) as PaymentSum
	FROM Invoices i
	JOIN Vendors v ON v.VendorID = i.VendorID
	GROUP BY VendorName
	ORDER BY PaymentSum DESC

--333 Write a SELECT statement that returns three columns:--VendorName, InvoiceCount, and InvoiceSum. --InvoiceCount is the count of the number of invoices, --InvoiceSum is the sum of the InvoiceTotal column. --Group the result set by vendor. --Sort the result set so the vendor with the highest number of invoices appears first.SELECT VendorName, COUNT(*) as InvoiceCount, SUM(InvoiceTotal) as InvoiceSum	FROM Invoices i	JOIN Vendors v ON v.VendorID = i.VendorID	GROUP BY VendorName	ORDER BY InvoiceCount DESC
	