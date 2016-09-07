USE Football
GO

SELECT
	l.LeagueName AS 'League Name',
	COUNT(DISTINCT lt.TeamId) AS Teams,
	COUNT(DISTINCT tm.Id) AS Matches,
	(
		CASE
			WHEN AVG(tm.HomeGoals + tm.AwayGoals) IS NULL
			THEN (
				CASE
					WHEN AVG(im.HomeGoals + im.AwayGoals) IS NULL
					THEN 0
					ELSE AVG(im.HomeGoals + im.AwayGoals)
				END
			)
			ELSE AVG(tm.HomeGoals + tm.AwayGoals)
		END
	) AS 'Average Goals'
FROM
	Leagues l
		LEFT JOIN
			Leagues_Teams lt ON
				lt.LeagueId = l.Id
		LEFT JOIN
			TeamMatches tm ON
				tm.LeagueId = l.Id
		LEFT JOIN
			InternationalMatches im ON
				im.LeagueId = l.Id
GROUP BY
	l.LeagueName
ORDER BY
	Teams DESC,
	Matches DESC