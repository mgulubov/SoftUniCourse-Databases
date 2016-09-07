USE Ads
GO

SELECT
	COUNT(a.Id) AS AdsCount,
	(
		CASE
			WHEN t.Name IS NULL
			THEN '(no town)'
			ELSE t.Name
		END
	) AS Town
FROM
	Towns t
		RIGHT JOIN
			Ads a ON
				a.TownId = t.Id
GROUP BY
	t.Name
HAVING
	COUNT(a.Id) = 2
OR
	count(a.Id) = 3
ORDER BY
	t.Name ASC