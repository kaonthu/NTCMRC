CREATE TABLE kao_practice_5.Total_speciem_202111 (
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

SELECT * FROM kao_practice_5.Total_speciem_202111;

SELECT * FROM CMRC_DB.CMRC_Sample_info;


SELECT * FROM CMRC_DB.CMRC_sample_Database
WHERE C_Date >= 20211103
;

SELECT C_number,count(*) FROM CMRC_DB.CMRC_sample_Database
WHERE C_Date >= 20211103
GROUP BY C_number
;

SELECT * FROM CMRC_DB.CMRC_sample_Database
WHERE C_number IN ("C4028594");

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
WHERE C_Date >= 20211103
GROUP BY Specimen,CMRC_reserved;

SELECT P_number,C_number,Specimen,CMRC_reserved,max(box),max(site),count(*) as co
,max(SUBSTRING(C_number,3,6)) as ma,min(SUBSTRING(C_number,3,6)) as mi
FROM CMRC_DB.CMRC_sample_Database
WHERE C_Date >= 20211103
GROUP BY Specimen,CMRC_reserved;


SELECT C_Date,P_number,C_number,Specimen,CMRC_reserved,max(box),max(site),count(*) as co
,max(SUBSTRING(C_number,3,6)) as ma,min(SUBSTRING(C_number,3,6)) as mi
FROM CMRC_DB.CMRC_sample_Database
WHERE C_Date >= 20211103
GROUP BY C_Date,Specimen,CMRC_reserved;

SELECT * FROM CMRC_DB.CMRC_sample_Database
WHERE (Specimen = 'U' or Specimen = 'Uw')
AND C_Date >= 20211013;

SELECT P_number,C_number,Specimen,CMRC_reserved,box,site
FROM CMRC_DB.CMRC_sample_Database
WHERE CMRC_reserved=1 AND Specimen="P" AND C_Date >= 20210000;

SELECT P_number,C_number,Specimen,CMRC_reserved,box,site
FROM CMRC_DB.CMRC_sample_Database
WHERE CMRC_reserved=1 AND Specimen="SY" AND C_Date >= 20210000;



SELECT C_Date,P_number,C_number,Specimen,CMRC_reserved,min(box),min(site),max(box),max(site),count(*) as co
,max(SUBSTRING(C_number,3,6)) as ma,min(SUBSTRING(C_number,3,6)) as mi
FROM CMRC_DB_kaonthu.CMRC_sample_Database
WHERE C_Date >= 20211013
GROUP BY C_Date,Specimen,CMRC_reserved
ORDER BY Specimen,CMRC_reserved,C_Date;


SELECT P_number,C_number,Specimen,CMRC_reserved,box,site FROM CMRC_DB.CMRC_sample_Database
WHERE (Specimen = 'P')
AND C_Date >= 20211013 AND CMRC_reserved=0;

