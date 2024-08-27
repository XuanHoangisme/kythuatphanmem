CREATE DATABASE QuanLyDaoTaoTieuHoc
GO

USE QuanLyDaoTaoTieuHoc
GO

-- Create Schema
CREATE SCHEMA educate;
GO

CREATE SCHEMA activate;
GO


-- Create Table
CREATE TABLE educate.Students (
	student_id INT IDENTITY (1, 1) PRIMARY KEY,
	student_name NVARCHAR (255) NOT NULL,
	birthday DATE NOT NULL,
	sex NVARCHAR (25) NULL,
	address NVARCHAR (255) NOT NULL,
	parents NVARCHAR (MAX) NOT NULL,
	class_id INT,
	FOREIGN KEY (class_id) 
    REFERENCES educate.Classes (class_id) 
    ON DELETE CASCADE ON UPDATE CASCADE
);
GO


CREATE TABLE educate.Staffs (
	staff_id INT IDENTITY (1, 1) PRIMARY KEY,
	staff_name NVARCHAR (50) NOT NULL,
	sex NVARCHAR (25) NOT NULL,
	email VARCHAR (255) NOT NULL UNIQUE,
	phone VARCHAR (25),
	birthday DATE NOT NULL,
	office VARCHAR (50) NOT NULL
);
GO



CREATE TABLE educate.Teachers (
	teacher_id INT IDENTITY (1, 1) PRIMARY KEY,
	teacher_name NVARCHAR (50) NOT NULL,
	sex NVARCHAR (25) NOT NULL,
	email VARCHAR (255) NOT NULL UNIQUE,
	phone VARCHAR (25),
	birthday DATE NOT NULL,
	office NVARCHAR (50) NOT NULL,
	main_subject NVARCHAR (50) NOT NULL
);
GO



CREATE TABLE educate.Grades (
	grade_id INT IDENTITY (1, 1) PRIMARY KEY,
	oral_point INT NOT NULL,
	daily_point INT NOT NULL,
	midterm_score INT NOT NULL,
	end_point INT NOT NULL,
	student_id INT,
	subject_id INT,
	FOREIGN KEY (student_id) 
    REFERENCES educate.Students (student_id) 
    ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (subject_id) 
    REFERENCES educate.Subjects (subject_id) 
    ON DELETE CASCADE ON UPDATE CASCADE
);
GO


CREATE TABLE educate.Subjects (
	subject_id INT IDENTITY (1, 1) PRIMARY KEY,
	subject_name NVARCHAR (50) NOT NULL
);
GO



CREATE TABLE educate.Teach (
	subject_id INT,
	teacher_id INT,
	PRIMARY KEY (subject_id, teacher_id),
	syllabus NVARCHAR (MAX) NOT NULL,
	FOREIGN KEY (subject_id) 
    REFERENCES educate.Subjects (subject_id) 
    ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (teacher_id) 
    REFERENCES educate.Teachers (teacher_id) 
    ON DELETE CASCADE ON UPDATE CASCADE,
);
GO



CREATE TABLE educate.Study (
	schedule NVARCHAR (MAX) NOT NULL,
	class_id INT,
	teacher_id INT,
	PRIMARY KEY (class_id, teacher_id),
	FOREIGN KEY (class_id) 
    REFERENCES educate.Classes (class_id) 
    ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (teacher_id) 
    REFERENCES educate.Teachers (teacher_id) 
    ON DELETE CASCADE ON UPDATE CASCADE,
);
GO



CREATE TABLE educate.Classes (
	class_id INT IDENTITY (1, 1) PRIMARY KEY,
	class_name VARCHAR (10) NOT NULL,
	total_member INT NOT NULL,
	main_class_teacher_name NVARCHAR (50) NOT NULL
);
GO



CREATE TABLE activate.Participations(
	start_date DATE NOT NULL,
	end_date DATE NOT NULL,
	class_id INT,
	event_id INT,
	PRIMARY KEY (class_id, event_id),
	FOREIGN KEY (class_id) 
    REFERENCES educate.Classes (class_id) 
    ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (event_id) 
    REFERENCES activate.Eventes (event_id) 
    ON DELETE CASCADE ON UPDATE CASCADE
);
GO



CREATE TABLE activate.Eventes  (
	event_id INT IDENTITY (1, 1) PRIMARY KEY,
	event_name NVARCHAR (MAX) NOT NULL,
	date_of_event DATE NOT NULL,
	describe NVARCHAR (MAX) NOT NULL,
	location NVARCHAR (MAX) NOT NULL,
	staff_id INT,
	FOREIGN KEY (staff_id) 
    REFERENCES educate.Staffs (staff_id) 
    ON DELETE CASCADE ON UPDATE CASCADE
);
GO



CREATE TABLE activate.Attend(
	teacher_id INT,
	event_id INT,
	start_date DATE NOT NULL,
	end_date DATE NOT NULL,
	PRIMARY KEY (teacher_id, event_id),
	FOREIGN KEY (teacher_id) 
    REFERENCES educate.Teachers (teacher_id) 
    ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (event_id) 
    REFERENCES activate.Eventes (event_id) 
    ON DELETE CASCADE ON UPDATE CASCADE
);
GO



CREATE TABLE activate.Teaching_plans (
	plan_id INT IDENTITY (1, 1) PRIMARY KEY,
	plan_name NVARCHAR (MAX) NOT NULL,
	semester INT NOT NULL,
	start_date DATE NOT NULL,
	end_date DATE NOT NULL,
	teacher_id INT,
	subject_id INT,
	class_id INT,
	staff_id INT,
	FOREIGN KEY (teacher_id) 
    REFERENCES educate.Teachers (teacher_id) 
    ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (subject_id) 
    REFERENCES educate.Subjects (subject_id) 
    ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (class_id) 
    REFERENCES educate.Classes (class_id) 
    ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (staff_id) 
    REFERENCES educate.Staffs (staff_id) 
    ON DELETE CASCADE ON UPDATE CASCADE,
	school_year INT NOT NULL
);
GO
