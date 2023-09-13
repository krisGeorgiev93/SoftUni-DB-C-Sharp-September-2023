CREATE DATABASE UniversityDatabase

GO

USE UniversityDatabase

GO


CREATE TABLE Majors(
	MajorID INT PRIMARY KEY IDENTITY(1, 1),
	[Name] VARCHAR(50) NOT NULL
)

CREATE TABLE Subjects(
	SubjectID INT PRIMARY KEY IDENTITY(1, 1),
	SubjectName VARCHAR(50) NOT NULL
)

CREATE TABLE Students(
	StudentID INT PRIMARY KEY IDENTITY(1, 1),
	StudentNumber VARCHAR(30) NOT NULL,
	StudentName VARCHAR(50) NOT NULL,
	MajorID INT FOREIGN KEY REFERENCES Majors(MajorID)
)

CREATE TABLE Payments(
	PaymentID INT PRIMARY KEY IDENTITY(1, 1),
	PaymentDate DATE NOT NULL,
	PaymentAmount DECIMAL(18, 2) NOT NULL,
	StudentID INT FOREIGN KEY REFERENCES Students(StudentID)
)

CREATE TABLE Agenda(
	StudentID INT FOREIGN KEY REFERENCES Students(StudentID),
	SubjectID INT FOREIGN KEY REFERENCES Subjects(SubjectID),
	CONSTRAINT PK_Agenda_StudentSubject PRIMARY KEY(StudentID, SubjectID)
)