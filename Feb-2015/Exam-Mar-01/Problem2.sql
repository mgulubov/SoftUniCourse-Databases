USE Geography
GO

SELECT TOP 30
	c.CountryName,
	c.Population
FROM
	Countries c
		INNER JOIN
			Continents cn ON
				cn.ContinentCode = c.ContinentCode
				AND
				cn.ContinentName = 'Europe'
ORDER BY
	c.Population DESC,
	c.CountryName ASC