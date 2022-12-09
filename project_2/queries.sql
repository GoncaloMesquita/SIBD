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

--  All boats that have been reserved at least once
SELECT DISTINCT boat_name
    FROM boat b
    JOIN  reservation r on b.boat_cni = r.boat_cni;

--  All sailors that have reserved boats registered in the country 'Portugal'
SELECT DISTINCT s.first_name, s.surname
    FROM sailor s
    JOIN reservation r ON s.email = r.sailor_email
    JOIN boat b ON r.boat_cni = b.boat_cni
    JOIN Country c ON c.country_name = b.country_name
    WHERE c.country_name = 'Portugal';

-- Name of the boats that are reserved in order of date
SELECT boat_name, r.start_date
    FROM boat b
    JOIN  reservation r on b.boat_cni = r.boat_cni
    ORDER BY r.start_date;

-- The name of all boats that have been reserved for a trip that starts in 'Portugal'
SELECT b.boat_name FROM boat b
    JOIN reservation r ON b.boat_cni = r.boat_cni
    JOIN trip t ON r.boat_cni = t.boat_cni and r.start_date = t.start_date and r.end_date = t.end_date
    JOIN location l ON t.location_from = l.location_name
    JOIN country c ON l.country_name = c.country_name
    WHERE c.country_name = 'Portugal';

-- The name of all boats that have been reserved for a trip that starts in 'Spain' and ends in 'Portugal'
SELECT b.boat_name FROM boat b
    JOIN reservation r ON b.boat_cni = r.boat_cni
    JOIN trip t ON r.boat_cni = t.boat_cni and r.start_date = t.start_date and r.end_date = t.end_date
    JOIN location l ON t.location_from = l.location_name
    JOIN location l2 ON t.location_to = l2.location_name
    WHERE l.country_name = 'Spain' AND l2.country_name = 'Portugal';

-- Name of the sailors order by their expiried Sailing Certification
SELECT s.first_name, s.surname
    FROM sailor s
    JOIN Sailing_Certificate SC on s.email = SC.email
    ORDER BY  SC.expiry_date;

-- Name of the sailors and how many different class certification they have
SELECT  s.first_name, s.surname, Count(SC.boat_class_name)
    FROM sailor s
    JOIN Sailing_Certificate SC on s.email = SC.email
    GROUP BY s.first_name, s.surname