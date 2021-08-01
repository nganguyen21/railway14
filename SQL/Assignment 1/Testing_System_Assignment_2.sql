DROP DATABASE IF EXISTS TestingManagement;
CREATE DATABASE IF NOT EXISTS TestingManagement;
USE TestingManagement;

DROP TABLE IF EXISTS Department;
CREATE TABLE Department (
	DepartmentID	TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    DepartmentName	NVARCHAR(20) UNIQUE KEY NOT NULL
);
-- add data Department
INSERT INTO department (DepartmentID,	 DepartmentName)
VALUES 				   	(		1,	 		N'Sale'),
						(		2,	 		N'Marketing'),
                        (		3,	 		N'Tài chính'),
                        (		4,	 		N'Nhân sự'),
                        (		5,	 		N'Bảo vệ'),
                        (		6,	 		N'Kỹ thuật'),
                        (		7,	 		N'Giám đốc'),
						(		8,	 		N'Phó giám đốc'),
						(		9,	 		N'Thư ký'),
						(		10,	 		N'Bán hàng');

CREATE TABLE Position (
	PositionID		TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    PositionName	ENUM ('Dev', 'Test', 'Scrum Master', 'PM') NOT NULL
);
-- add data Position
INSERT INTO Position	(PositionID,		 PositionName)
VALUES 					(		1,				'Dev'   ),
						(		2,				'Test'   ),
						(		3,				'Scrum Master'   ),
                        (		4,				'PM'   );

CREATE TABLE `Account` (
	AccountID		SMALLINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    Email			VARCHAR(50) UNIQUE KEY CHECK (LENGTH (Email) > 10),
    Username		NVARCHAR(20) UNIQUE KEY NOT NULL CHECK (LENGTH (Usename)>= 6),
    FullName 		NVARCHAR(50) NOT NULL CHECK (LENGTH (FullName) >= 6),
    DepartmentID 	TINYINT UNSIGNED UNIQUE NOT NULL,
    PositionID		TINYINT UNSIGNED,
    Createdate		DATETIME DEFAULT NOW(),
    FOREIGN KEY (DepartmentID) REFERENCES Department (DepartmentID),
    FOREIGN KEY (PositionID) REFERENCES Position (PositionID)
);
-- add data `Account`
INSERT INTO `Account`	(AccountID, 	Email, 						Username, 			FullName, 				DepartmentID, 	PositionID)
VALUES 					(	1,		'nguyennga0302002@gmail.com',	'nguyennga',		N'Nguyễn Thị Nga',			3,				1	   ),
						(	2,		'thu.minhhoang1@gmail.com',		 'minhthu',			N'Hoàng Minh Thu',			10,				2	   ),
                        (	3,		'khangtm@gmail.com',			'tongminhkhang',	N'Tống Minh Khang',			4,				4	   ),
                        (	4,		'letran1202@gmail.com',			'tranthile',		N'Trần Thị Lệ',				6,				2		),
                        (	5,		'changchang@gmail.com',			'changchang',		N'Nguyễn Huyền Trang',		1,				3	   ),
						(	6,		'hapham@gmail.com',				'phamha',			N'Phạm Ngân Hà',			5,				4	   ),
                        (	7,		'hoanglong@gmail.com',			'hoanglong',		N'Hoàng Văn Long',			9,				1	   );
                        
CREATE TABLE `Group` (
	GroupID			TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    GroupName		NVARCHAR(50) NOT NULL,
    CreatorID		SMALLINT UNSIGNED NOT NULL,
    CreateDate		DATETIME DEFAULT NOW(),
	FOREIGN KEY (CreatorID) REFERENCES `Account`(AccountID)
);
INSERT INTO `Group` ( GroupName,	 CreatorID)
VALUES 				(N'Sale01',	 		3),
					(N'Sale02',	 		1),
                    (N'Marketing',	 	2),
					(N'Radio',	 		7),
                    (N'Học viên',	 	2);
                    
CREATE TABLE GroupAccount (
	GroupID			TINYINT UNSIGNED NOT NULL,
    AccountID		SMALLINT UNSIGNED NOT NULL,
    PRIMARY KEY (GroupID, AccountID),
    JoinDate		DATETIME DEFAULT NOW(),
    FOREIGN KEY (GroupID) REFERENCES `Group`(GroupID),
    FOREIGN KEY (AccountID) REFERENCES `Account`(AccountID)
);
-- add data GroupAccount 
INSERT INTO GroupAccount (GroupID, AccountID)
VALUES 					( 1, 		6),
						( 2,  		4),  
                        ( 3,  		3),  
                        ( 4,  		7),  
                        ( 5,  		1);
CREATE TABLE TypeQuestion (
	TypeID			TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    TypeName		ENUM ('Essay', 'Multiple-Choice') NOT NULL
);
-- add data TypeQuestion
INSERT INTO Typequestion ( TypeName)
VALUES					('Essay'),
						('Multiple-Choice');

CREATE TABLE CategoryQuestion (
	CategoryID		TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    CategoryName	NVARCHAR(20) UNIQUE KEY NOT NULL
);
-- add data CategoryQuestion
INSERT INTO CategoryQuestion(CategoryName)
VALUES 						('Java'),
							('NET'),
                            ('SQL'),
                            ('Postman'),
                            ('Ruby'),
                            ('C++'),
                            ('Python'),
                            ('Javascript');

CREATE TABLE Question (
	QuestionID		TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT ,
    Content			NVARCHAR(100) NOT NULL CHECK (LENGTH (Content) >10),
    CategoryID		TINYINT UNSIGNED NOT NULL,
    TypeID			TINYINT UNSIGNED NOT NULL,
    CreatorID		SMALLINT UNSIGNED NOT NULL,
    CreateDate		DATETIME DEFAULT NOW(),
    FOREIGN KEY (CategoryID) REFERENCES CategoryQuestion (CategoryID),
    FOREIGN KEY (TypeID) REFERENCES TypeQuestion (TypeID),
    FOREIGN KEY (CreatorID) REFERENCES `Account` (AccountID)
);
-- add data Question
INSERT INTO question (Content,			  	CategoryID, TypeID, CreatorID)
VALUES 				(N'Câu hỏi về Java',		3, 			1, 	  5),
					(N'Câu hỏi về NET',			2, 			2, 	  2),
                    (N'Câu hỏi về SQL',			8, 			2, 	  1),
                    (N'Câu hỏi về Postman',		5, 			1, 	  3),
                    (N'Câu hỏi về Ruby',		1, 			2, 	  7),
                    (N'Câu hỏi về C++',			4, 			1, 	  6),
                    (N'Câu hỏi về Python',		6, 			1, 	  1),
                    (N'Câu hỏi về Javascript',	7, 			1, 	  4);

CREATE TABLE Answer (
	AnswerID		TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	Content			NVARCHAR(100) NOT NULL CHECK (LENGTH (Content) >10),
    QuestionID		TINYINT UNSIGNED,
    isCorrect 		ENUM ('Dung','Sai') DEFAULT 'Dung',
    FOREIGN KEY (QuestionID) REFERENCES Question(QuestionID)
);
-- add date Answer
INSERT INTO Answer	(Content, 		QuestionID, isCorrect)
VALUES 				(N'Trả lời 01',		4,		'Dung'),
					(N'Trả lời 02',		1,		'Sai'),
                    (N'Trả lời 03',		3,		'Dung'),
                    (N'Trả lời 04',		5,		'Dung'),
                    (N'Trả lời 05',		7,		'Sai'),
                    (N'Trả lời 06',		5,		'Sai'),
                    (N'Trả lời 07',		2,		'Dung'),
                    (N'Trả lời 08',		6,		'Sai');
                    
CREATE TABLE Exam (
	ExamID			TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	`Code`			TINYINT UNIQUE KEY NOT NULL,
    Title			NVARCHAR(50)NOT NULL CHECK(LENGTH ( Title) > 6),
    CategoryID 		TINYINT UNSIGNED NOT NULL,
    Duration		TINYINT NOT NULL ,
    CreatorID		SMALLINT UNSIGNED NOT NULL,
    CreateDate		DATE,
    FOREIGN KEY (CategoryID) REFERENCES  CategoryQuestion(CategoryID),
    FOREIGN KEY (CreatorID) REFERENCES  `Account`(AccountID)
);
INSERT INTO exam(`Code`, Title, 		CategoryID, 	Duration,	 CreatorID,		CreateDate)
VALUES			(011,	N'Đề thi Java',		 	7,			60,  		1,			'2021-07-05'),
				(012,	N'Đề thi C++',	    	1,			120, 		2,			'2021-04-12'),
                (013,	N'Đề thi Python',	    3,			60,  		1,			'2020-11-30'),
                (014,	N'Đề thi SQL',	    	2,			90,  		3,			'2021-02-25'),
				(015,	N'Đề thi Postman',	    5,			60,  		4,			'2021-05-03'),
                (016,	N'Đề thi NET',	   		6,			60,  		5,			'2021-03-21'),
                (017,	N'Đề thi Javascript',	4,			120, 		2,			'2020-12-01'),
                (018,	N'Đề thi Ruby',	    	8,			60,  		6,			'2021-01-13');
                
CREATE TABLE ExamQuestion (
	ExamID			TINYINT UNSIGNED NOT NULL,
    QuestionID		TINYINT UNSIGNED NOT NULL,
    PRIMARY KEY (ExamID, QuestionID),
    FOREIGN KEY (ExamID) REFERENCES Exam (ExamID),
    FOREIGN KEY (QuestionID) REFERENCES Question (QuestionID)
);
INSERT INTO ExamQuestion(ExamID,QuestionID)
VALUES 					(1,			5),
						(2,			6),
                        (3,			2),
                        (4,			1),
                        (5,			4),
                        (6,			7),
                        (7,			3),
                        (8,			8);
                        

	