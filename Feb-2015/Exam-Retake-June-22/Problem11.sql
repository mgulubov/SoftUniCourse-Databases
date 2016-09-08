USE Football
GO

SELECT
	(
		CONCAT(
			SUBSTRING(LOWER(t1.TeamName), 1, LEN(t1.TeamName) - 1),
			SUBSTRING(LOWER(REVERSE(t2.TeamName)), 1, LEN(t2.TeamName))
		)
	) AS Mix
FROM
	Teams t1,
	Teams t2
WHERE
	SUBSTRING(LOWER(t1.TeamName), LEN(t1.TeamName), 1) = SUBSTRING(LOWER(REVERSE(t2.TeamName)), 1, 1)
ORDER BY
	Mix ASC