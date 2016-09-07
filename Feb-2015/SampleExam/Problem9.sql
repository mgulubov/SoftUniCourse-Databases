USE Ads
GO

SELECT TOP 10
	a.Title,
	a.Date,
	s.Status
FROM
	Ads a
		INNER JOIN
			AdStatuses s ON
				s.Id = a.StatusId
ORDER BY
	a.Date DESC