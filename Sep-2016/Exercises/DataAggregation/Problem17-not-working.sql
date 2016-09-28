USE SoftUni
GO

WITH
	DepartmentIdSalaryRows
AS
(
	SELECT
		e.DepartmentId,
		e.Salary,
		ROW_NUMBER() OVER(PARTITION BY e.DepartmentId ORDER BY e.Salary DESC) AS RowNumber
	FROM
		Employees e
)

SELECT
	di.DepartmentId AS DepartmentID,
	di.Salary AS ThirdHighestSalary
from
	DepartmentIdSalaryRows di
where
	RowNumber = 3



