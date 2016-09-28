USE Gringotts
GO

DECLARE @AverageSizes TABLE(
	DepositGroup NVARCHAR(250),
	AverageSize INT
)

INSERT INTO
	@AverageSizes
SELECT
	wd.DepositGroup,
	AVG(wd.MagicWandSize)
FROM
	WizzardDeposits wd
GROUP BY
	wd.DepositGroup

SELECT
	DepositGroup
FROM
	@AverageSizes
WHERE
	AverageSize = (
		SELECT
			MIN(AverageSize)
		FROM
			@AverageSizes
	)


	

