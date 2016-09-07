USE Football
GO

SELECT
	t.TeamName AS 'Team Name',
	l.LeagueName AS League,
	(
		CASE
			WHEN c.CountryName IS NULL
			THEN 'International'
			ELSE c.CountryName
		END
	) AS 'League Country'
FROM
	Teams t
		LEFT JOIN
			Leagues_Teams lt ON
				lt.TeamId = t.Id
		LEFT JOIN
			Leagues l ON
				l.Id = lt.LeagueId
		LEFT JOIN
			Countries c ON
				c.CountryCode = l.CountryCode
ORDER BY
	t.TeamName ASC,
	l.LeagueName ASC