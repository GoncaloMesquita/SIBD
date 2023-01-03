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

