USE Geography
GO

DECLARE @CountriesMountainsPeaks TABLE (
	CountryName varchar(45),
	MountainName varchar(50),
	PeakName varchar(50),
	PeakElevation int
)

DECLARE @CountryMountainHighestPeak TABLE (
	Country varchar(45),
	HighestPeakName varchar(50),
	HighestPeakElevation int,
	Mountain varchar(50)
)

DECLARE @CursorCountryName varchar(45)

DECLARE country_name_cursor CURSOR FOR
	SELECT
		c.CountryName
	FROM
		Countries c

INSERT INTO @CountriesMountainsPeaks
	SELECT
		c.CountryName,
		(
			CASE 
				WHEN 
					p.PeakName IS NULL
				THEN
					'(no mountain)'
				ELSE
					m.MountainRange
			END
		),
		(
			CASE 
				WHEN 
					p.PeakName IS NULL
				THEN
					'(no highest peak)'
				ELSE
					p.PeakName
			END
		),
		(
			CASE
				WHEN
					p.Elevation IS NULL
				THEN
					0
				ELSE
					p.Elevation
			END
		)
	FROM
		Countries c
			LEFT JOIN
				MountainsCountries mc
			ON
				c.CountryCode = mc.CountryCode
			LEFT JOIN
				Mountains m
			ON
				m.Id = mc.MountainId
			LEFT JOIN
				Peaks p
			ON
				p.MountainId = m.Id
	GROUP BY
		c.CountryName,
		m.MountainRange,
		p.PeakName,
		p.Elevation


OPEN
	country_name_cursor

FETCH NEXT FROM
	country_name_cursor
INTO
	@CursorCountryName

WHILE
	@@FETCH_STATUS = 0
BEGIN
	INSERT INTO
		@CountryMountainHighestPeak
	SELECT
		cmp.CountryName,
		cmp.PeakName,
		cmp.PeakElevation,
		cmp.MountainName
	FROM
		@CountriesMountainsPeaks cmp
	WHERE
		cmp.CountryName = @CursorCountryName
	AND
		cmp.PeakElevation = (
			SELECT
				MAX(PeakElevation)
			FROM
				@CountriesMountainsPeaks
			WHERE
				CountryName = @CursorCountryName
		)

	FETCH NEXT FROM
		country_name_cursor
	INTO
		@CursorCountryName
END

CLOSE 
	country_name_cursor
DEALLOCATE 
	country_name_cursor

SELECT
	cmhp.Country,
	cmhp.HighestPeakName AS 'Highest Peak Name',
	cmhp.HighestPeakElevation AS 'Highest Peak Elevation',
	cmhp.Mountain
FROM
	@CountryMountainHighestPeak cmhp
ORDER BY
	cmhp.Country,
	cmhp.HighestPeakName