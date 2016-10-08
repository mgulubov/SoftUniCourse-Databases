USE Bank
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
------------
------------