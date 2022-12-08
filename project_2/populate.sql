-- Inserting values into Sailor

-- Inserting values into Country
INSERT INTO Country (country_name,country_flag,country_iso) VALUES ('Portugal','pt.jpeg','PRT');

-- Inserting values into Location
INSERT INTO Location (location_name, location_longitude, location_latitude, country_name) VALUES ('Porto', 'N39º546.89', 'W008º234.987', 'Portugal');
INSERT INTO Location (location_name, location_longitude, location_latitude, country_name) VALUES ('Lisboa', 'N36º234.08', 'W008º234.987','Portugal');
INSERT INTO Location (location_name, location_longitude, location_latitude, country_name) VALUES ('Viana', 'N39º546.89', 'W008º290.459','Portugal');

-- Inserting values into Boat_Class
INSERT INTO boat_class (boat_class_name, max_length) VALUES ('Class 1', 15);
-- Inserting values into Boat
INSERT INTO Boat (boat_cni, registration_year, boat_class_name, country_name, length) VALUES ('123456789', 1990, 'Class 1', 'Portugal', 10);
INSERT INTO Boat (boat_cni, registration_year, boat_class_name, country_name, length) VALUES ('987654321', 2015, 'Class 2', 'Portugal', 20);
INSERT INTO Boat (boat_cni, registration_year, boat_class_name, country_name, length) VALUES ('123456789', 1990, 'Class 1', 'Portugal', 10);-- supposed to fail
INSERT INTO Boat (boat_cni, registration_year, boat_class_name, country_name, length) VALUES ('123456789', 1663, 'Class 1', 'Espanha', 10);

-- Inserting values into Date_interval
INSERT INTO Date_interval (start_date, end_date) VALUES ('2022-12-01', '2022-12-02');
INSERT INTO Date_interval (start_date, end_date) VALUES ('2022-12-03', '2022-12-04');
INSERT INTO Date_interval (start_date, end_date) VALUES ('2022-12-01', '2022-12-02');-- supposed to fail
INSERT INTO Date_interval (start_date, end_date) VALUES ('2022-12-03', '2022-12-02');-- supposed to fail
INSERT INTO Date_interval (start_date, end_date) VALUES ('2022-12-01', '2022-12-03');

-- Inserting values into Reservation
INSERT INTO Reservation (boat_cni, start_date, end_date, senior_email) VALUES ('123456789', '2022-12-01', '2022-12-02', 'sailor1@email.com');
INSERT INTO Reservation (boat_cni, start_date, end_date, senior_email) VALUES ('987654321', '2022-12-01', '2022-12-02', 'sailor1@email.com');
INSERT INTO Reservation (boat_cni, start_date, end_date, senior_email) VALUES ('123456789', '2022-12-01', '2022-12-02', 'sailor2@email.com');-- supposed to fail

-- Inserting values into Trip
INSERT INTO Trip (trip_take_off, trip_arrival ,trip_insurance,boat_cni,
    start_date,end_date,location_to,location_from,skipper_email) VALUES
    ('2022-12-01','2022-12-02', '123456','123456789','2022-12-01','2022-12-02','Porto','Lisboa','sailor1@email.com');
INSERT INTO Trip (trip_take_off, trip_arrival ,trip_insurance,boat_cni,
    start_date,end_date,location_to,location_from,skipper_email) VALUES
    ('2022-12-12','2022-12-13', '123467','987654321','2022-12-01','2022-12-02','Lisboa','Viana','sailor2@email.com');

