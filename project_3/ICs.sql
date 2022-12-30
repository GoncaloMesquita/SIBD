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

DROP TRIGGER IF EXISTS check_sailor_tg ON location;

CREATE CONSTRAINT TRIGGER check_sailor_tg
AFTER INSERT ON sailor DEFERRABLE
FOR EACH ROW EXECUTE PROCEDURE check_sailor();

--IC2: ) The take-off and arrival dates of Trips for the same reservation must not overlap (i.e., one Trip 
-- cannot take off before the arrival of another)
CREATE OR REPLACE FUNCTION check_trip() RETURNS TRIGGER AS
    $$
        DECLARE
            reservation_start DATE;
            reservation_end DATE;
            trip_start DATE;
            trip_end DATE;
            trip_start2 DATE;
            trip_end2 DATE;
        BEGIN
            SELECT start_date, end_date INTO reservation_start, reservation_end FROM reservation WHERE start_date = NEW.reservation_start_date 
                    AND end_date = NEW.reservation_end_date AND country = NEW.boat_country AND cni = NEW.cni;

            SELECT takeoff, arrival INTO trip_start, trip_end FROM trip WHERE reservation_start_date = reservation_start 
                                                                        AND reservation_start_date = reservation_end;

            SELECT takeoff, arrival INTO trip_start2, trip_end2 FROM trip WHERE reservation_start_date = reservation_start 
                                                                        AND reservation_start_date = reservation_end;
                                                                        
            IF trip_start < trip_end2 AND trip_end > trip_start2 THEN
                RAISE EXCEPTION 'Trips overlap';
            END IF;
            RETURN NEW;
        END
    $$ LANGUAGE plpgsql;