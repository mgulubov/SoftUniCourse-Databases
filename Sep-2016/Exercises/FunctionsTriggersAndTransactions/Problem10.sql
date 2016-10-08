USE Bank
GO
-----------
-----------
-- Drop procedure if exists
DROP PROCEDURE IF EXISTS
	usp_GetHoldersWithBalanceHigherThan
GO
-----------
-----------
-- Create procedure
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
GO
-----------
-----------
-- Execute procedure
EXECUTE usp_GetHoldersWithBalanceHigherThan
			@TargetAmount = 10
GO
-----------
-----------
-- Drop procedure if exists
DROP PROCEDURE IF EXISTS
	usp_GetHoldersWithBalanceHigherThan
GO
-----------
-----------