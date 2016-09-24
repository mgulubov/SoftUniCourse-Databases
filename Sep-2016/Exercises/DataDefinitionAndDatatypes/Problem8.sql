USE Minions
GO

-- Drop table if exists
DROP TABLE IF EXISTS
	Users
GO

-- Create table
CREATE TABLE
	Users(
		Id INT NOT NULL IDENTITY
			CONSTRAINT PK_Users_Id PRIMARY KEY (Id),
		Username CHAR(30) NOT NULL,
		Password CHAR(30) NOT NULL,
		ProfilePicture VARBINARY(900),
		LastLoginTime DATETIME,
		IsDeleted CHAR(5) NOT NULL
			CONSTRAINT DF_IsDeleted_Default DEFAULT 'false'
			CONSTRAINT CH_IsDeleted_Value CHECK (IsDeleted IN ('true', 'false'))
	)
GO

-- Insert Values
INSERT INTO
	Users(Username, Password)
VALUES
	('mgalabov', 'admin'),
	('mgulubov', 'god'),
	('mg4l4bov', 'sex'),
	('mga1abov', 'power'),
	('mgalab0v', 'h4ck3rs')
GO

