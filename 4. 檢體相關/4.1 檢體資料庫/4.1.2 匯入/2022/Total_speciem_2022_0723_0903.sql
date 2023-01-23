SELECT * FROM kao_practice_5.Total_speciem_2022_0723_0903;

CREATE temporary table kao_practice_5.Total_speciem_2021_2022 as
SELECT * FROM kao_practice_5.Total_speciem_2022_0723_0903; #1761-81 + 329 = 2009;

SELECT * FROM kao_practice_5.Total_speciem_2021_2022;

SELECT a.C_Date,a.sid,a.IN_time,b.data_exam,b.P_dn
FROM kao_practice_5.Total_speciem_2021_2022 as a
INNER JOIN CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310 as b
ON a.P_number = b.P_number
WHERE  a.IN_time != 20220910;

UPDATE kao_practice_5.Total_speciem_2021_2022 as a
INNER JOIN CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310 as b
ON a.P_number = b.P_number
SET a.C_Date = b.data_exam,a.sid = b.P_dn,a.IN_time = 20220910;

INSERT INTO CMRC_DB_kaonthu.CMRC_Sample_info 
(P_number,C_number,ML,Specimen,QC,C_Date,CMRC_Reserved,In_time)
SELECT P_number,C_number,ML,Specimen,QC,C_Date,CMRC_Reserved,In_time
FROM kao_practice_5.Total_speciem_2021_2022;

INSERT INTO CMRC_DB_kaonthu.CMRC_Sample_status
(P_number,C_number,Box,Site,`out`,entry_time)
SELECT P_number,C_number,Box,Site,0,now()
FROM kao_practice_5.Total_speciem_2021_2022;

UPDATE CMRC_DB_kaonthu.CMRC_Sample_info as a
INNER JOIN CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310 as b
ON a.P_number = b.P_number
SET a.CMRC_ID = b.CMRC_ID,a.New_CMRC_id = b.New_CMRC_id
WHERE In_time = 20220910;

SELECT a.CMRC_ID,a.New_CMRC_id,a.C_Date,a.C_number,
a.P_number,a.Fridge,a.Box,a.Site,a.Specimen,b.`year`
FROM
(SELECT * FROM CMRC_DB_kaonthu.CMRC_sample_Database_Consent
WHERE C_date >= 20220000) as a
INNER JOIN CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310_desc_last as b
ON a.CMRC_id = b.CMRC_id;

SELECT Specimen,CMRC_reserved,count(*) 
FROM CMRC_DB_kaonthu.CMRC_sample_Database_Consent
WHERE C_date >= 20220000
GROUP BY Specimen,CMRC_reserved;

SELECT C_date,Specimen,CMRC_reserved,count(*) 
FROM CMRC_DB_kaonthu.CMRC_sample_Database_Consent
WHERE C_date >= 20220000
GROUP BY C_date,Specimen,CMRC_reserved
ORDER BY Specimen,CMRC_reserved,C_date;


SELECT *
FROM CMRC_DB_kaonthu.CMRC_sample_Database_Consent
WHERE C_date >= 20220000
AND `out` = 1
AND specimen != 'BC'
AND entry_time >= 20220910 ;

SELECT *,count(*)
FROM CMRC_DB_kaonthu.CMRC_sample_Database_Consent
WHERE C_date >= 20220000
AND `out` = 1
AND entry_time >= 20220910 
GROUP BY specimen;

############################################

SELECT * FROM CMRC_DB_kaonthu.CMRC_Sample_status
WHERE entry_time >= 20220910
AND `out` = 1 ;

DELETE FROM CMRC_DB_kaonthu.CMRC_Sample_status
WHERE entry_time >= 20220910
AND `out` = 1 ;








 
 