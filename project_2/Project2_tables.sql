DROP TABLE IF EXISTS Trip,Reservation,Location,
    Boat,Date_interval,Country, Boat_Class,
    Sailing_Certificate, valid_for,
    Senior, Junior, Sailor,Authorized;

CREATE TABLE Boat_Class(
    boat_class_name VARCHAR(80),
    max_length NUMERIC(12,4) NOT NULL,
    PRIMARY KEY(boat_class_name)
);

CREATE TABLE Country(
    country_name VARCHAR(80),
    country_flag VARCHAR(80) NOT NULL,
    country_ISO INTEGER,
    PRIMARY KEY(country_name),
    UNIQUE(country_flag),
    UNIQUE(country_ISO)
);

CREATE TABLE Boat(
    boat_cni VARCHAR(80),
    length INTEGER NOT NULL,
    registration_year DATE NOT NULL,
    country_name VARCHAR(80) NOT NULL,
    boat_class_name VARCHAR(80) NOT NULL,

    PRIMARY KEY (boat_cni,country_name),
    FOREIGN KEY (boat_class_name) REFERENCES Boat_Class(boat_class_name) ,
    FOREIGN KEY (country_name) REFERENCES Country(country_name),
    UNIQUE(boat_cni)
);

CREATE TABLE Date_interval(
    date_inter_start DATE,
    date_inter_end DATE,
    PRIMARY KEY (date_inter_start,date_inter_end)
);

CREATE TABLE Sailor(
    email VARCHAR(254),
    surname VARCHAR(15) NOT NULL,
    first_name VARCHAR(15) NOT NULL,
    PRIMARY KEY(email)
    --No sailor can exist at the same time in both tables 'Junior' and 'Senior'
);

CREATE TABLE Junior(
    email VARCHAR(254),
    PRIMARY KEY( email),
    FOREIGN KEY (email) REFERENCES Sailor(email)
);

CREATE TABLE Senior(
    email VARCHAR(254),
    PRIMARY KEY( email),
    FOREIGN KEY (email) REFERENCES Sailor(email)
);

CREATE TABLE Reservation(
    boat_cni VARCHAR(80),
    date_inter_start DATE,
    date_inter_end DATE,
    responsible_for VARCHAR(80) NOT NULL ,
    PRIMARY KEY (boat_cni,date_inter_start,date_inter_end),
    FOREIGN KEY (date_inter_start,date_inter_end) REFERENCES Date_interval(date_inter_start,date_inter_end),
    FOREIGN KEY (boat_cni) REFERENCES Boat(boat_cni),
    FOREIGN KEY (responsible_for) REFERENCES Senior(email)
    --Every	reservation	must have at least one 'sailor'
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
    date_inter_start DATE,
    date_inter_end DATE,

    location_to VARCHAR(80) NOT NULL,
    location_from VARCHAR(80) NOT NULL,
    skipper_email VARCHAR(80) NOT NULL,

    PRIMARY KEY (boat_cni,date_inter_end,
                 date_inter_start,trip_take_off),

    FOREIGN KEY (boat_cni,date_inter_start,date_inter_end)
        REFERENCES Reservation(boat_cni,date_inter_start,
                               date_inter_end),

    FOREIGN KEY (location_to) REFERENCES Location(location_name),
    FOREIGN KEY (location_from) REFERENCES Location(location_name),
    FOREIGN KEY (skipper_email) REFERENCES Sailor(email)

    -- A boat can not take off on a trip before the reservation start date.
    -- The skipper must be an authorized sailor of the corresponding reservation.
    -- A boat can not take off on a trip before the reservation start date.
);

CREATE TABLE Sailing_Certificate(
    boat_class_name VARCHAR(80) NOT NULL,
    email VARCHAR(80) NOT NULL,
    issue_date DATE NOT NULL,
    expiry_date DATE NOT NULL,
    PRIMARY KEY(email, issue_date),
    --uncomment when sailor table is done
    FOREIGN KEY(email) REFERENCES Sailor(email),
    FOREIGN KEY(boat_class_name) REFERENCES Boat_Class(boat_class_name),
    UNIQUE(issue_date)
    --every certificate must exist in the table valid_for
);

CREATE TABLE valid_for(
    country_name VARCHAR(80) NOT NULL,
    issue_date DATE NOT NULL,
    sailor_email VARCHAR(80) NOT NULL,
    boat_class_name VARCHAR(80) NOT NULL,

    PRIMARY KEY(country_name, issue_date, sailor_email,boat_class_name),

    FOREIGN KEY(country_name) REFERENCES Country(country_name),
    FOREIGN KEY(issue_date) REFERENCES Sailing_Certificate(issue_date),
    FOREIGN KEY(boat_class_name) REFERENCES Boat_Class(boat_class_name),
    --uncomment after sailor is defined
    FOREIGN KEY(sailor_email) REFERENCES sailor(email)
);


CREATE TABLE Authorized(
    email VARCHAR(254),
    boat_cni VARCHAR(80),
    date_inter_start DATE,
    date_inter_end DATE,
    PRIMARY KEY (email, boat_cni, date_inter_start,date_inter_end),
    FOREIGN KEY (email) REFERENCES Sailor(email),
    FOREIGN KEY (boat_cni, date_inter_start,date_inter_end) REFERENCES Reservation(boat_cni, date_inter_start,date_inter_end)
);
