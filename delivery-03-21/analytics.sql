--Exercice 6)e the total number of trips according to different groups depending on:

--1)The start date (i.e., per year, per month independently of year, and per exact date);

select extract(year from t.trip_start_date) as year, extract(month from t.trip_start_date) as month, t.trip_start_date as exact_date, count(*) as nr_of_trips
from trip_info t
group by grouping sets ( (extract(year from t.trip_start_date)) , (extract(month from t.trip_start_date)), (t.trip_start_date));

--2)The location of origin (i.e., per location within countries, per country, and in total).

select t.country_name_origin as country , t.loc_name_origin as location, count(*) as nr_of_trips
from trip_info t
group by rollup (t.country_name_origin, t.loc_name_origin);
