DELETE FROM CMRC_DB.CMRC_Sample_info 
WHERE C_Date >= 20211103;
#先將11月的10721筆刪除

DELETE FROM CMRC_DB.CMRC_Sample_status 
WHERE entry_time > 20211127;
#先將11月的10721筆刪除

DELETE FROM CMRC_DB.CMRC_Sample_info 
WHERE C_Date >= 20211013;
#再將10月6135筆刪除

DELETE FROM CMRC_DB.CMRC_Sample_status 
WHERE entry_time >= 20211126;
#再將10月6135筆刪除


UPDATE kao_practice_5.Total_speciem_2021_1013_1130 as a 
INNER JOIN kao_practice_5.Update_C_number_20211208 as b
ON a.C_number = b.C_number_old
SET a.C_number = b.C_number_new
WHERE a.Specimen = 'P'
AND a.C_Date >= 20211013 AND a.CMRC_reserved=0 ;

UPDATE kao_practice_5.Total_speciem_2021_1013_1130
SET box = 691
WHERE box = 667;

INSERT INTO CMRC_DB.CMRC_Sample_info 
(P_number,C_number,ML,Specimen,QC,C_Date,CMRC_Reserved)
SELECT P_number,C_number,ML,Specimen,QC,C_Date,CMRC_Reserved
FROM kao_practice_5.Total_speciem_2021_1013_1130;

INSERT INTO CMRC_DB.CMRC_Sample_status
(P_number,C_number,Box,Site,entry_time)
SELECT P_number,C_number,Box,Site,now()
FROM kao_practice_5.Total_speciem_2021_1013_1130;

SELECT C_Date,P_number,C_number,Specimen,CMRC_reserved,min(box),min(site),max(box),max(site),count(*) as co
,max(SUBSTRING(C_number,3,6)) as ma,min(SUBSTRING(C_number,3,6)) as mi
FROM CMRC_DB.CMRC_sample_Database
WHERE C_Date >= 20211013
GROUP BY C_Date,Specimen,CMRC_reserved
ORDER BY Specimen,CMRC_reserved,C_Date;

SELECT C_Date,P_number,C_number,Specimen,CMRC_reserved,box,site
FROM CMRC_DB.CMRC_sample_Database
WHERE C_Date >= 20211013
GROUP BY C_Date,Specimen,CMRC_reserved
ORDER BY Specimen,CMRC_reserved,C_Date;

SELECT P_number,C_number,Specimen,CMRC_reserved,box,site 
FROM CMRC_DB.CMRC_sample_Database
WHERE (Specimen = 'P')
AND C_Date >= 20211013 AND CMRC_reserved=0;

SELECT P_number,C_number,Specimen,CMRC_reserved,box,site 
FROM CMRC_DB.CMRC_sample_Database
WHERE (Specimen = 'P')
AND C_Date >= 20211013 AND CMRC_reserved=1;