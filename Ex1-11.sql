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

#Ex5 Create a table called "slowest_animals" with three columns : 'animal', 'species' and 'speed',
# where the first two columns will have a character data type and the 'speed' will be a decimal number with 6 decimal places.

CREATE TABLE slowest_animals
(
    animal VARCHAR(50),
    spieces VARCHAR(50),
    speed DECIMAL(8,6)
);

