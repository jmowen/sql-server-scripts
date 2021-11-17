/*
 how can I get the referenced table + column name from a foreign key?

Note: Not the table/column where the key is in, but the key it refers to.

variation
find all the "Key" and "ID" columns having/missing a constraint...columns compared to the list of all PK OR FK OR Null
*/

SELECT  
    fk.name,
    OBJECT_NAME(fk.parent_object_id) 'Parent table',
    c1.name 'Parent column',
    OBJECT_NAME(fk.referenced_object_id) 'Referenced table',
    c2.name 'Referenced column'
FROM 
    sys.foreign_keys fk
INNER JOIN 
    sys.foreign_key_columns fkc ON fkc.constraint_object_id = fk.object_id
INNER JOIN
    sys.columns c1 ON fkc.parent_column_id = c1.column_id AND fkc.parent_object_id = c1.object_id
INNER JOIN
    sys.columns c2 ON fkc.referenced_column_id = c2.column_id AND fkc.referenced_object_id = c2.object_id
