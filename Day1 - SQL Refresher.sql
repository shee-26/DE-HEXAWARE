SELECT name, database_id, create_date
FROM sys.databases;
SELECT name FROM sys.databases WHERE database_id <= 4;
SELECT name, physical_name, type_desc FROM sys.master_files;

USE WeDB;

CREATE TABLE Stu (
  ID INT PRIMARY KEY,
  Name NVARCHAR(50),
  Age INT,
  GPA FLOAT
);

ALTER TABLE Stu ADD Email NVARCHAR(100);

INSERT INTO Stu (ID, Name, Age, GPA)
VALUES (1, 'Ali', 20, 3.5);

--Filtering data
SELECT * FROM Stu;

SELECT * FROM Stu WHERE Age > 18;

SELECT * FROM Stu
WHERE GPA > 3.0 AND Age < 25;

SELECT * FROM Stu
WHERE Name = 'Ali' OR GPA > 3.7;

SELECT * FROM Stu
WHERE Name IN ('Ali', 'Sara', 'John');

SELECT * FROM Stu
WHERE GPA BETWEEN 3.0 AND 4.0;

-- Name starts with A
SELECT * FROM Stu
WHERE Name LIKE 'A%';

-- Name ends with i
SELECT * FROM Stu
WHERE Name LIKE '%i';

-- Name contains "li"
SELECT * FROM Stu
WHERE Name LIKE '%li%';

SELECT DISTINCT GPA FROM Stu;

SELECT Name AS StudentName, GPA AS Grade FROM Stu;

--DML
INSERT INTO Stu (ID, Name, Age, GPA )
VALUES (5, 'Lina', 21, 3.7);

UPDATE Stu SET GPA = 3.9 WHERE Name = 'Lina';

DELETE FROM Stu WHERE Name = 'Lina';

--Functions
SELECT Name, UPPER(Name) AS UpperName, LEN(Name) AS NameLength
FROM Stu;

SELECT GETDATE() AS Today;

SELECT GPA, ROUND(GPA, 1) AS RoundedGPA, FLOOR(GPA), CEILING(GPA)
FROM Stu;

--Aggregate fn
SELECT 
  COUNT(*) AS TotalStudents,
  AVG(GPA) AS AverageGPA,
  MAX(GPA) AS MaxGPA,
  MIN(GPA) AS MinGPA
FROM Stu;

-- Grp by
SELECT Age, COUNT(*) AS StudentsPerAge
FROM Stu
GROUP BY Age;

--Joins
-- Create Courses
CREATE TABLE Courses (
  CourseID INT PRIMARY KEY,
  CourseName NVARCHAR(50)
);

-- Create Enrollments
CREATE TABLE Enrollments (
  StudentID INT,
  CourseID INT
);

INSERT INTO Courses VALUES (1, 'Math'), (2, 'Science'), (3, 'English');
INSERT INTO Enrollments VALUES (1, 1), (2, 2), (3, 1), (4, 3);

--Left
SELECT S.Name, C.CourseName
FROM Stu S
LEFT JOIN Enrollments E ON S.ID = E.StudentID
LEFT JOIN Courses C ON E.CourseID = C.CourseID;

--Right
SELECT S.Name, C.CourseName
FROM Stu S
RIGHT JOIN Enrollments E ON S.ID = E.StudentID
RIGHT JOIN Courses C ON E.CourseID = C.CourseID;

--Full outer
SELECT S.Name, C.CourseName
FROM Stu S
FULL OUTER JOIN Enrollments E ON S.ID = E.StudentID
FULL OUTER JOIN Courses C ON E.CourseID = C.CourseID;

--cross
SELECT S.Name, C.CourseName
FROM Stu S
CROSS JOIN Courses C;

--join,agg,grp
SELECT C.CourseName, COUNT(E.StudentID) AS TotalStudents
FROM Courses C
JOIN Enrollments E ON C.CourseID = E.CourseID
GROUP BY C.CourseName;

--joins,subqueries
-- Self Join
SELECT A.Name AS StudentA, B.Name AS StudentB
FROM Stu A
JOIN Stu B ON A.Age = B.Age AND A.ID <> B.ID;

--GROUP BY, HAVING 
SELECT GPA, COUNT(*) AS Count
FROM Stu
GROUP BY GPA
HAVING COUNT(*) > 1;

--GROUPING SETS
SELECT Name, GPA, COUNT(*) AS Total
FROM Stu
GROUP BY GROUPING SETS ((Name), (GPA), ());

-- Equi Join
SELECT S.Name, C.CourseName
FROM Stu S
JOIN Enrollments E ON S.ID = E.StudentID
JOIN Courses C ON E.CourseID = C.CourseID;

--Self Join
SELECT A.Name AS StudentA, B.Name AS StudentB, A.GPA
FROM Stu A
JOIN Stu B ON A.GPA = B.GPA AND A.ID <> B.ID;

--GROUP BY, HAVING, GROUPING SET
SELECT C.CourseName, COUNT(*) AS StudentCount
FROM Courses C
JOIN Enrollments E ON C.CourseID = E.CourseID
GROUP BY C.CourseName;

SELECT C.CourseName, COUNT(*) AS StudentCount
FROM Courses C
JOIN Enrollments E ON C.CourseID = E.CourseID
GROUP BY C.CourseName
HAVING COUNT(*) > 1;

SELECT CourseName, StudentID
FROM Courses C
JOIN Enrollments E ON C.CourseID = E.CourseID
GROUP BY GROUPING SETS ((CourseName), (StudentID), ());

--SUBQUERIES
SELECT Name FROM Stu S
WHERE EXISTS (
  SELECT 1 FROM Enrollments E WHERE E.StudentID = S.ID
);

SELECT * FROM Stu
WHERE GPA > ANY (
  SELECT GPA FROM Stu WHERE Age < 22
);

SELECT * FROM Stu
WHERE GPA > ALL (
  SELECT GPA FROM Stu WHERE Age < 22
);

--Nested Subqueries
SELECT Name FROM Stu
WHERE ID IN (
  SELECT StudentID FROM Enrollments WHERE CourseID = 1
);

--Correlated Subqueries
SELECT Name, GPA, Age
FROM Stu S
WHERE GPA = (
  SELECT MAX(GPA)
  FROM Stu
  WHERE Age = S.Age
);

--SET OPERATIONS
SELECT Name FROM Stu
UNION
SELECT CourseName FROM Courses;

SELECT ID FROM Stu
INTERSECT
SELECT StudentID FROM Enrollments;

SELECT ID FROM Stu
EXCEPT
SELECT StudentID FROM Enrollments;

MERGE Stu AS Target
USING (SELECT 6 AS ID, 'Nora' AS Name, 21 AS Age, 3.6 AS GPA, 'nora@mail.com' AS Email) AS Source
ON Target.ID = Source.ID
WHEN MATCHED THEN
  UPDATE SET Name = Source.Name, GPA = Source.GPA
WHEN NOT MATCHED THEN
  INSERT (ID, Name, Age, GPA, Email)
  VALUES (Source.ID, Source.Name, Source.Age, Source.GPA, Source.Email);













