USE Football
GO
--------------------------------
--------------------------------
-- Drop constraints if exist
ALTER TABLE
	Leagues
DROP CONSTRAINT IF EXISTS
	CH_IsSeasonal_Check_Value
GO

ALTER TABLE
	Leagues
DROP CONSTRAINT IF EXISTS
	DF_IsSeasonal_Value
GO

-- Drop columns if exist
ALTER TABLE
	Leagues
DROP COLUMN IF EXISTS
	IsSeasonal
GO

-- Drop functions if exist
DROP FUNCTION IF EXISTS
	FN_GetTeamIdByName
GO

DROP FUNCTION IF EXISTS
	FN_GetLeagueIdByName
GO

DROP FUNCTION IF EXISTS
	FN_GetLeaguesIdsWithTeamMatches
GO

DROP FUNCTION IF EXISTS
	FN_GetLeaguesIdsWithTeamMatches
GO
--------------------------------
--------------------------------
-- 1.	Write a SQL command to add a new Boolean column IsSeasonal in the Leagues 
-- table (defaults to false). 
-- Note that there is no "Boolean" type in SQL server, so you should use an alternative.
-- Drop constraints if exist
ALTER TABLE
	Leagues
ADD
	IsSeasonal CHAR(1)
GO

ALTER TABLE
	Leagues
ADD CONSTRAINT
	CH_IsSeasonal_Check_Value
CHECK
	(IsSeasonal IN ('0', '1'))
GO

UPDATE
	Leagues
SET
	IsSeasonal = 0
GO

ALTER TABLE
	Leagues
ALTER COLUMN
	IsSeasonal CHAR(1) NOT NULL
GO

ALTER TABLE
	Leagues
ADD CONSTRAINT
	DF_IsSeasonal_Value
DEFAULT
	'0'
FOR
	IsSeasonal
GO
--------------------------------
--------------------------------
--2. Add a new team match holding the following information: 
-- HomeTeam="Empoli", AwayTeam="Parma", HomeGoals=2, AwayGoals=2, Date= '19-Apr-2015 16:00', 
-- League= 'Italian Serie A'.
--3. Add a new team match holding the following information: 
-- HomeTeam="Internazionale", AwayTeam="AC Milan", HomeGoals=0, AwayGoals=0, Date= '19-Apr-2015 21:45, 
-- League= 'Italian Serie A'.
--------------------------------
-- Create functions
CREATE FUNCTION
	FN_GetTeamIdByName(
		@TeamName NVARCHAR(250)
	)
RETURNS INT
AS
BEGIN
DECLARE @TeamId INT = (
	SELECT
		Id
	FROM
		Teams
	WHERE
		TeamName = @TeamName
)
RETURN @TeamId
END
GO

CREATE FUNCTION
	FN_GetLeagueIdByName(
		@LeagueName NVARCHAR(250)
	)
RETURNS INT
AS
BEGIN
DECLARE @LeagueId INT = (
	SELECT
		Id
	FROM
		Leagues
	WHERE
		LeagueName = @LeagueName
)
RETURN @LeagueId
END
GO
--------------------------------
-- Insert values
INSERT INTO
	TeamMatches(
		HomeTeamId,
		HomeGoals,
		AwayTeamId,
		AwayGoals,
		MatchDate,
		LeagueId
	)
VALUES
	(
		dbo.FN_GetTeamIdByName('Empoli'),
		2,
		dbo.FN_GetTeamIdByName('Parma'),
		2,
		'19-Apr-2015 16:00',
		dbo.FN_GetLeagueIdByName('Italian Serie A')
	),
	(
		dbo.FN_GetTeamIdByName('Internazionale'),
		0,
		dbo.FN_GetTeamIdByName('AC Milan'),
		0,
		'19-Apr-2015 21:45',
		dbo.FN_GetLeagueIdByName('Italian Serie A')
	)
GO
--------------------------------
--------------------------------
-- 4. Write and execute a SQL command to mark as seasonal all leagues that have at least one team match.
-- Create function
CREATE FUNCTION
	FN_GetLeaguesIdsWithTeamMatches()
RETURNS @LeagueIds TABLE(
	LeagueId INT
)
AS
BEGIN

INSERT INTO
	@LeagueIds
SELECT
	l.Id
FROM
	Leagues l
		LEFT JOIN
			TeamMatches tm ON
				tm.LeagueId = l.Id
GROUP BY
	l.Id
HAVING
	COUNT(tm.Id) > 0

RETURN
END
GO
--------------------------------
-- Update Leagues table
UPDATE
	Leagues
SET
	IsSeasonal = '1'
WHERE
	Id IN (
		SELECT
			LeagueId
		FROM
			dbo.FN_GetLeaguesIdsWithTeamMatches()
	)
GO
--------------------------------
--------------------------------
-- 5. Find all seasonal matches strictly after 10th April 2015. 
-- Display the home team name and score, the away team name and score and the league. 
-- Sort the results by league name (alphabetically), then by home team score count and 
-- away team score count (from largest to lowest). 
-- Name the columns exactly like in the table below. 
-- Submit for evaluation the result grid with headers.
SELECT
	tHome.TeamName AS 'Home Team',
	tm.HomeGoals AS 'Home Goals',
	tAway.TeamName AS 'Away Team',
	tm.AwayGoals AS 'Away Goals',
	l.LeagueName AS 'League Name'
FROM
	TeamMatches tm
		LEFT JOIN
			Teams tHome ON
				tHome.Id = tm.HomeTeamId
		LEFT JOIN
			Teams tAway ON
				tAway.Id = tm.AwayTeamId
		INNER JOIN
			Leagues l ON
				l.Id = tm.LeagueId
				AND
				l.IsSeasonal = '1'
WHERE
	tm.MatchDate >= 'April 10 2015'
ORDER BY
	'League Name' ASC,
	'Home Goals' DESC,
	'Away Goals' DESC
--------------------------------
--------------------------------