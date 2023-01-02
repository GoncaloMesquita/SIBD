DROP VIEW IF EXISTS trip_info;

CREATE VIEW trip_info(country_iso_origin, country_name_origin,
                      country_iso_dest, country_name_dest,
                      loc_name_origin, loc_name_dest,
                      cni_boat,country_iso_boat,
                      country_name_boat, trip_start_date)
AS SELECT DISTINCT c.iso_code, l.country_name,c2.iso_code, l2.country_name, l.name, l2.name, T1.cni, c3.iso_code, T1.boat_country, T1.takeoff
FROM trip T1 JOIN location l on l.latitude = T1.from_latitude and l.longitude = T1.from_longitude
                JOIN country c on c.name = l.country_name
                JOIN location l2 on l2.latitude = T1.to_latitude and l2.longitude = T1.to_longitude
                JOIN country c2 on c2.name = l2.country_name
                JOIN country c3 on c3.name = T1.boat_country;


-- Verificação da View criada

SELECT *
FROM trip_info
ORDER BY country_iso_origin DESC;