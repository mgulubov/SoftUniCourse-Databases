USE master
GO
------------
------------
-- Drop procedure
DROP PROCEDURE IF EXISTS
	usp_WithdrawMoney
GO
------------
------------
-- Create procedure
-- AccountHolders(Id (PK), FirstName, LastName, SSN)
-- Accounts(Id (PK), AccountHolderId (FK), Balance).
CREATE PROCEDURE
	usp_WithdrawMoney
		@AccountId INT,
		@moneyAmount MONEY
AS
BEGIN

BEGIN TRANSACTION WithdrawMoneyTransaction

UPDATE
	Accounts
SET
	Balance = Balance - @moneyAmount
WHERE
	Id = @AccountId

COMMIT TRANSACTION WithdrawMoneyTransaction

END
GO
------------
------------
-- Drop procedure
DROP PROCEDURE IF EXISTS
	usp_WithdrawMoney
GO