USE Geography
GO

SELECT
	r.RiverName AS River,
	COUNT(cr.RiverId) AS 'Countries Count'
FROM
	Rivers r
		INNER JOIN
			CountriesRivers cr ON
				cr.RiverId = r.Id
GROUP BY
	r.RiverName
HAVING
	COUNT(cr.RiverId) >= 3
ORDER BY
	r.RiverName
