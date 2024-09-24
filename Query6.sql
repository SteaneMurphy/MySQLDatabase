-- Print the number of quests given in each location.
-- Display Columns: Location Name, Number of quests.
SELECT locationName, COUNT(DISTINCT questName) AS numberOfQuests
FROM QUEST q
JOIN LOCATION l ON l.locationId = q.locationId
GROUP BY l.locationName;

/*
	STATEMENT EXPLANATION
    
    The SELECT command is used to print all instances of questName
    in the table QUEST. The COUNT command is used to tally how many
    unique instances of questName are returned (DISTINCT).
    
    The JOIN command is used to match on 'questName' in relation to
    its associated 'locationId' and the informed to collate all results
    that are the same by the GROUP BY command.
    
    This results in counting how many quests exist for each unique location
    in the database.
*/