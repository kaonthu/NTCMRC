SELECT * FROM CMRC_DB_kaonthu_work.doctor_ye_20220613_outwork_3288;

SELECT *,count(*) 
FROM CMRC_DB_kaonthu_work.doctor_ye_20220613_outwork_3288
GROUP BY CMRC;

DELETE FROM CMRC_DB_kaonthu_work.doctor_ye_20220613_outwork_3288
WHERE No is NULL;

SELECT *,count(*) 
FROM CMRC_DB_kaonthu_work.doctor_ye_20220613_outwork_3288
GROUP BY CMRC;

CREATE TABLE CMRC_DB_kaonthu_work.doctor_ye_20220613_outwork_3288_2 as
SELECT a.*,b.* 
FROM CMRC_DB_kaonthu_work.doctor_ye_20220613_outwork_3288 as a
LEFT JOIN 
CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310 as b
ON a.CMRC = b.CMRC_id
GROUP BY CMRC;

SELECT CMRC 
FROM CMRC_DB_kaonthu_work.doctor_ye_20220613_outwork_3288_2
WHERE CMRC_id is NULL; #有9個是門診收案 舊CMRC_ID 編號

SELECT * FROM CMRC_DB.backup_CMRC_all_persontimes_20210603
WHERE CMRC_id IN (SELECT CMRC 
FROM CMRC_DB_kaonthu_work.doctor_ye_20220613_outwork_3288_2
WHERE CMRC_id is NULL); #找回來

UPDATE CMRC_DB_kaonthu_work.doctor_ye_20220613_outwork_3288_2 as a
INNER JOIN CMRC_DB.backup_CMRC_all_persontimes_20210603 as b
ON a.CMRC = b.CMRC_id
set a.p_id = b.p_id
WHERE a.New_CMRC_id is NULL;


SELECT *
FROM CMRC_DB_kaonthu_work.doctor_ye_20220613_outwork_3288_2;


UPDATE CMRC_DB_kaonthu_work.doctor_ye_20220613_outwork_3288_2 as a
INNER JOIN 
CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310 as b
ON a.p_id = b.p_id
SET a.CMRC_id = b.CMRC_id , a.New_CMRC_id = b.New_CMRC_id
WHERE a.New_CMRC_id is NULL;

SELECT * FROM CMRC_DB.backup_CMRC_all_persontimes_20210603
WHERE p_id IN ('4002802','4395115')

