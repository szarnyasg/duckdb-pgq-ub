DROP TABLE IF EXISTS Person;
DROP TABLE IF EXISTS Person_knows_Person;

PRAGMA force_index_join;
CREATE TABLE Person (id bigint PRIMARY KEY, isLocatedIn_City bigint);
CREATE TABLE Person_knows_Person (Person1id bigint, Person2id bigint);

COPY Person FROM 'PATHVAR/Person.csv' (DELIMITER '|', HEADER, FORMAT csv);
COPY Person_knows_Person (Person1id, Person2id) FROM 'PATHVAR/Person_knows_Person.csv' (DELIMITER '|', HEADER, FORMAT csv);
COPY Person_knows_Person (Person2id, Person1id) FROM 'PATHVAR/Person_knows_Person.csv' (DELIMITER '|', HEADER, FORMAT csv);
