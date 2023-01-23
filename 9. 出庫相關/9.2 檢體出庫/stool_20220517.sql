SELECT * FROM CMRC_DB_kaonthu_work.stool_20220517
WHERE `YEAR` = 2020;


SELECT * FROM CMRC_DB_kaonthu.CMRC_sample_Database_Consent
WHERE specimen = "P" AND `out` = 1 AND out_name IN ("賴旗俊","葉集孝")
AND `out_time` regexp '^2020';

SELECT a.*,b.CMRC_ID 
FROM CMRC_DB.CMRC_DNA_Release_DB as a
INNER JOIN  CMRC_DB.CMRC_DNA_DB as b
ON a.C_number = b.C_number 
WHERE out_name IN ("賴旗俊","葉集孝")
AND `out_time` regexp '^2020';

###########################################################

SELECT b.CMRC_ID 
FROM CMRC_DB.CMRC_DNA_Release_DB as a
INNER JOIN  CMRC_DB.CMRC_DNA_DB as b
ON a.C_number = b.C_number 
WHERE out_name IN ("賴旗俊","葉集孝")
AND `out_time` regexp '^2020|^2019'
GROUP BY b.CMRC_ID
UNION 
SELECT CMRC_ID FROM CMRC_DB_kaonthu.CMRC_sample_Database_Consent
WHERE specimen = "P" AND `out` = 1 AND out_name IN ("賴旗俊","葉集孝")
AND `out_time` regexp '^2020'
GROUP BY CMRC_ID
UNION 
SELECT CMRC_ID FROM CMRC_DB_kaonthu_work.stool_20220517
WHERE `YEAR` = 2020
GROUP BY CMRC_ID
UNION 
SELECT CMRC_ID
FROM CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310
WHERE P_dn regexp '^M09B|^M09C';



SELECT CMRC_ID  FROM CMRC_DB_kaonthu.CMRC_sample_Database_Consent
WHERE specimen = "P" AND `out` = 1 AND out_name IN ("賴旗俊","葉集孝")
AND `out_time` regexp '^2021'
GROUP BY CMRC_ID
UNION 
SELECT b.CMRC_ID 
FROM CMRC_DB.CMRC_DNA_Release_DB as a
INNER JOIN  CMRC_DB.CMRC_DNA_DB as b
ON a.C_number = b.C_number 
WHERE out_name IN ("賴旗俊","葉集孝")
AND `out_time` regexp '^2021'
GROUP BY CMRC_ID
UNION 
SELECT CMRC_ID FROM CMRC_DB_kaonthu_work.stool_20220517
WHERE `YEAR` = 2021
GROUP BY CMRC_ID
UNION 
SELECT CMRC_ID
FROM CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310
WHERE P_dn regexp '^M10B' and CMRC_ID != ''
GROUP BY CMRC_ID;

#1184 + 253 + (61-9) = 
########################################################################


CREATE TEMPORARY TABLE test as
SELECT * FROM CMRC_DB_kaonthu.CMRC_sample_Database_Consent
WHERE specimen = "P" AND `out` = 1 AND out_name IN ("賴旗俊","葉集孝");

UPDATE `CMRC_DB_kaonthu`.`doctor_ye_20220127`
SET plasma_1649 = 0;

SELECT a.*,b.p_id 
FROM test as a
INNER JOIN kao_practice_3.CMRC_all_persontimes_desc_last_kaonthu as b
ON a.CMRC_id = b.CMRC_ID;

UPDATE `CMRC_DB_kaonthu`.`doctor_ye_20220127`  as a
INNER JOIN (SELECT a.*,b.p_id 
FROM test as a
INNER JOIN kao_practice_3.CMRC_all_persontimes_desc_last_kaonthu as b
ON a.CMRC_id = b.CMRC_ID) as b
ON a.p_id = b.p_ID
Set a.plasma_1649 = 1;

