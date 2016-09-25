USE SoftUni
GO

SELECT
	e.FirstName,
	e.LastName
FROM
	Employees e
WHERE
	e.JobTitle NOT LIKE '%engineer%'