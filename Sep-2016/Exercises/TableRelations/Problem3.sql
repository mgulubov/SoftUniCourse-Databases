USE TableRelationsTestDatabase
GO
--------------------
--------------------
-- Drop tables if exist
DROP TABLE IF EXISTS
	StudentsExams
--------------------
DROP TABLE IF EXISTS
	Exams
--------------------
DROP TABLE IF EXISTS
	Students
--------------------
--------------------
-- Create tables
CREATE TABLE
    Students(
        StudentID INT NOT NULL
            CONSTRAINT PK_Students_StudentID PRIMARY KEY,
        Name NVARCHAR(300) NOT NULL
    )
--------------------
CREATE TABLE
	Exams(
		ExamID INT NOT NULL
			CONSTRAINT PK_Exams_ExamID PRIMARY KEY,
		Name NVARCHAR(300) NOT NULL	
	)
--------------------
CREATE TABLE
	StudentsExams(
		StudentID INT NOT NULL
			CONSTRAINT FK_StudentsExams_StudentID_Students_StudentID REFERENCES Students(StudentID),
		ExamID INT NOT NULL
			CONSTRAINT FK_StudentsExams_ExamID_Exams_ExamID REFERENCES Exams(ExamID),

		CONSTRAINT PK_StudentsExams_StudentID_ExamID PRIMARY KEY (StudentID, ExamID)
	)
--------------------
--------------------
-- Insert values
INSERT INTO
	Students
VALUES
	(1, 'Mila'),
	(2, 'Toni'),
	(3, 'Roni')
--------------------
INSERT INTO
	Exams
VALUES
	(101, 'Spring MVC'),
	(102, 'Neoj'),
	(103, 'Oracle 11g')
--------------------
INSERT INTO
	StudentsExams
VALUES
	(1, 101),
	(1, 102),
	(2, 101),
	(3, 103),
	(2, 102),
	(2, 103)
--------------------
--------------------
