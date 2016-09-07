USE Forum
GO

SELECT
	a.[Content],
	a.CreatedOn
FROM
	Answers a
WHERE
	a.CreatedOn BETWEEN '06-15-2012'
				AND '03-22-2013'
ORDER BY
	a.CreatedOn ASC,
	a.Id ASC