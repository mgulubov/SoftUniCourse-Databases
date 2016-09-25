USE SoftUni
GO

SELECT TOP 7
	e.FirstName,
	e.LastName,
	e.HireDate
FROM
	Employees e
ORDER BY
	e.HireDate DESC