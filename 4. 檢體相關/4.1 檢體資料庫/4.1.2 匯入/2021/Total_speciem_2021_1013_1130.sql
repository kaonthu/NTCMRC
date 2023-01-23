CREATE TABLE kao_practice_5.Total_speciem_2021_1013_1130 (
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
  `sup` int(9) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

SELECT * FROM kao_practice_5.Total_speciem_2021_1013_1130;

SELECT C_Date,P_number,C_number,Specimen,CMRC_reserved,min(box),site,max(box),site,count(*) as co
,max(SUBSTRING(C_number,3,6)) as ma,min(SUBSTRING(C_number,3,6)) as mi
FROM kao_practice_5.Total_speciem_2021_1013_1130
WHERE C_Date >= 20211013
GROUP BY C_Date,Specimen,CMRC_reserved
ORDER BY Specimen,CMRC_reserved,C_Date;

SELECT P_number,C_number,Specimen,CMRC_reserved,box,site 
FROM CMRC_DB.CMRC_sample_Database
WHERE (Specimen = 'P')
AND C_Date >= 20211013 AND CMRC_reserved=0;



