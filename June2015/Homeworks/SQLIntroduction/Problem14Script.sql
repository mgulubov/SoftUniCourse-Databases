USE SoftUni
GO

SELECT
	CONCAT(e.FirstName, ' ', e.MiddleName, ' ', e.LastName)
	AS 'Full Name'
FROM
	Employees e
WHERE
	e.Salary = 25000
OR
	e.Salary = 12500
OR
	e.Salary = 14000
OR 
	e.Salary = 23600