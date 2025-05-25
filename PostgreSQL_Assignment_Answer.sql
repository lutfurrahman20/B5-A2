
-- problem 01
INSERT INTO rangers(name, region) VALUES
('Derek Fox', 'Coastal Plains');

SELECT * FROM rangers;

-- problem 02

SELECT COUNT(DISTINCT species_id) AS unique_species_count
FROM sightings;

-- problem 03

SELECT * FROM sightings
WHERE location ILIKE '%Pass%';


-- problem 04

SELECT name,
  (
    SELECT COUNT(*) 
    FROM sightings s 
    WHERE s.ranger_id = r.ranger_id
  ) 
  AS total_sightings
FROM rangers r;

-- problem 05

SELECT common_name FROM species
WHERE species_id NOT IN (
    SELECT species_id FROM sightings
);

-- problem 6

SELECT common_name, sighting_time, name
FROM species, sightings, rangers
WHERE species.species_id = sightings.species_id
  AND rangers.ranger_id = sightings.ranger_id
ORDER BY sighting_time DESC
LIMIT 2;

-- problem 7

UPDATE species
SET conservation_status = 'Historic'
WHERE EXTRACT(YEAR FROM discovery_date) < 1800;



-- problem 8

CREATE OR REPLACE FUNCTION get_time_of_day(ts TIMESTAMP)
RETURNS TEXT AS 
$$
BEGIN
  IF EXTRACT(HOUR FROM ts) < 12 THEN
    RETURN 'Morning';
  ELSIF EXTRACT(HOUR FROM ts) BETWEEN 12 AND 17 THEN
    RETURN 'Afternoon';
  ELSE
    RETURN 'Evening';
  END IF;
END;
$$ LANGUAGE plpgsql;

SELECT sighting_id, get_time_of_day(sighting_time) AS time_of_day
FROM sightings;



-- problem 9

DELETE FROM rangers
WHERE ranger_id NOT IN (
    SELECT DISTINCT ranger_id FROM sightings
);




