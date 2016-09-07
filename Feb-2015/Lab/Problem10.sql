USE Forum
GO

DECLARE @LastYear INT = (
	SELECT
		MAX(YEAR(a.CreatedOn))
	FROM
		Answers a
)

DECLARE @FirstMonthOfLastYear INT = (
	SELECT
		MIN(MONTH(a.CreatedOn))
	FROM
		Answers a
	WHERE
		YEAR(a.CreatedOn) = @LastYear
)

DECLARE @LastMonthOfLastYear INT = (
	SELECT
		MAX(MONTH(a.CreatedOn))
	FROM
		Answers a
	WHERE
		YEAR(a.CreatedOn) = @LastYear
)

SELECT
	a.[Content] AS 'Answer Content',
	q.Title AS Question,
	c.Name AS Category
FROM
	Answers a
		LEFT JOIN
			Questions q ON
				q.Id = a.QuestionId
		LEFT JOIN
			Categories c ON
				c.Id = q.CategoryId
WHERE
	YEAR(a.CreatedOn) = @LastYear
	AND
	(
		MONTH(a.CreatedOn) = @FirstMonthOfLastYear
		OR
		MONTH(a.CreatedOn) = @LastMonthOfLastYear
	)
	AND
	a.IsHidden = 1
ORDER BY
	c.Name ASC
