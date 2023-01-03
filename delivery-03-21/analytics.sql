--Exercice 6)

--1)

select extract(year from t.trip_start_date) as year, extract(month from t.trip_start_date) as month, t.trip_start_date as exact_date, count(*) as nr_of_trips
from trip_info t
group by grouping sets ( (extract(year from t.trip_start_date)) , (extract(month from t.trip_start_date)), (t.trip_start_date));

--2)

select t.country_name_origin as country , t.loc_name_origin as location, count(*) as nr_of_trips
from trip_info t
group by rollup (t.country_name_origin, t.loc_name_origin);
