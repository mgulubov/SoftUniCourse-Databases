USE Diablo
GO

SELECT
	u.Username,
	u.IpAddress AS 'IP Address'
FROM
	Users u
WHERE
	u.IpAddress LIKE '___.1_%._%.___'
ORDER BY
	u.Username ASC