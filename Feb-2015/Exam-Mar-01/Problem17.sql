USE Geography
GO

-- Drop functions
DROP FUNCTION IF EXISTS
	FN_MountainsPeaksJSON

DROP FUNCTION IF EXISTS
	FN_PeaksForMountainJSON
GO
---------------------
---------------------
-- Create function
CREATE FUNCTION
	FN_PeaksForMountainJSON(
		@MountainRange NVARCHAR(MAX)
	)
RETURNS NVARCHAR(MAX)
AS
BEGIN

DECLARE peaks_cursor CURSOR
FOR
	SELECT
		p.PeakName,
		p.Elevation
	FROM
		Peaks p
			INNER JOIN
				Mountains m ON
					m.Id = p.MountainId
					AND
					m.MountainRange = @MountainRange
	ORDER BY
		p.PeakName ASC

DECLARE @PeakName NVARCHAR(MAX)
DECLARE @PeakElevation INT
DECLARE @PeaksJSON NVARCHAR(MAX)

SET @PeaksJSON = '['

OPEN peaks_cursor

FETCH NEXT FROM
	peaks_cursor
INTO
	@PeakName,
	@PeakElevation



WHILE @@FETCH_STATUS = 0
BEGIN
	SET @PeaksJSON = @PeaksJSON +
						'{"name":"' + @PeakName + '",' +
						'"elevation":' + CAST(@PeakElevation AS NVARCHAR(MAX)) + '},'

	FETCH NEXT FROM
		peaks_cursor
	INTO
		@PeakName,
		@PeakElevation
END

CLOSE peaks_cursor
DEALLOCATE peaks_cursor

SET @PeaksJSON = (
	CASE
		WHEN LEN(@PeaksJSON) > 1
		THEN SUBSTRING(@PeaksJSON, 0, LEN(@PeaksJSON)) + ']'
		ELSE '[]'
	END
)

RETURN @PeaksJSON

END
GO

CREATE FUNCTION
	FN_MountainsPeaksJSON()
RETURNS NVARCHAR(MAX)
AS
BEGIN

DECLARE mountains_cursor CURSOR
FOR
	SELECT
		m.MountainRange
	FROM
		Mountains m
	ORDER BY
		m.MountainRange ASC

DECLARE @MountainRange NVARCHAR(MAX)
DECLARE @MountainsPeaksJSON NVARCHAR(MAX) = '{"mountains":['

OPEN mountains_cursor

FETCH NEXT FROM 
	mountains_cursor
INTO
	@MountainRange

WHILE @@FETCH_STATUS = 0
BEGIN

SET @MountainsPeaksJSON = @MountainsPeaksJSON + 
							'{"name":"' + @MountainRange + '",' + 
							'"peaks":' + dbo.FN_PeaksForMountainJSON(@MountainRange) + '},'

FETCH NEXT FROM
	mountains_cursor
INTO
	@MountainRange

END

CLOSE mountains_cursor
DEALLOCATE mountains_cursor

SET @MountainsPeaksJSON = (
	SUBSTRING(@MountainsPeaksJSON, 0, LEN(@MountainsPeaksJSON)) + ']}'
)

RETURN @MountainsPeaksJSON

END
GO

SELECT dbo.FN_MountainsPeaksJSON()