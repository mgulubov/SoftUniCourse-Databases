USE Football
GO

SELECT
	c.CountryName,
	c.CountryCode,
	(
		CASE
			WHEN c.CurrencyCode = 'EUR'
			THEN 'Inside'
			ELSE 'Outside'
		END
	) AS Eurozone
FROM
	Countries c
ORDER BY
	c.CountryName ASC