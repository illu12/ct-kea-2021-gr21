# Authors
By Hamza Amir, Alexander Sandbæk & Kasper Kim Andersen
Group 21
Team DA2

# Content
This repository contains both the physical data model for the digital solution inquired by Coderstrust, as well as the application in the form of a webapplication.
The webapplication can be accessed at http://206.189.11.147/coderstrust (currently hosting downtime, 15/3 12:31).


# Setting up the database


## Prerequisites
To use the datamodel, you are assumed to have installed a MySql server on your PC, or have access to a remote PC.
It is adviced to have the MySql DBMS, MySql Workbench installed for testing the scripts.

## Get started
When you have downloaded the scripts, you have the possibility of running either each individual setup script, or the COMPLETE_SETUP.sql script, which will make sure everything is setup correctly, including table values.

If you choose not to run the COMPLETE_SETUP.sql script, you should run the scripts in following order:
1. setup_database.sql
2. graphical_design_interest.sql
3. programming_interest.sql
4. social_media_interest.sql
5. highest_course_score.sql
6. user_interests.sql
