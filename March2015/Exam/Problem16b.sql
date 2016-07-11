USE Geography
GO

SELECT
	cn.ContinentName,
	c.CountryName,
	(
		SELECT
			COUNT(m.CountryCode)
		FROM
			Monasteries m
		WHERE
			m.CountryCode = c.CountryCode
	) AS MonasteriesCount
FROM
	Continents cn
		INNER JOIN
			Countries c
		ON
			cn.ContinentCode = c.ContinentCode
WHERE
	c.IsDeleted != 1
ORDER BY
	MonasteriesCount DESC,
	c.CountryName