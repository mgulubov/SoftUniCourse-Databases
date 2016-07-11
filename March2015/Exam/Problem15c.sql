USE Geography
GO

SELECT
	m.Name AS Monastery,
	c.CountryName AS Country
FROM
	Monasteries m,
	Countries c
WHERE
	c.CountryCode = m.CountryCode
AND
	c.IsDeleted = 0
ORDER BY
	m.Name