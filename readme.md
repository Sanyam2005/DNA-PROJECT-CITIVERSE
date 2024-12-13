# CITIVERSE

## Team Members: 
Krishiv Gupta  
Atharva Kulkarni  
Sanyam Agrawal  
Kushal Mangla

## About our Project

CITIVERSE is an immersive, city-focused mini world designed to provide travelers with comprehensive insights
into cities across the globe. It encapsulates everything special and essential about each city, from cultural
highlights and seasonal events to local cuisines ,hotel recommendations and restaurants.
CITIVERSE serves as a one-stop knowledge hub for anyone looking to explore a city, plan a trip, or dive deep
into its unique aspects.

We have made  ER model and relational model of the database in previous phases.

A video (Video) showcasing the functionalities of the application and its usage on dummy data has also been added into the repository.

It has been implemented using Python and MySQL. We are using the Python library, "pymysql", to execute SQL queries. The database follows and uses various principles of databases like ER relationships and Normalizations.

# CITIVERSE
# Team 38
Krishiv Gupta  
Atharva Kulkarni  
Sanyam Agrawal  
Kushal Mangla  

## About our Project

CITIVERSE is an immersive, city-focused mini world designed to provide travelers with comprehensive insights
into cities across the globe. It encapsulates everything special and essential about each city, from cultural
highlights and seasonal events to local cuisines ,hotel recommendations and restaurants.
CITIVERSE serves as a one-stop knowledge hub for anyone looking to explore a city, plan a trip, or dive deep
into its unique aspects.

We have made  ER model and relational model of the database in previous phases.

A video (Video) showcasing the functionalities of the application and its usage on dummy data has also been added into the repository.

It has been implemented using Python and MySQL. We are using the Python library, "pymysql", to execute SQL queries. The database follows and uses various principles of databases like ER relationships and Normalizations.

## Purpose

The application allows users to view, update, and analyze data, making it ideal for travel administrators, tourism agencies, and hospitality managers. Citiverse leverages a MySQL database to store and process the information efficiently.


## List of commands that can be run using our code

### List of Commands

1. **View Table**  
   View the existing data table.

2. **Insert a New Tourist**  
   Add details of a new tourist, including their name, age, and other relevant information.

3. **Add a New Hotel**  
   Add details of a new hotel to the database.

4. **Update the Fare for Cab Service**  
   Modify the fare details for cab services.

5. **Delete an Event That Has Been Cancelled**  
   Remove an event from the database that is no longer active.

6. **Search for Events Scheduled for a Particular Date**  
   Retrieve a list of all events scheduled on a specific date.

7. **Get All Hotels with a Rating Greater Than 4**  
   Fetch details of all hotels with a rating exceeding 4.

8. **Average Cost of All Food Items in a Restaurant**  
   Calculate the average price of food items offered in a restaurant.

9. **Total Number of Visitors Across All Places of Attraction**  
   Compute the total number of visitors across various attractions.

10. **Update Seat Availability for Public Transport**  
    Change or update the number of available seats in public transport.

11. **Update the Rating of a Hotel**  
    Change the current rating of a hotel based on user reviews or feedback.

12. **Get the Number of Visitors for a Place of Attraction**  
    Display the total number of visitors for a specific tourist destination.

13. **Name of Events a Tourist Has Attended**  
    Retrieve and display a list of events attended by a particular tourist.

14. **Number of People Mentored by a Particular Mentor**  
    Fetch the count of individuals mentored by a specified mentor.

15. **Number of Tourists Present in a City**  
    Retrieve the total number of tourists currently present in a specific city.

16. **Exit**  
    Close the application. 


## To run the project:

You must have MySQL and python3 in your local system for this to work.

1. Clone the repository into a folder and open that folder into in Terminal.

2. Login in to your MySQL using 
```
 sudo mysql -u <yourusername>
```
 and then enter your password.

3. In MySQL, create a database, "Travel".
```
CREATE DATABASE Travel;
```
4.Populate the DB using dump.sql

5. Now start the application by
```
python3 index.py
```
and now enter your credentials (either your native user or new user created).

6. You may select options to see various functionalities.

## Future Enhancements
Add functionality for exporting reports.
Integrate APIs for live transport and hotel booking data.
Add user authentication for role-based access.
