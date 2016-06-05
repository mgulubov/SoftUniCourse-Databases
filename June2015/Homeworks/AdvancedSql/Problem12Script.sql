USE SoftUni
GO

SELECT
	CONCAT(e.FirstName, ' ', e.LastName)
		AS 'Employee',
	ISNULL(
			(SELECT
				CONCAT(m.FirstName, ' ', m.LastName)
			FROM
				Employees m
			WHERE
				m.EmployeeID = e.ManagerId),
		  '(no manager)')
		AS 'Manager'
FROM
	Employees e