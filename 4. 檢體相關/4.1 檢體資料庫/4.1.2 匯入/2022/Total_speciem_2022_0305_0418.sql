SELECT *,count(*) FROM kao_practice_5.Total_speciem_2022_0305_0418
group by C_number;

SELECT *,count(*) FROM kao_practice_5.Total_speciem_2022_0305_0418
WHERE IN_time >= 20220606
GROUP BY Specimen,CMRC_reserved;

SELECT * FROM kao_practice_5.Total_speciem_2022_0305_0418
WHERE IN_time >= 20220606;

DELETE FROM kao_practice_5.Total_speciem_2022_0305_0418
WHERE Specimen = "SY" and CMRC_reserved = 1;

INSERT INTO CMRC_DB_kaonthu.CMRC_Sample_info 
(P_number,C_number,ML,Specimen,QC,C_Date,CMRC_Reserved,In_time)
SELECT P_number,C_number,ML,Specimen,QC,C_Date,CMRC_Reserved,In_time
FROM kao_practice_5.Total_speciem_2022_0305_0418;

INSERT INTO CMRC_DB_kaonthu.CMRC_Sample_status
(P_number,C_number,Box,Site,entry_time)
SELECT P_number,C_number,Box,Site,now()
FROM kao_practice_5.Total_speciem_2022_0305_0418;

SELECT * FROM CMRC_DB_kaonthu.CMRC_sample_Database_Consent
WHERE entry_time >= 20220606;

UPDATE CMRC_DB_kaonthu.CMRC_Sample_info as a
INNER JOIN CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310 as b
ON a.P_number = b.P_number
SET a.CMRC_ID = b.CMRC_ID
WHERE C_Date >= 20220305;

ALTER TABLE `CMRC_DB_kaonthu`.`CMRC_Sample_info` 
ADD COLUMN `New_CMRC_id` VARCHAR(40) NULL AFTER `CMRC_ID`;

UPDATE CMRC_DB_kaonthu.CMRC_Sample_info as a
INNER JOIN CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310 as b
ON a.P_number = b.P_number
SET a.New_CMRC_id = b.New_CMRC_id;

SELECT * FROM CMRC_DB_kaonthu.CMRC_Sample_info 
WHERE C_Date >= 20220305;

SELECT * FROM CMRC_DB_kaonthu.CMRC_sample_Database_Consent
WHERE C_Date >= 20220305
GROUP BY C_number;

SELECT * FROM CMRC_DB_kaonthu.CMRC_Sample_status
WHERE entry_time >= 20220606;


SELECT *,count(*) FROM CMRC_DB_kaonthu.CMRC_Sample_status
GROUP BY C_number;

SELECT * FROM CMRC_DB_kaonthu.CMRC_Sample_info 
GROUP BY C_number;


SELECT * FROM kao_practice_6.CMRC_sample_Database
WHERE entry_time >= 20220606;


