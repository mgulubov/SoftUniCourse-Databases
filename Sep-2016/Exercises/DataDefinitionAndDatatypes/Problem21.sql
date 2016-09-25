USE SoftUni
GO
--------------------
--------------------
SELECT
	t.Name
FROM
	Towns t
ORDER BY
	t.Name ASC
--------------------
--------------------
SELECT
	d.Name
FROM
	Departments d
ORDER BY
	d.Name ASC
--------------------
--------------------
SELECT
	e.FirstName,
	e.LastName,
	e.JobTitle,
	e.Salary
FROM
	Employees e
ORDER BY
	e.Salary DESC