USE Diablo
GO

SELECT
	g.Name AS Game,
	gt.Name AS 'Game Type',
	u.Username,
	ug.Level,
	ug.Cash,
	c.Name AS Character
FROM
	UsersGames ug
		LEFT JOIN
			Games g ON
				g.Id = ug.GameId
		LEFT JOIN
			GameTypes gt ON
				gt.Id = g.GameTypeId
		LEFT JOIN
			Users u ON
				u.Id = ug.UserId
		LEFT JOIN
			Characters c ON
				c.Id = ug.CharacterId
ORDER BY
	ug.Level DESC,
	u.Username ASC,
	g.Name ASC