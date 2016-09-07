USE Geography
GO

SELECT
	c.CountryName,
	cn.ContinentName,
	(
		CASE
			WHEN COUNT(r.Id) IS NULL
			THEN 0
			ELSE COUNT(r.Id)
		END
	) AS RiversCount,
	(
		CASE
			WHEN SUM(r.Length) IS NULL
			THEN 0
			ELSE SUM(r.Length)
		END
	) AS TotalLength
FROM
	Countries c
		LEFT JOIN
			CountriesRivers cr ON
				cr.CountryCode = c.CountryCode
		LEFT JOIN
			Rivers r ON
				r.Id = cr.RiverId
		LEFT JOIN
			Continents cn ON
				cn.ContinentCode = c.ContinentCode
GROUP BY
	c.CountryName,
	cn.ContinentName
ORDER BY
	RiversCount DESC,
	TotalLength DESC,
	c.CountryName ASC