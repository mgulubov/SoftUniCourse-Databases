USE Geography
GO

SELECT
	cur.CurrencyCode,
	cur.Description AS Currency,
	COUNT(c.CountryCode) AS NumberOfCountries
FROM
	Currencies cur
		LEFT JOIN
			Countries c
		ON
			c.CurrencyCode = cur.CurrencyCode
GROUP BY
	cur.CurrencyCode, cur.Description
ORDER BY
	NumberOfCountries DESC,
	Currency