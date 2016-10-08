USE master
GO
------------
------------
-- Drop procedure
DROP PROCEDURE IF EXISTS
	usp_DepositMoney
GO
------------
------------
-- Create procedure
-- AccountHolders(Id (PK), FirstName, LastName, SSN)
-- Accounts(Id (PK), AccountHolderId (FK), Balance).
CREATE PROCEDURE
	usp_DepositMoney
		@AccountId INT,
		@moneyAmount MONEY
AS
BEGIN

BEGIN TRANSACTION DepositMoneyTransaction

UPDATE
	Accounts
SET
	Balance = Balance + @moneyAmount
WHERE
	Id = @AccountId

COMMIT TRANSACTION DepositMoneyTransaction

END
GO
------------
------------
-- Drop procedure
DROP PROCEDURE IF EXISTS
	usp_DepositMoney
GO