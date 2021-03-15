-- Choose correct database
USE Coderstrust;
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
        
