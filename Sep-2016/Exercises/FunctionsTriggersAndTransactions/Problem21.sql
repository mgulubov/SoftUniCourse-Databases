USE Diablo
GO

WITH
	UsersWithEmailProviders
AS
(
	SELECT
		u.Id AS UserId,
		RIGHT(u.Email, LEN(u.Email) - CHARINDEX('@', u.Email)) AS EmailProvider
	FROM
		Users u
)

SELECT
	uep.EmailProvider AS 'Email Provider',
	COUNT(uep.UserId) AS 'Number Of Users'
FROM
	UsersWithEmailProviders uep
GROUP BY
	uep.EmailProvider
ORDER BY
	'Number Of Users' DESC,
	uep.EmailProvider ASC