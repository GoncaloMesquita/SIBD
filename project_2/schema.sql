DROP TABLE IF EXISTS Location,Trip,Reservation,
    Boat,Date_interval,Country;

CREATE TABLE Boat(
    boat_cni VARCHAR(80),
    name VARCHAR(80) NOT NULL,
    length INTEGER NOT NULL,
    PRIMARY KEY (boat_cni)
--    FOREIGN KEY (boat_cni) REFERENCES Country(boat_cni)
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
    PRIMARY KEY (location_latitude,location_longitude)
);

CREATE TABLE Trip(
    trip_arrival DATE,
    trip_take_off DATE,
    trip_insurance VARCHAR(80),
    boat_cni VARCHAR(80),
    date_inter_start DATE,
    date_inter_end DATE,

    PRIMARY KEY (boat_cni,date_inter_end,
                 date_inter_start,trip_take_off),

    FOREIGN KEY (boat_cni,date_inter_start,date_inter_end)
        REFERENCES Reservation(boat_cni,date_inter_start,
                               date_inter_end)

--A boat can not take off on a trip before the reservation start date.
);
