SELECT count(*)
FROM (
    SELECT p1.rowid AS p1_denseid, p1.id AS p1_sparseid,
           p2.rowid AS p2_denseid, p2.id AS p2_sparseid
    FROM Person_knows_Person pkp
    JOIN Person p1
    ON pkp.Person1id = p1.id
    JOIN Person p2
    ON pkp.Person2id = p2.id
) sub;
