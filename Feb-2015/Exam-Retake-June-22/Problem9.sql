USE Football
GO

-- Drop functions if exist
DROP FUNCTION IF EXISTS
	FN_GetTotalTeamGoals
GO

-- Declare functions
CREATE FUNCTION 
	FN_GetTotalTeamGoals(
		@TeamId INT
	)
RETURNS INT
AS
BEGIN

DECLARE @HomeTeamGoals INT = (
	SELECT
		(
			CASE
				WHEN SUM(tm.HomeGoals) IS NULL
				THEN 0
				ELSE SUM(tm.HomeGoals)
			END
		)
	FROM
		TeamMatches tm
	WHERE
		tm.HomeTeamId = @TeamId
)

DECLARE @AwayTeamGoals INT = (
	SELECT
		(
			CASE
				WHEN SUM(tm.AwayGoals) IS NULL
				THEN 0
				ELSE SUM(tm.AwayGoals)
			END
		)
	FROM
		TeamMatches tm
	WHERE
		tm.AwayTeamId = @TeamId
)

RETURN @HomeTeamGoals + @AwayTeamGoals

END
GO

-- Select query
SELECT
	t.TeamName,
	dbo.FN_GetTotalTeamGoals(t.Id) AS 'Total Goals'
FROM
	Teams t
GROUP BY
	t.TeamName, t.Id
ORDER BY
	'Total Goals' DESC,
	t.TeamName ASC
