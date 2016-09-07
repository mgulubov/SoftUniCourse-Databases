USE Ads
GO

SELECT 
	a.Id,
	a.Title,
	a.Date,
	s.Status
FROM
	Ads a
		RIGHT JOIN
			(
				SELECT 
					MONTH(Date) AS AdMonth,
					YEAR(Date) AS AdYear
				FROM
					Ads
				WHERE
					Date = (
						SELECT
							MIN(Date)
						FROM
							Ads
					)
			) AS EarliestAd ON
					MONTH(a.Date) = EarliestAd.AdMonth
				AND
					YEAR(a.Date) = EarliestAd.AdYear
			INNER JOIN
				AdStatuses s ON
					a.StatusId = s.Id
				AND
					s.Status != 'Published'
ORDER BY
	a.Id ASC
