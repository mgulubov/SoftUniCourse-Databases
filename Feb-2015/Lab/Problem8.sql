USE Forum
GO

SELECT
	MIN(minA.CreatedOn) AS MinDate,
	MAX(maxA.CreatedOn) AS MaxDate
FROM
	Answers minA,
	Answers maxA
WHERE
	YEAR(minA.CreatedOn) = 2012
	AND
	YEAR(maxA.CreatedOn) = 2014