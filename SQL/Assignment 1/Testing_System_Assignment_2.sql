DROP DATABASE IF EXISTS TestingManagement;
CREATE DATABASE IF NOT EXISTS TestingManagement;
USE TestingManagement;

DROP TABLE IF EXISTS Department;
CREATE TABLE Department (
	DepartmentID	TINYINT UNSIGNED PRIMARY KEY,
    DepartmentName	VARCHAR(20) UNIQUE KEY NOT NULL
);

CREATE TABLE Position (
	PositionID		TINYINT UNSIGNED PRIMARY KEY,
    PositionName	ENUM ('Dev', 'Test', 'Scrum Master', 'PM')
);

CREATE TABLE `Account` (
	AccountID		SMALLINT UNSIGNED PRIMARY KEY,
    Email			VARCHAR(50) UNIQUE KEY,
    Username		VARCHAR(20) UNIQUE KEY NOT NULL,
    Fullname 		VARCHAR(50),
    DepartmentID 	TINYINT UNSIGNED,
    PositionID		VARCHAR(20),
    Createdate		DATE,
    FOREIGN KEY (DepartmentID) REFERENCES Department (DepartmentID)
);

CREATE TABLE `Group` (
	GroupID			TINYINT UNSIGNED PRIMARY KEY,
    GroupName		VARCHAR(50) NOT NULL,
    CreatorID		SMALLINT UNSIGNED NOT NULL,
    CreateDate		DATE,
	FOREIGN KEY (CreatorID) REFERENCES `Account`(AccountID)
);

CREATE TABLE GroupAccount (
	GroupID			TINYINT UNSIGNED PRIMARY KEY,
    AccountID		TINYINT UNSIGNED,
    JoinDate		DATE
);

CREATE TABLE TypeQuestion (
	TypeID			TINYINT UNSIGNED PRIMARY KEY,
    TypeName		ENUM ('Essay', 'Multiple-Choice')
);

CREATE TABLE CategoryQuestion (
	CategoryID		TINYINT UNSIGNED PRIMARY KEY,
    CategoryName	VARCHAR(20) UNIQUE KEY
);

CREATE TABLE Question (
	QuestionID		TINYINT UNSIGNED PRIMARY KEY,
    Content			VARCHAR(50) NOT NULL,
    CategoryID		TINYINT UNSIGNED,
    TypeID			TINYINT UNSIGNED,
    CreatorID		TINYINT UNSIGNED,
    CreateDate		DATE
);

CREATE TABLE Answer (
	AnswerID		TINYINT UNSIGNED PRIMARY KEY,
	Content			VARCHAR(50),
    QuestionID		TINYINT,
    isCorrect 		ENUM ('Dung','Sai')
);

CREATE TABLE Exam (
	ExamID			TINYINT UNSIGNED PRIMARY KEY,
	Code			TINYINT UNIQUE KEY,
    Title			VARCHAR(50)NOT NULL,
    CategoryID 		TINYINT UNSIGNED,
    Duration		DATETIME,
    CreatorID		TINYINT UNSIGNED,
    CreateDate		DATE
);

CREATE TABLE ExamQuestion (
	ExamID			TINYINT UNSIGNED PRIMARY KEY,
    QuestionID		TINYINT UNSIGNED
);

	