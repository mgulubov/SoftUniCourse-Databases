USE Geography
GO

SELECT TOP 30
	c.CountryName,
	c.Population
FROM
	Countries c
WHERE
	c.ContinentCode = 'EU'
ORDER BY
	Population desc,
	CountryCode
GO