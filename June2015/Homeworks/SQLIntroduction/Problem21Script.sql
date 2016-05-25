USE SoftUni
GO

SELECT
	CONCAT(e.FirstName, ' ', e.MiddleName, ' ', e.LastName)
		AS 'Employee Name',
	CONCAT(m.FirstName, ' ', m.MiddleName, ' ', m.LastName)
		AS 'Manage Name',
	a.AddressText
		AS 'Address'
FROM
	Employees e
		INNER JOIN
			Employees m
		ON
			e.ManagerID = m.EmployeeID
		INNER JOIN
			Addresses a
		ON
			e.AddressID = a.AddressID
WHERE e.ManagerID IS NOT NULL
		