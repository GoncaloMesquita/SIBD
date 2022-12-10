-- Insert into Country
INSERT INTO Country (country_name,country_flag,country_iso) VALUES ('Portugal','pt_flag','PRT');
INSERT INTO Country (country_name,country_flag,country_iso) VALUES ('Spain','esp_flag','ESP');
INSERT INTO Country (country_name,country_flag,country_iso) VALUES ('France','fr_flag','FRA');
INSERT INTO Country (country_name,country_flag,country_iso) VALUES ('Italy','it_flag','ITA');
INSERT INTO Country (country_name,country_flag,country_iso) VALUES ('Germany','de_flag','DEU');
INSERT INTO Country (country_name,country_flag,country_iso) VALUES ('England','uk_flag','GBR');
INSERT INTO Country (country_name,country_flag,country_iso) VALUES ('Netherlands','nl_flag','NLD');


-- Inserting values into Location
INSERT INTO Location (location_name, location_longitude, location_latitude, country_name) VALUES ('Porto', 'N41.148592', 'W-8.620414', 'Portugal');
INSERT INTO Location (location_name, location_longitude, location_latitude, country_name) VALUES ('Leiria', 'N39.743936', 'W-8.807098', 'Portugal');
INSERT INTO Location (location_name, location_longitude, location_latitude, country_name) VALUES ('Albufeira', 'N37.089072', 'W-8.247880', 'Portugal');
INSERT INTO Location (location_name, location_longitude, location_latitude, country_name) VALUES ('Lagos', 'N37.101268', 'W-8.674545', 'Portugal');
INSERT INTO Location (location_name, location_longitude, location_latitude, country_name) VALUES ('Lisboa', 'N38.742751', 'W-9.132196','Portugal');
INSERT INTO Location (location_name, location_longitude, location_latitude, country_name) VALUES ('Madrid', 'N40.416775', 'W-3.703790','Spain');
INSERT INTO Location (location_name, location_longitude, location_latitude, country_name) VALUES ('Londres', 'N51.507351', 'W-0.127758','England');
INSERT INTO Location (location_name, location_longitude, location_latitude, country_name) VALUES ('Paris', 'N48.856614', 'W-2.352222','France');
INSERT INTO Location (location_name, location_longitude, location_latitude, country_name) VALUES ('Roma', 'N41.902782', 'W-12.496366','Italy');
INSERT INTO Location (location_name, location_longitude, location_latitude, country_name) VALUES ('Amesterdao', 'N52.370216', 'W-4.895168','Netherlands');
INSERT INTO Location (location_name, location_longitude, location_latitude, country_name) VALUES ('Berlim', 'N52.520007', 'W-13.404954','Germany');


-- Inserting values into Boat_Class
INSERT INTO boat_class (boat_class_name, max_length) VALUES ('Class 1', 15);
INSERT INTO boat_class (boat_class_name, max_length) VALUES ('Class 2', 25);
INSERT INTO boat_class (boat_class_name, max_length) VALUES ('Class 3', 35);
INSERT INTO boat_class (boat_class_name, max_length) VALUES ('Class 4', 45);
INSERT INTO boat_class (boat_class_name, max_length) VALUES ('Class 5', 55);


-- Inserting values into Boat
INSERT INTO Boat (boat_cni, boat_registration_year, boat_class_name, country_name, boat_length ,boat_name) VALUES ('123456789', 1990, 'Class 1', 'Portugal', 10, 'barco 1');
INSERT INTO Boat (boat_cni, boat_registration_year, boat_class_name, country_name, boat_length, boat_name) VALUES ('987654321', 1663, 'Class 1', 'Spain', 10, 'Titanic');
INSERT INTO Boat (boat_cni, boat_registration_year, boat_class_name, country_name, boat_length, boat_name) VALUES ('123490312', 1663, 'Class 1', 'Portugal', 10, 'barco 2');
INSERT INTO Boat (boat_cni, boat_registration_year, boat_class_name, country_name, boat_length, boat_name) VALUES ('142359879', 2000, 'Class 2', 'Portugal', 20, 'Los Santos');
INSERT INTO Boat (boat_cni, boat_registration_year, boat_class_name, country_name, boat_length, boat_name) VALUES ('010101010', 2010, 'Class 2', 'Germany', 20, 'barco 3');
INSERT INTO Boat (boat_cni, boat_registration_year, boat_class_name, country_name, boat_length, boat_name) VALUES ('101010101', 2014, 'Class 2', 'Netherlands', 22, 'barco 4');
INSERT INTO Boat (boat_cni, boat_registration_year, boat_class_name, country_name, boat_length, boat_name) VALUES ('112233445', 2015, 'Class 4', 'Spain', 43, 'barco 5');



-- Inserting values into Sailor
INSERT INTO Sailor (email, surname, first_name) VALUES ('joaosilva@email.com', 'Silva', 'João');
INSERT INTO Sailor (email, surname, first_name) VALUES ('pedrocabral@email.com', 'Cabral', 'Pedro');
INSERT INTO Sailor (email, surname, first_name) VALUES ('vascogama@email.com', 'Gama', 'Vasco');
INSERT INTO Sailor (email, surname, first_name) VALUES ('diogocao@email.com', 'Cão', 'Diogo');
INSERT INTO Sailor (email, first_name, surname) VALUES ('santos@email.com','Jose', 'Santos');
INSERT INTO Sailor (email, first_name, surname) VALUES ('santos2@email.com','Mateus', 'Santos');
INSERT INTO Sailor (email, first_name, surname) VALUES ('joaomatos@email.com','Joao', 'Matos');
INSERT INTO Sailor (email, first_name, surname) VALUES ('johnsmith@email.com','John', 'Smith');
INSERT INTO Sailor (email, first_name, surname) VALUES ('pierrefrance@email.com','Pierre', 'France');

-- Inserting the sailor into Senior 
INSERT INTO Senior (email) VALUES ('pedrocabral@email.com');
INSERT INTO Senior (email) VALUES ('vascogama@email.com');
INSERT INTO Senior (email) VALUES ('diogocao@email.com');
INSERT INTO Senior (email) VALUES ('santos@email.com');
INSERT INTO Senior (email) VALUES ('santos2@email.com');
INSERT INTO Senior (email) VALUES ('pierrefrance@email.com');


-- Inserting the sailor into Junior
INSERT INTO Junior (email) VALUES ('joaosilva@email.com');
INSERT INTO Junior (email) VALUES ('johnsmith@email.com');
INSERT INTO Junior (email) VALUES ('joaomatos@email.com');


-- Inserting values into Date_interval
INSERT INTO Date_interval (start_date, end_date) VALUES ('2022-12-01', '2022-12-02');
INSERT INTO Date_interval (start_date, end_date) VALUES ('2022-12-03', '2022-12-04');
INSERT INTO Date_interval (start_date, end_date) VALUES ('2022-12-01', '2022-12-03');
INSERT INTO Date_interval (start_date, end_date) VALUES ('2022-12-04', '2022-12-05');
INSERT INTO Date_interval (start_date, end_date) VALUES ('2022-12-05', '2022-12-06');
INSERT INTO Date_interval (start_date, end_date) VALUES ('2022-12-06', '2022-12-07');
INSERT INTO Date_interval (start_date, end_date) VALUES ('2022-12-07', '2022-12-08');
INSERT INTO Date_interval (start_date, end_date) VALUES ('2022-12-12', '2022-12-13');


-- Inserting values into Reservation
INSERT INTO Reservation (boat_cni, start_date, end_date, sailor_email) VALUES ('010101010', '2022-12-01', '2022-12-02', 'pedrocabral@email.com');
INSERT INTO Reservation (boat_cni, start_date, end_date, sailor_email) VALUES ('123456789', '2022-12-03', '2022-12-04', 'vascogama@email.com');
INSERT INTO Reservation (boat_cni, start_date, end_date, sailor_email) VALUES ('123456789', '2022-12-01', '2022-12-03', 'pedrocabral@email.com');
INSERT INTO Reservation (boat_cni, start_date, end_date, sailor_email) VALUES ('987654321', '2022-12-01', '2022-12-02', 'santos@email.com');
INSERT INTO Reservation (boat_cni, start_date, end_date, sailor_email) VALUES ('142359879', '2022-12-01', '2022-12-02', 'santos2@email.com');
INSERT INTO Reservation (boat_cni, start_date, end_date, sailor_email) VALUES ('123456789', '2022-12-01', '2022-12-02', 'santos@email.com');
INSERT INTO Reservation (boat_cni, start_date, end_date, sailor_email) VALUES ('101010101', '2022-12-03', '2022-12-04', 'pierrefrance@email.com');
INSERT INTO Reservation (boat_cni, start_date, end_date, sailor_email) VALUES ('101010101', '2022-12-12', '2022-12-13', 'pedrocabral@email.com');


-- Inserting values into authorized
INSERT INTO Authorized (email, boat_cni, start_date, end_date)  VALUES  ('pedrocabral@email.com','010101010','2022-12-01','2022-12-02');
INSERT INTO Authorized (email, boat_cni, start_date, end_date)  VALUES  ('joaosilva@email.com','987654321','2022-12-01','2022-12-02');
INSERT INTO Authorized (email, boat_cni, start_date, end_date)  VALUES  ('diogocao@email.com','123456789','2022-12-03','2022-12-04');
INSERT INTO Authorized (email, boat_cni, start_date, end_date)  VALUES  ('diogocao@email.com','123456789','2022-12-01','2022-12-03');
INSERT INTO Authorized (email, boat_cni, start_date, end_date)  VALUES  ('pierrefrance@email.com','123456789','2022-12-01','2022-12-03');
INSERT INTO Authorized (email, boat_cni, start_date, end_date)  VALUES  ('johnsmith@email.com','123456789','2022-12-01','2022-12-03');
INSERT INTO Authorized (email, boat_cni, start_date, end_date)  VALUES  ('joaomatos@email.com','123456789','2022-12-01','2022-12-03');
INSERT INTO Authorized (email, boat_cni, start_date, end_date)  VALUES  ('santos@email.com','142359879','2022-12-01','2022-12-02');
INSERT INTO Authorized (email, boat_cni, start_date, end_date)  VALUES  ('santos@email.com','010101010','2022-12-01','2022-12-02');
INSERT INTO Authorized (email, boat_cni, start_date, end_date)  VALUES  ('pedrocabral@email.com','101010101','2022-12-12','2022-12-13');

-- Inserting values into Trip
INSERT INTO Trip (trip_take_off, trip_arrival ,trip_insurance,boat_cni,start_date,end_date,location_to,location_from,skipper_email) VALUES
    ('2022-12-01','2022-12-02', '123456','123456789','2022-12-01','2022-12-03','Porto','Lisboa','diogocao@email.com');
INSERT INTO Trip (trip_take_off, trip_arrival ,trip_insurance,boat_cni,start_date,end_date,location_to,location_from,skipper_email) VALUES
    ('2022-12-01','2022-12-02', '120467','987654321','2022-12-01','2022-12-02','Lisboa','Madrid','joaosilva@email.com');
INSERT INTO Trip (trip_take_off, trip_arrival ,trip_insurance,boat_cni,start_date,end_date,location_to,location_from,skipper_email) VALUES
    ('2022-12-01','2022-12-02', '121467','142359879','2022-12-01','2022-12-02','Porto','Albufeira','santos@email.com');
INSERT INTO Trip (trip_take_off, trip_arrival ,trip_insurance,boat_cni,start_date,end_date,location_to,location_from,skipper_email) VALUES
    ('2022-12-01','2022-12-02', '123567','010101010','2022-12-01','2022-12-02','Porto','Roma','santos@email.com');
INSERT INTO Trip (trip_take_off, trip_arrival ,trip_insurance,boat_cni,start_date,end_date,location_to,location_from,skipper_email) VALUES
    ('2022-12-12','2022-12-14', '123567','101010101','2022-12-12','2022-12-13','Porto','Roma','pedrocabral@email.com');

-- Inserting Sailing Certification to each sailor
INSERT INTO Sailing_Certificate(boat_class_name, email, issue_date, expiry_date)  VALUES ('Class 1', 'pedrocabral@email.com', '2015-11-08','2025-11-08' );
INSERT INTO Sailing_Certificate(boat_class_name, email, issue_date, expiry_date)  VALUES ('Class 1', 'vascogama@email.com', '2014-11-08','2024-11-08' );
INSERT INTO Sailing_Certificate(boat_class_name, email, issue_date, expiry_date)  VALUES ('Class 1', 'joaosilva@email.com', '2018-11-08','2028-11-08' );
INSERT INTO Sailing_Certificate(boat_class_name, email, issue_date, expiry_date)  VALUES ('Class 1', 'diogocao@email.com', '2016-11-08','2026-11-08' );
INSERT INTO Sailing_Certificate(boat_class_name, email, issue_date, expiry_date)  VALUES ('Class 1', 'santos@email.com', '2016-11-08','2026-11-08' );
INSERT INTO Sailing_Certificate(boat_class_name, email, issue_date, expiry_date)  VALUES ('Class 2', 'santos@email.com', '2016-11-09','2026-11-08' );
INSERT INTO Sailing_Certificate(boat_class_name, email, issue_date, expiry_date)  VALUES ('Class 3', 'santos@email.com', '2016-11-08','2026-11-08' );
INSERT INTO Sailing_Certificate(boat_class_name, email, issue_date, expiry_date)  VALUES ('Class 4', 'santos@email.com', '2016-12-08','2026-11-08' );

-- Inserting values into valid_for
INSERT INTO valid_for (country_name, issue_date, boat_class_name, sailor_email) VALUES ('Portugal', '2015-11-08', 'Class 1', 'pedrocabral@email.com');
INSERT INTO valid_for (country_name, issue_date, boat_class_name, sailor_email) VALUES ('Portugal', '2016-11-09', 'Class 2', 'santos@email.com');
INSERT INTO valid_for (country_name, issue_date, boat_class_name, sailor_email) VALUES ('Italy', '2016-11-09', 'Class 2', 'santos@email.com');