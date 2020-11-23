CREATE VIEW personsview AS
SELECT persons.`FirstName`,orders.`OrderNo` FROM persons 
LEFT JOIN orders
ON persons.`NEWID`=orders.`ID`
ORDER BY OrderNo

SELECT * FROM `personsview` WHERE orderno>'40000'

SELECT persons.`FirstName`,orders.`OrderNo` FROM persons 
NATURAL JOIN orders

UPDATE  `persons` SET LastName='JACK' WHERE `persons`.`﻿ID`=1

UPDATE `persons`,`personsnew` SET `persons`.`Address`=`personsnew`.`Address`,
`persons`.`FirstName`=`personsnew`.`FirstName`,
`persons`.`LastName`=`personsnew`.`LastName` 
WHERE `persons`.`﻿ID`=`personsnew`.`﻿ID`

SELECT persons.`FirstName` FROM persons 
INNER JOIN orders ON persons.`﻿ID`=orders.`ID` WHERE orders.`ID`='3' AND orders.`OrderNo`='77895'

UPDATE persons SET FirstName=(SELECT FirstName FROM `personsnew` WHERE city='New York') WHERE persons.city='London'

UPDATE persons SET LastName=(
SELECT  `personsnew`.`FirstName` FROM `personsnew` 
INNER JOIN orders ON `personsnew`.`﻿ID`=orders.`ID` WHERE orders.`ID`='1' AND orders.`OrderNo`='24562')
WHERE persons.`Address`='Oxford Street' AND persons.`LastName`='Lee'

UPDATE persons SET lastName=(
SELECT personsnew.`FirstName` FROM personsnew 
WHERE personsnew.`City`='New York' AND personsnew.`Address`='Changan Street' )

INSERT INTO persons (NEWID,LastName,FirstName,Address,City) VALUES ('7','LEI','ZHANG','ZHEJIANG','HANGZHOU')

ALTER TABLE persons ADD height VARCHAR(100) NOT NULL

ALTER TABLE persons DROP COLUMN `height`

ALTER TABLE persons ADD UNIQUE (NEWID)

ALTER TABLE persons ADD NEWID VARCHAR(100) NOT NULL

SELECT MIN(GoodRetail) FROM `rbvehicle202010` WHERE FamilyCode='E300' AND YearGroup='2020'

SELECT COUNT(VehicleKey) ,MIN(GoodRetail),VehicleKey,YearGroup FROM `rbvehicle202010` WHERE FamilyCode='E300' 


SELECT DISTINCT FamilyCode AS FamilyCode2 FROM `rbvehicle202010`WHERE YearGroup='2020' AND VehicleKey IS NOT NULL
SELECT DISTINCT FamilyCode AS FamilyCode2 FROM `rbvehicle202010`WHERE YearGroup='2020' AND VehicleKey IS NOT NULL

/*
In the result second select
The familycode in 2019 No extension to 2020
*/
SELECT DISTINCT MakeCode,FamilyCode FROM `rbvehicle202010` WHERE FamilyCode IN (
SELECT FamilyCode FROM 
(SELECT DISTINCT FamilyCode FROM `rbvehicle202010`WHERE YearGroup='2019' AND VehicleKey IS NOT NULL) temp
WHERE temp.familycode NOT IN (SELECT DISTINCT FamilyCode  FROM `rbvehicle202010`WHERE YearGroup='2020' AND VehicleKey IS NOT NULL)
ORDER BY FamilyCode
)

/*
In the result second select
The Description in 2019 No extension to 2020
*/

SELECT MakeCode,FamilyCode,YearGroup, Description FROM `rbvehicle202011` WHERE rbvehicle202011.`Description` IN (
SELECT Description FROM 
(SELECT DISTINCT Description FROM `rbvehicle202011`WHERE YearGroup='2019' ) temp
WHERE temp.Description NOT IN (SELECT DISTINCT Description  FROM `rbvehicle202011`WHERE YearGroup='2020' )
)
AND YearGroup='2019'
ORDER BY MakeCode,FamilyCode

/*
monthly passenger vehicle have not been entry new prices
*/

SELECT * FROM `rbvehicle202011` WHERE (VehicleTypeCode='PS' OR VehicleTypeCode='SV')AND YearGroup='2020' AND NewPrice IS NULL

/*
monthly update vehicle
*/

SELECT * FROM `rbvehicle202011` WHERE VehicleKey IN (
SELECT VehicleKey FROM `rbvehicle202011` temp 
WHERE temp.VehicleKey NOT IN (SELECT VehicleKey FROM `rbvehicle202010`) 
)

/*
select using the 'having' and 'group by' keyword
*/
SELECT MakeCode,FamilyCode,Description,YearGroup,AVG(GoodRetail)FROM`rbvehicle202010`
WHERE (MakeCode='BMW' OR MakeCode='MERC'OR MakeCode='AUDI') AND YearGroup='2018'
GROUP BY FamilyCode
HAVING AVG(GoodRetail)>'500000'
ORDER BY FamilyCode


SELECT VehicleKey ,MakeCode,FamilyCode,Description,YearGroup,MAX(GoodRetail) FROM`rbvehicle202010`
WHERE (MakeCode='BMW' OR MakeCode='MERC'OR MakeCode='AUDI') AND (YearGroup='2018'OR YearGroup='2019')
GROUP BY FamilyCode ,Description

/*
Insert values
*/

INSERT INTO `personsnew` (ID,LastName,FirstName,Address,City)
VALUES('11','Daniel','Wang','Oxford Street','Paris')

/*
Add new column
Drop a column
*/
ALTER TABLE persons ADD height VARCHAR(100) NOT NULL
ALTER TABLE tableName DROP COLUMN columnName 
SELECT * FROM `personsnew`


/*
select repeate values
*/

/*
When use the select * you need to specify an alias for the temporary table
*/

SELECT * FROM `rbvehicle202011` 
WHERE (FamilyCode,YearGroup,Description)IN
(SELECT FamilyCode,YearGroup,Description FROM `rbvehicle202011`
GROUP BY FamilyCode,YearGroup,Description
HAVING COUNT(*)>1
AND YearGroup>'2015'
)
ORDER BY MakeCode,FamilyCode


/*
Insert into A table using B table values
*/

INSERT INTO `personsnew` (FirstName,Address) SELECT LastName,Address FROM `persons`

/*
Delete the null values
*/
DELETE FROM `personsnew` WHERE LastName IS NULL









