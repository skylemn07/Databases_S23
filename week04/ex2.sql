CREATE TABLE University
(
location character(50) NOT NULL,
name character(50) NOT NULL PRIMARY KEY
);

CREATE TABLE Courses
(
credits integer NOT NULL,
name character(50) NOT NULL PRIMARY KEY,
name_university character(50) NOT NULL,
FOREIGN KEY (name_university) REFERENCES University(name)
);

CREATE TABLE Student
(
native_language character(50) NOT NULL,
name character(50) NOT NULL,
id integer NOT NULL PRIMARY KEY,
name_university character(50) NOT NULL,
FOREIGN KEY (name_university) REFERENCES University(name)
);

CREATE TABLE enroll
(
  name_course character(50), 
  FOREIGN KEY (name_course) REFERENCES Courses(name),
  student_id integer,
  FOREIGN KEY (student_id) REFERENCES Student(id)
);

INSERT INTO University VALUES ('Russia', 'Innopolis');
INSERT INTO University VALUES ('USA', 'MIT');
INSERT INTO University VALUES ('Russia', 'ITMO');

INSERT INTO Courses VALUES ('4', 'Intro to AI', 'ITMO');
INSERT INTO Courses VALUES ('6', 'Databases', 'Innopolis');
INSERT INTO Courses VALUES ('5', 'Linear Algebra', 'MIT');

INSERT INTO Student VALUES ('Russian', 'Ann', '1', 'Innopolis');
INSERT INTO Student VALUES ('English', 'Mary', '2', 'Innopolis');
INSERT INTO Student VALUES ('Russian', 'Vlad', '3', 'MIT');

select * from University where location = 'Russia';
select University.location from Student join University on Student.name_university = University.name where native_language = 'Russian' and location != 'Russia';
select Student.id from Student join University on Student.name_university = University.name where name_university = 'Innopolis';
select Courses.name_university, Courses.name from Courses join University on Courses.name_university = University.name where credits > 5;
select University.name from Student join University on Student.name_university = University.name where native_language = 'English' or location = 'USA';
