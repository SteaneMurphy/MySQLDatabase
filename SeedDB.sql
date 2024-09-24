/*
	A temporary table is created to hold all of the data from the
    provided CSV file. The LOAD DATA INFILE command is used to populate this
    temporary table, column by column.
    
    **LECTURER NOTE**
    Due to safety features of the MySQL database, the provided CSV file must be
    loaded from the 'uploads' folder in the MySQLWorkbench directory. This path may
    differ for you and may need to be changed below. You will also need to manually
    add the CSV file to this path.alter
    PLEASE NOTE: since an .xlsx file was provided, which is incompatible with MySQLWorkbench,
				 I have converted the file to .csv. This means that the file may differ slightly.
                 There was an invisible carriage return in my CSV file that there is specific code
                 designed to remove. This code may fail if you do not use my CSV file.
*/
CREATE TABLE STAGING (
	firstName VARCHAR(50),
    lastName VARCHAR(50),
    gender CHAR(1),
    factionCode CHAR(3),
    factionName VARCHAR(50),
    factionMotto VARCHAR(100),
    skillName VARCHAR(50),
    skillType VARCHAR(50),
    questName VARCHAR(100),
    locationName VARCHAR(50),
    regionCode VARCHAR(3),
    regionName VARCHAR(50),
    regionType VARCHAR(50)
);

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\Assessment_1_Game_World_Data.csv'
INTO TABLE STAGING
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

/*
	since QUEST contains a foreign key to LOCATION, and LOCATION contains
	a foreign key to REGION, the tables must be seeded in the following order:
    REGION -> LOCATION -> QUEST
*/
INSERT INTO NPC (firstName, lastName, gender)
SELECT DISTINCT firstName, lastName, gender FROM STAGING;

INSERT INTO SKILL (skillName, skillType)
SELECT DISTINCT skillName, skillType FROM STAGING;

INSERT INTO FACTION (factionName, factionMotto, factionCode)
SELECT DISTINCT factionName, factionMotto, factionCode FROM STAGING;

/*
	There is an error with the last row of the supplied CSV file. The final field
    contains an invisible carriage return. This was confirmed using hex comparison on
    the affected field and another 'duplicate' field.
    
    The 'TRIM' and 'TRAILING '\r' command removes this hidden carriage return value and
    prevents the duplication error.
*/
INSERT INTO REGION (regionCode, regionName, regionType)
SELECT DISTINCT regionCode, regionName, TRIM(TRAILING '\r' FROM regionType)
FROM STAGING;

INSERT INTO LOCATION (locationName, regionId)
SELECT DISTINCT s.locationName, r.regionId
FROM STAGING s
JOIN REGION r ON s.regionCode = r.regionCode;

INSERT INTO QUEST (questName, locationId)
SELECT DISTINCT s.questName, l.locationId
FROM STAGING s
JOIN LOCATION l ON s.locationName = l.locationName;

/*
	-- JUNCTION TABLE SEEDING --

	The junction table seeding commands are all the same but reference three different tables.
    I will explain the logic here for the PLAYERSKILL table, but please note that the command applies 
    to all three junction table seeds.
    
    Insert new entries into the table PLAYERSKILL that meet the following conditions:
     - All new entries must be unique, ignore duplicates (DISTINCT keyword).
     - From the PLAYER table, find any match on 'firstName' in both the PLAYER and STAGING tables.
     - From the SKILL table, find any match on 'skillName' in both the SKILL and STAGING tables.
     - For each matched pair in the PLAYER and SKILL tables, a new entry is added to PLAYERSKILL.
     - This new entry uses the associated playerId and skillId returned during the matched conditions.
*/
INSERT INTO NPCSKILL (npcId, skillId)
SELECT DISTINCT n.npcId, sk.skillId
FROM NPC n
JOIN STAGING s ON n.firstName = s.firstName
JOIN SKILL sk ON s.skillName = sk.skillName;

INSERT INTO NPCFACTION (npcId, factionId)
SELECT DISTINCT n.npcId, f.factionId
FROM NPC n
JOIN STAGING s ON n.firstName = s.firstName
JOIN FACTION f ON s.factionName = f.factionName;

INSERT INTO NPCQUEST (npcId, questId)
SELECT DISTINCT n.npcId, q.questId
FROM NPC n
JOIN STAGING s ON n.firstName = s.firstName
JOIN QUEST q ON s.questName = q.questName;

-- remove the staging table once data has been extracted
DROP TABLE STAGING;