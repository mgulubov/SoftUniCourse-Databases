USE Geography
GO

SELECT
	p.PeakName,
	m.MountainRange AS 'Mountain',
	c.CountryName,
	cn.ContinentName
FROM
	Peaks p,
	Mountains m
		INNER JOIN
			MountainsCountries mn
		ON
			m.Id = mn.MountainId,
	Countries c
		INNER JOIN
			Continents cn
		ON
			c.ContinentCode = cn.ContinentCode
WHERE
	p.MountainId = m.Id
AND
	mn.CountryCode = c.CountryCode
ORDER BY
	p.PeakName,
	c.CountryName