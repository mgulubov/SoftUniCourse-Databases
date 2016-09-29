USE TestExcerciseDatabase
GO
----------------------
----------------------
-- Drop tables if exist
DROP TABLE IF EXISTS
	Agenda
----------------------
DROP TABLE IF EXISTS
	Subjects
----------------------
DROP TABLE IF EXISTS
	Payments
----------------------
DROP TABLE IF EXISTS
	Students
----------------------
DROP TABLE IF EXISTS
	Majors
GO
----------------------
----------------------
-- Create tables
CREATE TABLE
	Majors(
		MajorID INT NOT NULL IDENTITY
			CONSTRAINT PK_Majors_MajorID PRIMARY KEY,
		Name VARCHAR(50) NOT NULL
	)
----------------------
CREATE TABLE
	Students(
		StudentID INT NOT NULL IDENTITY
			CONSTRAINT PK_Students_StudentID PRIMARY KEY,
		StudentNumber VARCHAR(12) NOT NULL,
		StudentName VARCHAR(50) NOT NULL,
		MajorID INT
			CONSTRAINT FK_Students_MajorID_Majors_MajorID REFERENCES Majors(MajorID),
		PaymentID INT
	)
----------------------
CREATE TABLE
	Payments(
		PaymentID INT NOT NULL IDENTITY
			CONSTRAINT PK_Payments_PaymentID PRIMARY KEY,
		PaymentDate DATE NOT NULL,
		PaymentAmount DECIMAL(8, 2) NOT NULL,
		StudentID INT NOT NULL
			CONSTRAINT FK_Payments_StudentID_Students_StudentID REFERENCES Students(StudentID)
	)
----------------------
CREATE TABLE
	Subjects(
		SubjectID INT NOT NULL IDENTITY
			CONSTRAINT PK_Subjects_SubjectID PRIMARY KEY,
		SubjectName VARCHAR(50) NOT NULL
	)
----------------------
CREATE TABLE
	Agenda(
		StudentID INT NOT NULL
			CONSTRAINT FK_Agenda_StudentID_Students_StudentID REFERENCES Students(StudentID),
		SubjectID INT NOT NULL
			CONSTRAINT FK_Agenda_SubjectID_Subjects_SubjectID REFERENCES Subjects(SubjectID),

		CONSTRAINT PK_Agenda_StudentID_SubjectID PRIMARY KEY CLUSTERED (StudentID, SubjectID)
	)
----------------------
----------------------