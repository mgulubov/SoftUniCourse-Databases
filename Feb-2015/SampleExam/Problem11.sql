USE Ads
GO

SELECT
	s.Status,
	COUNT(a.Id) AS Count
FROM
	AdStatuses s
		LEFT JOIN
			Ads a ON
				a.StatusId = s.Id
GROUP BY
	s.Status
ORDER BY
	s.Status