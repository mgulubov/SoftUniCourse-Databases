USE SoftUni
GO

SELECT 
	d.Name
		AS	'Department Name'
FROM
	Departments d
UNION
SELECT
	t.Name
FROM
	Towns t
