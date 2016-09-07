USE Forum
GO

SELECT
	c.Name AS Category,
	u.Username,
	u.PhoneNumber,
	COUNT(a.Id) AS 'Answers Count'
FROM
	Answers a
		LEFT JOIN
			Users u ON
				u.Id = a.UserId
		LEFT JOIN
			Questions q ON
				q.Id = a.QuestionId
		LEFT JOIN
			Categories c ON
				c.Id = q.CategoryId
WHERE
	u.PhoneNumber IS NOT NULL
GROUP BY
	c.Name,
	u.Username,
	u.PhoneNumber
ORDER BY
	COUNT(a.Id) DESC