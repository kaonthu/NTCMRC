CREATE TABLE kao_practice_5.`Total_speciem_2021_1204_1225` (
  `row_names` varchar(40) NOT NULL,
  `sid` varchar(40) NOT NULL,
  `P_number` varchar(40) DEFAULT NULL,
  `C_number` varchar(40) NOT NULL,
  `Box` varchar(40) DEFAULT NULL,
  `Site` int(5) DEFAULT NULL,
  `ML` float DEFAULT NULL,
  `Specimen` varchar(10) DEFAULT NULL,
  `QC` tinyint(1) DEFAULT NULL,
  `C_Date` date DEFAULT NULL,
  `In_time` date DEFAULT NULL,
  `CMRC_Reserved` tinyint(1) DEFAULT NULL,
  `sup` int(9) DEFAULT NULL,
  PRIMARY KEY (`C_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

SELECT * FROM kao_practice_5.Total_speciem_2021_1204_1225;

UPDATE kao_practice_5.Total_speciem_2021_1204_1225
set In_time = 20210112
WHERE Specimen = "P" AND CMRC_Reserved=1 ;

SELECT P_number,C_number,Specimen,CMRC_reserved,max(box),max(site),count(*) as co
,max(SUBSTRING(C_number,3,6)) as ma,min(SUBSTRING(C_number,3,6)) as mi
FROM kao_practice_5.Total_speciem_2021_1204_1225
GROUP BY Specimen,CMRC_reserved;

#DELETE FROM kao_practice_5.Total_speciem_2021_1204_1225
#WHERE Specimen = "SY" AND CMRC_Reserved=1 ;

SELECT * FROM kao_practice_5.Total_speciem_2021_1204_1225
WHERE Specimen = "SY" AND CMRC_Reserved=1 ;

#############################################################

INSERT INTO CMRC_DB_kaonthu.CMRC_Sample_info 
(P_number,C_number,ML,Specimen,QC,C_Date,CMRC_Reserved)
SELECT P_number,C_number,ML,Specimen,QC,C_Date,CMRC_Reserved
FROM kao_practice_5.Total_speciem_2021_1204_1225;

INSERT INTO CMRC_DB_kaonthu.CMRC_Sample_status
(P_number,C_number,Box,Site,entry_time)
SELECT P_number,C_number,Box,Site,now()
FROM kao_practice_5.Total_speciem_2021_1204_1225;

SELECT C_Date,P_number,C_number,Specimen,CMRC_reserved,min(box),min(site),max(box),max(site),count(*) as co
,max(SUBSTRING(C_number,3,6)) as ma,min(SUBSTRING(C_number,3,6)) as mi
FROM CMRC_DB_kaonthu.CMRC_sample_Database
WHERE C_Date >= 20211013
GROUP BY C_Date,Specimen,CMRC_reserved
ORDER BY Specimen,CMRC_reserved,C_Date;

SELECT C_Date,P_number,C_number,Specimen,CMRC_reserved,box,site
FROM CMRC_DB_kaonthu.CMRC_sample_Database
WHERE Specimen="P" AND CMRC_reserved=1 AND C_Date > 20211000;

SELECT C_Date,P_number,C_number,Specimen,CMRC_reserved,box,site
FROM CMRC_DB_kaonthu.CMRC_sample_Database
WHERE Specimen="SY" AND CMRC_reserved=1 AND C_Date > 20211000;

UPDATE CMRC_DB_kaonthu.CMRC_Sample_status
SET box=3749 
WHERE entry_time >= 20211000 AND Box = 3503;

UPDATE CMRC_DB_kaonthu.CMRC_Sample_status
SET box=3750
WHERE entry_time >= 20211000 AND Box = 3504;



UPDATE CMRC_DB_kaonthu.CMRC_Sample_info as a 
INNER JOIN CMRC_DB_kaonthu.`20220114不出庫的更新` as b
ON a.P_number = b.P_number
SET a.C_number = b.C_number
WHERE a.Specimen="P" AND a.CMRC_reserved=1 AND a.C_Date > 20211000;
#info 已更新完畢

SELECT * FROM CMRC_DB_kaonthu.CMRC_Sample_info
WHERE Specimen="P" AND CMRC_reserved=1 AND C_Date > 20211200;

SELECT * FROM CMRC_DB_kaonthu.CMRC_Sample_status
WHERE P_number = "P101416";


SELECT a.P_number,a.C_number,b.P_number,b.C_number
FROM CMRC_DB_kaonthu.CMRC_Sample_info as a
LEFT JOIN CMRC_DB_kaonthu.CMRC_Sample_status as b
ON a.C_number = b.C_number
WHERE a.C_Date > 20211200 AND a.Specimen="P" AND a.CMRC_reserved=1;


CREATE TABLE `20220114不出庫的更新對照表` as 
SELECT a.P_number as W_P_number,a.C_number as W_C_number,
b.P_number as T_P_number,b.C_number as T_C_number
FROM (SELECT * FROM CMRC_DB_kaonthu.CMRC_Sample_info
WHERE Specimen="P" AND CMRC_reserved=1 AND C_Date > 20211000) as a 
INNER JOIN CMRC_DB_kaonthu.`20220114不出庫的更新` as b
ON a.P_number = b.P_number;

SELECT * FROM CMRC_DB_kaonthu.CMRC_Sample_status as a
INNER JOIN `20220114不出庫的更新對照表` as b 
ON a.C_number = b.W_C_number
WHERE entry_time > 20211000
GROUP by b.T_P_number;

UPDATE CMRC_DB_kaonthu.CMRC_Sample_status as a
INNER JOIN `20220114不出庫的更新對照表` as b 
ON a.C_number = b.W_C_number
SET a.C_number = b.T_C_number
WHERE a.entry_time > 20211000;

SELECT * FROM CMRC_DB_kaonthu.CMRC_Sample_status as a
INNER JOIN `20220114不出庫的更新` as b 
ON a.C_number = b.C_number;

UPDATE CMRC_DB_kaonthu.CMRC_Sample_status as a
INNER JOIN `20220114不出庫的更新` as b 
ON a.C_number = b.C_number
SET a.Box = b.box,a.site= b.site;

SELECT count(*),a.* FROM CMRC_DB_kaonthu.CMRC_sample_Database as a
WHERE C_Date > 20211200
GROUP BY Specimen,CMRC_reserved;

SELECT a.* FROM CMRC_DB_kaonthu.CMRC_sample_Database as a
WHERE C_Date > 20211000;