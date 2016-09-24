USE master

-- Drop existing connections
ALTER DATABASE 
	Movies 
SET 
	SINGLE_USER 
WITH ROLLBACK 
	IMMEDIATE
GO

-- Delete database if exists
DROP DATABASE IF EXISTS
	Movies
GO

-- Create database
CREATE DATABASE
	Movies
GO

USE Movies
GO

-- Create tables
CREATE TABLE
	Directors(
		Id INT NOT NULL IDENTITY
			CONSTRAINT PK_Directors_Id PRIMARY KEY (Id),
		DirectorName NVARCHAR(250) NOT NULL,
		Notes NVARCHAR(MAX)
	)
GO

CREATE TABLE
	Genres(
		Id INT NOT NULL IDENTITY
			CONSTRAINT PK_Genres_Id PRIMARY KEY (Id),
		GenreName NVARCHAR(250) NOT NULL,
		Notes NVARCHAR(MAX)
	)
GO

CREATE TABLE
	Categories(
		Id INT NOT NULL IDENTITY
			CONSTRAINT PK_Categories_Id PRIMARY KEY (Id),
		CategoryName NVARCHAR(250) NOT NULL,
		Notes NVARCHAR(MAX)
	)
GO

CREATE TABLE
	Movies(
		Id INT NOT NULL IDENTITY
			CONSTRAINT PK_Movies_Id PRIMARY KEY (Id),
		Title NVARCHAR(250) NOT NULL,
		DirectorId INT
			CONSTRAINT FK_Movies_DirectorId_Directors REFERENCES Directors(Id),
		CopyrightYear SMALLINT,
		Length SMALLINT,
		GenreId INT NOT NULL
			CONSTRAINT FK_Movies_GenreId_Genres REFERENCES Genres(Id),
		CategoryId INT NOT NULL
			CONSTRAINT FK_Movies_CategoryId_Genres REFERENCES Categories(Id),
		Rating TINYINT,
		Notes NVARCHAR(MAX)
	)
GO

-- Insert Values
INSERT INTO
	Directors(DirectorName)
VALUES
	('Miroslav'),
	('Galabov'),
	('Miroslav Galabov'),
	('Lucky Strike'),
	('Tobacco')
GO

INSERT INTO
	Genres(GenreName)
VALUES
	('Action'),
	('Adventure'),
	('Comedy'),
	('Crime'),
	('Drama')
GO

INSERT INTO
	Categories(CategoryName)
VALUES
	('War'),
	('Classic'),
	('Fantasy'),
	('Shit'),
	('Sci-Fi')
GO

INSERT INTO
	Movies(Title, DirectorId, GenreId, CategoryId)
VALUES
	('Suicide Squad', 1, 1, 3),
	('Captain America: Civil War', 2, 2, 5),
	('The Secret Life of Pets', 3, 3, 3),
	('Pulp Fiction', 4, 4, 2),
	('Snowden', 5, 5, 4)
GO