USE SoftUni
GO

SELECT DISTINCT
	e.DepartmentId AS DepartmentID,
	MIN(e.Salary) OVER(PARTITION BY e.DepartmentId) AS MinimumSalary
FROM
	Employees e
WHERE
	e.HireDate > '01/01/2000'
AND
	e.DepartmentID IN (2, 5, 7)