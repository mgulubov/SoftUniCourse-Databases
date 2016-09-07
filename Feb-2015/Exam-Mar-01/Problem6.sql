USE Geography
GO

SELECT
	p.PeakName,
	m.MountainRange AS Mountain,
	c.CountryName,
	cn.ContinentName
FROM
	Peaks p
		LEFT JOIN
			Mountains m ON
				m.Id = p.MountainId
		INNER JOIN
			MountainsCountries mc ON
				mc.MountainId = m.Id
		LEFT JOIN
			Countries c ON
				c.CountryCode = mc.CountryCode
		LEFT JOIN
			Continents cn ON
				cn.ContinentCode = c.ContinentCode
ORDER BY
	p.PeakName ASC,
	c.CountryName ASC