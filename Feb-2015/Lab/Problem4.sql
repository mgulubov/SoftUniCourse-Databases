USE Forum
GO

SELECT
	q.Title AS 'Question Title',
	u.Username AS Author
FROM
	Questions q
		LEFT JOIN
			Users u ON
				u.Id = q.UserId
ORDER BY
	q.Id ASC