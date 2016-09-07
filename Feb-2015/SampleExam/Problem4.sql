USE Ads
GO

SELECT
	*
FROM
	Ads a
WHERE
	a.TownId IS NULL
OR
	a.CategoryId IS NULL
OR
	a.ImageDataURL IS NULL
ORDER BY
	a.Id