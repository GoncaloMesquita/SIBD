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

SELECT t.skipper, MAX(arrival - takeoff) AS total_duration
FROM trip t
GROUP BY t.skipper
ORDER BY total_duration DESC;


/*
7. Indexes

Present the SQL index(es) creating instruction(s) to improve the querying times for each of the cases
listed below, explaining what are the operations that would be optimized and how.
Indicate, with proper justification, what type of index(es), over which attribute(s) and over which
table(s), it would make sense to create, in order to speed up each query execution. Assume that the size
of the tables exceeds the available memory by several orders of magnitude.
Assume that there are no indexes over the tables, aside from those implicit when declaring primary and
foreign keys.
 */


/*7.1 - List the names of all boats of a given class and registered after given year:*/
SELECT boat.name
FROM boat
WHERE year >= 1990
AND boat_class = 'Class 1';
/* Range query which must be faster using trees instead of hashes*/
/* composite key indexes may be better*/

/*7.2 - Count the number of trips of boats by country:*/
SELECT boat_country, COUNT(*)
FROM trip
GROUP BY boat_country
 /* group by

