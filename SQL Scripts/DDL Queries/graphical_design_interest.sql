-- Choose correct database
USE Coderstrust;
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


SELECT * FROM Graphical_Design_Interest;
