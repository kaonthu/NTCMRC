SELECT a.*,b.*
FROM CMRC_DB_kaonthu_work.doctor_chen_20220602 as a
INNER JOIN CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310_desc_last as b
ON a.New_CMRC_id = b.New_CMRC_id;


SELECT a.*,b.*,count(*)
FROM CMRC_DB_kaonthu_work.doctor_chen_20220602 as a
INNER JOIN CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310_desc_last as b
ON a.New_CMRC_id = b.New_CMRC_id
GROUP BY LEFT(data_exam,4);

SELECT * FROM CMRC_DB_kaonthu.CMRC_sample_Database_Consent
WHERE Specimen = "BC"
AND C_Date >= 20190000;

SELECT * FROM CMRC_DB_kaonthu.CMRC_sample_Database_Consent
WHERE Specimen = "BC" and New_CMRC_id IN 
(SELECT New_CMRC_id FROM CMRC_DB_kaonthu_work.doctor_chen_20220602);

#######################################################################
SELECT b.*,a.*
FROM 
(SELECT * FROM CMRC_DB_kaonthu.CMRC_sample_Database_Consent
WHERE `out` <> 1
AND specimen = 'BC'
AND (back_yes regexp '1'
OR new_yes REGEXP '1') ) as a
INNER JOIN 
(SELECT * 
FROM CMRC_DB_kaonthu_work.doctor_chen_20220602) as b
ON a.New_CMRC_id = b.New_CMRC_id #共對到149管檢體
GROUP BY b.New_CMRC_id;          #60個人

CREATE TABLE CMRC_DB_kaonthu_work.doctor_chen_20220602_outwork_149 as
SELECT a.*
FROM 
(SELECT * FROM CMRC_DB_kaonthu.CMRC_sample_Database_Consent
WHERE `out` <> 1
AND specimen = 'BC'
AND (back_yes regexp '1'
OR new_yes REGEXP '1') ) as a
INNER JOIN 
(SELECT * 
FROM CMRC_DB_kaonthu_work.doctor_chen_20220602) as b
ON a.New_CMRC_id = b.New_CMRC_id #共對到149管檢體
GROUP BY b.New_CMRC_id;          #60個人


SELECT a.CMRC_ID,a.New_CMRC_id,a.C_Date,a.C_number,a.P_number,a.Fridge,a.Box,a.Site,a.Specimen
FROM CMRC_DB_kaonthu_work.doctor_chen_20220602_outwork_149 as a
WHERE C_Date >= 20210000
ORDER BY a.Fridge+0,a.Box,a.Site+0; #59管

SELECT a.CMRC_ID,a.New_CMRC_id,a.C_Date,a.C_number,a.P_number,a.Fridge,a.Box,a.Site,a.Specimen
FROM CMRC_DB_kaonthu_work.doctor_chen_20220602_outwork_149 as a
WHERE New_CMRC_id not in (SELECT a.New_CMRC_id
FROM CMRC_DB_kaonthu_work.doctor_chen_20220602_outwork_149 as a
WHERE C_Date >= 20210000)
ORDER BY a.Fridge+0,a.Box,a.Site+0; #1管


SELECT a.CMRC_ID,a.New_CMRC_id,a.C_Date,a.C_number,a.P_number,a.Fridge,a.Box,a.Site,a.Specimen
FROM CMRC_DB_kaonthu_work.doctor_chen_20220602_outwork_149 as a
WHERE C_Date >= 20210000
UNION ALL
SELECT a.CMRC_ID,a.New_CMRC_id,a.C_Date,a.C_number,a.P_number,a.Fridge,a.Box,a.Site,a.Specimen
FROM CMRC_DB_kaonthu_work.doctor_chen_20220602_outwork_149 as a
WHERE New_CMRC_id not in (SELECT a.New_CMRC_id
FROM CMRC_DB_kaonthu_work.doctor_chen_20220602_outwork_149 as a
WHERE C_Date >= 20210000)
ORDER BY Fridge+0,Box,Site+0; #1管

SELECT a.*
FROM 
(SELECT * FROM CMRC_DB_kaonthu.CMRC_sample_Database_Consent
WHERE 
 specimen = 'BC'
AND (back_yes regexp '1'
OR new_yes REGEXP '1') ) as a
INNER JOIN 
(SELECT * 
FROM CMRC_DB_kaonthu_work.doctor_chen_20220602) as b
ON a.New_CMRC_id = b.New_CMRC_id #有2管出庫掉了