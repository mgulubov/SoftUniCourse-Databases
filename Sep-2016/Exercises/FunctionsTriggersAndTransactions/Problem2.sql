USE SoftUni
GO
------------
------------
-- Drop procedure if exists
DROP PROCEDURE IF EXISTS
	usp_GetEmployeesSalaryAboveNumber
GO
------------
------------
-- Create procedure
CREATE PROCEDURE
	usp_GetEmployeesSalaryAboveNumber
		@EmployeeSalary MONEY
AS
BEGIN
	SELECT
		e.FirstName,
		e.LastName
	FROM
		Employees e
	WHERE
		e.Salary >= @EmployeeSalary
END
GO
------------
------------
-- Call procedure
EXECUTE usp_GetEmployeesSalaryAboveNumber @EmployeeSalary = 48100