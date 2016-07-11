USE Geography
GO

SELECT
	r.RiverName AS 'River',
	(SELECT COUNT(CountryCode) FROM CountriesRivers WHERE RiverId = r.Id) AS 'Countries Count'
FROM
	Rivers r
		INNER JOIN
			CountriesRivers cr
		ON
			r.Id = cr.RiverId,
	Countries c
WHERE
	c.CountryCode = cr.CountryCode
AND
	(SELECT COUNT(CountryCode) FROM CountriesRivers WHERE RiverId = r.Id) >= 3
GROUP BY 
	r.RiverName, r.Id
ORDER BY
	r.RiverName

