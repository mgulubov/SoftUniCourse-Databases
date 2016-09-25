USE SoftUni
GO

SELECT TOP 5
	e.FirstName,
	e.LastName
FROM
	Employees e
ORDER BY
	e.Salary DESC