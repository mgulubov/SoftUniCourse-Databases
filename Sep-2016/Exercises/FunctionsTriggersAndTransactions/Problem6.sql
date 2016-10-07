USE SoftUni
GO
--------------
--------------
-- Drop procedure if exists
DROP PROCEDURE IF EXISTS
	usp_EmployeesBySalaryLevel
GO
--------------
--------------
-- Create function
CREATE PROCEDURE
	usp_EmployeesBySalaryLevel
		@SalaryLevel NVARCHAR(7)
AS
BEGIN

WITH
	EmployeesNamesSalaryLevel
AS
(
	SELECT
		e.FirstName,
		e.LastName,
		(
			CASE
				WHEN e.Salary > 50000
				THEN 'High'
				ELSE (
					CASE
						WHEN e.Salary >= 30000 AND e.Salary <= 30000
						THEN 'Average'
						ELSE 'Low'
					END
				)
			END
		) AS SalaryLevel
	FROM
		Employees e
)

SELECT
	ens.FirstName,
	ens.LastName
FROM
	EmployeesNamesSalaryLevel ens
WHERE
	ens.SalaryLevel = @SalaryLevel

END
GO
--------------
--------------
-- Execute procedure
EXECUTE usp_EmployeesBySalaryLevel @SalaryLevel = 'High'