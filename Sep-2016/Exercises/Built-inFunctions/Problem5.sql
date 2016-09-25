USE SoftUni
GO

SELECT
	t.Name
FROM
	Towns t
WHERE
	LEN(t.Name) IN (5, 6)
ORDER BY
	t.Name ASC