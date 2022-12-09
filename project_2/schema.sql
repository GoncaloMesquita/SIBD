DROP TABLE IF EXISTS Location,Trip,Reservation,
    Boat,Date_interval,Country, Boat_Class, 
    Sailing_Certificate, valid_for,
    Senior, Junior, Sailor, Authorized CASCADE;



CREATE TABLE Boat_Class(
    boat_class_name VARCHAR(80),
    max_length NUMERIC(12,4) NOT NULL,
    PRIMARY KEY(boat_class_name)
);

CREATE TABLE Country(
    country_name VARCHAR(80),
    country_flag VARCHAR(80) NOT NULL,
    country_ISO VARCHAR(80) NOT NULL,
    PRIMARY KEY(country_name),
    UNIQUE(country_flag),
    UNIQUE(country_ISO)
);

CREATE TABLE Boat(
    boat_name VARCHAR(80) NOT NULL,
    boat_cni VARCHAR(80),
    boat_length NUMERIC(5,1) NOT NULL,
    boat_registration_year NUMERIC(4) NOT NULL,
    country_name VARCHAR(80) NOT NULL,
    boat_class_name VARCHAR(80) NOT NULL,

    PRIMARY KEY (boat_cni,country_name),
    FOREIGN KEY (boat_class_name) REFERENCES Boat_Class(boat_class_name) ,
    FOREIGN KEY (country_name) REFERENCES Country(country_name),
    UNIQUE(boat_cni)
);

CREATE TABLE Date_interval(
    start_date DATE,
    end_date DATE,
    PRIMARY KEY (start_date,end_date)

    -- start_date should be before end_date
);

CREATE TABLE Sailor(
    email VARCHAR(254),
    surname VARCHAR(15) NOT NULL,
    first_name VARCHAR(15) NOT NULL,
    PRIMARY KEY(email)
    --A sailor must be a member of either one of the tables 'Junior' or 'Senior'

);

CREATE TABLE Junior(
    email VARCHAR(254),
    PRIMARY KEY (email),
    FOREIGN KEY (email) REFERENCES Sailor(email)
);

CREATE TABLE Senior(
    email VARCHAR(254),
    PRIMARY KEY (email),
    FOREIGN KEY (email) REFERENCES Sailor(email)
);

CREATE TABLE Reservation(
    boat_cni VARCHAR(80),
    start_date DATE,
    end_date DATE,
    sailor_email VARCHAR(80) NOT NULL ,
    PRIMARY KEY (boat_cni,start_date,end_date),
    FOREIGN KEY (start_date,end_date) REFERENCES Date_interval(start_date,end_date),
    FOREIGN KEY (boat_cni) REFERENCES Boat(boat_cni),
    FOREIGN KEY (sailor_email) REFERENCES Senior(email)
    --Every	reservation	must have at least one 'Senior sailor'
    --Every reservation must have at least one 'authorization' from a sailor
    --start_date should be before end_date
);

CREATE TABLE Location(
    location_name VARCHAR(80) NOT NULL ,
    location_latitude VARCHAR(80),
    location_longitude VARCHAR(80),
    country_name VARCHAR(80) NOT NULL,
    PRIMARY KEY (location_latitude,location_longitude),
    FOREIGN KEY (country_name) REFERENCES Country(country_name),
    UNIQUE(location_name)
    -- Any two locations must be at least one nautical mile apart
);

CREATE TABLE Trip(
    trip_arrival DATE,
    trip_take_off DATE,
    trip_insurance VARCHAR(80) NOT NULL,
    boat_cni VARCHAR(80),
    start_date DATE,
    end_date DATE,

    location_to VARCHAR(80) NOT NULL,
    location_from VARCHAR(80) NOT NULL,
    skipper_email VARCHAR(80) NOT NULL,

    PRIMARY KEY (boat_cni,end_date,
                 start_date,trip_take_off),

    FOREIGN KEY (boat_cni,start_date,end_date)
        REFERENCES Reservation(boat_cni,start_date,
                               end_date),

    FOREIGN KEY (location_to) REFERENCES Location(location_name),
    FOREIGN KEY (location_from) REFERENCES Location(location_name),
    FOREIGN KEY (skipper_email) REFERENCES Sailor(email)

    -- A boat can not take off on a trip before the reservation start date.
    -- The skipper must be an authorized sailor of the corresponding reservation.
    -- A boat can not take off on a trip before the reservation start date.
    -- start_date should be before end_date
    -- trip_take_off should be before trip_arrival
);

CREATE TABLE Sailing_Certificate(
    boat_class_name VARCHAR(80) NOT NULL,
    email VARCHAR(80) NOT NULL,
    issue_date DATE NOT NULL,
    expiry_date DATE NOT NULL,
    PRIMARY KEY(email, issue_date,boat_class_name),
    FOREIGN KEY(email) REFERENCES Sailor(email),
    FOREIGN KEY(boat_class_name) REFERENCES Boat_Class(boat_class_name),
    UNIQUE (email, issue_date,boat_class_name)
    --every certificate must exist in the table valid_for
    --issue_date should be before expiry_date
);

CREATE TABLE valid_for(
    country_name VARCHAR(80) NOT NULL,
    issue_date DATE NOT NULL,
    sailor_email VARCHAR(80) NOT NULL,
    boat_class_name VARCHAR(80) NOT NULL,

    PRIMARY KEY(country_name, issue_date, sailor_email,boat_class_name),

    FOREIGN KEY(country_name) REFERENCES Country(country_name),
    FOREIGN KEY(sailor_email,issue_date,boat_class_name) REFERENCES Sailing_Certificate(email,issue_date,boat_class_name)
);


CREATE TABLE Authorized(
    email VARCHAR(254),
    boat_cni VARCHAR(80),
    start_date DATE,
    end_date DATE,
    PRIMARY KEY (email, boat_cni, start_date,end_date),
    FOREIGN KEY (email) REFERENCES Sailor(email),
    FOREIGN KEY (boat_cni, start_date,end_date) REFERENCES Reservation(boat_cni, start_date,end_date)
    --start_date should be before end_date
);
