USE Football
GO

SELECT
	t.TeamName AS Team,
	COUNT(tm.Id) AS 'Matches Count'
FROM
	Teams t
		LEFT JOIN
			TeamMatches tm ON
				tm.HomeTeamId = t.Id
				OR
				tm.AwayTeamId = t.Id
GROUP BY
	t.TeamName
HAVING
	COUNT(tm.Id) > 1
ORDER BY
	t.TeamName