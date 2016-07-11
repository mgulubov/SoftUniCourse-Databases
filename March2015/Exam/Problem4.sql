USE Geography
GO


SELECT
	c.CountryName AS 'Country Name',
	c.IsoCode AS 'ISO Code'
FROM
	Countries c
WHERE
	(LEN(c.CountryName) - LEN(REPLACE(LOWER(c.CountryName), 'a', ''))) >= 3
ORDER BY
	c.IsoCode