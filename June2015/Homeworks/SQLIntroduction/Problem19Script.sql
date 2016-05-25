USE SoftUni
GO

SELECT
	CONCAT(e.FirstName, ' ', e.MiddleName, ' ', e.LastName)
		AS 'Name',
	a.AddressText 
		AS 'Address'
FROM
	Employees e,
	Addresses a
WHERE
	e.AddressID = a.AddressID