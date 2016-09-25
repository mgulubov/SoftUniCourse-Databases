USE Diablo
GO

SELECT
	g.Name AS Game,
	(
		CASE
			WHEN FORMAT(g.Start, 'HH') >= 0 AND FORMAT(g.Start, 'HH') < 12
			THEN 'Morning'
			ELSE (
				CASE 
					WHEN FORMAT(g.Start, 'HH') >= 12 AND FORMAT(g.Start, 'HH') < 18
					THEN 'Afternoon'
					ELSE 'Evening'
				END
			)
		END
	) AS 'Part of the Day',
	(
		CASE
			WHEN g.Duration <= 3
			THEN 'Extra Short'
			ELSE (
				CASE
					WHEN g.Duration >= 4 AND g.Duration <= 6
					THEN 'Short'
					ELSE (
						CASE
							WHEN g.Duration IS NULL
							THEN 'Extra Long'
							ELSE 'Long'
						END
					)
				END
			)
		END
	) AS Duration
FROM
	Games g
ORDER BY
	g.Name ASC,
	Duration ASC,
	'Part of the Day' ASC