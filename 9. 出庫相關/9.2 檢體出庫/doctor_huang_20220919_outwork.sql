SELECT a.ma,a.p_id,a.CMRC_id,a.New_CMRC_id,b.CMRC_id,b.New_CMRC_id
FROM CMRC_DB_kaonthu_work.doctor_joe_20220629_outwork_270 as a
INNER JOIN 
CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310 as b
ON a.CMRC_id = b.CMRC_id
WHERE a.CMRC_id != b.CMRC_id;

SELECT a.ma,a.p_id,a.CMRC_id,a.New_CMRC_id,b.CMRC_id,b.New_CMRC_id
FROM CMRC_DB_kaonthu_work.doctor_joe_20220629_outwork_270 as a
INNER JOIN 
CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310 as b
ON a.CMRC_id = b.CMRC_id
WHERE a.New_CMRC_id != b.New_CMRC_id;

SELECT a.ma,a.p_id,a.CMRC_id,a.New_CMRC_id,b.CMRC_id,b.New_CMRC_id
FROM CMRC_DB_kaonthu_work.doctor_joe_20220629_outwork_270 as a
INNER JOIN 
CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310 as b
ON a.CMRC_id = b.CMRC_id
GROUP BY a.CMRC_id;

SELECT a.ma,a.p_id,CMRC_id,New_CMRC_id
FROM CMRC_DB_kaonthu_work.doctor_joe_20220629_outwork_270 as a;


SELECT a.ma,a.p_id,b.*
FROM CMRC_DB_kaonthu_work.doctor_joe_20220629_outwork_270 as a
INNER JOIN 
(SELECT * FROM CMRC_DB_kaonthu.CMRC_sample_Database_Consent
WHERE Specimen IN ("SY","SR") and CMRC_reserved != 1 
AND (back_yes regexp '1' OR new_yes regexp '1' )) as b 
ON a.CMRC_id = b.CMRC_id
GROUP BY a.CMRC_id;