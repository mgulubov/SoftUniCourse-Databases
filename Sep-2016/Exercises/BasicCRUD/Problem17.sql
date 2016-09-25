USE SoftUni
GO
----------------
----------------
DROP VIEW IF EXISTS
	V_EmployeeNameJobTitle
GO
----------------
----------------
CREATE VIEW
	V_EmployeeNameJobTitle
AS
SELECT
	CONCAT(e.FirstName, ' ', e.MiddleName, ' ', e.LastName) AS 'Full Name',
	e.JobTitle AS 'Job Title'
FROM
	Employees e
GO
-----------------
-----------------
DROP VIEW IF EXISTS
	V_EmployeeNameJobTitle
GO