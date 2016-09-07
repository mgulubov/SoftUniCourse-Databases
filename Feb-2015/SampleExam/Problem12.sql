USE Ads
GO

SELECT
	t.Name AS 'Town Name',
	s.Status,
	COUNT(a.Id) AS Count
FROM
	Ads a
		INNER JOIN
			Towns t ON
				a.TownId = t.Id
		INNER JOIN
			AdStatuses s ON
				a.StatusId = s.Id
GROUP BY
	t.Name,
	s.Status
ORDER BY
	t.Name,
	s.Status