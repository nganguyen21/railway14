DROP DATABASE IF EXISTS TestingManagement;
CREATE DATABASE TestingManagement;
USE TestingManagement;

-- Create table Department
CREATE TABLE Department (
	DepartmentID	INT,
    DepartmentName	VARCHAR(50)
);

-- Create table Position
CREATE TABLE Position (
	PositionID		INT,
    PositionName	VARCHAR(50)
);

CREATE TABLE `Account` (
	AccountID		INT,
    Email			VARCHAR(50),
    Username		VARCHAR(50),
    Fullname 		VARCHAR(50),
    DepartmentID	INT,
    PositionID		INT,
    Createdate		DATE
);

CREATE TABLE `Group` (
	GroupID			INT,
	GroupName		VARCHAR(50),
    CreatorID 		INT,
    CreateDate		DATE
);

CREATE TABLE GroupAccount (
	GroupID			INT,
    AccountID		VARCHAR(50),
    JoinDate		DATE
);

CREATE TABLE TypeQuestion (
	TypeID			INT,
    TypeName		VARCHAR(50)
);

CREATE TABLE CategoryQuestion (
	CategoryID		INT,
    CategoryName	VARCHAR(50)
);

CREATE TABLE Question (
	QuestionID		INT,
    Content			VARCHAR(50),
    CategoryID		INT,
    TypeID			INT,
    CreatorID		INT,
    CreateDate		DATE
);

CREATE TABLE Answer (
	AnswerID		INT,
	Content			VARCHAR(50),
    QuestionID		INT,
    isCorrect 		VARCHAR(50)
);

CREATE TABLE Exam (
	ExamID			INT,
	`Code`			INT,
    Title			VARCHAR(50),
    CategoryID 		INT,
    Duration		INT,
    CreatorID		INT,
    CreateDate		DATE
);

CREATE TABLE ExamQuestion (
	ExamID			INT,
    QuestionID		INT
);
