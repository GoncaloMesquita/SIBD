DROP TABLE IF EXISTS Boat_Class CASCADE;
DROP TABLE IF EXISTS Country CASCADE;
DROP TABLE IF EXISTS Boat CASCADE;
DROP TABLE IF EXISTS Date_interval CASCADE;
DROP TABLE IF EXISTS Sailor CASCADE;
DROP TABLE IF EXISTS Junior CASCADE;
DROP TABLE IF EXISTS Senior CASCADE;
DROP TABLE IF EXISTS Reservation CASCADE;
DROP TABLE IF EXISTS Location CASCADE;
DROP TABLE IF EXISTS Trip CASCADE;
DROP TABLE IF EXISTS Sailing_Certificate CASCADE;
DROP TABLE IF EXISTS valid_for CASCADE;
DROP TABLE IF EXISTS "Authorization" CASCADE;



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
    boat_cni VARCHAR(80),
    length INTEGER NOT NULL,
    registration_year NUMERIC(4) NOT NULL,
    country_name VARCHAR(80) NOT NULL,
    boat_class_name VARCHAR(80) NOT NULL,

    PRIMARY KEY (boat_cni,country_name),
    FOREIGN KEY (boat_class_name) REFERENCES Boat_Class(boat_class_name) ,
    FOREIGN KEY (country_name) REFERENCES Country(country_name),
    UNIQUE(boat_cni)
);

CREATE TABLE Date_interval(
    date_start DATE,
    date_end DATE,
    PRIMARY KEY (date_start,date_end)
);

CREATE TABLE Sailor(
    email VARCHAR(254),
    surname VARCHAR(15) NOT NULL,
    first_name VARCHAR(15) NOT NULL,
    PRIMARY KEY(email)
    --No sailor can exist at the same time in both tables 'Junior' and 'Senior'.
    --
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
    date_start DATE,
    date_end DATE,
    responsible_for VARCHAR(80) NOT NULL ,
    PRIMARY KEY (boat_cni,date_start,date_end),
    FOREIGN KEY (date_start,date_end) REFERENCES Date_interval(date_start,date_end),
    FOREIGN KEY (boat_cni) REFERENCES Boat(boat_cni),
    FOREIGN KEY (responsible_for) REFERENCES Senior(email)
    --Every	reservation	must have at least one 'Senior sailor'
    --Every reservation must have at least one 'authorization' from a sailor
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
    date_start DATE,
    date_end DATE,

    location_to VARCHAR(80) NOT NULL,
    location_from VARCHAR(80) NOT NULL,
    skipper_email VARCHAR(80) NOT NULL,

    PRIMARY KEY (boat_cni,date_end,
                 date_start,trip_take_off),

    FOREIGN KEY (boat_cni,date_start,date_end)
        REFERENCES Reservation(boat_cni,date_start,
                               date_end),

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


CREATE TABLE "Authorization" (
    email VARCHAR(254),
    boat_cni VARCHAR(80),
    date_start DATE,
    date_end DATE,
    PRIMARY KEY (email, boat_cni, date_start,date_end),
    FOREIGN KEY (email) REFERENCES Sailor(email),
    FOREIGN KEY (boat_cni, date_start,date_end) REFERENCES Reservation(boat_cni, date_start,date_end)
);

INSERT INTO Country (country_name,country_flag,country_iso) VALUES ('Portugal','pt.jpeg','PRT');
INSERT INTO Country (country_name,country_flag,country_iso) VALUES ('Espanha','esp.jpeg','ESP');

-- Inserting values into Location
INSERT INTO Location (location_name, location_longitude, location_latitude, country_name) VALUES ('Porto', 'N39º546.89', 'W008º234.987', 'Portugal');
INSERT INTO Location (location_name, location_longitude, location_latitude, country_name) VALUES ('Lisboa', 'N36º234.08', 'W008º234.987','Portugal');
INSERT INTO Location (location_name, location_longitude, location_latitude, country_name) VALUES ('Viana', 'N39º546.89', 'W008º290.459','Portugal');

-- Inserting values into Boat_Class
INSERT INTO boat_class (boat_class_name, max_length) VALUES ('Class 1', 15);

-- Inserting values into Boat
INSERT INTO Boat (boat_cni, registration_year, boat_class_name, country_name, length) VALUES ('123456789', 1990, 'Class 1', 'Portugal', 10);
INSERT INTO Boat (boat_cni, registration_year, boat_class_name, country_name, length) VALUES ('987654321', 1663, 'Class 1', 'Espanha', 20);
--INSERT INTO Boat (boat_cni, registration_year, boat_class_name, country_name, length) VALUES ('987654321', 2015, 'Class 2', 'Portugal', 20);

-- Inserting values into Sailor

INSERT INTO Sailor (email, surname, first_name) VALUES ('joaosilva@gmail.com', 'Silva', 'João');
--INSERT INTO Sailor (email, surname, first_name) VALUES ('joaosilva@gmail.com', 'Gama', 'Vasco'); -- supposed not to work
INSERT INTO Sailor (email, surname, first_name) VALUES ('pedrocabral@gmail.com', 'Cabral', 'Pedro');
INSERT INTO Sailor (email, surname, first_name) VALUES ('vascogama@gmail.com', 'Gama', 'Vasco');
INSERT INTO Sailor (email, surname, first_name) VALUES ('diogocao@gmail.com', 'Cão', 'Diogo');

-- Inserting the sailor into Senior or Junior

INSERT INTO Senior (email) VALUES ('pedrocabral@gmail.com');
INSERT INTO Senior (email) VALUES ('vascogama@gmail.com');
INSERT INTO Senior (email) VALUES ('diogocao@gmail.com');
INSERT INTO Junior (email) VALUES ('joaosilva@gmail.com');
--INSERT INTO Senior (email) VALUES ('fasdsaf@gmail.com'); -- Supposed not to work, theres is no sailor with this email

-- Inserting values into Date_interval

INSERT INTO Date_interval (date_start, date_end) VALUES ('2022-12-01', '2022-12-02');
INSERT INTO Date_interval (date_start, date_end) VALUES ('2022-12-03', '2022-12-04');
INSERT INTO Date_interval (date_start, date_end) VALUES ('2022-12-01', '2022-12-03');

-- Inserting values into Reservation
INSERT INTO Reservation (boat_cni, date_start, date_end, responsible_for) VALUES ('123456789', '2022-12-01', '2022-12-02', 'pedrocabral@gmail.com');
INSERT INTO Reservation (boat_cni, date_start, date_end, responsible_for) VALUES ('987654321', '2022-12-01', '2022-12-02', 'diogocao@gmail.com');
INSERT INTO Reservation (boat_cni, date_start, date_end, responsible_for) VALUES ('123456789', '2022-12-03', '2022-12-04', 'vascogama@gmail.com');
INSERT INTO Reservation (boat_cni, date_start, date_end, responsible_for) VALUES ('123456789', '2022-12-01', '2022-12-03', 'pedrocabral@gmail.com');

-- Inserting Sailor in the reservation

INSERT INTO "Authorization" (email, boat_cni, date_start, date_end)  VALUES  ('pedrocabral@gmail.com','123456789', '2022-12-01', '2022-12-02');
INSERT INTO "Authorization" (email, boat_cni, date_start, date_end)  VALUES  ('joaosilva@gmail.com','987654321', '2022-12-01', '2022-12-02');
INSERT INTO "Authorization" (email, boat_cni, date_start, date_end)  VALUES  ('diogocao@gmail.com','123456789', '2022-12-03', '2022-12-04');
INSERT INTO "Authorization" (email, boat_cni, date_start, date_end)  VALUES  ('diogocao@gmail.com','123456789', '2022-12-01', '2022-12-03');

-- Inserting values into Trip

INSERT INTO Trip (trip_take_off, trip_arrival ,trip_insurance,boat_cni,date_start,date_end,location_to,location_from,skipper_email) VALUES
    ('2022-12-01','2022-12-02', '123456','123456789','2022-12-01','2022-12-02','Porto','Lisboa','pedrocabral@gmail.com');
INSERT INTO Trip (trip_take_off, trip_arrival ,trip_insurance,boat_cni,date_start,date_end,location_to,location_from,skipper_email) VALUES
    ('2022-12-12','2022-12-13', '123467','987654321','2022-12-01','2022-12-02','Lisboa','Viana','vascogama@gmail.com');

-- Inserting Sailing Certification to each sailor

INSERT INTO Sailing_Certificate(boat_class_name, email, issue_date, expiry_date)  VALUES ('Class 1', 'pedrocabral@gmail.com', '2015-11-08','2025-11-08' );
INSERT INTO Sailing_Certificate(boat_class_name, email, issue_date, expiry_date)  VALUES ('Class 1', 'vascogama@gmail.com', '2014-11-08','2024-11-08' );
INSERT INTO Sailing_Certificate(boat_class_name, email, issue_date, expiry_date)  VALUES ('Class 1', 'joaosilva@gmail.com', '2018-11-08','2028-11-08' );
INSERT INTO Sailing_Certificate(boat_class_name, email, issue_date, expiry_date)  VALUES ('Class 1', 'diogocao@gmail.com', '2016-11-08','2026-11-08' );
