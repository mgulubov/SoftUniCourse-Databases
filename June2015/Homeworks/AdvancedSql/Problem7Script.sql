USE SoftUni
GO

SELECT
	COUNT(*)
		AS	'Employees with manager'
FROM
	Employees e
WHERE
	e.ManagerID IS NOT NULL