USE Ads
GO

SELECT
	a.Title,
	a.Date
FROM
	Ads a
WHERE
	a.Date
		BETWEEN '26-December-2014'
		AND '2-January-2015'
ORDER BY
	a.Date