--Chapter 4 demos
--pg 103 two table join
--vendors and invoices

Select *
	FROM Vendors;

Select *
	FROM Invoices
	ORDER BY VendorID;

-- which vendors have we invoiced? (done business)
-- whilch vendors have we not invoiced?
-- which vendors have spent the most money with us?

--p. 103 join vendors and invocies
--vendor ID is foreign key in invoice table; primary key in Vendor table

--gives us all vendors who have been invoiced
SELECT InvoiceNumber, VendorName
	FROM Vendors v
	JOIN Invoices i ON i.VendorID = v.VendorID;


--pg 105 aliases in joins w/ AS keyword
SELECT InvoiceNumber, VendorName
	FROM Invoices AS Inv
	JOIN Vendors AS Ven ON Ven.VendorID = Inv.VendorID;

SELECT InvoiceNumber, VendorName
	FROM Invoices AS I
	JOIN Vendors AS V ON V.VendorID = I.VendorID;

--simplest form
SELECT InvoiceNumber, VendorName
	FROM Invoices I
	JOIN Vendors V ON V.VendorID = I.VendorID;

--(still 105) add in calculated column, where and order by
SELECT InvoiceNumber, VendorName, InvoiceDueDate, (InvoiceTotal - PaymentTotal - CreditTotal) AS balancedue
	FROM Invoices I
	JOIN Vendors V ON V.VendorID = I.VendorID
	Where (InvoiceTotal - PaymentTotal - CreditTotal) > 0
	ORDER BY InvoiceDueDate DESC;

--p. 109 joining on multiple things
--Invoices to InvoiceLineItems AND InvoiceTotal to InvoiceLineItemAmount
SELECT InvoiceNumber, InvoiceDate, InvoiceTotal, InvoiceLineItemAmount
	FROM Invoices I
	JOIN InvoiceLineItems LI ON I.InvoiceID = LI.InvoiceID
	AND I.InvoiceTotal > LI.InvoiceLineItemAmount
	ORDER BY InvoiceNumber;

--changing second condition to a where clause
SELECT InvoiceNumber, InvoiceDate, InvoiceTotal, InvoiceLineItemAmount
	FROM Invoices I
	JOIN InvoiceLineItems LI ON I.InvoiceID = LI.InvoiceID
	WHERE I.InvoiceTotal > LI.InvoiceLineItemAmount
	ORDER BY InvoiceNumber;	

--pg 111 Vendors table - self-join
--we want to find vendors in cities in common with other vendors
SELECT DISTINCT V1.VendorName, V1.VendorCity, V1.VendorState
	FROM Vendors V1
	JOIN Vendors V2 ON V1.VendorCity = V2.VendorCity
				AND V1.VendorState = V2.VendorState
				AND V1.VendorID <> V2.VendorID
	ORDER BY V1.VendorState, V1.VendorCity;

--pg 113 look at and demo

--pg 115 implicit join - vendors and invoices (Vendors who have invoices)
--NOT RECEOMMENDED
SELECT InvoiceNumber, VendorName
	FROM Invoices I, Vendors V
	WHERE V.VendorID = I.InvoiceID

-- which vendors have we invoiced? (done business)
-- whilch vendors have we not invoiced?
-- which vendors have spent the most money with us?
--INNER JOIN - which Venders DO appear in the invoices table
--OUTER JOIN - which Venders DO NOT appear in the invoices table

--vendors & invoices - left outer join
--we want all data from Vendors AND Invoice Data if exists
--122 records for vendors and invoice 114 records
SELECT VendorName, InvoiceNumber, InvoiceTotal
	FROM Vendors V
	LEFT JOIN Invoices I ON V.VendorID = I.VendorID
	ORDER BY VendorName;

--same thing as right outer join
SELECT VendorName, InvoiceNumber, InvoiceTotal
	FROM Invoices I
	RIGHT JOIN Vendors V ON V.VendorID = I.VendorID
	ORDER BY VendorName;

--vendors and invoices - left outer join where invoicenumber is NULL
--which vendors have we not done business with (don't appear in the invoice table)
SELECT VendorName, InvoiceNumber, InvoiceTotal
	FROM Vendors V
	LEFT JOIN Invoices I ON V.VendorID = I.VendorID
	WHERE InvoiceNumber IS NULL
	ORDER BY VendorName;


--CH 4 QUESTIONS 
--	Q1//Write a SELECT statement that returns all columns from the Vendors table inner-joined with the Invoices table.SELECT *	FROM Vendors V	JOIN Invoices I ON V.VendorID = I.VendorID--	Q21//Write a SELECT statement that returns four columns: VendorName InvoiceNumber InvoiceDate Balance--Q22//From the Vendors table From the Invoices table From the Invoices table--Q23InvoiceTotal minus the sum of PaymentTotal and CreditTotal

SELECT VendorName, InvoiceNumber, InvoiceDate, InvoiceTotal - PaymentTotal - CreditTotal AS Balance
	FROM Vendors V
	JOIN Invoices I ON V.VendorID = I.VendorID
	WHERE (InvoiceTotal - PaymentTotal - CreditTotal) <> 0 
	ORDER BY VendorName

--Q3Write a SELECT statement that returns three columns: --VendorName From the Vendors table--DefaultAccountNo From the Vendors table--AccountDescription From the GLAccounts table--The result set should have one row for each vendor, with the account number and account description for that vendor’s default account number.
--Sort the result set by AccountDescription, then by VendorName.

SELECT VendorName, DefaultAccountNo, AccountDescription
	FROM Vendors V
	JOIN GLAccounts G ON G.AccountNo = V.DefaultAccountNo
	ORDER BY AccountDescription, VendorName

--Q4 Generate the same result set described in exercise 2, but use the implicit join syntax.

SELECT VendorName, InvoiceNumber, InvoiceDate, InvoiceTotal - PaymentTotal - CreditTotal AS Balance
	FROM Vendors V, Invoices I 
	WHERE V.VendorID = I.VendorID
	AND (InvoiceTotal - PaymentTotal - CreditTotal) <> 0 
	ORDER BY VendorName

--Q5  Write a SELECT statement that returns five columns from three tables, all using the following column aliases: --Vendor        VendorName column--Date          InvoiceDate column--Number        InvoiceNumber column--#             InvoiceSequence column--LinteItem     InvoiceLineItemAmount column--Assign the following aliases to the tables: v i li 
--Sort the final result set by Vendor, Date, Number, and #

SELECT (VendorName) AS Vendor, (InvoiceDate) AS Date, (InvoiceNumber) AS Number, (InvoiceSequence) AS '#', (InvoiceLineItemAmount) AS LineItem
	FROM Vendors v
	JOIN Invoices i ON i.VendorID = v.VendorID
	JOIN InvoiceLineItems li ON li.InvoiceID = i.InvoiceID
	ORDER BY Vendor, Date, Number, #

--Q6  Write a SELECT statement that returns three columns: --VendorID       From the Vendors table--VendorName     From the Vendors table--Name           A concatenation of VendorContactFName and VendorContactLName, with a space in between--The result set should have one row for each vendor whose contact has the same first name as another vendor’s contact.--Sort the final result set by Name. Hint: Use a self-joinSELECT v1.VendorID, v1.VendorName, (v1.VendorContactFName + ' ' + v1.VendorContactLName) AS Name	FROM Vendors v1	JOIN Vendors v2 		ON v1.VendorID <> v2.VendorID		AND v1.VendorContactFName = v2.VendorContactFName	ORDER BY Name--Q7   Write a SELECT statement that returns two columns from the GLAccounts table: AccountNo and AccountDescription. --The result set should have one row for each account number that has never been used. --Sort the final result set by AccountNo. Hint: Use an outer join to the InvoiceLineItems table.SELECT gl.AccountNo, AccountDescription	FROM GLAccounts gl	LEFT JOIN InvoiceLineItems ili 		ON ili.AccountNo = gl.AccountNo	WHERE ili.AccountNo IS NULL	ORDER BY AccountNo--q8SELECT VendorName, VendorState	FROM Vendors	WHERE VendorState = 'CA'UNIONSELECT VendorName, 'Outside CA'	FROM Vendors	WHERE VendorState <> 'CA'	ORDER BY VendorName