USE SoftUni
GO

SELECT
	CONCAT(e.FirstName, '.', e.Lastname, '@softuni.bg') AS 'Full Email Address'
FROM
	Employees e