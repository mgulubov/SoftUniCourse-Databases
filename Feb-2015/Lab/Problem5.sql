USE Forum
GO

SELECT
	a.[Content] AS 'Answer Content',
	a.CreatedOn,
	u.Username AS 'Answer Author',
	q.Title AS 'Question Title',
	c.Name AS 'Category Name'
FROM
	Answers a
		LEFT JOIN
			Questions q ON
				q.Id = a.QuestionId
		LEFT JOIN
			Users u ON
				u.Id = a.UserId
		LEFT JOIN
			Categories c ON
				c.Id = q.CategoryId
ORDER BY
	c.Name ASC,
	u.Username ASC,
	a.CreatedOn ASC