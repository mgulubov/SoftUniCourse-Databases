USE Geography
GO

SELECT
	p.PeakName,
	r.RiverName,
	CONCAT(
		SUBSTRING(LOWER(p.PeakName), 0, LEN(p.PeakName)),
		LOWER(r.RiverName)
	) AS Mix
FROM
	Peaks p,
	Rivers r
WHERE
	SUBSTRING(LOWER(p.PeakName), LEN(p.PeakName), 1) = SUBSTRING(LOWER(r.RiverName), 1, 1)
ORDER BY
	Mix ASC
