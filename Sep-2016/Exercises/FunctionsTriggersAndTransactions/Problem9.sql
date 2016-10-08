USE Bank
GO
-----------
-----------
-- Drop procedure if exists
DROP PROCEDURE IF EXISTS
	usp_GetHoldersFullName
GO
-----------
-----------
-- Create procedure
CREATE PROCEDURE
	usp_GetHoldersFullName
AS
BEGIN
	SELECT
		ah.FirstName + ' ' + ah.LastName AS 'Full Name'
	FROM
		AccountHolders ah
END
GO
-----------
-----------
-- Execute procedure
EXECUTE usp_GetHoldersFullName
-----------
-----------
-- Drop procedure if exists
DROP PROCEDURE IF EXISTS
	usp_GetHoldersFullName
GO
-----------
-----------