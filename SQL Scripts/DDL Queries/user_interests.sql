-- Choose correct database
USE Coderstrust;

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

SELECT * FROM UserInterests;

