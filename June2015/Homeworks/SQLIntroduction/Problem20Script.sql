USE SoftUni
GO

SELECT
	CONCAT(e.FirstName, ' ', e.MiddleName, ' ', e.LastName)
		AS 'Employee Name',
	(
		SELECT
			CONCAT(e1.FirstName, ' ', e1.MiddleName, ' ', e1.LastName)
		FROM
			Employees e1
		WHERE
			e.ManagerID = e1.EmployeeID
	)
		AS 'Manager Name'
FROM
	Employees e
WHERE
	e.ManagerID IS NOT NULL