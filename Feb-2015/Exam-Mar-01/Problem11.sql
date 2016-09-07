USE Geography
GO

SELECT
	cn.ContinentName,
	SUM(CAST(c.AreaInSqKm AS DECIMAL)) AS CountriesArea,
	SUM(CAST(c.Population AS DECIMAL)) AS CountriesPopulation
FROM
	Continents cn
		LEFT JOIN
			Countries c ON
				c.ContinentCode = cn.ContinentCode
GROUP BY
	cn.ContinentName
ORDER BY
	CountriesPopulation DESC