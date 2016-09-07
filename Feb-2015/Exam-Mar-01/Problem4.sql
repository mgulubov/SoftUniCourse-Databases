USE Geography
GO

SELECT
	c.CountryName AS 'Country Name',
	c.IsoCode AS 'ISO Code'
FROM
	Countries c
WHERE
	c.CountryName LIKE '%a%a%a%' COLLATE SQL_Latin1_General_CP1_CI_AS
ORDER BY
	c.IsoCode ASC