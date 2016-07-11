USE Geography
GO

SELECT
	cn.ContinentName,
	SUM(CAST(c.AreaInSqKm AS bigint)) AS CountriesArea,
	SUM(CAST(c.Population AS bigint)) AS CountriesPopulation
FROM
	Continents cn
		LEFT JOIN
			Countries c
		ON
			cn.ContinentCode = c.ContinentCode
GROUP BY
	cn.ContinentName
ORDER BY
	CountriesPopulation DESC