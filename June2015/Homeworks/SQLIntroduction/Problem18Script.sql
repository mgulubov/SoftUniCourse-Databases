USE SoftUni
GO

SELECT
	CONCAT(e.FirstName, ' ', e.MiddleName, ' ', e.LastName) 
		AS 'Name',
	a.AddressText
		AS 'Address'
FROM
	Employees e
		INNER JOIN
	Addresses a
		ON
	e.AddressID = a.AddressID
