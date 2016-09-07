USE Forum
GO

SELECT
	c.Name AS Category,
	COUNT(a.Id) AS 'Answers Count'
FROM
	Categories c
		LEFT JOIN
			Questions q ON
				q.CategoryId = c.Id
		LEFT JOIN
			Answers a ON
				a.QuestionId = q.Id
GROUP BY
	c.Name
ORDER BY
	COUNT(a.Id) DESC
