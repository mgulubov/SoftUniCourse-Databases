USE Geography
GO

SELECT
	p.PeakName,
	r.RiverName,
	CONCAT(
		SUBSTRING(LOWER(p.PeakName), 1, LEN(p.PeakName) - 1),
		LOWER(r.RiverName)
	) AS Mix
FROM
	Peaks p
		INNER JOIN
			Rivers r ON
				SUBSTRING(LOWER(r.RiverName), 1, 1) = SUBSTRING(LOWER(p.PeakName), LEN(p.PeakName), 1)
ORDER BY
	Mix ASC