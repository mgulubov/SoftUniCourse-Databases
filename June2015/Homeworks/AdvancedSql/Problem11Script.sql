USE SoftUni
GO

SELECT
	m.FirstName,
	m.LastName,
	(SELECT COUNT(*) FROM Employees e WHERE e.ManagerID = m.ManagerID)
		AS 'Employees count'
FROM
	Employees m
WHERE 
	(SELECT COUNT(*) FROM Employees e WHERE e.ManagerID = m.ManagerID) = 5