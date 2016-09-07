USE Geography
GO

SELECT
	cu.CurrencyCode,
	cu.Description AS Currency,
	COUNT(c.CountryCode) AS NumberOfCountries
FROM
	Currencies cu
		LEFT JOIN
			Countries c ON
				c.CurrencyCode = cu.CurrencyCode
GROUP BY
	cu.CurrencyCode,
	cu.Description
ORDER BY
	NumberOfCountries DESC,
	cu.Description ASC