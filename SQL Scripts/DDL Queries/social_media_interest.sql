
-- Choose correct database
USE Coderstrust;
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


