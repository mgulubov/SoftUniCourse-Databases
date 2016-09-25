USE SoftUni
GO

BEGIN TRAN
	UpdateSalariesTransaction

UPDATE
	Employees
SET
	Salary = Salary + (Salary * 0.12)
WHERE
	DepartmentID IN (
		SELECT
			d.DepartmentID
		FROM
			Departments d
		WHERE
			d.Name IN ('Engineering', 'Tool Design', 'Marketing', 'Information Services')
	)

SELECT
	e.Salary
FROM
	Employees e

ROLLBACK TRAN
	UpdateSalariesTransaction
