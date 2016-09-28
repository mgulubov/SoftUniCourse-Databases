USE Gringotts
GO

SELECT
	'[0-10]' AS AgeGroup,
	COUNT(wd.Id) AS WizardCount
FROM
	WizzardDeposits wd
WHERE
	wd.Age
		BETWEEN 0
		AND 10
UNION ALL
SELECT
	'[11-20]' AS AgeGroup,
	COUNT(wd.Id) AS WizardCount
FROM
	WizzardDeposits wd
WHERE
	wd.Age
		BETWEEN 11
		AND 20
UNION ALL
SELECT
	'[21-30]' AS AgeGroup,
	COUNT(wd.Id) AS WizardCount
FROM
	WizzardDeposits wd
WHERE
	wd.Age
		BETWEEN 21
		AND 30
UNION ALL
SELECT
	'[31-40]' AS AgeGroup,
	COUNT(wd.Id) AS WizardCount
FROM
	WizzardDeposits wd
WHERE
	wd.Age
		BETWEEN 31
		AND 40
UNION ALL
SELECT
	'[41-50]' AS AgeGroup,
	COUNT(wd.Id) AS WizardCount
FROM
	WizzardDeposits wd
WHERE
	wd.Age
		BETWEEN 41
		AND 50
UNION ALL
SELECT
	'[51-60]' AS AgeGroup,
	COUNT(wd.Id) AS WizardCount
FROM
	WizzardDeposits wd
WHERE
	wd.Age
		BETWEEN 51
		AND 60
UNION ALL
SELECT
	'[61+]' AS AgeGroup,
	COUNT(wd.Id) AS WizardCount
FROM
	WizzardDeposits wd
WHERE
	wd.Age > 60