-- Insert into Country
INSERT INTO Country (name,flag,iso_code) VALUES ('Portugal','pt_flag','PRT');
INSERT INTO Country (name,flag,iso_code) VALUES ('Spain','esp_flag','ESP');
INSERT INTO Country (name,flag,iso_code) VALUES ('France','fr_flag','FRA');
INSERT INTO Country (name,flag,iso_code) VALUES ('Italy','it_flag','ITA');
INSERT INTO Country (name,flag,iso_code) VALUES ('Germany','de_flag','DEU');
INSERT INTO Country (name,flag,iso_code) VALUES ('England','uk_flag','GBR');
INSERT INTO Country (name,flag,iso_code) VALUES ('Netherlands','nl_flag','NLD');


-- Inserting values into Location
INSERT INTO Location (name,  latitude, longitude, country_name) VALUES ('Porto', 41.148592, -8.620414, 'Portugal');
INSERT INTO Location (name,  latitude, longitude, country_name) VALUES ('Leiria', 39.743936, -8.807098, 'Portugal');
INSERT INTO Location (name,  latitude, longitude, country_name) VALUES ('Albufeira', 37.089072, -8.247880, 'Portugal');
INSERT INTO Location (name,  latitude, longitude, country_name) VALUES ('Lagos', 37.101268, -8.674545, 'Portugal');
INSERT INTO Location (name,  latitude, longitude, country_name) VALUES ('Lisboa', 38.742751, -9.132196,'Portugal');
INSERT INTO Location (name,  latitude, longitude, country_name) VALUES ('Madrid', 40.416775, -3.703790,'Spain');
INSERT INTO Location (name,  latitude, longitude, country_name) VALUES ('Londres', 51.507351, -0.127758,'England');
INSERT INTO Location (name,  latitude, longitude, country_name) VALUES ('Paris', 48.856614, -2.352222,'France');
INSERT INTO Location (name,  latitude, longitude, country_name) VALUES ('Roma', 41.902782, -12.496366,'Italy');
INSERT INTO Location (name,  latitude, longitude, country_name) VALUES ('Amesterdao', 52.370216, -4.895168,'Netherlands');
INSERT INTO Location (name,  latitude, longitude, country_name) VALUES ('Berlim', 52.520007, -13.404954,'Germany');

-- Inserting values into Sailor and Junior
START TRANSACTION;
SET CONSTRAINTS ALL DEFERRED;
INSERT INTO Sailor (email, firstname, surname) VALUES ('joaosilva@email.com', 'João', 'Silva');
INSERT INTO Junior (email) VALUES ('joaosilva@email.com');


INSERT INTO Sailor (email, firstname, surname) VALUES ('johnsmith@email.com','John', 'Smith');
INSERT INTO Junior (email) VALUES ('johnsmith@email.com');


INSERT INTO Sailor (email, firstname, surname) VALUES ('joaomatos@email.com','Joao', 'Matos');
INSERT INTO Junior (email) VALUES ('joaomatos@email.com');

COMMIT;

-- Inserting values into Sailor and Senior
START TRANSACTION;
SET CONSTRAINTS ALL DEFERRED;

INSERT INTO Sailor (email, firstname, surname) VALUES ('pedrocabral@email.com', 'Pedro', 'Cabral');
INSERT INTO Senior (email) VALUES ('pedrocabral@email.com');

INSERT INTO Sailor (email, firstname, surname) VALUES ('vascogama@email.com', 'Vasco', 'Gama');
INSERT INTO Senior (email) VALUES ('vascogama@email.com');

INSERT INTO Sailor (email, firstname, surname) VALUES ('diogocao@email.com', 'Cão', 'Diogo');
INSERT INTO Senior (email) VALUES ('diogocao@email.com');

INSERT INTO Sailor (email, firstname, surname) VALUES ('santos@email.com','Jose', 'Santos');
INSERT INTO Senior (email) VALUES ('santos@email.com');

INSERT INTO Sailor (email, firstname, surname) VALUES ('santos2@email.com','Mateus', 'Santos');
INSERT INTO Senior (email) VALUES ('santos2@email.com');

INSERT INTO Sailor (email, firstname, surname) VALUES ('pierrefrance@email.com','Pierre', 'France');
INSERT INTO Senior (email) VALUES ('pierrefrance@email.com');

COMMIT;

-- Inserting values into Boat_Class
INSERT INTO boat_class (name, max_length) VALUES ('Class 1', 15);
INSERT INTO boat_class (name, max_length) VALUES ('Class 2', 25);
INSERT INTO boat_class (name, max_length) VALUES ('Class 3', 35);
INSERT INTO boat_class (name, max_length) VALUES ('Class 4', 45);
INSERT INTO boat_class (name, max_length) VALUES ('Class 5', 55);

-- Inserting Sailing Certification to each sailor
INSERT INTO Sailing_Certificate(boat_class, sailor, issue_date, expiry_date)  VALUES ('Class 1', 'pedrocabral@email.com', '2015-11-08','2025-11-08' );
INSERT INTO Sailing_Certificate(boat_class, sailor, issue_date, expiry_date)  VALUES ('Class 1', 'vascogama@email.com', '2014-11-08','2024-11-08' );
INSERT INTO Sailing_Certificate(boat_class, sailor, issue_date, expiry_date)  VALUES ('Class 1', 'joaosilva@email.com', '2018-11-08','2028-11-08' );
INSERT INTO Sailing_Certificate(boat_class, sailor, issue_date, expiry_date)  VALUES ('Class 1', 'diogocao@email.com', '2016-11-08','2026-11-08' );
INSERT INTO Sailing_Certificate(boat_class, sailor, issue_date, expiry_date)  VALUES ('Class 1', 'santos@email.com', '2016-11-08','2026-11-08' );
INSERT INTO Sailing_Certificate(boat_class, sailor, issue_date, expiry_date)  VALUES ('Class 2', 'santos@email.com', '2016-11-09','2026-11-08' );
--INSERT INTO Sailing_Certificate(boat_class, sailor, issue_date, expiry_date)  VALUES ('Class 3', 'santos@email.com', '2016-11-08','2026-11-08' );
--INSERT INTO Sailing_Certificate(boat_class, sailor, issue_date, expiry_date)  VALUES ('Class 4', 'santos@email.com', '2016-12-08','2026-11-08' );


-- Inserting values into valid_for
INSERT INTO valid_for (country_name, issue_date, max_length, sailor) VALUES ('Portugal', '2015-11-08', 10, 'pedrocabral@email.com');
INSERT INTO valid_for (country_name, issue_date, max_length, sailor) VALUES ('Portugal', '2016-11-09', 20, 'santos@email.com');
INSERT INTO valid_for (country_name, issue_date, max_length, sailor) VALUES ('Italy', '2016-11-09', 20, 'santos@email.com');

-- Inserting values into Boat
INSERT INTO Boat (cni, year, boat_class, country, length ,name) VALUES ('123456789', 1990, 'Class 1', 'Portugal', 10, 'barco 1');
INSERT INTO Boat (cni, year, boat_class, country, length, name) VALUES ('987654321', 1663, 'Class 1', 'Spain', 10, 'Titanic');
INSERT INTO Boat (cni, year, boat_class, country, length, name) VALUES ('123490312', 1663, 'Class 1', 'Portugal', 10, 'barco 2');
INSERT INTO Boat (cni, year, boat_class, country, length, name) VALUES ('142359879', 2000, 'Class 2', 'Portugal', 20, 'Los Santos');
INSERT INTO Boat (cni, year, boat_class, country, length, name) VALUES ('010101010', 2010, 'Class 2', 'Germany', 20, 'barco 3');
INSERT INTO Boat (cni, year, boat_class, country, length, name) VALUES ('101010101', 2014, 'Class 2', 'Netherlands', 22, 'barco 4');
INSERT INTO Boat (cni, year, boat_class, country, length, name) VALUES ('112233445', 2015, 'Class 4', 'Spain', 43, 'barco 5');

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
INSERT INTO Reservation (cni, country, start_date, end_date, responsible) VALUES ('010101010', 'Germany', '2022-12-01', '2022-12-02', 'pedrocabral@email.com');
INSERT INTO Reservation (cni, country, start_date, end_date, responsible) VALUES ('123456789', 'Portugal', '2022-12-03', '2022-12-04', 'vascogama@email.com');
INSERT INTO Reservation (cni, country, start_date, end_date, responsible) VALUES ('123456789', 'Portugal', '2022-12-01', '2022-12-03', 'pedrocabral@email.com');
INSERT INTO Reservation (cni, country, start_date, end_date, responsible) VALUES ('987654321', 'Spain', '2022-12-01', '2022-12-02', 'santos@email.com');
INSERT INTO Reservation (cni, country, start_date, end_date, responsible) VALUES ('142359879', 'Portugal', '2022-12-01', '2022-12-02', 'santos2@email.com');
INSERT INTO Reservation (cni, country, start_date, end_date, responsible) VALUES ('123456789', 'Portugal', '2022-12-01', '2022-12-02', 'santos@email.com');
INSERT INTO Reservation (cni, country, start_date, end_date, responsible) VALUES ('101010101', 'Netherlands', '2022-12-03', '2022-12-04', 'pierrefrance@email.com');
INSERT INTO Reservation (cni, country, start_date, end_date, responsible) VALUES ('101010101', 'Netherlands', '2022-12-12', '2022-12-13', 'pedrocabral@email.com');


--Inserting values into authorized
INSERT INTO Authorised (sailor, cni, boat_country, start_date, end_date)  VALUES  ('pedrocabral@email.com','010101010', 'Germany', '2022-12-01','2022-12-02');
INSERT INTO Authorised (sailor, cni, boat_country, start_date, end_date)  VALUES  ('joaosilva@email.com','987654321', 'Spain', '2022-12-01','2022-12-02');
INSERT INTO Authorised (sailor, cni, boat_country, start_date, end_date)  VALUES  ('diogocao@email.com','123456789', 'Portugal', '2022-12-03','2022-12-04');
INSERT INTO Authorised (sailor, cni, boat_country, start_date, end_date)  VALUES  ('diogocao@email.com','123456789', 'Portugal', '2022-12-01','2022-12-03');
INSERT INTO Authorised (sailor, cni, boat_country, start_date, end_date)  VALUES  ('pierrefrance@email.com','123456789', 'Portugal', '2022-12-01','2022-12-03');
INSERT INTO Authorised (sailor, cni, boat_country, start_date, end_date)  VALUES  ('johnsmith@email.com','123456789', 'Portugal', '2022-12-01','2022-12-03');
INSERT INTO Authorised (sailor, cni, boat_country, start_date, end_date)  VALUES  ('joaomatos@email.com','123456789', 'Portugal', '2022-12-01','2022-12-03');
INSERT INTO Authorised (sailor, cni, boat_country, start_date, end_date)  VALUES  ('santos@email.com','142359879', 'Portugal', '2022-12-01','2022-12-02');
INSERT INTO Authorised (sailor, cni, boat_country, start_date, end_date)  VALUES  ('santos@email.com','010101010', 'Germany', '2022-12-01','2022-12-02');
INSERT INTO Authorised (sailor, cni, boat_country, start_date, end_date)  VALUES  ('pedrocabral@email.com','101010101', 'Netherlands', '2022-12-12','2022-12-13');

-- Inserting values into Trip
INSERT INTO Trip (takeoff, arrival ,insurance, cni , boat_country , reservation_start_date, reservation_end_date, to_latitude, to_longitude, from_latitude, from_longitude,skipper) VALUES
    ('2022-12-01','2022-12-02', '123456','123456789', 'Portugal', '2022-12-01','2022-12-03',41.148592, -8.620414,38.742751, -9.132196, 'diogocao@email.com');
INSERT INTO Trip (takeoff, arrival , insurance ,  cni , boat_country , reservation_start_date , reservation_end_date , to_latitude, to_longitude, from_latitude, from_longitude,skipper) VALUES
    ('2022-12-01','2022-12-02', '120467','987654321', 'Spain', '2022-12-01','2022-12-02',38.742751, -9.132196,40.416775, -3.703790,'joaosilva@email.com');
INSERT INTO Trip (takeoff, arrival ,insurance, cni , boat_country , reservation_start_date, reservation_end_date, to_latitude, to_longitude, from_latitude, from_longitude,skipper) VALUES
    ('2022-12-01','2022-12-02', '121467','142359879', 'Portugal', '2022-12-01','2022-12-02',41.148592, -8.620414, 37.089072, -8.247880,'santos@email.com');
INSERT INTO Trip (takeoff, arrival ,insurance, cni , boat_country , reservation_start_date, reservation_end_date, to_latitude, to_longitude, from_latitude, from_longitude,skipper) VALUES
    ('2022-12-01','2022-12-02', '123567','010101010', 'Germany', '2022-12-01','2022-12-02',41.148592, -8.620414,41.902782, -12.496366,'santos@email.com');
INSERT INTO Trip (takeoff, arrival ,insurance, cni , boat_country , reservation_start_date, reservation_end_date, to_latitude, to_longitude, from_latitude, from_longitude,skipper) VALUES
    ('2022-12-12','2022-12-14', '123567','101010101', 'Netherlands', '2022-12-12','2022-12-13',41.148592, -8.620414,41.902782, -12.496366,'pedrocabral@email.com');