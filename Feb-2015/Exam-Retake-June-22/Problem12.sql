USE Football
GO

SELECT
	c.CountryName AS 'Country Name',
	COUNT(DISTINCT im.Id) AS 'International Matches',
	COUNT(DISTINCT tm.Id) AS 'Team Matches'
FROM
	Countries c
		LEFT JOIN
			Leagues l ON
				l.CountryCode = c.CountryCode
		LEFT JOIN
			InternationalMatches im ON
				im.HomeCountryCode = c.CountryCode
				OR
				im.AwayCountryCode = c.CountryCode
		LEFT JOIN
			TeamMatches tm ON
				tm.LeagueId = l.Id
GROUP BY
	c.CountryName
HAVING
	COUNT(DISTINCT im.Id) > 0
	OR
	COUNT(DISTINCT tm.Id) > 0
ORDER BY
	'International Matches' DESC,
	'Team Matches' DESC,
	c.CountryName ASC