-- Create db if it doesn't exist
IF NOT EXISTS (SELECT * FROM master.dbo.sysdatabases WHERE name = 'University')
	CREATE DATABASE University
	GO

-- Switch to University db
USE University
GO

-- Drop tables if they exist, so that we may recreate them
IF OBJECT_ID('CoursesStudents') IS NOT NULL
	DROP TABLE CoursesStudents
IF OBJECT_ID('Students') IS NOT NULL
	DROP TABLE Students
IF OBJECT_ID('ProfessorsCourses') IS NOT NULL
	DROP TABLE ProfessorsCourses
IF OBJECT_ID('Courses') IS NOT NULL
	DROP TABLE Courses
IF OBJECT_ID('TitlesProfessors') IS NOT NULL
	DROP TABLE TitlesProfessors
IF OBJECT_ID('ProfessorsCourses') IS NOT NULL
	DROP TABLE ProfessorsCourses
IF OBJECT_ID('Professors') IS NOT NULL
	DROP TABLE Professors
IF OBJECT_ID('Titles') IS NOT NULL
	DROP TABLE Titles
IF OBJECT_ID('Departments') IS NOT NULL
	DROP TABLE Departments
IF OBJECT_ID('Faculties') IS NOT NULL
	DROP TABLE Faculties

-- Creating tables
CREATE TABLE Faculties(
	Id int IDENTITY NOT NULL,
	Name nvarchar(200) NOT NULL,

	CONSTRAINT PK_Faculties
		PRIMARY KEY CLUSTERED (Id)
)
GO

CREATE TABLE Departments(
	Id int IDENTITY NOT NULL,
	Name nvarchar(200) NOT NULL,
	FacultyId int NOT NULL,

	CONSTRAINT PK_Departments
		PRIMARY KEY CLUSTERED (Id)
)
GO

CREATE TABLE Professors(
	Id int IDENTITY NOT NULL,
	FirstName nvarchar(50) NOT NULL,
	LastName nvarchar(50) NOT NULL,

	CONSTRAINT PK_Professors
		PRIMARY KEY CLUSTERED (Id)
)
GO

CREATE TABLE Titles(
	Id int IDENTITY NOT NULL,
	Name varchar(50) NOT NULL,

	CONSTRAINT PK_Titles
		PRIMARY KEY CLUSTERED (Id)
)
GO

CREATE TABLE TitlesProfessors(
	TitleId int NOT NULL,
	ProfessorId int NOT NULL,

	CONSTRAINT PK_TitlesProfessors
		PRIMARY KEY CLUSTERED (TitleId, ProfessorId)
)
GO

CREATE TABLE Courses(
	Id int IDENTITY NOT NULL,
	Name nvarchar(100) NOT NULL,

	CONSTRAINT PK_Coursers
		PRIMARY KEY CLUSTERED (Id)
)
GO

CREATE TABLE ProfessorsCourses(
	ProfessorId int NOT NULL,
	CourseId int NOT NULL,

	CONSTRAINT PK_ProfessorsCourses
		PRIMARY KEY (ProfessorId, CourseId)
)
GO

CREATE TABLE Students(
	Id int IDENTITY NOT NULL,
	FirstName nvarchar(50) NOT NULL,
	LastName nvarchar(50) NOT NULL,
	FacultyId int NOT NULL,

	CONSTRAINT PK_Students
		PRIMARY KEY CLUSTERED (Id)
)
GO

CREATE TABLE CoursesStudents(
	CourseId int NOT NULL,
	StudentId int NOT NULL,

	CONSTRAINT PK_CoursesStudents
		PRIMARY KEY CLUSTERED (CourseId, StudentId)
)
GO

-- Add integrity constraints
ALTER TABLE Departments
	WITH CHECK
	ADD CONSTRAINT FK_Departments_Faculties
		FOREIGN KEY (FacultyId)
		REFERENCES Faculties (Id)
GO

ALTER TABLE TitlesProfessors
	WITH CHECK
	ADD CONSTRAINT FK_TitlesProfessors_Titles
		FOREIGN KEY (TitleId)
		REFERENCES Titles (Id)
GO

ALTER TABLE TitlesProfessors
	WITH CHECK
	ADD CONSTRAINT FK_TitlesProfessors_Professors
		FOREIGN KEY (ProfessorId)
		REFERENCES Professors (Id)
GO

ALTER TABLE ProfessorsCourses
	WITH CHECK
	ADD CONSTRAINT FK_ProfessorsCourses_Professors
		FOREIGN KEY (ProfessorId)
		REFERENCES Professors (Id)
GO

ALTER TABLE ProfessorsCourses
	WITH CHECK
	ADD CONSTRAINT FK_ProfessorsCourses_Courses
		FOREIGN KEY (CourseId)
		REFERENCES Courses (Id)
GO

ALTER TABLE Students
	WITH CHECK
	ADD CONSTRAINT FK_Students_Faculties
		FOREIGN KEY (FacultyId)
		REFERENCES Faculties (Id)
GO

ALTER TABLE CoursesStudents
	WITH CHECK
	ADD CONSTRAINT FK_CoursesStudents_Courses
		FOREIGN KEY (CourseId)
		REFERENCES Courses (Id)
GO

ALTER TABLE CoursesStudents
	WITH CHECK
	ADD CONSTRAINT FK_CoursesStudents_Students
		FOREIGN KEY (StudentId)
		REFERENCES Students (Id)

