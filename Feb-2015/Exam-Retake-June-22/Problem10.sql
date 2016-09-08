USE Football
GO

SELECT
	tm1.MatchDate AS 'First Date',
	tm2.MatchDate AS 'Second Date'
FROM
	TeamMatches tm1,
	TeamMatches tm2
WHERE
	YEAR(tm1.MatchDate) = YEAR(tm2.MatchDate)
	AND
	MONTH(tm1.MatchDate) = MONTH(tm2.MatchDate)
	AND
	DAY(tm1.MatchDate) = DAY(tm2.MatchDate)
	AND
	tm1.MatchDate < tm2.MatchDate
	AND
	tm2.Id != tm1.Id
ORDER BY
	tm1.MatchDate DESC,
	tm2.MatchDate DESC