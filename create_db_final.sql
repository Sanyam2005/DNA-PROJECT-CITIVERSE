-- Table: Tourist
CREATE TABLE Tourist (
    Identity_Proof INT AUTO_INCREMENT PRIMARY KEY, -- Use INT for auto-increment
    First_Name VARCHAR(50),
    Middle_Name VARCHAR(50),
    Last_Name VARCHAR(50),
    Phone_Number VARCHAR(15),
    Email_Id VARCHAR(100),
    Street VARCHAR(100),
    Zip VARCHAR(10) UNIQUE, -- Make Zip UNIQUE to reference it as a foreign key
    Tourist_hotel_id INT,
    Mentor_id INT,
    FOREIGN KEY (Mentor_id) REFERENCES Tourist (Identity_Proof), -- Proper self-reference
    CHECK (Phone_Number REGEXP '^[0-9]{10}$'), -- Ensures exactly 10 digits in the phone number
    CHECK (Email_Id REGEXP '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$') -- Ensures email format
);

-- Table: Tourist2 (Reference Zip from Tourist)
CREATE TABLE Tourist2 (
    City VARCHAR(50),
    Zip VARCHAR(10),
    PRIMARY KEY (Zip),
    FOREIGN KEY (Zip) REFERENCES Tourist (Zip) ON DELETE CASCADE
);

-- Table: Travels
CREATE TABLE Travels (
    Identity_Proof INT,
    Time_of_Visit TIME,
    City_Visited VARCHAR(50),
    Date_of_Visit DATE,
    PRIMARY KEY(Identity_Proof, Time_of_Visit, City_Visited, Date_of_Visit),
    FOREIGN KEY (Identity_Proof) REFERENCES Tourist(Identity_Proof) ON DELETE CASCADE
);

-- Table: Restaurant
CREATE TABLE Restaurant (
    Restaurant_ID INT PRIMARY KEY AUTO_INCREMENT UNIQUE,
    Name VARCHAR(100),
    Speciality VARCHAR(100),
    Rating FLOAT,
    Street VARCHAR(100),
    Zip VARCHAR(100) UNIQUE,
    Average_Cost_Per_Person DECIMAL(10, 2)
);

-- Table: Restaurants_2
CREATE TABLE Restaurants_2 (
    City VARCHAR(50),
    Zip VARCHAR(10),
    PRIMARY KEY (Zip),
    FOREIGN KEY (Zip) REFERENCES Restaurant(Zip) ON DELETE CASCADE
);

-- Table: Restaurants_3
CREATE TABLE Restaurants_3 (
    Zip VARCHAR(50),
    City_Rest_ID INT,
    PRIMARY KEY (Zip),
    FOREIGN KEY (Zip) REFERENCES Restaurant(Zip) ON DELETE CASCADE
);

-- Table: Dines_AT
CREATE TABLE Dines_AT (
    Identity_Proof INT,
    Restaurant_id INT,
    PRIMARY KEY(Identity_Proof, Restaurant_id),
    FOREIGN KEY (Identity_Proof) REFERENCES Tourist(Identity_Proof) ON DELETE CASCADE
);

-- Table: Food_items
CREATE TABLE Food_items(
    Rest_ID INT,
    Food_Name VARCHAR(100),
    Price DECIMAL(10, 2),
    PRIMARY KEY(Rest_ID, Food_Name),
    FOREIGN KEY(Rest_ID) REFERENCES Restaurant(Restaurant_ID) ON DELETE CASCADE
);

-- Table: Hotel
CREATE TABLE Hotel (
    Hotel_ID INT PRIMARY KEY AUTO_INCREMENT UNIQUE,
    Name VARCHAR(100),
    Contact_Number VARCHAR(15),
    Rating FLOAT,
    Price_Per_Night DECIMAL(10, 2),
    Street VARCHAR(100),
    Zip VARCHAR(10) UNIQUE
);

-- Table: Hotel_2
CREATE TABLE Hotel_2 (
    City VARCHAR(50),
    Zip VARCHAR(10),
    PRIMARY KEY (Zip),
    FOREIGN KEY (Zip) REFERENCES Hotel(Zip) ON DELETE CASCADE
);

-- Table: Hotel_3
CREATE TABLE Hotel_3 (
    Zip VARCHAR(10),
    CITY_Hotel_ID INT,
    PRIMARY KEY (Zip),
    FOREIGN KEY (Zip) REFERENCES Hotel(Zip) ON DELETE CASCADE
);

-- Table: Hotel_Amenities
CREATE TABLE Hotel_Amenities (
    Amenity_Hotel_ID INT,
    Amenities_Type VARCHAR(100),
    PRIMARY KEY(Amenity_Hotel_ID, Amenities_Type),
    FOREIGN KEY (Amenity_Hotel_ID) REFERENCES Hotel(Hotel_ID) ON DELETE CASCADE
);

-- Table: Restaurant_Package
CREATE TABLE Restaurant_Package (
    Package_id INT,
    For_rest_id INT,
    PRIMARY KEY(Package_ID, For_Rest_ID),
    FOREIGN KEY(For_rest_ID) REFERENCES Restaurant(Restaurant_ID) ON DELETE CASCADE
);

CREATE TABLE Cities (
    City_id INT PRIMARY KEY AUTO_INCREMENT UNIQUE,
    City_name VARCHAR(50),
    Country_name VARCHAR(50)
);
CREATE TABLE Tour_Package (
    Package_id INT AUTO_INCREMENT UNIQUE,
    Identity_Proof INT, 
    For_City_id INT,
    Name VARCHAR(100),
    Price DECIMAL(10, 2),
    Duration_days INT,
    PRIMARY KEY (Package_id),  -- Package_id as the primary key
    UNIQUE (Identity_Proof, Package_id),  -- Add unique constraint for Identity_Proof and Package_id
    FOREIGN KEY (For_City_id) REFERENCES Cities (City_id) ON DELETE CASCADE,
    FOREIGN KEY (Identity_Proof) REFERENCES Tourist (Identity_Proof) ON DELETE CASCADE
);
-- Table: Cities

-- Table: Places_of_attraction
CREATE TABLE Places_of_attraction (
    Place_ID INT PRIMARY KEY AUTO_INCREMENT UNIQUE,
    Name VARCHAR(100) UNIQUE,
    Entry_Fee DECIMAL(10, 2),
    Number_of_Visitors INT,
    Opening_Hours TIME,
    Closing_Hours TIME,
    Street VARCHAR(100),
    Zip VARCHAR(10) UNIQUE
);

-- Table: Place_of_Attraction_2
CREATE TABLE Place_of_Attraction_2 (
    City VARCHAR(50),
    Zip VARCHAR(10),
    PRIMARY KEY (Zip),
    FOREIGN KEY (Zip) REFERENCES Places_of_attraction (Zip) ON DELETE CASCADE
);

-- Table: Place_of_Attraction_3
CREATE TABLE Place_of_Attraction_3 (
    City_POA_ID INT,
    Zip VARCHAR(10),
    PRIMARY KEY (Zip),
    FOREIGN KEY (Zip) REFERENCES Places_of_attraction (Zip) ON DELETE CASCADE
);

-- Table: Place_of_Attraction_4
CREATE TABLE Place_of_Attraction_4 (
    Name VARCHAR(100) PRIMARY KEY,
    Type VARCHAR(50),
    FOREIGN KEY (Name) REFERENCES Places_of_attraction (Name) ON DELETE CASCADE
);

-- Table: Place_Attraction_Package
CREATE TABLE Place_Attraction_Package (
    Package_id INT UNIQUE,
    For_place_id INT,
    PRIMARY KEY(Package_id, For_place_id),
    FOREIGN KEY (For_place_id) REFERENCES Places_of_attraction (Place_ID) ON DELETE CASCADE
    -- FOREIGN KEY (Package_id) REFERENCES Tour_Package (Package_id) ON DELETE CASCADE
);

-- Table: Transport_Option
CREATE TABLE Transport_Option (
    Transport_ID INT  PRIMARY KEY AUTO_INCREMENT UNIQUE,
    Type VARCHAR(50),
    Fare DECIMAL(10, 2),
    Start_Location VARCHAR(100),
    Destination_Location VARCHAR(100)
);

-- Table: Public_Transport
CREATE TABLE Public_Transport (
    Transport_ID INT PRIMARY KEY AUTO_INCREMENT UNIQUE,
    Type VARCHAR(50),
    Departure_Time TIME,
    Destination_Time TIME,
    Seat_Availability INT,
    FOREIGN KEY (Transport_ID) REFERENCES Transport_Option (Transport_ID) ON DELETE CASCADE
);

-- Table: Private_Transport
CREATE TABLE Private_Transport (
    Transport_ID INT PRIMARY KEY AUTO_INCREMENT UNIQUE,
    Type VARCHAR(50),
    Company VARCHAR(100),
    Driver_Name VARCHAR(100),
    Price_per_Km DECIMAL(10, 2),
    FOREIGN KEY (Transport_ID) REFERENCES Transport_Option (Transport_ID) ON DELETE CASCADE
);

-- Table: Transport_Package
CREATE TABLE Transport_Package (
    Package_id INT PRIMARY KEY,
    For_Transport_id INT,
    FOREIGN KEY (For_Transport_id) REFERENCES Transport_Option (Transport_ID) ON DELETE CASCADE
    -- FOREIGN KEY (Package_id) REFERENCES Tour_Package (Package_id) ON DELETE CASCADE
);

-- Table: Hotel_Package
CREATE TABLE Hotel_Package (
    Package_id INT,
    For_Hotel_id INT,
    PRIMARY KEY (Package_id, For_Hotel_id),
    FOREIGN KEY (For_Hotel_id) REFERENCES Hotel (Hotel_ID) ON DELETE CASCADE
    -- FOREIGN KEY (Package_id) REFERENCES Tour_Package (Package_id) ON DELETE CASCADE
);


-- Table: EVENTS_1
CREATE TABLE Events_1 (
    Associated_Attraction_ID INT,
    Event_Name VARCHAR(100),
    Event_Date DATE,
    Event_Time TIME,
    PRIMARY KEY (Associated_Attraction_ID, Event_Date, Event_Name, Event_Time),
    FOREIGN KEY (Associated_Attraction_ID) REFERENCES Places_of_attraction (Place_ID) ON DELETE CASCADE
);

CREATE TABLE Events_2 (
    Associated_Attraction_ID INT,
    Event_Name VARCHAR(100),
    Price DECIMAL(10, 2),
    PRIMARY KEY (Associated_Attraction_ID, Event_Name),
    FOREIGN KEY (Associated_Attraction_ID) REFERENCES Places_of_attraction (Place_ID) ON DELETE CASCADE
);

-- Table: Tourist_attends
CREATE TABLE Tourist_attends (
    Identity_Proof INT,
    Event_id INT,
    Place_of_Attraction_ID INT,
    PRIMARY KEY (Identity_Proof, Event_id, Place_of_Attraction_ID),
    FOREIGN KEY (Identity_Proof) REFERENCES Tourist (Identity_Proof) ON DELETE CASCADE,
    FOREIGN KEY (Event_id) REFERENCES Events_1 (Associated_Attraction_ID) ON DELETE CASCADE,
    FOREIGN KEY (Place_of_Attraction_ID) REFERENCES Places_of_attraction (Place_ID) ON DELETE CASCADE
);
