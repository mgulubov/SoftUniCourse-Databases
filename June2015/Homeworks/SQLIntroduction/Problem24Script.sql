USE SoftUni
GO

SELECT
	CONCAT(e.FirstName, ' ', e.MiddleName, ' ', e.LastName)
		AS 'Employee Name'
FROM
	Employees e
		INNER JOIN
			Departments d
		ON
			e.DepartmentID = d.DepartmentID
WHERE
	(
		d.Name = 'Sales'
			OR
		d.Name = 'Finance'
	)
AND
	(
		e.HireDate >= CONVERT(datetime, '1995-01-01')
			AND
		e.HireDate <= CONVERT(datetime, '2005-12-31')
	)

	