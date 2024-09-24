-- Print all Quests that are given out by 'Warriors United' in a 'Large Scale City'.
-- Display Columns: Quest Name, NPC First Name.
SELECT q.questName, n.firstName
FROM NPC n
JOIN NPCQUEST nq ON n.npcId = nq.npcId
JOIN QUEST q ON q.questId = nq.questId
JOIN LOCATION l ON l.locationId = q.locationId
JOIN REGION r ON r.regionId = l.regionId
JOIN NPCFACTION nf ON n.npcId = nf.npcId
JOIN FACTION f ON f.factionId = nf.factionId
WHERE f.factionName = 'Warriors United'
AND r.regionType = 'Large Scale City';

/*
	STATEMENT EXPLANATION
    
    The SELECT statement is used to print all 'questName' and 'firstName'
    that match the conditions at the end. To find all the matches each 
    consecutive table had to be traversed using the JOIN command.
    
    Based on how the database is laid out, to match those conditions the 
    statement had to take an NPC primary key and match it through each table until
    it reached a match in both the FACTION and REGION tables.
    
    This is one of the drawbacks of a relational database vs an object database.
*/