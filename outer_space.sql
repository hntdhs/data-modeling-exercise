-- from the terminal run:
-- psql < outer_space.sql

DROP DATABASE IF EXISTS outer_space;

CREATE DATABASE outer_space;

\c outer_space
-- this is the original code that came with the file:
-- CREATE TABLE planets
-- (
--   id SERIAL PRIMARY KEY,
--   name TEXT NOT NULL,
--   orbital_period_in_years FLOAT NOT NULL,
--   orbits_around TEXT NOT NULL,
--   galaxy TEXT NOT NULL,
--   moons TEXT[]
-- );
-- lots of duplication with orbits around and galaxy
-- is it ok that with something like the moon column there's going to be multiple id's? - looked at the products example that's normalized in the pdf, it looks like they only use one id for color on a product that has two colors in the bad example, so I don't know

CREATE TABLE planets
(
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  orbital_period_in_years FLOAT NOT NULL,
  orbits_around TEXT NOT NULL,
  galaxy TEXT NOT NULL
);

CREATE TABLE moons
(
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL
);

CREATE TABLE planet_moon_associations
(
  id SERIAL PRIMARY KEY,
  planet_id INTEGER REFERENCES planets,
  moon_id INTEGER REFERENCES moons
);

INSERT INTO planets
  (name, orbital_period_in_years, orbits_around, galaxy)
VALUES
  ('Earth', 1.00, 'The Sun', 'Milky Way'),
  ('Mars', 1.88, 'The Sun', 'Milky Way'),
  ('Venus', 0.62, 'The Sun', 'Milky Way'),
  ('Neptune', 164.8, 'The Sun', 'Milky Way'),
  ('Proxima Centauri b', 0.03, 'Proxima Centauri', 'Milky Way'),
  ('Gliese 876 b', 0.23, 'Gliese 876', 'Milky Way');

INSERT INTO moons
  (name)
VALUES
  ('The Moon'), ('Phobos'), ('Deimos'), ('Naiad'), ('Thalassa'), ('Despina'), ('Galatea'), ('Larissa'), ('5/2004 N 1'), ('Proteus'), ('Triton'), ('Nereid'), ('Halimede'), ('Sao'), ('Laomedeia'), ('Psamathe'), ('Neso');