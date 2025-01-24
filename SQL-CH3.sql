--SELECT * FROM Invoices;
--select * from Invoices;
--selecT * froM Invoices;
USE AP;
SELECT *
	FROM Invoices;

-- Get VendorID, InvoiceNumber, InvoiceTotal
SELECT VendorID, InvoiceNumber, InvoiceTotal
	FROM Invoices

-- WHERE clause - where invoiceTotal > 1000
SELECT VendorID, InvoiceNumber, InvoiceTotal
	FROM Invoices
WHERE InvoiceTotal >= 2000;

--Calculated value - Total Credits
--SELECT CreditTotal, PaymentTotal, PaymentTotal + CreditTotal AS TotalCredits
SELECT CreditTotal, PaymentTotal, (PaymentTotal + CreditTotal) TotalCredits
	FROM Invoices;

--order by total credits, add InvoiceDate
SELECT InvoiceDate, CreditTotal, PaymentTotal,  (PaymentTotal + CreditTotal) TotalCredits
	FROM Invoices
ORDER BY TotalCredits DESC; 

--return only dates between 1/1/23 and 3/31/23
SELECT InvoiceDate, InvoiceNumber, InvoiceTotal
	FROM Invoices
	WHERE InvoiceDate BETWEEN '2023-01-01' and '2023-03-31'
	ORDER BY InvoiceDate;

--Q1P1//VEN// return 3 columns
SELECT VendorContactFName, VendorContactLName, (VendorContactFName + VendorContactLName) VenderName
	FROM Vendors;

--Q1P2//SORT
SELECT VendorContactFName, VendorContactLName, (VendorContactFName + VendorContactLName) VenderName
	FROM Vendors
	ORDER BY VendorContactLName;

--Q1P3//SORT
SELECT VendorContactFName, VendorContactLName, (VendorContactFName + VendorContactLName) VenderName
	FROM Vendors
	ORDER BY VendorContactFName;

--Q2// INV// Number, Total, Credits, Balanace
SELECT InvoiceNumber AS Number, InvoiceTotal AS Total, (PaymentTotal + CreditTotal) AS Credits, InvoiceTotal - (PaymentTotal + CreditTotal) AS Balance
	FROM Invoices;

--Q3P1//VEN//Last name first
SELECT (VendorContactFName + ', ' + VendorContactLName) AS FullName
	FROM Vendors
	ORDER BY VendorContactLName;

--Q3P2//VEN//first name first
SELECT (VendorContactFName + ', ' + VendorContactLName) AS FullName
	FROM Vendors
	ORDER BY VendorContactFName;

--Q4P1//INV
SELECT InvoiceTotal, (InvoiceTotal * 0.1) AS TenP, (InvoiceTotal * 1.1) AS OneTenP
	FROM Invoices
	WHERE InvoiceTotal - (PaymentTotal + CreditTotal) >= 1000

--Q5//INV
SELECT InvoiceNumber, InvoiceTotal, (PaymentTotal + CreditTotal) AS Credits, InvoiceTotal - (PaymentTotal + CreditTotal) AS Balance
	FROM Invoices
	WHERE InvoiceTotal BETWEEN 500 AND 10000;

--Q6//VEN
SELECT (VendorContactFName + ', ' + VendorContactLName) AS FullName
	FROM Vendors
	WHERE VendorContactLName LIKE '[ABCE]%';

--Q7//INV
SELECT InvoiceTotal - (PaymentTotal + CreditTotal) AS Balance, PaymentDate
	FROM Invoices
	WHERE PaymentDate IS NOT NULL and InvoiceTotal - (PaymentTotal + CreditTotal) > 0 
	OR PaymentDate IS NULL and InvoiceTotal - (PaymentTotal + CreditTotal) = 0

--DAYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY3
--Q6
SELECT (VendorContactFName + ', ' + VendorContactLName) AS 'Full Name'
	FROM Vendors
	WHERE VendorContactLName LIKE '[ABCE]%'
	ORDER BY VendorContactLName, VendorContactFName;

--Q7
SELECT InvoiceNumber, PaymentDate, (InvoiceTotal - PaymentTotal - CreditTotal) as BalanaceDue
	FROM Invoices
	WHERE (PaymentDate IS NULL
	AND (InvoiceTotal - PaymentTotal - CreditTotal) <= 0)
	OR (PaymentDate IS NOT NULL
	AND (InvoiceTotal - PaymentTotal - CreditTotal) > 0);