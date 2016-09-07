USE Ads
GO

SELECT
	a.Title,
	c.Name AS CategoryName,
	t.Name AS TownName,
	s.Status
FROM
	Ads a
		LEFT JOIN
			Categories c ON
				c.Id = a.CategoryId
		LEFT JOIN
			Towns t ON
				t.Id = a.TownId
		LEFT JOIN
			AdStatuses s ON
				s.Id = a.StatusId
ORDER BY
	a.Id ASC