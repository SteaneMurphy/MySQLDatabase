/*
	Change the data type of the field 'Gender' to CHAR() and update every NPC
    to hold the values 'Male' and 'Female' instead of 'M' and 'F' respectively
    using a single update call. Then show all NPCs.
    Display Columns: First Name, Last Name and Gender.
*/

ALTER TABLE NPC
MODIFY gender CHAR(6);

SET SQL_SAFE_UPDATES = 0;
UPDATE NPC
SET gender = CASE 
	WHEN gender = 'M' THEN 'Male' 
	WHEN gender = 'F' THEN 'Female' 
	ELSE gender 
END;
SET SQL_SAFE_UPDATES = 1;

SELECT firstName, lastName, gender FROM NPC;

/*
	STATEMENT EXPLANATION
    
    The ALTER TABLE and MODIFY command was used to change the existing table 'NPC'.
    The column 'gender' was modified from CHAR(1) to CHAR(6) to allow for the change
    from a single character to a word.alter
    
    As explained in Query 7, the database safety mode was temporarily turned off to
    allow the update to proceed.
    
    The SET/END command block was used to match on the provided conditions and change
	each instance of gender in the table to the new desired data.
    
    The SELECT statement then prints these changes with the firstName, lastName and gender columns.
*/