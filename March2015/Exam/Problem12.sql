USE Geography
GO

SELECT
	c.CountryName,
	(
		SELECT
			MAX(p.Elevation) AS H
		FROM
			Peaks p
				LEFT JOIN
					MountainsCountries
				ON
					p.MountainId = MountainsCountries.MountainId
		WHERE
			MountainsCountries.CountryCode = c.CountryCode
	) AS HighestPeakElevation,
	(
		SELECT
			MAX(r.Length) AS L
		FROM
			Rivers r
				LEFT JOIN
					CountriesRivers
				ON
					r.Id = CountriesRivers.RiverId
		WHERE
			CountriesRivers.CountryCode = c.CountryCode
	) AS LongestRiverLength

FROM
	Countries c
		LEFT JOIN
			CountriesRivers cr
		ON
			c.CountryCode = c.CountryCode
		LEFT JOIN
			MountainsCountries mc
		ON
			c.CountryCode = mc.CountryCode
GROUP BY
	c.CountryName, c.CountryCode
ORDER BY
	HighestPeakElevation DESC,
	LongestRiverLength DESC,
	c.CountryName