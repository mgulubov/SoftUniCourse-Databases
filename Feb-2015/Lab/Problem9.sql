USE Forum
GO

SELECT TOP 10	
	a.[Content],
	a.CreatedOn,
	u.Username
FROM
	Answers a
		RIGHT JOIN
			Users u ON
				u.Id = a.UserId
ORDER BY
	a.CreatedOn ASC