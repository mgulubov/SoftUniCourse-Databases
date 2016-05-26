USE SoftUni
GO

SELECT
	CONCAT(e.FirstName, ' ', e.MiddleName, ' ', e.LastName)
		AS 'Employee Name',
	CONCAT(m.FirstName, ' ', m.MiddleName, ' ', m.LastName)
		AS 'Manage Name'
FROM
	Employees e
		RIGHT JOIN
			Employees m
		ON
			e.ManagerID = m.EmployeeID

