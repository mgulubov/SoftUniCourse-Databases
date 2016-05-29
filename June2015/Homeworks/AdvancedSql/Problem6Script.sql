USE SoftUni
GO

SELECT
	COUNT(*)
FROM
	Employees
WHERE
	DepartmentID = (
						SELECT
							DepartmentID
						FROM
							Departments
						WHERE
							Name = 'Sales'
				   )