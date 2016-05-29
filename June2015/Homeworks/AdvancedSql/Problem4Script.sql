USE SoftUni
GO

SELECT
	AVG(e.Salary)
FROM
	Employees e
WHERE
	e.DepartmentID = 1