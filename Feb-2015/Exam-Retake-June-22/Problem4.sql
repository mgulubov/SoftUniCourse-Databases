USE Football
GO

SELECT
	t.TeamName AS 'Team Name',
	t.CountryCode AS 'Country Code'
FROM
	Teams t
WHERE
	t.TeamName LIKE '%[0-9]%'
ORDER BY
	t.CountryCode ASC