USE SoftUni
GO

SELECT TOP 5
	e.EmployeeID,
	e.FirstName,
	p.Name AS ProjectName
FROM
	Employees e
		INNER JOIN
			EmployeesProjects ep ON
				ep.EmployeeID = e.EmployeeID
		LEFT JOIN
			Projects p ON
				p.ProjectID = ep.ProjectID
WHERE
	p.StartDate > CONVERT(SMALLDATETIME, '13.08.2002', 104)
AND
	p.EndDate IS NULL
ORDER BY
	e.EmployeeID ASC