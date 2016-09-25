USE SoftUni
GO

SELECT
	*
FROM
	Towns t
WHERE
	SUBSTRING(t.Name, 1, 1) IN ('M', 'K', 'B', 'E')
ORDER BY
	t.Name ASC