USE Geography
GO

SELECT
	c.CountryName,
	cn.ContinentName,
	COUNT(cr.RiverId) AS RiversCount,
	(CASE WHEN (
		SELECT
			SUM(Rivers.Length)
		FROM
			Rivers
				INNER JOIN
					CountriesRivers
				ON
					Rivers.Id = CountriesRivers.RiverId
		WHERE
			CountriesRivers.CountryCode = cr.CountryCode
	) IS NULL 
		THEN 0
		ELSE (
				SELECT
				SUM(Rivers.Length)
			FROM
				Rivers
					INNER JOIN
						CountriesRivers
					ON
						Rivers.Id = CountriesRivers.RiverId
			WHERE
				CountriesRivers.CountryCode = cr.CountryCode
		)
	END
	) AS TotalLength
FROM
	CountriesRivers cr
		RIGHT JOIN
			Countries c
		ON
			cr.CountryCode = c.CountryCode,
	Continents cn
WHERE
	c.ContinentCode = cn.ContinentCode
GROUP BY c.CountryName, cr.CountryCode, cn.ContinentName
ORDER BY
	RiversCount DESC,
	TotalLength DESC,
	c.CountryName

