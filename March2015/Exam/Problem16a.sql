USE Geography
GO

UPDATE
	Countries
SET
	CountryName = 'Burma'
WHERE
	CountryName = 'Myanmar'
GO

INSERT INTO
	Monasteries(Name, CountryCode)
VALUES
	('Hanga Abbey', (
		SELECT
			CountryCode
		FROM
			Countries
		WHERE
			CountryName = 'Tanzania'
	))
GO

INSERT INTO
	Monasteries(Name, CountryCode)
VALUES
	('Myin-Tin-Daik', (
		SELECT
			CountryCode
		FROM
			Countries
		WHERE
			CountryName = 'Myanmar'
	))
GO