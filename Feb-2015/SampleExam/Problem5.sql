USE Ads
GO

SELECT
	a.Title,
	t.Name AS Town
FROM
	Ads a
		LEFT JOIN
			Towns t ON
				t.Id = a.TownId
ORDER BY
	a.Id
