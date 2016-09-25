USE Geography
GO

SELECT
	c.CountryName,
	c.IsoCode AS 'ISO Code'
FROM
	Countries c
WHERE
	c.CountryName LIKE '%a%a%a%'
ORDER BY
	c.IsoCode ASC