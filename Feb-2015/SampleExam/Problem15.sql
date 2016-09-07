USE Ads
GO

SELECT
	firstDate.Date AS FirstDate,
	secondDate.Date AS SecondDate
FROM
	Ads firstDate,
	Ads secondDate
WHERE
	firstDate.Date < secondDate.Date
AND
	DATEDIFF(MINUTE, firstDate.Date, secondDate.Date) < 12 * 60
ORDER BY
	firstDate.Date ASC,
	secondDate.Date ASC 