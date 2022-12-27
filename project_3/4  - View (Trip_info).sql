DROP VIEW IF EXISTS trip_info;
DROP	FUNCTION	search_country_name(lat NUMERIC(8,6), long NUMERIC(9,6));
DROP	FUNCTION	search_country_iso(lat NUMERIC(8,6), long NUMERIC(9,6));
DROP FUNCTION location_name(lat NUMERIC(8,6), long NUMERIC(9,6));




CREATE OR REPLACE FUNCTION	search_country_name(lat NUMERIC(8,6), long NUMERIC(9,6))
RETURNS VARCHAR(80)
AS $$
    DECLARE
        name VARCHAR(80);
    BEGIN
		SELECT C.name into name
		FROM location A JOIN country C ON A.country_name=C.name
		WHERE A.latitude=lat and A.longitude=long;

		return name;
	END;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION	search_country_iso(lat NUMERIC(8,6), long NUMERIC(9,6))
RETURNS CHAR(3)
AS $$
    DECLARE
        iso CHAR(3);
    BEGIN
		SELECT C.iso_code into iso
		FROM location A JOIN country C ON A.country_name=C.name
		WHERE A.latitude=lat and A.longitude=long;

		return iso;
	END;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION location_name(lat NUMERIC(8,6), long NUMERIC(9,6))
RETURNS VARCHAR(80)
AS $$
    DECLARE
        name VARCHAR(80);
    BEGIN
		SELECT A.name into name
		FROM location A
		WHERE A.latitude=lat and A.longitude=long;

		return name;
	END;
$$
LANGUAGE plpgsql;


CREATE VIEW trip_info(
country_iso_origin, country_name_origin,
country_iso_dest, country_name_dest,
loc_name_origin,
loc_name_dest,
cni_boat,
country_iso_boat, country_name_boat,
trip_start_date)
AS
    SELECT search_country_name(trip.from_latitude, trip.from_longitude), search_country_iso(from_latitude, from_longitude),
       search_country_name(to_latitude, to_longitude), search_country_iso(to_latitude, to_longitude),
       location_name(from_latitude, from_longitude), location_name(to_latitude, to_longitude),
       trip.cni, c.iso_code, b.country, trip.takeoff
from trip join reservation r on trip.reservation_start_date = r.start_date and trip.reservation_end_date = r.end_date and trip.boat_country = r.country and trip.cni = r.cni
join boat b on r.country = b.country and r.cni = b.cni
join country c on b.country = c.name

select * from trip_info