DROP TABLE IF EXISTS Location,Trip,Reservation,
    Boat,Date_interval,Country, Boat_Class, Sailing_Certificate CASCADE ;

CREATE TABLE Boat_Class(
    name VARCHAR(80),
    max_length NUMERIC(12,4) NOT NULL,
    PRIMARY KEY(name)
);

CREATE TABLE Country(
    name VARCHAR(80),
    flag VARCHAR(80) NOT NULL,
    ISO_code INTEGER,
    PRIMARY KEY(name),
    UNIQUE(flag),
    UNIQUE(ISO_code)
);

CREATE TABLE Boat(
    boat_cni VARCHAR(80),
    name VARCHAR(80) NOT NULL,
    length INTEGER NOT NULL,
    registration_year DATE NOT NULL,
    country_name VARCHAR(80) NOT NULL,
    boat_class_name VARCHAR(80) NOT NULL,

    PRIMARY KEY (boat_cni,country_name),
    FOREIGN KEY (boat_class_name) REFERENCES Boat_Class(name),
    FOREIGN KEY (country_name) REFERENCES Country(name),
    UNIQUE(boat_cni)
);

CREATE TABLE Date_interval(
    date_inter_start DATE,
    date_inter_end DATE,
    PRIMARY KEY (date_inter_start,date_inter_end)
);

CREATE TABLE Reservation(
    boat_cni VARCHAR(80),
    date_inter_start DATE,
    date_inter_end DATE,
    PRIMARY KEY (boat_cni,date_inter_start,date_inter_end),
    FOREIGN KEY (date_inter_start,date_inter_end) REFERENCES Date_interval(date_inter_start,date_inter_end),
    FOREIGN KEY (boat_cni) REFERENCES Boat(boat_cni)
);

CREATE TABLE Location(
    location_name VARCHAR(80) NOT NULL ,
    location_latitude VARCHAR(80),
    location_longitude VARCHAR(80),
    country_name VARCHAR(80) NOT NULL,
    PRIMARY KEY (location_latitude,location_longitude),
    FOREIGN KEY (country_name) REFERENCES Country(name),
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
    FOREIGN KEY (location_from) REFERENCES Location(location_name)
    --FOREIGN KEY (skipper_email) REFERENCES Sailor(sailor_email)

    -- A boat can not take off on a trip before the reservation start date.
    -- The skipper must be an authorized sailor of the corresponding reservation.
    -- A boat can not take off on a trip before the reservation start date.
);

CREATE TABLE Sailing_Certificate(
    boat_name VARCHAR(80) NOT NULL,
    email VARCHAR(80) NOT NULL,
    issue_date DATE NOT NULL,
    expiry_date DATE NOT NULL,
    PRIMARY KEY(email, issue_date),
    --uncomment when sailor table is done
    --FOREIGN KEY(email) REFERENCES Sailor(email),
    FOREIGN KEY(boat_name) REFERENCES Boat_Class(name),
    UNIQUE(issue_date)
    --every certificate must exist in the table valid_for
);

--There is an error in this table
CREATE TABLE valid_for(
    country_name VARCHAR(80) NOT NULL,
    issue_date DATE NOT NULL,
    sailor_email VARCHAR(80) NOT NULL,
    PRIMARY KEY(country_name, issue_date, sailor_email),
    FOREIGN KEY(country_name) REFERENCES Country(name),
    FOREIGN KEY(issue_date) REFERENCES Sailing_Certificate(issue_date),
    --uncomment after sailor is defined
    --FOREIGN KEY(sailor_email) REFERENCES sailor(email),
);