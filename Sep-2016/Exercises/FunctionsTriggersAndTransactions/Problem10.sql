CREATE PROCEDURE
	usp_GetHoldersWithBalanceHigherThan
		@TargetAmount MONEY
AS
BEGIN
	SELECT
		ah.FirstName AS 'First Name',
		ah.Lastname AS 'Last Name'
	FROM
		AccountHolders ah
			INNER JOIN
				Accounts a ON
					a.AccountHolderId = ah.Id
	GROUP BY
		ah.FirstName,
		ah.LastName
	HAVING
		SUM(a.Balance) > @TargetAmount
END