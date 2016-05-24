-- Create database if it doesn't exist
IF NOT EXISTS (SELECT * FROM master.dbo.sysdatabases WHERE name = 'Forum')
	CREATE DATABASE Forum
GO

USE Forum
GO

-- Drop the tables if the exist, so that we may recreate them
IF OBJECT_ID('Votes') IS NOT NULL
	DROP TABLE Votes
IF OBJECT_ID('Answers') IS NOT NULL
	DROP TABLE Answers
IF OBJECT_ID('QuestionsTags') IS NOT NULL
	DROP TABLE QuestionsTags
IF OBJECT_ID('Questions') IS NOT NULL
	DROP TABLE Questions
IF OBJECT_ID('Tags') IS NOT NULL
	DROP TABLE Tags
IF OBJECT_ID('Categories') IS NOT NULL
	DROP TABLE Categories
IF OBJECT_ID('Users') IS NOT NULL
	DROP TABLE Users

-- Create the tables with the appropriate PRIMARY KEY CONSTRAINTS (PK_)
CREATE TABLE Users(
	Id int IDENTITY NOT NULL,
	Username nvarchar(20) NOT NULL,
	FirstName nvarchar(50) NOT NULL,
	LastName nvarchar(50) NOT NULL,
	PhoneNumber nvarchar(50) NOT NULL,

	CONSTRAINT PK_Users 
		PRIMARY KEY CLUSTERED (Id)
)
GO

CREATE TABLE Categories(
	Id int IDENTITY NOT NULL,
	Title nvarchar(100) NOT NULL,

	CONSTRAINT PK_Categories 
		PRIMARY KEY CLUSTERED (Id)
)
GO

CREATE TABLE Tags(
	Id int IDENTITY NOT NULL,
	Name nvarchar(50) NOT NULL,

	CONSTRAINT PK_Tags
		PRIMARY KEY CLUSTERED (Id)
)
GO

CREATE TABLE Questions(
	Id int IDENTITY NOT NULL,
	Title nvarchar(100) NOT NULL,
	Description nvarchar(MAX) NOT NULL,
	CategoryId int NOT NULL,
	UserId int NOT NULL,
	
	CONSTRAINT PK_Questions
		PRIMARY KEY CLUSTERED (Id) 
)
GO

CREATE TABLE QuestionsTags(
	TagId int NOT NULL,
	QuestionId int NOT NULL,

	CONSTRAINT PK_QuestionsTags
		PRIMARY KEY CLUSTERED (TagId, QuestionId)
)
GO

CREATE TABLE Answers(
	Id int IDENTITY NOT NULL,
	[Content] nvarchar(MAX) NOT NULL,
	QuestionId int NOT NULL,
	UserId int NOT NULL,

	CONSTRAINT PK_Answers
		PRIMARY KEY CLUSTERED (Id)
)
GO

CREATE TABLE Votes(
	Id int IDENTITY NOT NULL,
	UserId int NOT NULL,
	Value int NOT NULL DEFAULT 0,
	AnswerId int NOT NULL,

	CONSTRAINT PK_Votes
		PRIMARY KEY CLUSTERED (Id)
)
GO

-- Add intregrity constraints
ALTER TABLE QuestionsTags
	WITH CHECK
	ADD CONSTRAINT FK_QuestionsTags_Tags
		FOREIGN KEY (TagId)
		REFERENCES Tags (Id)
GO

ALTER TABLE QuestionsTags
	WITH CHECK
	ADD CONSTRAINT FK_QuestionsTags_Questions
		FOREIGN KEY (QuestionId)
		REFERENCES Questions (Id)
GO

ALTER TABLE Questions
	WITH CHECK 
	ADD CONSTRAINT FK_Questions_Users
		FOREIGN KEY (UserId)
		REFERENCES Users (Id)
GO

ALTER TABLE Questions
	WITH CHECK 
	ADD CONSTRAINT FK_Questions_Categories
		FOREIGN KEY (CategoryId)
		REFERENCES Categories (Id)
GO

ALTER TABLE Answers
	WITH CHECK
	ADD CONSTRAINT FK_Answers_Questions
		FOREIGN KEY (QuestionId)
		REFERENCES Questions (Id)
GO

ALTER TABLE Answers
	WITH CHECK
	ADD CONSTRAINT FK_Answers_Users
		FOREIGN KEY (UserId)
		REFERENCES Users (Id)
GO

ALTER TABLE Votes
	WITH CHECK
	ADD CONSTRAINT FK_Votes_Answers
		FOREIGN KEY (AnswerId)
		REFERENCES Answers (Id)
GO

ALTER TABLE Votes
	WITH CHECK
	ADD CONSTRAINT FK_Votes_Users
		FOREIGN KEY (UserId)
		REFERENCES Users (Id)
GO

-- Insert sample values
INSERT INTO Users(Username, FirstName, LastName, PhoneNumber) 
VALUES
	('mgulubov', 'Miroslav', 'Galabov', '0896671901'),
	('zorni4kata', 'Zornica', 'Goranova', '00000000'),
	('mpetkova', 'Maya', 'Petkova', '00000000'),
	('lari', 'Lari', 'Dog', '000000000'),
	('admin', 'Admin', 'Admin', 'xxxxxxxxx')
GO

INSERT INTO Tags(Name)
VALUES
	('c#'),
	('java'),
	('homework'),
	('problem'),
	('loop'),
	('for loop'),
	('while loop'),
	('exam'),
	('class'),
	('abstraction'),
	('interface')
GO

INSERT INTO Categories(Title)
VALUES
	('C# Basics'),
	('Advanced C#'),
	('OOP'),
	('HQC'),
	('Java'),
	('Databases'),
	('C# Web')
GO

INSERT INTO Questions(Title, Description, CategoryId, UserId)
VALUES
	('How to declare a variable?', 'Hello\n, can someone explain how to declare a variable in C#?\n', 1, 1),
	('What is a boolean variable?', 'Hello,\n can someone please explain what a boolean variable is?\n', 1, 1),
	('Need help with abstraction', 'What is abstraction and how can I use it?', 2, 3),
	('Clean Code by Robert Martin', 'Hello\n I want to know if your program follows the book mentioned in the title?', 3, 4),
	('POST request', 'Does C# have an annotation for POST requests?', 4, 5)
GO

INSERT INTO QuestionsTags(TagId, QuestionId)
VALUES
	(1, 1), (3, 1), (4, 1),
	(1, 2), (3, 2), (4, 2),
	(1, 3), (3, 3), (4, 3), (10, 3),
	(1, 4),
	(1, 5), (11, 5)
GO

INSERT INTO Answers([Content], QuestionId, UserId)
VALUES
	('You declare variables by specifying the type, the name and the value.', 1, 2),
	('A boolean variable is either TRUE, or FALSE', 2, 3),
	('Absstraction is like something, but not quite.', 3, 1),
	('Example please.', 1, 1),
	('That was very helpful(NOT).', 3, 3)
GO

INSERT INTO Votes(UserId, Value, AnswerId)
VALUES
	(1, 1, 1),
	(2, 3, 2)
GO