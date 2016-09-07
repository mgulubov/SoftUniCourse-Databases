USE Geography
GO

SELECT
	p.PeakName,
	m.MountainRange AS Mountain,
	p.Elevation
FROM
	Peaks p
		LEFT JOIN
			Mountains m ON
				m.Id = p.MountainId
ORDER BY
	p.Elevation DESC,
	p.PeakName ASC