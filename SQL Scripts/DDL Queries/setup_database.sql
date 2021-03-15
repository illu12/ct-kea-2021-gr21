
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


