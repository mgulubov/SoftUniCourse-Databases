USE SoftUni
GO

SELECT TOP 5
	e.EmployeeId,
	e.JobTitle,
	e.AddressId,
	a.AddressText
FROM
	Employees e
		LEFT JOIN
			Addresses a ON
				a.AddressID = e.AddressID
ORDER BY
	e.AddressID ASC