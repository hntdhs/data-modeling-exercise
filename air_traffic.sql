-- from the terminal run:
-- psql < air_traffic.sql

DROP DATABASE IF EXISTS air_traffic;

CREATE DATABASE air_traffic;

\c air_traffic

-- original code that came with assignment: 
-- CREATE TABLE tickets
-- (
--   id SERIAL PRIMARY KEY,
--   first_name TEXT NOT NULL,
--   last_name TEXT NOT NULL,
--   seat TEXT NOT NULL,
--   departure TIMESTAMP NOT NULL,
--   arrival TIMESTAMP NOT NULL,
--   airline TEXT NOT NULL,
--   from_city TEXT NOT NULL,
--   from_country TEXT NOT NULL,
--   to_city TEXT NOT NULL,
--   to_country TEXT NOT NULL
-- );
-- break into categories: passengers (first and last name), destinations (city, country), flights (airline, arrival, departure), tickets (all tables joined together + seat?)

CREATE TABLE passengers 
(
  id PRIMARY KEY,
  first_name TEXT NOT NULL,
  last_name TEXT NOT NULL
);

CREATE TABLE destinations 
(
  id PRIMARY KEY,
  city TEXT NOT NULL,
  country TEXT NOT NULL
);

CREATE TABLE airlines 
(
  id PRIMARY KEY,
  name TEXT NOT NULL
);

CREATE TABLE connected_cities
(
  id PRIMARY KEY,
  from_city INTEGER REFERENCES destinations,
  to_city INTEGER REFERENCES destinations
)

CREATE TABLE flights
(
  id PRIMARY KEY,
  airline INTEGER REFERENCES airlines,
  departure TIMESTAMP NOT NULL,
  arrival TIMESTAMP NOT NULL,
  to_and_from INTEGER REFERENCES connected_cities
);
-- still wondering if I need to worry about seeding with the to_and_from not being seeded and the others being seeded. obviously the id isn't seeded.
-- you would enter the destinations when seeding. you would have to manually add the connected cities too, it wouldn't know what they are otherwise. and likewise, the flights table wouldn't know which connected_cities id is right for any row. 

CREATE TABLE tickets
(
  id PRIMARY KEY,
  passenger_id INTEGER REFERENCES passengers,
  flight_id INTEGER REFERENCES flights,
  seat TEXT NOT NULL
);

INSERT INTO passengers
  (first_name, last_name)
VALUES
  ('Jennifer', 'Finch'), ('Thadeus', 'Gathercoal'), ('Sonja', 'Pauley'), ('Waneta', 'Skeleton'), ('Berkie', 'Wycliff'), ('Alvin', 'Leathes'), ('Cory', 'Squibbes');

INSERT INTO destinations
  (city, country)
VALUES
  ('Washington DC', 'United States'), ('Seattle', 'United States'), ('Tokyo', 'Japan'), ('London', 'United Kingdom'), ('Los Angeles', 'United States'), ('Las Vegas', 'United States'), ('Mexico City', 'Mexico'), ('Paris', 'France'), ('Casablanca', 'Morocco'), ('Dubai', 'UAE'), ('Beijing', 'China'), ('New York', 'United States'), ('Charlotte', 'United States'), ('Cedar Rapids', 'United States'), ('Chicago', 'United States'), ('New Orleans', 'United States'), ('Sao Paolo', 'Brazil'), ('Santiago', 'Chile');

INSERT INTO airlines
  (name)
VALUES
  ('United'), ('British Airways'), ('Delta'), ('TUI Fly Belgium'), ('Air China'), ('American Airlines'), ('Avianca Brasil');

INSERT INTO flights
  (departure, arrival)
VALUES
  ('2018-04-08 09:00:00', '2018-04-08 12:00:00'), ('2018-12-19 12:45:00', '2018-12-19 16:15:00'), ('2018-01-02 07:00:00', '2018-01-02 08:03:00'), ('2018-04-15 16:50:00', '2018-04-15 21:00:00'), ('2018-08-01 18:30:00', '2018-08-01 21:50:00'), ('2018-10-31 01:15:00', '2018-10-31 12:55:00'), ('2019-02-06 06:00:00', '2019-02-06 07:47:00'), ('2018-12-22 14:42:00', '2018-12-22 15:56:00'), ('2019-02-06 16:28:00', '2019-02-06 19:18:00'), ('2019-01-20 19:30:00', '2019-01-20 22:45:00');

INSERT INTO tickets
  (seat)
VALUES
  ('33B'),
  ('8A'),
  ('12F'),
  ('20A'),
  ('23D'),
  ('18C'),
  ('9E'),
  ('1A'),
  ('32B'),
  ('10D');
