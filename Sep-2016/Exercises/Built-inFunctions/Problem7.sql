USE SoftUni
GO

SELECT
	*
FROM
	Towns t
WHERE
	SUBSTRING(t.Name, 1, 1) NOT IN ('R', 'B', 'D')
ORDER BY
	t.Name ASC