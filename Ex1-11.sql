#Ex1 Delete the created 'animals' database and check if it has been deleted.

DROP DATABASE animals;
SHOW DATABASES;

#Ex2 Enter the information_schema database and list the available tables to the window.

USE information_schema;
SHOW TABLES;

#Ex3 Display the structure of the table containing units of measurement.

DESC st_units_of_measure;