-- Populate Cities Table
INSERT INTO Cities (City_name, Country_name) VALUES 
('New York', 'United States'),
('Paris', 'France'),
('Tokyo', 'Japan'),
('Rome', 'Italy'),
('Sydney', 'Australia');

-- Populate Tourist Table
INSERT INTO Tourist (First_Name, Middle_Name, Last_Name, Phone_Number, Email_Id, Street, Zip, Mentor_id) VALUES 
('John', 'Michael', 'Doe', '1234567890', 'john.doe@email.com', '123 Main St', '10001', NULL),
('Emily', 'Rose', 'Smith', '2345678901', 'emily.smith@email.com', '456 Oak Ave', '10002', 1),
('David', 'James', 'Brown', '3456789012', 'david.brown@email.com', '789 Pine Rd', '10003', 1),
('Sarah', 'Elizabeth', 'Wilson', '4567890123', 'sarah.wilson@email.com', '321 Maple Ln', '10004', 2),
('Michael', 'Andrew', 'Taylor', '5678901234', 'michael.taylor@email.com', '654 Elm St', '10005', 3);

-- Populate Tourist2 Table
INSERT INTO Tourist2 (City, Zip) VALUES 
('New York', '10001'),
('Boston', '10002'),
('Chicago', '10003'),
('San Francisco', '10004'),
('Miami', '10005');

-- Populate Travels Table
INSERT INTO Travels (Identity_Proof, Time_of_Visit, City_Visited, Date_of_Visit) VALUES 
(1, '10:00:00', 'New York', '2024-01-15'),
(2, '14:30:00', 'Paris', '2024-02-20'),
(3, '09:45:00', 'Tokyo', '2024-03-10'),
(4, '16:15:00', 'Rome', '2024-04-05'),
(5, '11:20:00', 'Sydney', '2024-05-12');

-- Populate Restaurant Table
INSERT INTO Restaurant (Name, Speciality, Rating, Street, Zip, Average_Cost_Per_Person) VALUES 
('Gourmet Delights', 'Italian Cuisine', 4.5, '100 Culinary St', '20001', 50.00),
('Sushi Paradise', 'Japanese Sushi', 4.8, '200 Ocean Blvd', '20002', 75.00),
('Bistro Elegance', 'French Cuisine', 4.3, '300 Riverside Dr', '20003', 65.00),
('Spice Route', 'Indian Cuisine', 4.6, '400 Flavor Ave', '20004', 40.00),
('Pasta Palace', 'Pasta and Pizza', 4.4, '500 Noodle Rd', '20005', 45.00);

-- Populate Restaurants_2 Table
INSERT INTO Restaurants_2 (City, Zip) VALUES 
('New York', '20001'),
('Los Angeles', '20002'),
('Chicago', '20003'),
('San Francisco', '20004'),
('Miami', '20005');

-- Populate Restaurants_3 Table
INSERT INTO Restaurants_3 (Zip, City_Rest_ID) VALUES 
('20001', 1),
('20002', 2),
('20003', 3),
('20004', 4),
('20005', 5);

-- Populate Dines_AT Table
INSERT INTO Dines_AT (Identity_Proof, Restaurant_id) VALUES 
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

-- Populate Food_items Table
INSERT INTO Food_items (Rest_ID, Food_Name, Price) VALUES 
(1, 'Margherita Pizza', 15.99),
(1, 'Lasagna', 18.50),
(2, 'Salmon Sushi Roll', 22.99),
(2, 'Tuna Sashimi', 25.50),
(3, 'Coq au Vin', 24.99),
(3, 'French Onion Soup', 12.50),
(4, 'Butter Chicken', 16.99),
(4, 'Vegetable Biryani', 14.50),
(5, 'Carbonara', 17.99),
(5, 'Seafood Linguine', 21.50);

-- Populate Hotel Table
INSERT INTO Hotel (Name, Contact_Number, Rating, Price_Per_Night, Street, Zip) VALUES 
('Luxury Towers', '555-1234', 4.7, 250.00, '100 Grand Ave', '30001'),
('Seaside Resort', '555-5678', 4.5, 200.00, '200 Beach Rd', '30002'),
('Mountain View Inn', '555-9012', 4.3, 150.00, '300 Pine Trail', '30003'),
('City Center Hotel', '555-3456', 4.6, 180.00, '400 Downtown St', '30004'),
('Riverside Lodge', '555-7890', 4.4, 170.00, '500 River Blvd', '30005');

-- Populate Hotel_2 Table
INSERT INTO Hotel_2 (City, Zip) VALUES 
('New York', '30001'),
('Miami', '30002'),
('Denver', '30003'),
('Chicago', '30004'),
('Seattle', '30005');

-- Populate Hotel_3 Table
INSERT INTO Hotel_3 (Zip, CITY_Hotel_ID) VALUES 
('30001', 1),
('30002', 2),
('30003', 3),
('30004', 4),
('30005', 5);

-- Populate Hotel_Amenities Table
INSERT INTO Hotel_Amenities (Amenity_Hotel_ID, Amenities_Type) VALUES 
(1, 'Swimming Pool'),
(1, 'Gym'),
(2, 'Beach Access'),
(2, 'Spa'),
(3, 'Free Breakfast'),
(3, 'Mountain View'),
(4, 'Conference Room'),
(4, 'Business Center'),
(5, 'River View'),
(5, 'Restaurant');

-- Populate Places_of_attraction Table
INSERT INTO Places_of_attraction (Name, Entry_Fee, Number_of_Visitors, Opening_Hours, Closing_Hours, Street, Zip) VALUES 
('Statue of Liberty', 25.50, 5000000, '09:00:00', '17:00:00', '1 Liberty Island', '40001'),
('Eiffel Tower', 30.75, 7000000, '09:30:00', '23:00:00', 'Champ de Mars', '40002'),
('Tokyo Disneyland', 75.00, 17500000, '08:00:00', '22:00:00', '1-1 Maihama', '40003'),
('Colosseum', 20.50, 6000000, '08:30:00', '19:00:00', 'Piazza del Colosseo', '40004'),
('Sydney Opera House', 40.00, 8500000, '09:00:00', '17:00:00', 'Bennelong Point', '40005');

-- Populate Place_of_Attraction_2 Table
INSERT INTO Place_of_Attraction_2 (City, Zip) VALUES 
('New York', '40001'),
('Paris', '40002'),
('Tokyo', '40003'),
('Rome', '40004'),
('Sydney', '40005');

-- Populate Place_of_Attraction_3 Table
INSERT INTO Place_of_Attraction_3 (City_POA_ID, Zip) VALUES 
(1, '40001'),
(2, '40002'),
(3, '40003'),
(4, '40004'),
(5, '40005');

-- Populate Place_of_Attraction_4 Table
INSERT INTO Place_of_Attraction_4 (Name, Type) VALUES 
('Statue of Liberty', 'Historical Monument'),
('Eiffel Tower', 'Landmark'),
('Tokyo Disneyland', 'Theme Park'),
('Colosseum', 'Ancient Ruins'),
('Sydney Opera House', 'Cultural Center');

-- Populate Transport_Option Table
INSERT INTO Transport_Option (Type, Fare, Start_Location, Destination_Location) VALUES 
('Bus', 15.50, 'Downtown', 'Airport'),
('Train', 25.75, 'Central Station', 'Suburbs'),
('Taxi', 30.00, 'Hotel', 'Tourist Attraction'),
('Shuttle', 20.25, 'Airport', 'City Center'),
('Metro', 5.50, 'Downtown', 'Shopping District');

-- Populate Public_Transport Table
INSERT INTO Public_Transport (Transport_ID, Type, Departure_Time, Destination_Time, Seat_Availability) VALUES 
(1, 'City Bus', '07:00:00', '20:00:00', 50),
(2, 'Metro Train', '05:30:00', '23:30:00', 200),
(3, 'Tourist Bus', '08:15:00', '18:45:00', 30),
(4, 'Commuter Train', '06:00:00', '22:00:00', 150),
(5, 'Airport Shuttle', '05:45:00', '23:15:00', 25);

-- Populate Private_Transport Table
INSERT INTO Private_Transport (Transport_ID, Type, Company, Driver_Name, Price_per_Km) VALUES 
(1, 'Luxury Car', 'City Rides', 'John Smith', 2.50),
(2, 'Minivan', 'Family Tours', 'Emily Davis', 1.75),
(3, 'SUV', 'Comfort Travel', 'Michael Johnson', 3.00),
(4, 'Sedan', 'Premium Drives', 'Sarah Williams', 2.25),
(5, 'Electric Car', 'Green Mobility', 'David Brown', 1.50);

-- Populate Tour_Package Table
INSERT INTO Tour_Package (Identity_Proof, For_City_id, Name, Price, Duration_days) VALUES 
(1, 1, 'New York City Explorer', 1200.50, 5),
(2, 2, 'Paris Romance Package', 1500.75, 6),
(3, 3, 'Tokyo Adventure', 1800.25, 7),
(4, 4, 'Rome Historical Tour', 1100.00, 4),
(5, 5, 'Sydney Coastal Experience', 1300.50, 5);

-- Populate Events_1 Table
INSERT INTO Events_1 (Associated_Attraction_ID, Event_Name, Event_Date, Event_Time) VALUES 
(1, 'Liberty Island Sunset Tour', '2024-06-15', '19:00:00'),
(2, 'Eiffel Tower Light Show', '2024-07-20', '22:30:00'),
(3, 'Disneyland Summer Parade', '2024-08-10', '15:00:00'),
(4, 'Colosseum Night Tour', '2024-09-05', '20:00:00'),
(5, 'Opera House Concert', '2024-10-12', '19:30:00');

-- Populate Events_2 Table
INSERT INTO Events_2 (Associated_Attraction_ID, Event_Name, Price) VALUES 
(1, 'Liberty Island Sunset Tour', 45.50),
(2, 'Eiffel Tower Light Show', 60.75),
(3, 'Disneyland Summer Parade', 75.00),
(4, 'Colosseum Night Tour', 55.25),
(5, 'Opera House Concert', 80.00);

-- Populate Tourist_attends Table
INSERT INTO Tourist_attends (Identity_Proof, Event_id, Place_of_Attraction_ID) VALUES 
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 4),
(5, 5, 5);

-- Populate Restaurant_Package Table
INSERT INTO Restaurant_Package (Package_id, For_rest_id) VALUES 
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

-- Populate Transport_Package Table
INSERT INTO Transport_Package (Package_id, For_Transport_id) VALUES 
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

-- Populate Hotel_Package Table
INSERT INTO Hotel_Package (Package_id, For_Hotel_id) VALUES 
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

-- Populate Place_Attraction_Package Table
INSERT INTO Place_Attraction_Package (Package_id, For_place_id) VALUES 
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);