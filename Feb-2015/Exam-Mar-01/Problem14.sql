USE Geography
GO

SELECT
	c.CountryName AS Country,
	(
		CASE
			WHEN MAX(p.Elevation) IS NULL
			THEN '(no highest peak)'
			ELSE (
				SELECT
					PeakName
				FROM
					Peaks
				WHERE
					Elevation = MAX(p.Elevation)
			)
		END
	) AS 'Highest Peak Name',
	(
		CASE
			WHEN MAX(p.Elevation) IS NULL
			THEN 0
			ELSE MAX(p.Elevation)
		END
	) AS 'Highest Peak Elevation',
	(
		CASE
			WHEN (
				SELECT
					MountainRange
				FROM
					Mountains
						INNER JOIN
							Peaks ON
								Peaks.MountainId = Mountains.Id
								AND
								Peaks.Elevation = MAX(p.Elevation)
			) IS NULL
			THEN '(no mountain)'
			ELSE (
				SELECT
					MountainRange
				FROM
					Mountains
						INNER JOIN
							Peaks ON
								Peaks.MountainId = Mountains.Id
								AND
								Peaks.Elevation = MAX(p.Elevation)
			)
		END
	) AS Mountain
FROM
	Countries c
		LEFT JOIN
			MountainsCountries mc ON
				mc.CountryCode = c.CountryCode
		LEFT JOIN
			Mountains m ON
				m.Id = mc.MountainId
		LEFT JOIN
			Peaks p ON
				p.MountainId = m.Id
GROUP BY
	c.CountryName
ORDER BY
	c.CountryName ASC,
	(
		SELECT
			PeakName
		FROM
			Peaks
		WHERE
			Elevation = MAX(p.Elevation)
	) ASC