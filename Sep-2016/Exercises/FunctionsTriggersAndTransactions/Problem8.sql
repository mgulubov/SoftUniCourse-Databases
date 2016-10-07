USE SoftUni
GO

BEGIN TRANSACTION TranOne

DELETE FROM
	Employees
WHERE
	EmployeeID IN (
		SELECT
			EmployeeID
		FROM
			Employees e
				INNER JOIN
					Departments d ON
						d.DepartmentID = e.DepartmentID
		WHERE
			d.Name IN ('Production', 'Production Control')
	)

DELETE FROM
	Departments
WHERE
	DepartmentID IN (
		SELECT
			DepartmentID
		WHERE
			Name IN ('Production', 'Production Control')
	)

ROLLBACK TRANSACTION TranOne