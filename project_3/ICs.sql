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
