-- Integrity Constraints implemented in question 2 

-- (IC-1) Every sailor is either a senior or a junior -- disjoint

CREATE OR REPLACE FUNCTION check_sailor() RETURNS TRIGGER AS
    $$
        DECLARE is_junior BOOLEAN DEFAULT FALSE;
        DECLARE is_senior BOOLEAN DEFAULT FALSE;

        BEGIN
            IF EXISTS(SELECT * FROM junior WHERE email = NEW.email) THEN
                is_junior = TRUE;
            END IF;
            IF EXISTS(SELECT * FROM senior WHERE email = NEW.email) THEN
                IF is_junior THEN
                    RAISE EXCEPTION 'Sailor is junior';
                END IF;
                is_senior = TRUE;
            END IF;
            IF NOT is_junior AND NOT is_senior THEN
                RAISE EXCEPTION 'Sailor is not a junior or a senior';
            END IF;
            RETURN NEW;
        END
    $$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS check_sailor_tg ON sailor;

CREATE CONSTRAINT TRIGGER check_sailor_tg
AFTER INSERT ON sailor DEFERRABLE
FOR EACH ROW EXECUTE PROCEDURE check_sailor();

--IC2: ) The take-off and arrival dates of Trips for the same reservation must not overlap (i.e., one Trip 
-- cannot take off before the arrival of another)
CREATE OR REPLACE FUNCTION check_dates() RETURNS TRIGGER AS
    $$
        DECLARE existing_trips RECORD;
        BEGIN
            FOR existing_trips IN SELECT takeoff,arrival FROM trip WHERE reservation_start_date = NEW.reservation_start_date
                                                            AND reservation_end_date = NEW.reservation_end_date
                                                            AND cni = NEW.cni
                                                            AND boat_country = NEW.boat_country
            LOOP
                IF NEW.takeoff > existing_trips.takeoff AND NEW.takeoff < existing_trips.arrival THEN
                    RAISE EXCEPTION 'Start date value invalid.';
                    EXIT;
                END IF;

                IF NEW.arrival > existing_trips.takeoff AND NEW.arrival < existing_trips.arrival THEN
                    RAISE EXCEPTION 'End date value invalid';
                    EXIT;
                END IF;
            END LOOP;
            RETURN NEW;
        END;
    $$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS check_dates_tg ON trip;

CREATE TRIGGER check_dates_tg
BEFORE INSERT ON trip
FOR EACH ROW EXECUTE PROCEDURE check_dates();


-- Other integrity constraints needed for the correct deletion of entries
DROP TRIGGER IF EXISTS delete_sailor ON sailor;
DROP TRIGGER IF EXISTS delete_reservation ON reservation;
DROP TRIGGER IF EXISTS delete_senior ON senior;
DROP TRIGGER IF EXISTS delete_sailing_certificate ON sailing_certificate;

-- TRIGGER TO DELETE A SAILING CERTIFICATE AND ALL RELATED DATA FROM OTHER TABLES
CREATE OR REPLACE FUNCTION delete_sailing_certificate()
RETURNS TRIGGER
AS
$$
BEGIN
    DELETE FROM valid_for vf
    WHERE OLD.sailor = vf.sailor AND OLD.issue_date = vf.issue_date;

    RETURN OLD;
END;
$$ language plpgsql;

CREATE TRIGGER delete_sailing_certificate
BEFORE DELETE ON sailing_certificate
FOR EACH ROW EXECUTE PROCEDURE delete_sailing_certificate();


-- Trigger before deleting a senior
CREATE OR REPLACE FUNCTION delete_senior()
RETURNS TRIGGER
AS
$$
BEGIN
    DELETE FROM reservation r
    WHERE OLD.email = r.responsible;

    DELETE FROM sailing_certificate sc
    WHERE OLD.email = sc.sailor;

    RETURN OLD;
END;
$$ language plpgsql;

CREATE TRIGGER delete_senior
BEFORE DELETE ON senior
FOR EACH ROW EXECUTE PROCEDURE delete_senior();

-- Trigger to delete a sailor from the sailor table 
-- and all related data from the other tables
CREATE OR REPLACE FUNCTION delete_sailor()
RETURNS TRIGGER
AS
$$
BEGIN
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




