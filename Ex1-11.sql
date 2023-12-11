#Ex1 Delete the created 'animals' database and check if it has been deleted.

DROP DATABASE animals;
SHOW DATABASES;

#Ex2 Enter the information_schema database and list the available tables to the window.

USE information_schema;
SHOW TABLES;

#Ex3 Display the structure of the table containing units of measurement.

DESC st_units_of_measure;

#Ex4 Create a new "fastest_animals" database.

CREATE DATABASE fastest_animals;

/*
Ex5 
Create a table called "slowest_animals" with three columns : 'animal', 'species' and 'speed',
where the first two columns will have a character data type and the 'speed' will be a decimal number with 6 decimal places.
*/

CREATE TABLE slowest_animals
(
    animal VARCHAR(50),
    spieces VARCHAR(50),
    max_speed DECIMAL(8,6)
);

/*
Ex6
Insert the following data into the table (note the order):
American Woodcock, bird, 8.0
Giant Tortoise, reptile, 1.6
fish, Seahorse, 0.0161
Banana Snail, 0.000083
Reef, corals

View entered data.
*/

INSERT INTO slowest_animals(animal, spieces, max_speed)
VALUES ('American Woodcock', 'bird', 8.0);

INSERT INTO slowest_animals(animal, spieces, max_speed)
VALUES ('Giant Tortoise', 'reptile', 1.6);

INSERT INTO slowest_animals(spieces, animal, max_speed)
VALUES ('fish', 'Seahorse', 0.0161);

INSERT INTO slowest_animals(animal, max_speed)
VALUES ('Banana Snail', 0.000083);

INSERT INTO slowest_animals(animal, spieces)
VALUES ('Reef', 'corals');

SELECT * FROM slowest_animals;

/*
Ex7
Add two more animals to the table:
Falco subbuteo - reaching a speed of 160km/h
Cheetah - reaching a speed of 120km/h
Ensure safe access to Falco subbuteo with ID=173, then add the Cheetah without specifying an ID number.
What ID number was assigned to the Cheetah?
*/

INSERT INTO unique_fastest (animal_ID, animal, max_speed)
VALUES (173, 'Falco subbuteo', 160);

INSERT INTO unique_fastest (animal, max_speed)
VALUES ('Cheetah', 120);

SELECT * FROM unique_fastest;

/* USE DATABSE SAKILA
Ex8
Display the first 50 movies, with their titles and rating.
*/

SELECT title, rating FROM film LIMIT 50;

