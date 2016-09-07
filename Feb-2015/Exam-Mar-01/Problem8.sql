USE Geography
GO

SELECT
	MAX(p.Elevation) AS MaxElevation,
	MIN(p.Elevation) AS MinElevation,
	AVG(p.Elevation) AS AverageElevation
FROM
	Peaks p