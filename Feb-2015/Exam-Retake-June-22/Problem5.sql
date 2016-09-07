USE Football
GO

SELECT
	htc.CountryName AS 'Home Team',
	atc.CountryName AS 'Away Team',
	im.MatchDate AS 'Match Date'
FROM
	InternationalMatches im
		LEFT JOIN
			Countries htc ON
				htc.CountryCode = im.HomeCountryCode
		LEFT JOIN
			Countries atc ON
				atc.CountryCode = im.AwayCountryCode
ORDER BY
	im.MatchDate DESC