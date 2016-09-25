USE Diablo
GO

SELECT TOP 50
	g.Name AS Game,
	FORMAT(g.Start, 'yyy-MM-dd')
FROM
	Games g
WHERE
	YEAR(g.Start) IN (2011, 2012)
ORDER BY
	g.Start ASC,
	g.Name ASC