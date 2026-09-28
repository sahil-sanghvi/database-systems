-- Author: Sahil Sanghvi

/*
This assignment introduces an example concerning World War II capital ships.
It involves the following relations:

Classes(class, type, country, numGuns, bore, displacement)
Ships(name, class, launched)  --launched is for year launched
Battles(name, date_fought)
Outcomes(ship, battle, result)

Ships are built in "classes" from the same design, and the class is usually
named for the first ship of that class.

Relation Classes records the name of the class,
the type (bb for battleship or bc for battlecruiser),
the country that built the ship, the number of main guns,
the bore (diameter of the gun barrel, in inches)
of the main guns, and the displacement (weight, in tons).

Relation Ships records the name of the ship, the name of its class,
and the year in which the ship was launched.

Relation Battles gives the name and date of battles involving these ships.

Relation Outcomes gives the result (sunk, damaged, or ok)
for each ship in each battle.
*/


/*
Exercise 1. (1 point)

1.	Create simple SQL statements to create the above relations
    (no constraints for initial creations).
2.	Insert the following data.

For Classes:
('Bismarck','bb','Germany',8,15,42000);
('Kongo','bc','Japan',8,14,32000);
('North Carolina','bb','USA',9,16,37000);
('Renown','bc','Gt. Britain',6,15,32000);
('Revenge','bb','Gt. Britain',8,15,29000);
('Tennessee','bb','USA',12,14,32000);
('Yamato','bb','Japan',9,18,65000);

For Ships
('California','Tennessee',1921);
('Haruna','Kongo',1915);
('Hiei','Kongo',1914);
('Iowa','Iowa',1943);
('Kirishima','Kongo',1914);
('Kongo','Kongo',1913);
('Missouri','Iowa',1944);
('Musashi','Yamato',1942);
('New Jersey','Iowa',1943);
('North Carolina','North Carolina',1941);
('Ramilles','Revenge',1917);
('Renown','Renown',1916);
('Repulse','Renown',1916);
('Resolution','Revenge',1916);
('Revenge','Revenge',1916);
('Royal Oak','Revenge',1916);
('Royal Sovereign','Revenge',1916);
('Tennessee','Tennessee',1920);
('Washington','North Carolina',1941);
('Wisconsin','Iowa',1944);
('Yamato','Yamato',1941);

For Battles
('North Atlantic','27-May-1941');
('Guadalcanal','15-Nov-1942');
('North Cape','26-Dec-1943');
('Surigao Strait','25-Oct-1944');

For Outcomes
('Bismarck','North Atlantic', 'sunk');
('California','Surigao Strait', 'ok');
('Duke of York','North Cape', 'ok');
('Fuso','Surigao Strait', 'sunk');
('Hood','North Atlantic', 'sunk');
('King George V','North Atlantic', 'ok');
('Kirishima','Guadalcanal', 'sunk');
('Prince of Wales','North Atlantic', 'damaged');
('Rodney','North Atlantic', 'ok');
('Scharnhorst','North Cape', 'sunk');
('South Dakota','Guadalcanal', 'ok');
('West Virginia','Surigao Strait', 'ok');
('Yamashiro','Surigao Strait', 'sunk');
*/
-- Drop tables with CASCADE to remove dependent views
DROP TABLE IF EXISTS Outcomes CASCADE;
DROP TABLE IF EXISTS Ships CASCADE;
DROP TABLE IF EXISTS Battles CASCADE;
DROP TABLE IF EXISTS Classes CASCADE;

-- Also drop the views explicitly if needed
DROP VIEW IF EXISTS OutcomesView CASCADE;
DROP VIEW IF EXISTS ShipsV CASCADE;
DROP VIEW IF EXISTS OutcomesV CASCADE;
-- Create tables
CREATE TABLE Classes (
    class VARCHAR(50),
    type VARCHAR(5),
    country VARCHAR(50),
    numGuns INT,
    bore FLOAT,
    displacement INT
);

CREATE TABLE Ships (
    name VARCHAR(50),
    class VARCHAR(50),
    launched INT
);

CREATE TABLE Battles (
    name VARCHAR(50),
    date_fought VARCHAR(20)
);

CREATE TABLE Outcomes (
    ship VARCHAR(50),
    battle VARCHAR(50),
    result VARCHAR(20)
);

-- Insert data into Classes
INSERT INTO Classes VALUES ('Bismarck','bb','Germany',8,15,42000);
INSERT INTO Classes VALUES ('Kongo','bc','Japan',8,14,32000);
INSERT INTO Classes VALUES ('North Carolina','bb','USA',9,16,37000);
INSERT INTO Classes VALUES ('Renown','bc','Gt. Britain',6,15,32000);
INSERT INTO Classes VALUES ('Revenge','bb','Gt. Britain',8,15,29000);
INSERT INTO Classes VALUES ('Tennessee','bb','USA',12,14,32000);
INSERT INTO Classes VALUES ('Yamato','bb','Japan',9,18,65000);

-- Insert data into Ships
INSERT INTO Ships VALUES ('California','Tennessee',1921);
INSERT INTO Ships VALUES ('Haruna','Kongo',1915);
INSERT INTO Ships VALUES ('Hiei','Kongo',1914);
INSERT INTO Ships VALUES ('Iowa','Iowa',1943);
INSERT INTO Ships VALUES ('Kirishima','Kongo',1914);
INSERT INTO Ships VALUES ('Kongo','Kongo',1913);
INSERT INTO Ships VALUES ('Missouri','Iowa',1944);
INSERT INTO Ships VALUES ('Musashi','Yamato',1942);
INSERT INTO Ships VALUES ('New Jersey','Iowa',1943);
INSERT INTO Ships VALUES ('North Carolina','North Carolina',1941);
INSERT INTO Ships VALUES ('Ramilles','Revenge',1917);
INSERT INTO Ships VALUES ('Renown','Renown',1916);
INSERT INTO Ships VALUES ('Repulse','Renown',1916);
INSERT INTO Ships VALUES ('Resolution','Revenge',1916);
INSERT INTO Ships VALUES ('Revenge','Revenge',1916);
INSERT INTO Ships VALUES ('Royal Oak','Revenge',1916);
INSERT INTO Ships VALUES ('Royal Sovereign','Revenge',1916);
INSERT INTO Ships VALUES ('Tennessee','Tennessee',1920);
INSERT INTO Ships VALUES ('Washington','North Carolina',1941);
INSERT INTO Ships VALUES ('Wisconsin','Iowa',1944);
INSERT INTO Ships VALUES ('Yamato','Yamato',1941);

-- Insert data into Battles
INSERT INTO Battles VALUES ('North Atlantic','27-May-1941');
INSERT INTO Battles VALUES ('Guadalcanal','15-Nov-1942');
INSERT INTO Battles VALUES ('North Cape','26-Dec-1943');
INSERT INTO Battles VALUES ('Surigao Strait','25-Oct-1944');

-- Insert data into Outcomes
INSERT INTO Outcomes VALUES ('Bismarck','North Atlantic', 'sunk');
INSERT INTO Outcomes VALUES ('California','Surigao Strait', 'ok');
INSERT INTO Outcomes VALUES ('Duke of York','North Cape', 'ok');
INSERT INTO Outcomes VALUES ('Fuso','Surigao Strait', 'sunk');
INSERT INTO Outcomes VALUES ('Hood','North Atlantic', 'sunk');
INSERT INTO Outcomes VALUES ('King George V','North Atlantic', 'ok');
INSERT INTO Outcomes VALUES ('Kirishima','Guadalcanal', 'sunk');
INSERT INTO Outcomes VALUES ('Prince of Wales','North Atlantic', 'damaged');
INSERT INTO Outcomes VALUES ('Rodney','North Atlantic', 'ok');
INSERT INTO Outcomes VALUES ('Scharnhorst','North Cape', 'sunk');
INSERT INTO Outcomes VALUES ('South Dakota','Guadalcanal', 'ok');
INSERT INTO Outcomes VALUES ('West Virginia','Surigao Strait', 'ok');
INSERT INTO Outcomes VALUES ('Yamashiro','Surigao Strait', 'sunk');



-- Exercise 2. (6 points)
-- Write SQL queries for the following requirements.

-- 1.	(2 pts) List the name, displacement, and number of guns of the ships engaged in the battle of Guadalcanal.
/*
Expected result:
ship,displacement,numguns
Kirishima,32000,8
South Dakota,NULL,NULL
*/

-- Write your query here.

SELECT o.ship, c.displacement, c.numGuns
FROM Outcomes o
LEFT JOIN Ships s ON o.ship = s.name
LEFT JOIN Classes c ON s.class = c.class
WHERE o.battle = 'Guadalcanal';


-- 2.	(2 pts) Find the names of the ships whose number of guns was the largest for those ships of the same bore.

-- Write your query here.

SELECT s.name
FROM Ships s
JOIN Classes c ON s.class = c.class
WHERE c.numGuns = (
    SELECT MAX(c2.numGuns)
    FROM Classes c2
    WHERE c2.bore = c.bore
);


--3. (2 pts) Find for each class with at least three ships the number of ships of that class sunk in battle.
/*
class,sunk_ships
Revenge,0
Kongo,1
Iowa,0
*/

-- Write your query here.

SELECT s.class,
       COUNT(CASE WHEN o.result = 'sunk' THEN 1 END) AS sunk_ships
FROM Ships s
LEFT JOIN Outcomes o ON s.name = o.ship
GROUP BY s.class
HAVING COUNT(s.name) >= 3;



-- Exercise 3. (4 points)

-- Write the following modifications.

-- 1.	(2 points) Two of the three battleships of the Italian Vittorio Veneto class –
-- Vittorio Veneto and Italia – were launched in 1940;
-- the third ship of that class, Roma, was launched in 1942.
-- Each had 15-inch guns and a displacement of 41,000 tons.
-- Insert these facts into the database.

-- Write your sql statements here.

INSERT INTO Classes VALUES ('Vittorio Veneto', 'bb', 'Italy', NULL, 15, 41000);
INSERT INTO Ships VALUES ('Vittorio Veneto', 'Vittorio Veneto', 1940);
INSERT INTO Ships VALUES ('Italia', 'Vittorio Veneto', 1940);
INSERT INTO Ships VALUES ('Roma', 'Vittorio Veneto', 1942);


-- 2.	(1 point) Delete all classes with fewer than three ships.

-- Write your sql statement here.

DELETE FROM Classes
WHERE class NOT IN (
    SELECT class
    FROM Ships
    GROUP BY class
    HAVING COUNT(*) >= 3
);


-- 3.	(1 point) Modify the Classes relation so that gun bores are measured in centimeters
-- (one inch = 2.5 cm) and displacements are measured in metric tons (one metric ton = 1.1 ton).

-- Write your sql statement here.

UPDATE Classes
SET bore = bore * 2.5,
    displacement = displacement / 1.1;



-- Exercise 4.  (9 points)
-- Add the following constraints using views with check option.

--1. (3 points) No ship can be in battle before it is launched.

-- Write your sql statement here.

CREATE VIEW OutcomesView AS
SELECT o.*
FROM Outcomes o
WHERE NOT EXISTS (
    SELECT 1
    FROM Ships s
    JOIN Battles b ON o.battle = b.name
    WHERE s.name = o.ship
    AND TO_DATE(b.date_fought, 'DD-Mon-YYYY') < TO_DATE(s.launched || '-01-01', 'YYYY-MM-DD')
)
WITH CHECK OPTION;

-- Now we can try some insertion on this view.
INSERT INTO OutcomesView (ship, battle, result)
VALUES('Musashi', 'North Atlantic','ok');
-- This insertion, as expected, should fail since Musashi is launched in 1942,
-- while the North Atlantic battle took place on 27-MAY-41.


-- 2. (3 points) No ship can be launched before
-- the ship that bears the name of the first ship's class.

-- Write your sql statement here.

CREATE VIEW ShipsV AS
SELECT s.*
FROM Ships s
WHERE NOT EXISTS (
    SELECT 1
    FROM Ships first_ship
    WHERE first_ship.name = s.class
    AND s.launched < first_ship.launched
)
WITH CHECK OPTION;

-- Now we can try some insertion on this view.
INSERT INTO ShipsV(name, class, launched)
VALUES ('AAA','Kongo',1912);
-- This insertion, as expected, should fail since ship Kongo (first ship of class Kongo) is launched in 1913.


--3. (3 points) No ship fought in a battle that was at a later date than another battle in which that ship was sunk.

-- Write your sql statements here.

CREATE VIEW OutcomesV AS
SELECT o.*
FROM Outcomes o
WHERE NOT EXISTS (
    SELECT 1
    FROM Outcomes o2
    JOIN Battles b1 ON o.battle = b1.name
    JOIN Battles b2 ON o2.battle = b2.name
    WHERE o.ship = o2.ship
    AND o2.result = 'sunk'
    AND TO_DATE(b1.date_fought, 'DD-Mon-YYYY') > TO_DATE(b2.date_fought, 'DD-Mon-YYYY')
)
WITH CHECK OPTION;

-- Now we can try some insertion on this view.
INSERT INTO OutcomesV(ship, battle, result)
VALUES('Bismarck', 'Guadalcanal', 'ok');
-- This insertion, as expected, should fail since 'Bismarck' was sunk in
-- the battle of North Atlantic, in 1941, whereas the battle of Guadalcanal happened in 1942.
