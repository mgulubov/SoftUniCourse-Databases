USE SoftUni
GO

SELECT
	t.Name
		AS 'Town',
	d.Name
		AS 'Department',
	COUNT(e.EmployeeId)
		AS 'Employees count'
FROM
	Employees e
		INNER JOIN
			Departments d
		ON
			d.DepartmentID = e.DepartmentID,
	Addresses a
		INNER JOIN
			Towns t
		ON
			t.TownID = a.TownID
WHERE
	a.AddressID = e.AddressID
GROUP BY
	t.Name, d.Name