DROP TRIGGER IF EXISTS delete_sailor ON sailor;
DROP TRIGGER IF EXISTS delete_reservation ON reservation;

-- Trigger to delete a sailor from the sailor table 
-- and all related data from the other tables
CREATE OR REPLACE FUNCTION delete_sailor()
RETURNS TRIGGER
AS
$$
BEGIN
    DELETE FROM reservation r
    WHERE OLD.email = r.responsible;

    DELETE FROM senior s
    WHERE OLD.email = s.email;

    DELETE FROM junior j
    WHERE OLD.email = j.email;

    RETURN OLD;
END;
$$ language plpgsql;

CREATE TRIGGER delete_sailor
BEFORE DELETE ON sailor
FOR EACH ROW EXECUTE PROCEDURE delete_sailor();

-- Trigger to delete all data associated with reservation
-- when a reservation is deleted
CREATE OR REPLACE FUNCTION delete_reservation()
RETURNS TRIGGER
AS
$$
BEGIN
    DELETE FROM authorised a
    WHERE OLD.start_date = a.start_date AND OLD.end_date = a.end_date AND OLD.cni = a.cni AND OLD.country = a.boat_country;

    DELETE FROM trip t
    WHERE OLD.start_date = t.reservation_start_date AND OLD.end_date = t.reservation_end_date AND OLD.cni = t.cni AND OLD.country = t.boat_country;

    RETURN OLD;
END;
$$ language plpgsql;

CREATE TRIGGER delete_reservation
BEFORE DELETE ON reservation
FOR EACH ROW EXECUTE PROCEDURE delete_reservation();


