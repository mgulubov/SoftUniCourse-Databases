USE SoftUni
GO
-----------------
-----------------
DROP VIEW IF EXISTS
	V_EmployeesSalaries
GO
-----------------
-----------------
CREATE VIEW
	V_EmployeesSalaries
AS
SELECT
	e.FirstName,
	e.LastName,
	e.Salary
FROM
	Employees e
GO
-----------------
-----------------
DROP VIEW IF EXISTS
	V_EmployeesSalaries
GO