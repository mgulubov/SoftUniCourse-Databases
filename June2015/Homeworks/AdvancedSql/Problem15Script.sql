USE SoftUni
GO

-- DROP table if it already exists
IF OBJECT_ID('Users') IS NOT NULL
	DROP TABLE Users

-- Creating table Users
CREATE TABLE Users(
	Id int IDENTITY NOT NULL,
	Username nvarchar(30) NOT NULL,
	Password nvarchar(128) NOT NULL,
	FullName nvarchar(100) NOT NULL,
	LastLoginDate datetime DEFAULT GETDATE()

	CONSTRAINT PK_Users
		PRIMARY KEY CLUSTERED(Id),
	CONSTRAINT UN_Users
		UNIQUE(Username),
	CONSTRAINT CH_Users
		CHECK (DATALENGTH(PASSWORD) >= 5)
)
GO

-- Create update datetime trigger
CREATE TRIGGER
	trgUpdateLoginDateOnUpdate
ON
	Users
AFTER 
	UPDATE
AS
	UPDATE 
		Users
	SET
		LastLoginDate = GETDATE()
	FROM Inserted i
GO

-- Add default values
INSERT INTO 
	Users(Username, Password, FullName)
VALUES
	('admin', 'myadmin', 'Admin Admin'),
	('mgalabov', 'miroizoriimaya', 'Miroslav Galabov'),
	('zgoranova', 'zornica', 'Zornica Goranova')
GO
