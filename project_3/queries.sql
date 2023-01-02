-- Exercice 3)


-- 1)

SELECT country, COUNT(*) AS num_boats
FROM boat
GROUP BY country
HAVING COUNT(*) = (SELECT MAX(num_boats) FROM (SELECT COUNT(*) AS num_boats FROM boat GROUP BY country) as t );

--2)

SELECT s.firstname, s.surname, COUNT(c.sailor) AS num_certificates
FROM sailor s
JOIN sailing_certificate c ON s.email = c.sailor
GROUP BY s.email
HAVING COUNT(c.sailor) >= 2 ;

--3)

SELECT s.email
FROM sailor s
JOIN trip t ON s.email = t.skipper
JOIN location l ON t.to_latitude = l.latitude OR t.to_longitude = l.longitude
WHERE l.country_name = 'Portugal'
GROUP BY s.email
HAVING COUNT(DISTINCT l.name) = (SELECT COUNT(*) FROM location WHERE country_name = 'Portugal');

--4)

SELECT s.firstname, s.surname, COUNT(t.takeoff) AS num_trips
FROM sailor s
JOIN trip t ON s.email = t.skipper
GROUP BY s.email
ORDER BY num_trips DESC;

--5)
--Errada corrigir

SELECT skipper, reservation_start_date, reservation_end_date, boat_country, cni, SUM(arrival - takeoff ) AS total_duration
FROM trip
GROUP BY skipper, takeoff, reservation_start_date, reservation_end_date, boat_country, cni
HAVING (SUM(arrival - takeoff )) >= ALL( SELECT SUM(arrival - takeoff )
                                        FROM trip
                                        GROUP BY skipper, takeoff, reservation_start_date, reservation_end_date, boat_country, cni);
