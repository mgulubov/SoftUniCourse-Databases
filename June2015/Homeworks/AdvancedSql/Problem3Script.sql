USE SoftUni
GO

SELECT
	CONCAT(e.FirstName, ' ', e.MiddleName, ' ', e.LastName)
		AS 'FullName',
	e.Salary,
	d.Name
		AS 'Department'
FROM
	Employees e
		INNER JOIN
			Departments d
		ON
			e.DepartmentID = d.DepartmentID
WHERE
	e.Salary = (
					SELECT
						MIN(Salary)
					FROM
						Employees
					WHERE
						e.DepartmentID = Employees.DepartmentID
			   )		
