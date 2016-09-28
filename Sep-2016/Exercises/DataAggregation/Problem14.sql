USE SoftUni
GO

DROP TABLE IF EXISTS
	HighestPaidEmployees
GO
---------------------------
---------------------------
SELECT
	*
INTO
	HighestPaidEmployees
FROM
	Employees
WHERE
	Salary > 30000
---------------------------
DELETE FROM
	HighestPaidEmployees
WHERE
	ManagerID = 42
---------------------------
UPDATE
	HighestPaidEmployees
SET
	Salary = Salary + 5000
WHERE
	DepartmentID = 1
---------------------------
SELECT
	DepartmentId,
	AVG(Salary) AS AverageSalary
FROM
	HighestPaidEmployees
GROUP BY
	DepartmentID
---------------------------
---------------------------
DROP TABLE IF EXISTS
	HighestPaidEmployees
GO