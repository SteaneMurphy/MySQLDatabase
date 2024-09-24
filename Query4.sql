-- Print all Quests given from NPCs in the location 'Arcane Capital'.
-- Display Columns: Quest Name, NPC First Name.
SELECT questName, firstName
FROM QUEST q
JOIN NPCQUEST nq ON q.questId = nq.questId
JOIN NPC n ON nq.npcId = n.npcId
JOIN LOCATION l ON q.locationId = l.locationId
WHERE l.locationName = 'Arcane Capital';

/*
	STATEMENT EXPLANATION
    
    The SELECT command was used to print all 'questName'
	and 'firstName' columns that matched the location name
    'Arcane Capital'.
    
    The 'questId' was matched through tables NPCQUEST, NPC and LOCATION
    to find the relevant entires that match the primary key using multiple
    JOIN commands.
*/
