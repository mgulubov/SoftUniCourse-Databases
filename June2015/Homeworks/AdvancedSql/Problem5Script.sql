USE SoftUni
GO

SELECT
	AVG(e.Salary)
FROM
	Employees e
WHERE
	e.DepartmentID = (
						SELECT 
							DepartmentID
						FROM
							Departments
						WHERE
							Name = 'Sales'
					 )	