-- Insert into Country
INSERT INTO Country (country_name,country_flag,country_iso) VALUES ('Portugal','pt_flag','PRT');
INSERT INTO Country (country_name,country_flag,country_iso) VALUES ('Espanha','esp_flag','ESP');







-- Inserting values into Location
INSERT INTO Location (location_name, location_longitude, location_latitude, country_name) VALUES ('Porto', 'N39º546.89', 'W008º234.987', 'Portugal');
INSERT INTO Location (location_name, location_longitude, location_latitude, country_name) VALUES ('Lisboa', 'N36º234.08', 'W008º234.987','Portugal');
INSERT INTO Location (location_name, location_longitude, location_latitude, country_name) VALUES ('Viana', 'N39º546.89', 'W008º290.459','Portugal');





-- Inserting values into Boat_Class
INSERT INTO boat_class (boat_class_name, max_length) VALUES ('Class 1', 15);



-- Inserting values into Boat
INSERT INTO Boat (boat_cni, boat_registration_year, boat_class_name, country_name, boat_length ,boat_name) VALUES ('123456789', 1990, 'Class 1', 'Portugal', 10, 'barco 1');
INSERT INTO Boat (boat_cni, boat_registration_year, boat_class_name, country_name, boat_length, boat_name) VALUES ('987654321', 1663, 'Class 1', 'Espanha', 20, 'Titanic');
INSERT INTO Boat (boat_cni, boat_registration_year, boat_class_name, country_name, boat_length, boat_name) VALUES ('123490312', 1663, 'Class 1', 'Portugal', 20, 'barco 2');





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

INSERT INTO Date_interval (start_date, end_date) VALUES ('2022-12-01', '2022-12-02');
INSERT INTO Date_interval (start_date, end_date) VALUES ('2022-12-03', '2022-12-04');
INSERT INTO Date_interval (start_date, end_date) VALUES ('2022-12-01', '2022-12-03');





-- Inserting values into Reservation
INSERT INTO Reservation (boat_cni, start_date, end_date, responsible_for) VALUES ('123456789', '2022-12-01', '2022-12-02', 'pedrocabral@gmail.com');
INSERT INTO Reservation (boat_cni, start_date, end_date, responsible_for) VALUES ('987654321', '2022-12-01', '2022-12-02', 'diogocao@gmail.com');
INSERT INTO Reservation (boat_cni, start_date, end_date, responsible_for) VALUES ('123456789', '2022-12-03', '2022-12-04', 'vascogama@gmail.com');
INSERT INTO Reservation (boat_cni, start_date, end_date, responsible_for) VALUES ('123456789', '2022-12-01', '2022-12-03', 'pedrocabral@gmail.com');




-- Inserting Sailor in the reservation

INSERT INTO Authorized (email, boat_cni, start_date, end_date)  VALUES  ('pedrocabral@gmail.com','123456789', '2022-12-01', '2022-12-02');
INSERT INTO Authorized (email, boat_cni, start_date, end_date)  VALUES  ('joaosilva@gmail.com','987654321', '2022-12-01', '2022-12-02');
INSERT INTO Authorized (email, boat_cni, start_date, end_date)  VALUES  ('diogocao@gmail.com','123456789', '2022-12-03', '2022-12-04');
INSERT INTO Authorized (email, boat_cni, start_date, end_date)  VALUES  ('diogocao@gmail.com','123456789', '2022-12-01', '2022-12-03');




-- Inserting values into Trip

INSERT INTO Trip (trip_take_off, trip_arrival ,trip_insurance,boat_cni,start_date,end_date,location_to,location_from,skipper_email) VALUES
    ('2022-12-01','2022-12-02', '123456','123456789','2022-12-01','2022-12-02','Porto','Lisboa','pedrocabral@gmail.com');
INSERT INTO Trip (trip_take_off, trip_arrival ,trip_insurance,boat_cni,start_date,end_date,location_to,location_from,skipper_email) VALUES
    ('2022-12-12','2022-12-13', '123467','987654321','2022-12-01','2022-12-02','Lisboa','Viana','vascogama@gmail.com');

-- Inserting Sailing Certification to each sailor

INSERT INTO Sailing_Certificate(boat_class_name, email, issue_date, expiry_date)  VALUES ('Class 1', 'pedrocabral@gmail.com', '2015-11-08','2025-11-08' );
INSERT INTO Sailing_Certificate(boat_class_name, email, issue_date, expiry_date)  VALUES ('Class 1', 'vascogama@gmail.com', '2014-11-08','2024-11-08' );
INSERT INTO Sailing_Certificate(boat_class_name, email, issue_date, expiry_date)  VALUES ('Class 1', 'joaosilva@gmail.com', '2018-11-08','2028-11-08' );
INSERT INTO Sailing_Certificate(boat_class_name, email, issue_date, expiry_date)  VALUES ('Class 1', 'diogocao@gmail.com', '2016-11-08','2026-11-08' );