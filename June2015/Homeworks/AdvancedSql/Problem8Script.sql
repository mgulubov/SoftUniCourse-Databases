USE SoftUni
GO

SELECT
	COUNT(*)
		AS 'Employees without manager'
FROM
	Employees e
WHERE
	e.ManagerID IS NULL