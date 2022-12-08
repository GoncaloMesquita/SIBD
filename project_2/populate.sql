
-- Inserting values into Location
INSERT INTO Location (name, longitude, latitude) VALUES ('Porto', 'N39º546.89', 'W008º234.987');
INSERT INTO Location (name, longitude, latitude) VALUES ('Lisboa', 'N36º234.08', 'W008º234.987');
INSERT INTO Location (name, longitude, latitude) VALUES ('Viana', 'N39º546.89', 'W008º290.459');
INSERT INTO Location (name, longitude, latitude) VALUES ('Porto', 'N50º560.89', 'W008º567.987');
INSERT INTO Location (name, longitude, latitude) VALUES ('Teste', 'N39º546.89', 'W008º234.987');-- supposed to fail 
INSERT INTO Location (name, longitude, latitude) VALUES ('Porto', 'N39º546.89', 'W008º234.987');-- supposed to fail

-- Inserting values into Boat
INSERT INTO Boat (cni, name, boat_class, country) VALUES ('123456789', 'O Salgado', 'Class 1', 'Portugal');
INSERT INTO Boat (cni, name, boat_class, country) VALUES ('987654321', 'Marujo', 'Class 2', 'Portugal');
INSERT INTO Boat (cni, name, boat_class, country) VALUES ('123456789', 'Rep1', 'Class 1', 'Portugal');-- supposed to fail
INSERT INTO Boat (cni, name, boat_class, country) VALUES ('123456789', 'Rep1', 'Class 1', 'Espanha');

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
    date_inter_start,date_inter_end,location_to,location_from,skipper_email) VALUES 
    ('2022-12-01','2022-12-02', '123456','123456789','2022-12-01','2022-12-02','Porto','Lisboa','sailor1@email.com');
INSERT INTO Trip (trip_take_off, trip_arrival ,trip_insurance,boat_cni,
    date_inter_start,date_inter_end,location_to,location_from,skipper_email) VALUES 
    ('2022-12-12','2022-12-13', '123467','987654321','2022-12-01','2022-12-02','Lisboa','Viana','sailor2@email.com');
