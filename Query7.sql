/*
Add a one-to-many relationship between the 'Factions' and 'Skills' to
the already existing database. Call this new relationship 'Favourite Skill'
and update each faction with the following skills;
	- School of Magicians: Fireball
    - Warriors United: Lunging Strike
    - Rogues Guild: Steal
After adding the above requirements for Query 7, print each Faction with its
Favourite Skill.
Display Columns: Faction Name, Favourite Skill Name.
*/

ALTER TABLE FACTION
ADD COLUMN favouriteSkill INT;

ALTER TABLE FACTION
ADD CONSTRAINT fk_favouriteSkill
FOREIGN KEY (favouriteSkill)
REFERENCES SKILL (skillId);

SET SQL_SAFE_UPDATES = 0;
UPDATE FACTION f
SET f.favouriteSkill = (
    CASE 
        WHEN f.factionName = 'School of Magicians' THEN (
            SELECT sk.skillId FROM SKILL sk WHERE sk.skillName = 'Fireball'
        )
        WHEN f.factionName = 'Warriors United' THEN (
            SELECT sk.skillId FROM SKILL sk WHERE sk.skillName = 'Lunging Strike'
        )
        WHEN f.factionName = 'Rogues Guild' THEN (
            SELECT sk.skillId FROM SKILL sk WHERE sk.skillName = 'Steal'
        )
        ELSE f.favouriteSkill
END
);
SET SQL_SAFE_UPDATES = 1;

SELECT factionName, skillName
FROM FACTION f
JOIN SKILL s ON f.favouriteSkill = s.skillId;

/*
	STATEMENT EXPLANATION
    
    The ALTER TABLE command was used to change the existing table schema. In this case it
    was first used to add a new column to the FACTION table. It was then used to modufy
    the new column, making it a foreign key that references 'skillId' in the SKILL table.
    
    Currently the MySQL database has update safety mode on so the command 'SET SQL_SAFE_UPDATES'
    was utilised to temporarily remove this constraint and allow the update. Without doing this
    the safety system requires a complex statement that references a table id to every update.
    
    The new column 'favouriteSkill' was updated using a SET/END command block and the conditions 
    on how and when it is changed was determined by the CASE/WHEN command. Each instance of 
    'favouriteSkill' was matched with its appropriate 'skillName' from the SKILL table as per
    the conditions.
    
    The final SELECT statement simply prints the factionName and its associated skillName for
    its match to 'favouriteSkill'.
*/