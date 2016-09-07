USE Football
GO

SELECT TOP 50
	c.CountryName,
	c.Population
FROM
	Countries c
ORDER BY
	c.Population DESC,
	c.CountryName