USE MurachCollege;

--CHAPTER 4 HOMEWORK

--8 tables: departments (8), instructors(16), courses (25)


SELECT CourseDescription, d1.DepartmentName AS CourseDept, 
	d2.DepartmentName AS InstuctorDept,
	LastName + ', ' + FirstName AS InstructorName
	FROM Courses c
	JOIN Departments d1 ON c.DepartmentID = d1.DepartmentID
	JOIN Instructors i ON c.InstructorID = i.InstructorID
	JOIN Departments d2 ON i.DepartmentID = d2.DepartmentID
	WHERE d1.DepartmentID != d2.DepartmentID

--7

SELECT DepartmentName, CourseID
	FROM Departments d
	LEFT JOIN Courses c
	ON c.DepartmentID = d.DepartmentID
	WHERE CourseID IS NULL

--8 

SELECT *
	FROM Departments d1
	JOIN Instructors i on i.DepartmentID = d1.DepartmentID
	JOIN Courses c on c.InstructorID = i.InstructorID
	JOIN Departments d2 on d2.DepartmentID = c.DepartmentID
	WHERE d1.DepartmentID <> d2.DepartmentID

--6

SELECT 'Undergrad', FirstName, LastName, EnrollmentDate, GraduationDate
	FROM Students s1
	WHERE s1.GraduationDate IS NULL
UNION
SELECT 'Grad', FirstName, LastName, EnrollmentDate, GraduationDate
	FROM Students s2
	WHERE s2.GraduationDate IS NOT NULL

--5

SELECT LastName, FirstName, CourseDescription
	FROM Instructors i
	LEFT JOIN Courses c on c.InstructorID = i.InstructorID
	ORDER BY LastName, FirstName