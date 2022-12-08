-- The name of all boats that are used in some trip
SELECT boat_name from boat
    natural join reservation
    natural join trip;

-- The name of all boats that are not used in any trip
SELECT b.boat_name from boat b
    JOIN reservation r on b.boat_cni = r.boat_cni
    JOIN trip t on r.boat_cni = t.boat_cni and r.start_date = t.start_date and r.end_date = t.end_date
    WHERE b.boat_cni NOT IN (t.boat_cni);