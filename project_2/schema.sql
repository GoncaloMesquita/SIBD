DROP TABLE IF EXISTS Location,Trip,Reservation,
    Boat,Date_interval,Country;

CREATE TABLE Boat(
    boat_cni VARCHAR(80),
    name VARCHAR(80) NOT NULL,
    length INTEGER NOT NULL,
    registration_year DATE NOT NULL,
    country_name VARCHAR(80) NOT NULL,
    boat_class_name VARCHAR(80) NOT NULL,

    PRIMARY KEY (boat_cni,country_name),
    FOREIGN KEY (boat_class_name) REFERENCES Boat_Class(boat_class_name),
    FOREIGN KEY (country_name) REFERENCES Country(country_name)
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
    FOREIGN KEY (country_name) REFERENCES Country(country_name)
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
                               date_inter_end)

    FOREIGN KEY (location_to) REFERENCES Location(location_name),
    FOREIGN KEY (location_from) REFERENCES Location(location_name),
    FOREIGN KEY (skipper_email) REFERENCES Sailor(sailor_email)

    -- A boat can not take off on a trip before the reservation start date.
    -- The skipper must be an authorized sailor of the corresponding reservation.
    -- A boat can not take off on a trip before the reservation start date.
);
