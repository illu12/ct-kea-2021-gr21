-- Choose correct database
USE Coderstrust;

-- Drop procedure if exists, debug only
-- DROP PROCEDURE IF EXISTS HighestCourseScore;

-- Change delimiter for stored procedure
DELIMITER $$
-- Create a stored procedure
CREATE PROCEDURE HighestCourseScore(
	-- Take integer input
	IN customer_id_ INT
)
-- Start procedure logic
BEGIN
	-- Query a table
	SELECT
		Customer.name,
		Course.course_id,
        Course.title,
		SUM(Quiz.score),
        Course.url
	FROM
		Course
	-- Get customer data with corresponding customer_id as input
	JOIN
		Customer
	ON
		Customer.customer_id = customer_id_
	-- Backtrack and group scores by course
	JOIN
		Question
	ON
		Question.course_id = Course.course_id
	JOIN
		Quiz
	ON 
		Question.question_id = Quiz.question_id AND Quiz.customer_id = customer_id_
	GROUP BY
		Course.course_id ORDER BY SUM(Quiz.score) desc LIMIT 1;
-- End procedure logic
END$$
-- Set default delimiter after procedure
DELIMITER ;

-- This checks the highest course score
CALL HighestCourseScore(1);

