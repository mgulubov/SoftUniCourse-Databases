USE SoftUni
GO

SELECT
	d.Name
		AS 'Department',
	(
		SELECT
			AVG(Salary)
		FROM
			Employees
		WHERE
			Employees.DepartmentID = d.DepartmentId
	)
		AS 'Avegare Salary'
FROM
	Departments d