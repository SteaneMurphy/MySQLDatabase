-- Print all members of the 'Rogue's Guild' in ascending order.
-- Display Columns: First Name, Last Name, Gender and Faction Code.
SELECT firstName, lastName, gender, factionName
FROM NPC n
JOIN NPCFACTION nf ON n.npcId = nf.npcId
JOIN FACTION f ON nf.factionId = f.factionId
WHERE f.factionName = 'Rogues Guild'
ORDER BY n.firstName ASC;

/*
	STATEMENT EXPLANATION
    
    The SELECT command was used to print all the listed columns that
    matched the faction name 'Rogues Guild'. The ORDER BY command was
    used to display the results in ascending order.
    
    The JOIN command was used to match the 'npcId' through the tables 
    NPCFACTION and FACTION.
*/