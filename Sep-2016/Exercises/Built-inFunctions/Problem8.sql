USE SoftUni
GO
-------------------
-------------------
DROP VIEW IF EXISTS
	V_EmployeesHiredAfter2000 
GO
-------------------
-------------------
CREATE VIEW
	V_EmployeesHiredAfter2000 
AS
SELECT
	e.FirstName,
	e.LastName
FROM
	Employees e
WHERE
	YEAR(e.HireDate) > 2000
GO
-------------------
-------------------
DROP VIEW IF EXISTS
	V_EmployeesHiredAfter2000 
GO