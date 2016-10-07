USE SoftUni
GO
----------------
----------------
-- Drop procedure if exists
DROP PROCEDURE IF EXISTS
	usp_GetEmployeesSalaryAbove35000
GO
----------------
----------------
-- Create procedure
CREATE PROCEDURE
	usp_GetEmployeesSalaryAbove35000
AS
BEGIN
	SELECT
		e.FirstName,
		e.LastName
	FROM
		Employees e
	WHERE
		e.Salary > 35000
END
GO
----------------
----------------
-- Execute procedure
EXECUTE usp_GetEmployeesSalaryAbove35000