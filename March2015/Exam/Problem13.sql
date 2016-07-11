USE Geography
GO

SELECT
	p.PeakName,
	r.RiverName,
	CONCAT(LOWER(SUBSTRING(p.PeakName, 1, LEN(p.PeakName) - 1)), LOWER(r.RiverName)) AS Mix
FROM
	Peaks p
		INNER JOIN 
			Rivers r
		ON
			SUBSTRING(LOWER(p.PeakName), LEN(p.PeakName), 1) = SUBSTRING(LOWER(r.RiverName), 1, 1)
GROUP BY
	p.PeakName, r.RiverName
ORDER BY
	Mix