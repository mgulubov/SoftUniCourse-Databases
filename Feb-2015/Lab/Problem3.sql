USE Forum
GO

SELECT
	u.Username,
	u.LastName,
	(
		CASE
			WHEN u.PhoneNumber IS NULL
			THEN '0'
			ELSE '1'
		END
	) AS 'Has Phone'
FROM
	Users u
ORDER BY
	u.LastName ASC,
	u.Id ASC