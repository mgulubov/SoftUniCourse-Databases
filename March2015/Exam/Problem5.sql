USE Geography
GO

SELECT
	p.PeakName,
	m.MountainRange AS 'Mountain',
	p.Elevation
FROM
	Peaks p
		INNER JOIN
			Mountains m
		ON
			p.MountainId = m.Id
ORDER BY
	p.Elevation DESC,
	m.MountainRange