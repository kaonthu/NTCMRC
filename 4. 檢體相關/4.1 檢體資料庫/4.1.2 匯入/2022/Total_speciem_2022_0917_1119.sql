SELECT * FROM kao_practice_5.Total_speciem_2022_0917_1119;

UPDATE kao_practice_5.Total_speciem_2022_0917_1119
SET IN_time = '20221125';

SELECT Specimen,CMRC_reserved,count(*) 
FROM kao_practice_5.Total_speciem_2022_0917_1119
WHERE C_date >= 20220000
GROUP BY Specimen,CMRC_reserved;

SELECT C_date,Specimen,CMRC_reserved,count(*) 
FROM kao_practice_5.Total_speciem_2022_0917_1119
WHERE C_date >= 20220000
GROUP BY C_date,Specimen,CMRC_reserved
ORDER BY Specimen,CMRC_reserved,C_date;

INSERT INTO CMRC_DB_kaonthu.CMRC_Sample_info 
(P_number,C_number,ML,Specimen,QC,C_Date,CMRC_Reserved,In_time)
SELECT P_number,C_number,ML,Specimen,QC,C_Date,CMRC_Reserved,In_time
FROM kao_practice_5.Total_speciem_2022_0917_1119;

INSERT INTO CMRC_DB_kaonthu.CMRC_Sample_status
(P_number,C_number,Box,Site,`out`,entry_time)
SELECT P_number,C_number,Box,Site,0,now()
FROM kao_practice_5.Total_speciem_2022_0917_1119;

UPDATE CMRC_DB_kaonthu.CMRC_Sample_info as a
INNER JOIN CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310 as b
ON a.P_number = b.P_number
SET a.CMRC_ID = b.CMRC_ID,a.New_CMRC_id = b.New_CMRC_id
WHERE In_time = 20221125;

SELECT Specimen,CMRC_reserved,count(*) 
FROM CMRC_DB_kaonthu.CMRC_sample_Database_Consent
WHERE C_date >= 20220000
GROUP BY Specimen,CMRC_reserved;

SELECT C_date,Specimen,CMRC_reserved,count(*) 
FROM CMRC_DB_kaonthu.CMRC_sample_Database_Consent
WHERE C_date >= 20220000
GROUP BY C_date,Specimen,CMRC_reserved
ORDER BY Specimen,CMRC_reserved,C_date;

###############################################
