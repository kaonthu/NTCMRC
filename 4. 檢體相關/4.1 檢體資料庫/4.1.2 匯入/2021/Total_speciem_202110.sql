CREATE TABLE kao_practice_5.Total_speciem_202110 (
  `sid`  varchar(40) NOT NULL,
  `P_number` varchar(40) DEFAULT NULL,
  `C_number` varchar(40) NOT NULL,
  `Box` varchar(40) DEFAULT NULL,
  `Site` int(5) DEFAULT NULL,
  `ML` float DEFAULT NULL,
  `Specimen` varchar(10) DEFAULT NULL,
  `QC` tinyint(1) DEFAULT NULL,
  `C_Date` date DEFAULT NULL,
  `In_time` varchar(10) DEFAULT NULL,
  `CMRC_Reserved` tinyint(1) DEFAULT NULL,
   `sup` int(9) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

SELECT * FROM kao_practice_5.Total_speciem_202110;

SELECT * FROM CMRC_DB.CMRC_Sample_info;

INSERT INTO CMRC_DB.CMRC_Sample_info 
(P_number,C_number,ML,Specimen,QC,C_Date,CMRC_Reserved)
SELECT P_number,C_number,ML,Specimen,QC,C_Date,CMRC_Reserved
FROM kao_practice_5.Total_speciem_202110;

INSERT INTO CMRC_DB.CMRC_Sample_status
(P_number,C_number,Box,Site,entry_time)
SELECT P_number,C_number,Box,Site,now()
FROM kao_practice_5.Total_speciem_202110;

CREATE table CMRC_DB.backup_CMRC_Sample_info_20211124 as 
SELECT * FROM CMRC_DB.CMRC_Sample_info ;

CREATE table CMRC_DB.backup_CMRC_Sample_status_20211124 as 
SELECT * FROM CMRC_DB.CMRC_Sample_status;

DELETE FROM CMRC_DB.CMRC_Sample_info 
WHERE C_Date >= 20211013;

DELETE FROM CMRC_DB.CMRC_Sample_status 
WHERE entry_time > 20211124;

SELECT *,count(*) FROM CMRC_DB.CMRC_sample_Database
WHERE C_Date >= 20211013
GROUP BY Specimen;

SELECT * FROM CMRC_DB.CMRC_sample_Database
WHERE C_Date >= 20211013
;

SELECT C_number,count(*) FROM CMRC_DB.CMRC_sample_Database
WHERE C_Date >= 20211013
GROUP BY C_number
;

SELECT * FROM CMRC_DB.CMRC_sample_Database
WHERE C_number IN ("C0438325");


SELECT * FROM CMRC_DB.CMRC_sample_Database
WHERE fridge=23 AND box=3359 and site=7;

SELECT * FROM CMRC_DB.CMRC_sample_Database
WHERE fridge=23 AND box=3504 and site=51;

SELECT * FROM CMRC_DB.CMRC_sample_Database
WHERE C_Date >= 20211013;

SELECT *,count(*) as co 
FROM CMRC_DB.CMRC_sample_Database
WHERE C_Date >= 20211013
GROUP BY Specimen,CMRC_reserved;

SELECT *,count(*) as co
FROM CMRC_DB.CMRC_sample_Database
WHERE C_Date >= 20211013
GROUP BY Specimen,CMRC_reserved;


SELECT P_number,C_number,Specimen,
max(SUBSTRING(C_number,3,6)) as ma,min(SUBSTRING(C_number,3,6)) as mi
FROM CMRC_DB.CMRC_sample_Database
WHERE C_Date >= 20211013
AND Specimen = 'U';

SELECT P_number,C_number,Specimen
FROM CMRC_DB.CMRC_sample_Database
WHERE C_Date >= 20211013
AND Specimen = 'U';


SELECT P_number,C_number,Specimen,CMRC_reserved,max(box),max(site),count(*) as co
,max(SUBSTRING(C_number,3,6)) as ma,min(SUBSTRING(C_number,3,6)) as mi
FROM CMRC_DB.CMRC_sample_Database
WHERE C_Date >= 20211013
GROUP BY Specimen,CMRC_reserved;


SELECT * FROM CMRC_DB.CMRC_sample_Database
WHERE (Specimen = 'U' or Specimen = 'Uw')
AND C_Date >= 20211013;

SELECT P_number,C_number,Specimen,CMRC_reserved,box,site
FROM CMRC_DB.CMRC_sample_Database
WHERE CMRC_reserved=1 AND Specimen="P" AND C_Date >= 20210000;

SELECT P_number,C_number,Specimen,CMRC_reserved,box,site
FROM CMRC_DB.CMRC_sample_Database
WHERE CMRC_reserved=1 AND Specimen="SY" AND C_Date >= 20210000;