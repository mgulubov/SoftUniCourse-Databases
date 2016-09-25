USE SoftUni
GO

SELECT
	e.FirstName,
	e.Lastname,
	e.JobTitle
FROM
	Employees e
WHERE
	e.Salary
		BETWEEN 20000
		AND 30000