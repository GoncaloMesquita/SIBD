-- The name of all boats that are used in some trip
SELECT boat_name from boat
    natural join reservation
    natural join trip;

-- The name of all boats that are not used in any trip
SELECT b.boat_name from boat b
    where b.boat_name not in
          (SELECT b.boat_name from Boat b
            JOIN Reservation r on b.boat_cni = r.boat_cni
            JOIN Trip t on r.boat_cni = t.boat_cni and r.start_date = t.start_date and r.end_date = t.end_date);

-- The name of all boats registered in 'PRT' (ISO code) for which at least one responsible for a
--reservation has a surname that ends with 'Santos'
SELECT b.boat_name FROM boat b
    JOIN country c ON c.country_name = b.country_name
    JOIN Reservation r on b.boat_cni = r.boat_cni
    JOIN Sailor s on r.sailor_email = s.email
    WHERE c.country_iso = 'PRT' AND s.surname LIKE '%Santos';

--  The full name of all skippers without any certificate corresponding to the class of the trip’s boat.
SELECT s.first_name, s.surname FROM Sailor s
    JOIN trip t on s.email = t.skipper_email
    JOIN sailing_certificate sc on s.email = sc.email
    JOIN reservation r on t.boat_cni = r.boat_cni and t.start_date = r.start_date and t.end_date = r.end_date
    JOIN boat b on r.boat_cni = b.boat_cni
    WHERE b.boat_class_name <> sc.boat_class_name;

-- Country and boat names from boats that have a trip on the first 3 days of December 2022
SELECT c.country_name,b.boat_name FROM country c
    JOIN boat b on c.country_name = b.country_name
    JOIN reservation r on b.boat_cni = r.boat_cni
    JOIN trip t on r.boat_cni = t.boat_cni and r.start_date = t.start_date and r.end_date = t.end_date
    WHERE t.trip_take_off >= '2022-12-01' AND t.trip_arrival <= '2022-12-03';

-- Number of boats by country and order by number of boats
SELECT c.country_name, count(b.boat_name) as boat_count FROM country c
    JOIN boat b on c.country_name = b.country_name
    GROUP BY c.country_name
    ORDER BY boat_count DESC;

-- The boat name from boats that sail internationally
SELECT b.boat_name FROM country c
    JOIN boat b on c.country_name = b.country_name
    JOIN reservation r on b.boat_cni = r.boat_cni
    JOIN trip t on r.boat_cni = t.boat_cni and r.start_date = t.start_date and r.end_date = t.end_date
    JOIN location l on t.location_from = l.location_name
    JOIN location l2 on t.location_to = l2.location_name
    WHERE l.country_name <> l2.country_name;

 

