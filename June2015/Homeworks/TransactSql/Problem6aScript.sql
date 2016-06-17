USE Bank
GO

-- Drop table if exists
IF OBJECT_ID('Logs') IS NOT NULL
	DROP TABLE Logs
GO

-- Create table
CREATE TABLE Logs(
	LogId int IDENTITY NOT NULL,
	AccountId int NOT NULL,
	OldSum money NOT NULL,
	NewSum money NOT NULL

	CONSTRAINT PK_Logs
		PRIMARY KEY (LogId)
)
GO