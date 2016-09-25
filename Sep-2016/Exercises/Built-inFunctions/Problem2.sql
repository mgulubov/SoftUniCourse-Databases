USE SoftUni
GO

SELECT
	e.Firstname,
	e.LastName
FROM
	Employees e
WHERE
	e.LastName LIKE '%ei%'