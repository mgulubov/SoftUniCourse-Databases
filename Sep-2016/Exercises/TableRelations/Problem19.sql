USE Geography
GO

SELECT
	COUNT(c.CountryCode) AS CountryCode
FROM
	Countries c
		LEFT JOIN
			MountainsCountries mc ON
				mc.CountryCode = c.CountryCode
WHERE
	mc.CountryCode IS NULL