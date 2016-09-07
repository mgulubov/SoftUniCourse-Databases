USE Forum
GO

SELECT
	u.Id,
	u.Username,
	u.FirstName,
	u.PhoneNumber,
	u.RegistrationDate,
	u.Email
FROM
	Users u
		LEFT JOIN
			Questions q ON
				q.UserId = u.Id
WHERE
	u.PhoneNumber IS NULL
GROUP BY
	u.Id,
	u.Username,
	u.FirstName,
	u.PhoneNumber,
	u.RegistrationDate,
	u.Email
HAVING
	COUNT(q.Id) = 0
ORDER BY
	u.RegistrationDate ASC