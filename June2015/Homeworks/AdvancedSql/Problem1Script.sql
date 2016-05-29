USE SoftUni
GO

SELECT
	e.FirstName,
	e.LastName,
	e.Salary
FROM
	Employees e
WHERE
	e.Salary = (
					SELECT 
						MIN(Salary) 
					FROM 
						Employees
			   )