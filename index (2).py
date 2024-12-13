import pymysql
import subprocess as sp
import pymysql.cursors
from tabulate import tabulate

def execute_query(query):
    try:
        with con.cursor() as cur:
            cur.execute(query)
            con.commit()
            print("Query executed successfully")
            
    except Exception as e:
        con.rollback()
        print("Failed to execute query")
        print(">>>>>>>>>>>>>", e)
        

def view_table():
    table_name = input("Enter table name: ")
    query = f"SELECT * FROM {table_name}"
    try: 
        with con.cursor() as cur:
            cur.execute(query)
            result = cur.fetchall()
            if result:
                print(tabulate(result, headers="keys", tablefmt="psql"))

    except Exception as e:
        con.rollback()
        print("Failed to view table")
        print(">>>>>>>>>>>>>", e)
                                                                                      
def add_new_hotel():
    hotel_name = input("Enter hotel name: ")
    contact_number = input("Enter contact number: ")
    rating = float(input("Enter rating: "))
    amenities = input("Enter amenities (comma-separated): ")
    price_per_night = float(input("Enter price per night: "))
    address = input("Enter address (Street, Zip): ")
    
    try:
        street, zip_code = [x.strip() for x in address.split(",")]
    except Exception as e:
        print("Invalid address")
        print(">>>>>>>>>>>>>", e)
        return
    
    query = """
        INSERT INTO Hotel (Name, Contact_Number, Rating,Price_Per_Night, Street, Zip) 
        VALUES (%s, %s, %s, %s, %s, %s)
    """

    r1 = 0
    
    try:
        with con.cursor() as cur:
            cur.execute(query, (
                hotel_name, 
                contact_number, 
                rating, 
                # amenities,
                price_per_night, 
                street, 
                zip_code
            ))
            con.commit()
            print("Inserted into database")
            
            # count rows in Hotel table
            query1 = "SELECT COUNT(*) as count FROM Hotel"
            cur.execute(query1)
            result = cur.fetchone()
            r1 = result['count']

    except Exception as e:
        con.rollback()
        print("Failed to insert into database")
        print(">>>>>>>>>>>>>", e)
        return
    
    amenities = [x.strip() for x in amenities.split(",")]
    for amenity in amenities:
        query = """
        INSERT INTO Hotel_Amenities (Amenities_type, `Amenity_Hotel_ID`) 
        VALUES (%s, %s)
        """
        
        try:
            with con.cursor() as cur:
                cur.execute(query, (amenity, str(r1)))
                con.commit()
                print("Inserted into database")
        except Exception as e:
            con.rollback()
            print("Failed to insert into database")
            print(">>>>>>>>>>>>>", e)
            return
    return 


def update_cab_price():
    print("Updating price")
    try:
        transport_type = input("Enter transport type (Taxi/Car Rental/Van/Limousine/Bike): ").strip()
        new_price = float(input("Enter new price per km: "))
        company_name = input("Enter company name: ").strip()
        
        query = """
        UPDATE Private_Transport 
        SET Price_Per_Km = %s 
        WHERE Type = %s AND Company = %s
        """
        
        try:
            with con.cursor() as cur:
                cur.execute(query, (new_price, transport_type, company_name))
                if cur.rowcount == 0:
                    print("No matching records found")
                    con.rollback()
                    return
                con.commit()
                print(f"Successfully updated price for {transport_type} by {company_name}")
        except Exception as e:
            con.rollback()
            print("Failed to update price")
            print(">>>>>>>>>>>>>", e)
            return
            
    except ValueError as e:
        print("Invalid price value. Please enter a number")
        print(">>>>>>>>>>>>>", e)
        return
    
    
def get_all_hotels_with_rating_greater_than_4():
    
    rating = float(input("Enter rating: "))
    
    query = """
    SELECT * FROM Hotel 
    WHERE Rating > %f
    """
    
    try:
        with con.cursor() as cur:
            cur.execute(query, (rating,))
            result = cur.fetchall()
            if result:
                print(tabulate(result, headers="keys", tablefmt="psql"))
    except Exception as e:
        con.rollback()
        print("Failed to view table")
        print(">>>>>>>>>>>>>", e)
        return
    
    
def get_average_cost_of_food_items():
    restaurant_name = input("Enter restaurant name: ")
    query = """
    SELECT r.Name, r.Restaurant_ID, AVG(f.Price) as Average_Cost, GROUP_CONCAT(f.Food_Name) as Food_Items
    FROM Restaurant r
    LEFT JOIN Food_items f ON r.Restaurant_ID = f.Rest_ID
    WHERE r.Name = %s
    GROUP BY r.Restaurant_ID, r.Name
    """
    
    try:
        with con.cursor() as cur:
            cur.execute(query, (restaurant_name,))
            result = cur.fetchone()
            if result and result['Average_Cost'] is not None:
                # Convert result to list of dicts for tabulate
                result_list = [dict(result)]
                print(tabulate(result_list, headers="keys", tablefmt="psql"))
            else:
                print(f"Restaurant '{restaurant_name}' not found or has no food items")
    except Exception as e:
        con.rollback()
        print("Failed to view table")
        print(">>>>>>>>>>>>>", e)
        return
    
def total_number_of_visitors_across_all_places_of_attraction():
    query = """
    SELECT SUM(Number_of_Visitors) as Total_Visitors FROM Places_of_attraction
    """
    
    try:
        with con.cursor() as cur:
            cur.execute(query)
            result = cur.fetchone()
            if result and result['Total_Visitors'] is not None:
                # Convert result to list of dicts for tabulate
                result_list = [dict(result)]
                print(tabulate(result_list, headers="keys", tablefmt="psql"))
            else:
                print("No visitor data found")
    except Exception as e:
        con.rollback()
        print("Failed to view table")
        print(">>>>>>>>>>>>>", e)
        return

def get_visitors_for_place():
    place_name = input("Enter place of attraction name: ").strip()
    
    query = """
    SELECT Name, SUM(Number_of_Visitors) as Total_Visitors FROM Places_of_attraction WHERE Name = %s
    """
    
    try:
        with con.cursor() as cur:
            cur.execute(query, (place_name,))
            result = cur.fetchone()
            if result:
                # Convert single result to list for tabulate
                result_list = [dict(result)]
                print(tabulate(result_list, headers="keys", tablefmt="psql"))
            else:
                print(f"Place '{place_name}' not found")
    except Exception as e:
        con.rollback()
        print("Failed to fetch visitor data")
        print(">>>>>>>>>>>>>", e)
        return


def update_seat_availability():
    print("Updating seat availability")
    try:
        transport_type = input("Enter transport type: ").strip()
        new_availability = int(input("Enter new seat availability: "))
        
        if new_availability < 0:
            print("Availability cannot be negative")
            return
        
        query = """
        UPDATE Public_Transport 
        SET Seat_Availability = %s 
        WHERE Type = %s
        """
        
        try:
            with con.cursor() as cur:
                cur.execute(query, (new_availability, transport_type))
                if cur.rowcount == 0:
                    print("No matching records found")
                    con.rollback()
                    return
                con.commit()
                print(f"Successfully updated seat availability for {transport_type}")
        except Exception as e:
            con.rollback()
            print("Failed to update seat availability")
            print(">>>>>>>>>>>>>", e)
            return
    except ValueError as e:
        print("Invalid availability value. Please enter a number")
        print(">>>>>>>>>>>>>", e)
        return

def update_rating():
    print("Updating rating")
    try:
        hotel_name = input("Enter hotel name: ").strip()
        new_rating = float(input("Enter new rating: "))
        
        if new_rating < 0 or new_rating > 5:
            print("Rating should be between 0 and 5")
            return
        
        query = """
        UPDATE Hotel 
        SET Rating = %s 
        WHERE Name = %s
        """
        
        try:
            with con.cursor() as cur:
                cur.execute(query, (new_rating, hotel_name))
                if cur.rowcount == 0:
                    print("No matching records found")
                    con.rollback()
                    return
                con.commit()
                print(f"Successfully updated rating for {hotel_name}")
        except Exception as e:
            con.rollback()
            print("Failed to update rating")
            print(">>>>>>>>>>>>>", e)
            return
    except ValueError as e:
        print("Invalid rating value. Please enter a number")
        print(">>>>>>>>>>>>>", e)
        return
   
def search_events_by_date():
    date = input("Enter date (YYYY-MM-DD): ")
    query = """
    SELECT * FROM Events_1
    WHERE Event_Date = %s
    """
    
    try:
        with con.cursor() as cur:
            cur.execute(query, (date,))
            result = cur.fetchall()
            # print(result)
            if result:
                print(tabulate(result, headers="keys", tablefmt="psql"))
            else:
                print(f"No events scheduled for {date}")
    except Exception as e:
        con.rollback()
        print("Failed to view table")
        print(">>>>>>>>>>>>>", e)
        return
    
def get_tourist_events_by_name():
    tourist_fname = input("Enter tourist first name: ").strip()
    
    query = """
    SELECT DISTINCT 
        t.First_Name,
        t.Identity_Proof,
        tp.Package_id,
        e.Event_Name,
        e.Event_Date,
        e.Event_Time
    FROM Tourist t
    JOIN Tour_Package tp ON t.Identity_Proof = tp.Identity_Proof
    JOIN Place_Attraction_Package pap ON tp.Package_ID = pap.Package_ID
    JOIN Events_1 e ON pap.For_place_id = e.Associated_Attraction_ID
    WHERE t.First_Name = %s
    ORDER BY e.Event_Date, e.Event_Time
    """
    
    try:
        with con.cursor() as cur:
            cur.execute(query, (tourist_fname,))
            results = cur.fetchall()
            if results:
                print(tabulate(results, headers="keys", tablefmt="psql"))
            else:
                print(f"No events found for tourist '{tourist_fname}'")
    except Exception as e:
        con.rollback()
        print("Failed to fetch tourist events")
        print(">>>>>>>>>>>>>", e)
        return
    
def delete_events_for_place():
    place_name = input("Enter place name: ").strip()
    
    # First get the Place_ID
    query1 = """
    SELECT Place_ID 
    FROM Places_of_attraction 
    WHERE Name = %s
    """
    
    # Then delete from Events_1 and Events_2
    query2 = """
    DELETE FROM Events_1 
    WHERE Associated_Attraction_ID = %s
    """
    
    query3 = """
    DELETE FROM Events_2 
    WHERE Associated_Attraction_ID = %s
    """
    
    try:
        with con.cursor() as cur:
            # Get Place_ID
            cur.execute(query1, (place_name,))
            result = cur.fetchone()
            
            if not result:
                print(f"Place '{place_name}' not found")
                return
                
            place_id = result['Place_ID']
            
            # Delete from Events tables
            cur.execute(query2, (place_id,))
            cur.execute(query3, (place_id,))
            con.commit()
            
            print(f"Successfully deleted events for {place_name}")
            
    except Exception as e:
        con.rollback()
        print("Failed to delete events")
        print(">>>>>>>>>>>>>", e)
        return
    
def add_new_tourist():
    first_name = input("Enter first name: ")
    middle_name = input("Enter middle name: ")
    last_name = input("Enter last name: ")
    phone_number = input("Enter phone number: ")
    email = input("Enter email: ")
    street = input("Enter street: ")
    zip_code = input("Enter zip code: ")
    mentor_name = input("Enter mentor name: ")
    hotel_name = input("Enter hotel name: ")
    
    # Query to get mentor's ID
    mentor_query = """
    SELECT Identity_Proof 
    FROM Tourist 
    WHERE First_Name = %s
    """
    
    # Query to get hotel's ID
    hotel_query = """
    SELECT Hotel_ID
    FROM Hotel
    WHERE Name = %s
    """
    
    # Main insert query with hotel_id
    insert_query = """
    INSERT INTO Tourist (
        First_Name, Middle_Name, Last_Name, 
        Phone_Number, Email_Id, Street, 
        Zip, Mentor_id, Tourist_hotel_id
    )
    VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
    """
    
    try:
        with con.cursor() as cur:
            # Get mentor ID
            cur.execute(mentor_query, (mentor_name,))
            mentor_result = cur.fetchone()
            if not mentor_result:
                print(f"Mentor with name '{mentor_name}' not found")
                return
            mentor_id = mentor_result['Identity_Proof']
            
            # Get hotel ID
            cur.execute(hotel_query, (hotel_name,))
            hotel_result = cur.fetchone()
            if not hotel_result:
                print(f"Hotel with name '{hotel_name}' not found")
                return
            hotel_id = hotel_result['Hotel_ID']
            
            # Insert new tourist with both IDs
            cur.execute(insert_query, (
                first_name, middle_name, last_name,
                phone_number, email, street,
                zip_code, mentor_id, hotel_id
            ))
            con.commit()
            print("Tourist added successfully")
            
    except Exception as e:
        con.rollback()
        print("Failed to add tourist")
        print(">>>>>>>>>>>>>", e)
        return

def number_of_people_mentored():
    mentor_name = input("Enter mentor name: ")
    
    # First get mentor's ID
    id_query = """
    SELECT Identity_Proof
    FROM Tourist
    WHERE First_Name = %s
    """
    
    # Then count mentees
    count_query = """
    SELECT t1.First_Name, COUNT(t2.Identity_Proof) as Mentored_Count
    FROM Tourist t1
    LEFT JOIN Tourist t2 ON t1.Identity_Proof = t2.Mentor_id
    WHERE t1.Identity_Proof = %s
    GROUP BY t1.First_Name, t1.Identity_Proof
    """
    
    try:
        with con.cursor() as cur:
            # Get mentor ID
            cur.execute(id_query, (mentor_name,))
            mentor_result = cur.fetchone()
            
            if not mentor_result:
                print(f"Mentor '{mentor_name}' not found")
                return
                
            mentor_id = mentor_result['Identity_Proof']
            
            # Get mentee count
            cur.execute(count_query, (mentor_id,))
            count_result = cur.fetchone()
            
            if count_result:
                print(f"{mentor_name} has mentored {count_result['Mentored_Count']} people")
            else:
                print(f"{mentor_name} hasn't mentored anyone yet")
                
    except Exception as e:
        con.rollback()
        print("Failed to fetch mentor data")
        print(">>>>>>>>>>>>>", e)
        return

def count_tourists_in_city():
    city_name = input("Enter city name: ").strip()
    
    query = """
    SELECT t2.City, COUNT(t1.Identity_Proof) as Tourist_Count
    FROM Tourist t1
    JOIN Tourist2 t2 ON t1.Zip = t2.Zip
    WHERE t2.City = %s
    GROUP BY t2.City
    """
    
    try:
        with con.cursor() as cur:
            cur.execute(query, (city_name,))
            result = cur.fetchone()
            
            if result and result['Tourist_Count'] > 0:
                # Convert to list for tabulate
                result_list = [dict(result)]
                print(tabulate(result_list, headers="keys", tablefmt="psql"))
            else:
                print(f"No tourists found in {city_name}")
                
    except Exception as e:
        con.rollback()
        print("Failed to fetch tourist count")
        print(">>>>>>>>>>>>>", e)
        return
    
if __name__ == "__main__":
    
    tmp = sp.call("clear", shell=True)
    
    username = input("Username: ")
    password = input("Password: ")
    
    try:
        con = pymysql.connect(
            host="localhost",
            user=username,
            password=password,
            db="Travel",
            cursorclass=pymysql.cursors.DictCursor,
        )   
        tmp = sp.call("clear", shell=True)
        
        if con.open:
            print("Connected")
        else:
            print("Failed to connect")
            
        tmp = input("Enter any key to CONTINUE>")
        
        with con.cursor() as cur:
            while True:
                tmp = sp.call("clear", shell=True)
                print("1. View Table")
                print("2. Insert a new tourist")
                print("3. Add a new Hotel")
                print("4. Update the fare for cab service")
                print("5. Delete all the events scheduled for a particular place")
                print("6. Search for all the events that are scheduled for a particular date")
                print("7. Get all the hotels with a rating greater than x")
                print("8. Average cost of all food items in a restaurant")
                print("9. Total number of visitors across all places of attraction")
                print("10. Update the seat availability for a public transport")
                print("11. Update the rating of a hotel")
                print("12. Get the number of visitors for a place of attraction")
                print("13. Name of events a tourist has attended")
                print("14. Number of people mentorted by a particular mentor(input)")
                print("15. Number of tourists present in a city given the name of the city")
                print("16. Exit")

                ch = int(input("Enter choice> "))
                tmp = sp.call("clear", shell=True)  
                if ch == 16:
                    exit()
                else:
                    if ch == 1:
                        view_table()
                    elif ch == 2:
                        add_new_tourist()
                    elif ch == 3:
                        add_new_hotel()
                    elif ch == 4:
                        update_cab_price()
                    elif ch == 5:
                        delete_events_for_place()
                    elif ch == 6:
                        search_events_by_date()
                    elif ch == 7:
                        get_all_hotels_with_rating_greater_than_4()
                    elif ch == 8:
                        get_average_cost_of_food_items()
                    elif ch == 9:
                        total_number_of_visitors_across_all_places_of_attraction()
                    elif ch == 10:
                        update_seat_availability()
                    elif ch == 11:
                        update_rating()
                    elif ch == 12:
                        get_visitors_for_place()
                    elif ch == 13 :
                        get_tourist_events_by_name()
                    elif ch == 14:
                        number_of_people_mentored()
                    elif ch == 15:
                        count_tourists_in_city()
                    else :
                        print("Invalid choice")
                    tmp = input("Enter any key to CONTINUE>")
            
    except Exception as e:
        
        con.rollback()
        print("Failed to insert into database")
        print(">>>>>>>>>>>>>", e)
    