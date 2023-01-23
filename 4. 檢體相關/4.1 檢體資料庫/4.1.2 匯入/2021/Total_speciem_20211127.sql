CREATE TABLE kao_practice_5.Total_speciem_20211127 (
  `row_names`  varchar(40) NOT NULL,
  `sid`  varchar(40) NOT NULL,
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
   `sup` int(9) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DELETE FROM kao_practice_5.Total_speciem_202110
WHERE CMRC_Reserved=1 AND Specimen = "P";

DELETE FROM kao_practice_5.Total_speciem_202111
WHERE CMRC_Reserved=1 AND Specimen = "P";

DELETE FROM kao_practice_5.Total_speciem_20211127_30
WHERE CMRC_Reserved=1 AND Specimen = "P";

DELETE FROM kao_practice_5.Total_speciem_202111
WHERE CMRC_Reserved=1 AND Specimen = "SY";

DELETE FROM kao_practice_5.Total_speciem_20211127
WHERE CMRC_Reserved=1 AND Specimen = "SY";

DELETE FROM kao_practice_5.Total_speciem_20211127_30
WHERE CMRC_Reserved=1 AND Specimen = "SY";


DELETE FROM CMRC_DB.CMRC_Sample_info 
WHERE C_Date >= 20211103;

DELETE FROM CMRC_DB.CMRC_Sample_status 
WHERE entry_time > 20211127;

INSERT INTO CMRC_DB.CMRC_Sample_info 
(P_number,C_number,ML,Specimen,QC,C_Date,CMRC_Reserved)
SELECT P_number,C_number,ML,Specimen,QC,C_Date,CMRC_Reserved
FROM kao_practice_5.Total_speciem_202111;

INSERT INTO CMRC_DB.CMRC_Sample_status
(P_number,C_number,Box,Site,entry_time)
SELECT P_number,C_number,Box,Site,now()
FROM kao_practice_5.Total_speciem_202111;


INSERT INTO CMRC_DB.CMRC_Sample_info 
(P_number,C_number,ML,Specimen,QC,C_Date,CMRC_Reserved)
SELECT P_number,C_number,ML,Specimen,QC,C_Date,CMRC_Reserved
FROM kao_practice_5.Total_speciem_20211127_30;

INSERT INTO CMRC_DB.CMRC_Sample_status
(P_number,C_number,Box,Site,entry_time)
SELECT P_number,C_number,Box,Site,now()
FROM kao_practice_5.Total_speciem_20211127_30;

INSERT INTO CMRC_DB.CMRC_Sample_info 
(P_number,C_number,ML,Specimen,QC,C_Date,CMRC_Reserved)
SELECT P_number,C_number,ML,Specimen,QC,C_Date,CMRC_Reserved
FROM kao_practice_5.Total_Urine_202111;

INSERT INTO CMRC_DB.CMRC_Sample_status
(P_number,C_number,Box,Site,entry_time)
SELECT P_number,C_number,Box,Site,now()
FROM kao_practice_5.Total_Urine_202111;

SELECT C_Date,P_number,C_number,Specimen,CMRC_reserved,box,site,count(*) as co
FROM CMRC_DB.CMRC_sample_Database
WHERE C_Date >= 20211103 
GROUP BY C_Date,Specimen,CMRC_reserved
ORDER BY CMRC_reserved,Specimen,C_Date;

SELECT P_number,C_number,Specimen,CMRC_reserved,max(box),max(site),count(*) as co
,max(SUBSTRING(C_number,3,6)) as ma,min(SUBSTRING(C_number,3,6)) as mi
FROM CMRC_DB.CMRC_sample_Database
WHERE C_Date >= 20211103
GROUP BY Specimen,CMRC_reserved;


SELECT C_Date,P_number,C_number,Specimen,Ml,CMRC_reserved,box,site,QC
FROM CMRC_DB.CMRC_sample_Database
WHERE C_Date = 20211130
AND (Specimen = "U" or Specimen = "Uw");

SELECT C_Date,P_number,C_number,Specimen,CMRC_reserved,box,site
FROM CMRC_DB.CMRC_sample_Database
WHERE C_Date = 20211030
AND (Specimen = "U" or Specimen = "Uw");


SELECT C_Date,P_number,C_number,Specimen,Ml,CMRC_reserved,box,site,QC
FROM CMRC_DB.CMRC_sample_Database
WHERE C_Date >= 20211013
AND (Specimen = "U" or Specimen = "Uw");