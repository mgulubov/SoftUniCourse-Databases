USE Forum
GO

SELECT
	c.Name,
	q.Title,
	q.CreatedOn
FROM
	Categories c
		LEFT JOIN
			Questions q ON
				q.CategoryId = c.Id
ORDER BY
	c.Name ASC