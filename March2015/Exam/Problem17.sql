use Geography
GO

-- Drop function if exists
IF OBJECT_ID(N'fn_MountainsPeaksJSON') IS NOT NULL
	DROP FUNCTION fn_MountainsPeaksJSON
GO

--Create function
CREATE FUNCTION 
	fn_MountainsPeaksJSON()
RETURNS 
	nvarchar(MAX)
AS
BEGIN
	DECLARE @JSONResult nvarchar(MAX)

	SET @JSONResult = (
		SELECT
			m.MountainRange as name,
			peaks.PeakName as name,
			peaks.Elevation as elevation
		FROM
			Mountains m
				INNER JOIN
					Peaks peaks
				ON
					m.Id = peaks.MountainId
		ORDER BY
			m.MountainRange,
			peaks.PeakName
		FOR
			JSON AUTO, ROOT('mountains')
	)

	RETURN @JSONResult
END
GO

-- Call function
SELECT dbo.fn_MountainsPeaksJSON()