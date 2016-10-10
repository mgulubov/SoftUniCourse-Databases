USE Diablo
GO
--------------
--------------
SELECT
	u.Username,
	g.Name AS Game,
	COUNT(ugi.ItemId) AS 'Items Count',
	SUM(i.Price) AS 'Items Price'
FROM
	UsersGames ug
		INNER JOIN
			Users u ON
				u.Id = ug.UserId
		INNER JOIN
			Games g ON
				g.Id = ug.GameId
		INNER JOIN
			UserGameItems ugi ON
				ugi.UserGameId = ug.Id
		INNER JOIN
			Items i ON
				i.Id = ugi.ItemId
GROUP BY
	u.Username,
	g.Name
HAVING
	COUNT(ugi.ItemId) >= 10
ORDER BY
	'Items Count' DESC,
	'Items Price' DESC,
	u.Username ASC