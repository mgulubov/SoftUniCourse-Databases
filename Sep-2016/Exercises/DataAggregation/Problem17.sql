USE SoftUni
GO

WITH
	DistinctSalaries
AS
(
	SELECT DISTINCT
  		e.DepartmentId,
  		e.Salary
  	FROM
  		Employees e
),

	DepartmentIdSalaryRows
AS
(
	SELECT
		ds.DepartmentId,
  		ds.Salary,
		ROW_NUMBER() OVER(PARTITION BY ds.DepartmentID ORDER BY ds.Salary DESC) AS RowNumber
	FROM
		DistinctSalaries ds
)

SELECT
	di.DepartmentId AS DepartmentID,
	di.Salary AS ThirdHighestSalary
FROM
	DepartmentIdSalaryRows di
WHERE
	RowNumber = 3



