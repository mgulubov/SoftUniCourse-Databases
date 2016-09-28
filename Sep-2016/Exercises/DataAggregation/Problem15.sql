USE SoftUni
GO

SELECT
	e.DepartmentId,
	MAX(e.Salary) AS MaxSalary
FROM
	Employees e
GROUP BY
	e.DepartmentID
HAVING
	(
		MAX(e.Salary) < 30000
		OR
		MAX(e.Salary) > 70000
	)

