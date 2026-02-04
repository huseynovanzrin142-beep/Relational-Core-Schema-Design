USE master
GO
IF EXISTS (SELECT name FROM sys.databases WHERE name = 'RelationalDB')
BEGIN
ALTER DATABASE RelationalDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE
DROP DATABASE RelationalDB
END
GO
CREATE DATABASE RelationalDB
GO
USE RelationalDB
GO
CREATE TABLE Curators (
[Id] INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
[Name] NVARCHAR(MAX) NOT NULL DEFAULT 'NO NAME',
[Surname] NVARCHAR(MAX) NOT NULL DEFAULT 'NO SURNAME'
)
GO
CREATE TABLE Teachers ( 
[Id] INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
[Name] NVARCHAR(MAX) NOT NULL DEFAULT 'NO NAME',
[Salary] MONEY NOT NULL,
[Surname] NVARCHAR(MAX) NOT NULL DEFAULT 'NO SURNAME',
CONSTRAINT CK_Salary CHECK ([Salary] > 0)
)
GO
CREATE TABLE Faculties (
[Id] INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
[Financing] MONEY NOT NULL DEFAULT 0,
[Name] NVARCHAR(100) UNIQUE NOT NULL DEFAULT 'NO NAME',
CONSTRAINT CK_Faculties_Financing CHECK ([Financing] >= 0)
)
GO 
CREATE TABLE Subjects (
[Id] INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
[Name] NVARCHAR(100) UNIQUE NOT NULL DEFAULT 'NO NAME'
)
GO 
CREATE TABLE Departments (
[Id] INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
[Financing] MONEY NOT NULL DEFAULT 0,
[Name] NVARCHAR(100) UNIQUE NOT NULL DEFAULT 'NO NAME',
[FacultyId] INT NOT NULL,
CONSTRAINT CK_Departments_Financing CHECK ([Financing] >= 0),
CONSTRAINT department_fk FOREIGN KEY ([FacultyId]) REFERENCES Faculties([Id])
)
GO
CREATE TABLE Groups (
[Id] INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
[Name] NVARCHAR(10) UNIQUE NOT NULL DEFAULT 'NO NAME',
[Year] INT NOT NULL,
[DepartmentId] INT NOT NULL,
CONSTRAINT year_ck CHECK([Year] >= 1 AND [Year] <= 5),
CONSTRAINT departmentId_fk FOREIGN KEY ([DepartmentId]) REFERENCES Departments([Id])
)
GO
CREATE TABLE Lectures (
[Id] INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
[LectureRoom] NVARCHAR(MAX) NOT NULL DEFAULT 'NO NAME',
[SubjectId] INT NOT NULL,
[TeacherId] INT NOT NULL,
CONSTRAINT FK_Lectures_Subjects FOREIGN KEY ([SubjectId]) REFERENCES Subjects([Id]),
CONSTRAINT FK_Lectures_Teachers FOREIGN KEY ([TeacherId]) REFERENCES Teachers([Id])
)
GO 
CREATE TABLE GroupsLectures (
[Id] INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
[GroupId] INT NOT NULL,
[LectureId] INT NOT NULL,
CONSTRAINT goupId_fk FOREIGN KEY ([GroupId]) REFERENCES Groups([Id]),
CONSTRAINT lectureId_fk FOREIGN KEY ([LectureId]) REFERENCES Lectures([Id])
)
GO 
CREATE TABLE GroupsCurators (
[Id] INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
[GroupId] INT NOT NULL,
[CuratorId] INT NOT NULL,
CONSTRAINT FK_Groups_Id FOREIGN KEY ([GroupId]) REFERENCES Groups([Id]),
CONSTRAINT curatorId_fk FOREIGN KEY ([CuratorId]) REFERENCES Curators([Id])
)
GO
INSERT INTO Curators ([Name], [Surname]) 
VALUES ('Ali', 'Huseynov')
INSERT INTO Curators ([Name], [Surname]) 
VALUES ('Aysel', 'Mammadova')
INSERT INTO Curators ([Name], [Surname]) 
VALUES ('Samantha', 'Adams')
GO
INSERT INTO Teachers ([Name], [Salary], [Surname]) 
VALUES ('John', 1500, 'Doe')
INSERT INTO Teachers ([Name], [Salary], [Surname]) 
VALUES ('Mary', 2000, 'Smith')
INSERT INTO Teachers ([Name], [Salary], [Surname]) 
VALUES ('Samantha', 1800, 'Adams')
GO
INSERT INTO Faculties ([Financing], [Name]) 
VALUES (50000, 'Computer Science')
INSERT INTO Faculties ([Financing], [Name]) 
VALUES (30000, 'Mathematics')
INSERT INTO Faculties ([Financing], [Name]) 
VALUES (40000, 'Physics')
GO
INSERT INTO Subjects ([Name]) 
VALUES ('Database Theory')
INSERT INTO Subjects ([Name]) 
VALUES ('Algorithms')
INSERT INTO Subjects ([Name]) 
VALUES ('Calculus')
INSERT INTO Subjects ([Name]) 
VALUES ('Physics')
GO
INSERT INTO Departments ([Financing], [Name], [FacultyId]) 
VALUES (60000, 'Software Engineering', 1)
INSERT INTO Departments ([Financing], [Name], [FacultyId]) 
VALUES (15000, 'Applied Math', 2)
INSERT INTO Departments ([Financing], [Name], [FacultyId]) 
VALUES (18000, 'Theoretical Physics', 3)
GO
INSERT INTO Groups ([Name], [Year], [DepartmentId]) 
VALUES ('P101', 1, 1)
INSERT INTO Groups ([Name], [Year], [DepartmentId]) 
VALUES ('P102', 2, 1)
INSERT INTO Groups ([Name], [Year], [DepartmentId]) 
VALUES ('P107', 4, 1)
INSERT INTO Groups ([Name], [Year], [DepartmentId]) 
VALUES ('M201', 5, 2)
INSERT INTO Groups ([Name], [Year], [DepartmentId]) 
VALUES ('P301', 5, 3)
GO
INSERT INTO Lectures ([LectureRoom], [SubjectId], [TeacherId]) 
VALUES ('B101', 2, 3)
INSERT INTO Lectures ([LectureRoom], [SubjectId], [TeacherId]) 
VALUES ('B102', 2, 1)
INSERT INTO Lectures ([LectureRoom], [SubjectId], [TeacherId]) 
VALUES ('B103', 1, 2)
INSERT INTO Lectures ([LectureRoom], [SubjectId], [TeacherId]) 
VALUES ('C201', 3, 2)
INSERT INTO Lectures ([LectureRoom], [SubjectId], [TeacherId]) 
VALUES ('C202', 4, 1)
GO
INSERT INTO GroupsLectures ([GroupId], [LectureId]) 
VALUES (1, 1)
INSERT INTO GroupsLectures ([GroupId], [LectureId]) 
VALUES (3, 3)
INSERT INTO GroupsLectures ([GroupId], [LectureId]) 
VALUES (4, 4)
INSERT INTO GroupsLectures ([GroupId], [LectureId]) 
VALUES (5, 5)
GO
INSERT INTO GroupsCurators ([GroupId], [CuratorId]) 
VALUES (1, 1)
INSERT INTO GroupsCurators ([GroupId], [CuratorId]) 
VALUES (2, 2)
INSERT INTO GroupsCurators ([GroupId], [CuratorId]) 
VALUES (3, 3)
GO
SELECT T.*, G.* 
FROM Teachers AS T, Groups AS G
GO
SELECT F.[Name] 
FROM Faculties AS F, Departments AS D 
WHERE D.[FacultyId] = F.[Id] 
AND D.[Financing] > F.[Financing]
GO
SELECT C.[Name], G.[Name] 
FROM Curators AS C, GroupsCurators AS GC, Groups AS G 
WHERE C.[Id] = GC.[CuratorId] 
AND G.[Id] = GC.[GroupId]
GO
SELECT T.[Name] 
FROM Teachers AS T, Lectures AS L, GroupsLectures AS GL, Groups AS G 
WHERE T.[Id] = L.[TeacherId] 
AND L.[Id] = GL.[LectureId] 
AND GL.[GroupId] = G.[Id] 
AND G.[Name] = 'P107'
GO
SELECT T.[Surname], F.[Name] 
FROM Teachers AS T, Lectures AS L, GroupsLectures AS GL, Groups AS G, Departments AS D, Faculties AS F 
WHERE T.[Id] = L.[TeacherId] 
AND L.[Id] = GL.[LectureId] 
AND GL.[GroupId] = G.[Id] 
AND G.[DepartmentId] = D.[Id] 
AND D.[FacultyId] = F.[Id]
GO
SELECT D.[Name], G.[Name] 
FROM Departments AS D, Groups AS G 
WHERE D.[Id] = G.[DepartmentId]
GO
SELECT S.[Name] 
FROM Subjects AS S, Lectures AS L, Teachers AS T 
WHERE S.[Id] = L.[SubjectId] 
AND L.[TeacherId] = T.[Id] 
AND T.[Name] = 'Samantha' 
AND T.[Surname] = 'Adams'
GO
SELECT D.[Name] 
FROM Departments AS D, Groups AS G, GroupsLectures AS GL, Lectures AS L, Subjects AS S 
WHERE D.[Id] = G.[DepartmentId] 
AND G.[Id] = GL.[GroupId] 
AND GL.[LectureId] = L.[Id] 
AND L.[SubjectId] = S.[Id] 
AND S.[Name] = 'Database Theory'
GO
SELECT G.[Name] 
FROM Groups AS G, Departments AS D, Faculties AS F 
WHERE G.[DepartmentId] = D.[Id] 
AND D.[FacultyId] = F.[Id] 
AND F.[Name] = 'Computer Science'
GO
SELECT G.[Name], F.[Name] 
FROM Groups AS G, Departments AS D, Faculties AS F 
WHERE G.[Year] = 5 
AND G.[DepartmentId] = D.[Id] 
AND D.[FacultyId] = F.[Id]
GO
SELECT T.[Name], S.[Name], G.[Name] 
FROM Teachers AS T, Lectures AS L, Subjects AS S, GroupsLectures AS GL, Groups AS G 
WHERE T.[Id] = L.[TeacherId] 
AND S.[Id] = L.[SubjectId] 
AND L.[Id] = GL.[LectureId] 
AND GL.[GroupId] = G.[Id] 
AND L.[LectureRoom] = 'B103'
GO
