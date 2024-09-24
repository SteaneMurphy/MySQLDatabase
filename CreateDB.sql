/*
	Drops the database, recreates it and then assigns
	the database as active. This is only useful for development
	purposes when a developer needs to make changes to the
	database structure repeatably.
    
    **LECTURER NOTE**
    'USE mysql' is the default database connected to before dropping/creating
     the 'GAMEWORLDDATA' database. This default database provided with MySQL
     might differ for you.
*/
USE mysql;
DROP DATABASE IF EXISTS GAMEWORLDDATA;
CREATE SCHEMA GAMEWORLDDATA;
USE GAMEWORLDDATA;

/*
	Creates all the tables as per the database design using the
    models below. Each column has a data type and constraint, most columns
    are declared 'NOT NULL' as their values are not optional. The primary
    key columns are auto incremented as they are created.
*/
CREATE TABLE NPC (
	npcId INT AUTO_INCREMENT PRIMARY KEY,
    firstName VARCHAR(50) NOT NULL,
    lastName VARCHAR(50) NOT NULL,
    gender CHAR(1) NOT NULL
);

CREATE TABLE SKILL (
	skillId INT AUTO_INCREMENT PRIMARY KEY,
    skillName VARCHAR(50) NOT NULL,
    skillType VARCHAR(50) NOT NULL
);

CREATE TABLE FACTION (
	factionId INT AUTO_INCREMENT PRIMARY KEY,
    factionName VARCHAR(50) NOT NULL,
    factionMotto VARCHAR(100) NOT NULL,
    factionCode CHAR(3) NOT NULL
);

CREATE TABLE REGION (
	regionId INT AUTO_INCREMENT PRIMARY KEY,
    regionCode CHAR(3) NOT NULL,
    regionName VARCHAR(50) NOT NULL,
    regionType VARCHAR(50) NOT NULL,
    UNIQUE (regionCode, regionName, regionType)
);

CREATE TABLE LOCATION (
	locationId INT AUTO_INCREMENT PRIMARY KEY,
    locationName VARCHAR(50) NOT NULL,
    regionId INT NOT NULL,
    FOREIGN KEY (regionId) REFERENCES REGION(regionId)
);

CREATE TABLE QUEST (
	questId INT AUTO_INCREMENT PRIMARY KEY,
    questName VARCHAR(100),
    locationId INT NOT NULL,
    FOREIGN KEY (locationId) REFERENCES LOCATION(locationId)
);

/*
	Creates all the junction tables as per the database design.
    These tables are created after the main tables as they reference
    other table primary keys.
*/
CREATE TABLE NPCSKILL (
	npcSkillId INT AUTO_INCREMENT PRIMARY KEY,
    npcId INT NOT NULL,
    skillId INT NOT NULL,
    FOREIGN KEY (npcId) REFERENCES NPC(npcId),
    FOREIGN KEY (skillId) REFERENCES SKILL(skillId)
);

CREATE TABLE NPCFACTION (
	npcFactionId INT AUTO_INCREMENT PRIMARY KEY,
    npcId INT NOT NULL,
    factionId INT NOT NULL,
    FOREIGN KEY (npcId) REFERENCES NPC(npcId),
    FOREIGN KEY (factionId) REFERENCES FACTION(factionId)
);

CREATE TABLE NPCQUEST (
	npcQuestId INT AUTO_INCREMENT PRIMARY KEY,
    npcId INT NOT NULL,
    questId INT NOT NULL,
    FOREIGN KEY (npcId) REFERENCES NPC(npcId),
    FOREIGN KEY (questId) REFERENCES QUEST(questId)
);