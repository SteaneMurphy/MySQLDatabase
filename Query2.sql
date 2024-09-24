-- Print all Female NPCs.
-- Display Columns: First Name and Last Name.
SELECT firstName, lastName 
FROM NPC 
WHERE gender = 'F';

/*
	STATEMENT EXPLANATION
    
    The SELECT statement was used to print all the 'firstName'
    and 'lastName' columns. The WHERE command was used to only
    display those rows that matched gender='F'.
*/