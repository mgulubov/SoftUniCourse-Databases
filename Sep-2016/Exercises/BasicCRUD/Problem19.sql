USE SoftUni
GO

SELECT TOP 10
	*
FROM
	Projects p
ORDER BY
	p.StartDate ASC,
	p.Name ASC