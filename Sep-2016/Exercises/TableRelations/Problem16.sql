USE Geography
GO

SELECT
	c.CountryCode,
	COUNT(mc.MountainId) AS MountainRanges
FROM
	Countries c
		RIGHT JOIN
			MountainsCountries mc ON
				mc.CountryCode = c.CountryCode
WHERE
	c.CountryName IN ('United States', 'Russia', 'Bulgaria')
GROUP BY
	c.CountryCode