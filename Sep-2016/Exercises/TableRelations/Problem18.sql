USE Geography
GO

WITH
	ContinentsWithCurrencyCount
AS
(
	SELECT
		cn.ContinentCode,
		cr.CurrencyCode,
		COUNT(c.CountryCode) AS CurrencyCount
	FROM
		Continents cn
			INNER JOIN
				Countries c ON
					c.ContinentCode = cn.ContinentCode
			INNER JOIN
				Currencies cr ON
					cr.CurrencyCode = c.CurrencyCode
	GROUP BY
		cn.ContinentCode,
		cr.CurrencyCode
	HAVING
		COUNT(c.CountryCode) > 1
)

SELECT
	cc.ContinentCode,
	cc.CurrencyCode,
	cc.CurrencyCount AS CurrencyUsage
FROM
	ContinentsWithCurrencyCount cc
WHERE
	cc.CurrencyCount = 
		(
			SELECT 
				MAX(CurrencyCount) 
			FROM 
				ContinentsWithCurrencyCount 
			WHERE 
				ContinentCode = cc.ContinentCode
		)
ORDER BY
	cc.ContinentCode ASC