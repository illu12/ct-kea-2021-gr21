
/*
	This script is for a complete setup
*/


-- Drop database if exists, debug only
-- DROP DATABASE IF EXISTS Coderstrust;

-- Create a new database
CREATE DATABASE Coderstrust;
-- Choose correct database
USE Coderstrust;

-- Create table to contain all categories
CREATE TABLE Category(
	category_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    title varchar(255)
);

-- Create table to contain all courses
CREATE TABLE Course(
	course_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    title varchar(255),
	url varchar(255),
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES Category(category_id) 
);

-- Create table to contain all questions
CREATE TABLE Question(
	question_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    description varchar(255),
    weight INT,
    course_id INT,
    FOREIGN KEY (course_id) REFERENCES Course(course_id)
);

-- Create table to contain all customers
CREATE TABLE Customer(
	customer_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    name varchar(255)
);

-- Create table to contain all quiz answer 
CREATE TABLE Quiz(
    customer_id INT,
    question_id INT,
    score INT,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

-- Categories
-- Insert multiple values
INSERT INTO Category(title) VALUES
	("Graphical Design"),
	("Programming"),
	("Social Media");

-- Courses
-- Insert multiple values
INSERT INTO Course(title,url,category_id) VALUES
	-- Graphical Design
	("Photoshop Essentials - Learn how to create professional designs","https://academy.coderstrust.com/courses/intro-to-graphic-design-photoshop",1),
	("Build Your Resume with Photoshop","https://academy.coderstrust.com/courses/create-your-resume-photoshop",1),
    ("Learn how to Animate a Logo","https://academy.coderstrust.com/courses/intro-animation-logo-reveal",1),
	("Premiere Pro for Beginners - Learn video editing ","https://academy.coderstrust.com/courses/intro-to-video-editing",1),
	-- Programming
	("Complete Wordpress Course for Beginners - Create websites without any coding","https://academy.coderstrust.com/courses/wordpress-customization",2),
	("Essential Python Course for Beginners - Learn Python with Easy Projects","https://academy.coderstrust.com/courses/intro-to-python",2),
    ("Essential Java Course for Beginners - Learn Java with Easy Tasks","https://academy.coderstrust.com/courses/intro-to-java",2),
    ("Build a Web App with Django","https://academy.coderstrust.com/courses/intro-to-django",2),
	-- Social Media
    ("Complete Guide to Facebook Ads Manager","https://academy.coderstrust.com/courses/facebook-ads-manager",3),
    ("Complete SEO for Beginners - Learn how to rank websites on search engines","https://academy.coderstrust.com/courses/intro-to-search-engine-optimization",3),
	("Intro to Copywriting","https://academy.coderstrust.com/courses/intro-to-copywriting",3);


-- Questions
-- Insert multiple values
INSERT INTO Question(description,weight,course_id) VALUES
	-- Graphical design
    ("Does a picture spark your imagination?",5,1),
	("Would you apply filters on an image, using your computer or phone?",5,1),
	("Browsing a beautiful website makes your day",5,2),
	("Content is important, so is style and layout",5,2),
	("Animations are amazing",5,3),
	("A great logo is a must",5,3),
	("Making videos is art",5,4),
	("A great video can change your world",5,4),
    
    -- Programming
    ("You want to share with the world!",5,5),
    ("If someone asked your about your interests, would you share?",5,5),
    ("Automating trivial tasks seems amazing!",5,6),
    ("You should be able to do anything!",5,6),
    ("You don’t mind running slower, to avoid injuries",5,7),
    ("If you had some type of system, you would need complete control over it",5,7),
    ("If you managed a hotel, it would run fast and smooth",5,8),
    ("You want to be the engineer in the team",5,8),
    
	-- Social Media
    ("You enjoy proposing products and services to the world",5,9),
    ("You feel comfortable on  Social Media",5,9),
    ("You prioritize speed over anything",5,10),
    ("Optimizing is a lot of fun!",5,10),
    ("Words are not just words, they need to be selected, carefully",5,11),
    ("When looking at a bouquet, you only notice few flowers",5,11);   

-- Customers
-- Insert multiple values
INSERT INTO Customer(name) VALUES
	("John"),
    ("Martin");




/*** Views ***/
	-- Drop view if exists, debug only
	-- DROP VIEW IF EXISTS Graphical_Design_Interest;
	-- Create view, to get total score for a customer on Graphical Design related questions
	CREATE VIEW Graphical_Design_Interest AS
		SELECT
			Customer.customer_id,
			Customer.name,
			Category.title,
			SUM(Quiz.score) as score
		FROM
			Customer
		/** Join all tables where customer is related and category corresponds  **/
		JOIN Quiz
		ON Quiz.customer_id = Customer.customer_id
		
		JOIN Question
		ON Question.question_id = Quiz.question_id
		
		JOIN Course
		ON Course.course_id = Question.course_id
		
		JOIN Category
		ON Category.category_id = Course.category_id
		AND Category.title = "Graphical Design"
		
		GROUP BY
			Customer.customer_id;
	;

	-- Drop view if exists, debug only
	-- DROP VIEW IF EXISTS Programming_Interest;
	-- Create view, to get total score for a customer on Programming related questions
	CREATE VIEW Programming_Interest AS
		SELECT
			Customer.customer_id,
			Customer.name,
			Category.title,
			SUM(Quiz.score) as score
		FROM
			Customer
		JOIN Quiz
		ON Quiz.customer_id = Customer.customer_id
		
		JOIN Question
		ON Question.question_id = Quiz.question_id
		
		JOIN Course
		ON Course.course_id = Question.course_id
		
		JOIN Category
		ON Category.category_id = Course.category_id
		AND Category.title = "Programming"
		GROUP BY
			Customer.customer_id
	;

	-- Drop view if exists, debug only
	-- DROP VIEW IF EXISTS Social_Media_Interest;
	-- Create view, to get total score for a customer on Social Media related questions
	CREATE VIEW Social_Media_Interest AS
		SELECT
			Customer.customer_id,
			Customer.name,
			Category.title,
			SUM(Quiz.score) as score
		FROM
			Customer
		/** Join all tables where customer is related and category corresponds  **/
		JOIN Quiz
		ON Quiz.customer_id = Customer.customer_id
		
		JOIN Question
		ON Question.question_id = Quiz.question_id
		
		JOIN Course
		ON Course.course_id = Question.course_id
		
		JOIN Category
		ON Category.category_id = Course.category_id
		AND Category.title = "Social Media"

		GROUP BY
			Customer.customer_id
	;

	-- Drop view if exists, debug only
	-- DROP VIEW IF EXISTS UserInterests;

	-- Create view to get percentage view of user interests
	CREATE VIEW UserInterests AS
		-- Query table
		SELECT
			Customer.customer_id,
			Customer.name,
			-- Generate a percentage value
			CONCAT(ROUND(GDI.score/(GDI.score+PI.score+SMI.score)*100,0),"%") as graphical_design,
			CONCAT(ROUND(PI.score/(GDI.score+PI.score+SMI.score)*100,0),"%") as programming,
			CONCAT(ROUND(SMI.score/(GDI.score+PI.score+SMI.score)*100,0),"%") as social_media
		FROM
			Customer
		/*** Join all tables, where customer_id is related ***/       
		-- Rename table as GDI
		JOIN Graphical_Design_Interest AS GDI
		ON GDI.customer_id = Customer.customer_id

		-- Rename table as PI
		JOIN Programming_Interest AS PI
		ON PI.customer_id = Customer.customer_id

		-- Rename table as SMI
		JOIN Social_Media_Interest AS SMI
		ON SMI.customer_id = Customer.customer_id
	;
/*** End of views **/


# Insert customer answers into quiz
INSERT INTO Quiz (customer_id,question_id,score) 
VALUES 
	# John
	(1,1,5),
	(1,2,0),
	(1,3,0),
	(1,4,5),
	(1,5,5),
	(1,6,5),
	(1,7,0),
	(1,8,5),
	(1,9,0),
	(1,10,5),
	(1,11,5),
	(1,12,5),
	(1,13,5),
	(1,14,0),
	(1,15,5),
	(1,16,0),
	(1,17,0),
	(1,18,0),
	(1,19,0),
	(1,20,0),
	(1,21,5),
	(1,22,0),
    
	# Martin
	(2,1,5),
	(2,6,5),
	(2,12,5),
	(2,21,5),
	(2,22,5),
    (2,2,0),
    (2,3,0),
    (2,4,0),
    (2,5,0),
    (2,7,0),
    (2,8,0),
    (2,9,0),
    (2,10,0),
    (2,11,0),
    (2,13,0),
    (2,14,0),
    (2,15,0),
    (2,16,0),
    (2,17,0),
    (2,18,0),
    (2,19,0),
    (2,20,0);

-- Just a check query
SELECT * FROM UserInterests;


