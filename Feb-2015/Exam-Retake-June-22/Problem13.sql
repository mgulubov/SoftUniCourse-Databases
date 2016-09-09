USE Football
GO
--------------------------------
--------------------------------
-- Drop constraint if exists
ALTER TABLE
	FriendlyMatches
DROP CONSTRAINT IF EXISTS
	FK_FriendlyMatchesHomeTeam_Teams,
	FK_FriendlyMatchesAwayTeam_Teams
GO
-- Drop table if exists
DROP TABLE IF EXISTS
	FriendlyMatches
GO
--------------------------------
--------------------------------
-- 1.	Create a table FriendlyMatches(Id, HomeTeamID, AwayTeamId, MatchDate). 
-- Use auto-increment for the primary key. 
-- Create a foreign keys between the tables FriendlyMatches and Teams.
CREATE TABLE
	FriendlyMatches(
		Id INT IDENTITY NOT NULL PRIMARY KEY,
		HomeTeamId INT,
		AwayTeamId INT,
		MatchDate DATETIME
	)
GO

ALTER TABLE
	FriendlyMatches
ADD CONSTRAINT
	FK_FriendlyMatchesHomeTeam_Teams
FOREIGN KEY
	(HomeTeamId)
REFERENCES
	Teams (Id)
GO

ALTER TABLE
	FriendlyMatches
ADD CONSTRAINT
	FK_FriendlyMatchesAwayTeam_Teams
FOREIGN KEY
	(AwayTeamId)
REFERENCES
	Teams (Id)
GO
--------------------------------
--------------------------------
-- 2. Execute the following SQL script (it should pass without any errors):
INSERT INTO Teams(TeamName) VALUES
 ('US All Stars'),
 ('Formula 1 Drivers'),
 ('Actors'),
 ('FIFA Legends'),
 ('UEFA Legends'),
 ('Svetlio & The Legends')
GO

INSERT INTO FriendlyMatches(
  HomeTeamId, AwayTeamId, MatchDate) VALUES
  
((SELECT Id FROM Teams WHERE TeamName='US All Stars'), 
 (SELECT Id FROM Teams WHERE TeamName='Liverpool'),
 '30-Jun-2015 17:00'),
 
((SELECT Id FROM Teams WHERE TeamName='Formula 1 Drivers'), 
 (SELECT Id FROM Teams WHERE TeamName='Porto'),
 '12-May-2015 10:00'),
 
((SELECT Id FROM Teams WHERE TeamName='Actors'), 
 (SELECT Id FROM Teams WHERE TeamName='Manchester United'),
 '30-Jan-2015 17:00'),

((SELECT Id FROM Teams WHERE TeamName='FIFA Legends'), 
 (SELECT Id FROM Teams WHERE TeamName='UEFA Legends'),
 '23-Dec-2015 18:00'),

((SELECT Id FROM Teams WHERE TeamName='Svetlio & The Legends'), 
 (SELECT Id FROM Teams WHERE TeamName='Ludogorets'),
 '22-Jun-2015 21:00')

GO
--------------------------------
--------------------------------
-- 3.	Write a query to display all non-international matches along with the given team names, 
-- starting from the newest date and ending with games with no date. 
-- Submit for evaluation the result grid with headers.
SELECT
	*
FROM
(
	SELECT
		tHome.TeamName AS 'Home Team',
		tAway.TeamName AS 'Away Team',
		tm.MatchDate AS 'Match Date'
	FROM
		TeamMatches tm
			LEFT JOIN
				Teams tHome ON
					tHome.Id = tm.HomeTeamId
			LEFT JOIN
				Teams tAway ON
					tAway.Id = tm.AwayTeamId

	UNION ALL
	SELECT
		tHome.TeamName AS 'Home Team',
		tAway.TeamName AS 'Away Team',
		fm.MatchDate AS 'Match Date'
	FROM
		FriendlyMatches fm
			LEFT JOIN
				Teams tHome ON
					tHome.Id = fm.HomeTeamId
			LEFT JOIN
				Teams tAway ON
					tAway.Id = fm.AwayTeamId
) AS UnionTable
ORDER BY
	'Match Date' DESC
GO
--------------------------------
--------------------------------