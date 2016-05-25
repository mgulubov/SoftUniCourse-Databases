USE SoftUni
GO

SELECT 
	CONCAT(e.FirstName, ' ', e.MiddleName, '', e.LastName) 
	AS 'Full Name'
FROM 
	Employees e
WHERE
	e.FirstName LIKE 'SA%'
