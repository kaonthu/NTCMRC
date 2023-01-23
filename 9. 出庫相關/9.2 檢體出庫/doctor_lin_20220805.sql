SELECT * FROM CMRC_DB_kaonthu.CMRC_sample_Database_Consent
WHERE CMRC_ID is NULL or CMRC_ID='' ;

SELECT * FROM CMRC_DB_kaonthu_work.doctor_lin_20220805;

SELECT a.*,b.* 
FROM CMRC_DB_kaonthu_work.doctor_lin_20220805 as a
INNER JOIN CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310_desc_last as b
ON a.CMRC_id = b.CMRC_id ;

SELECT a.*,b.*
FROM
(SELECT * FROM CMRC_DB_kaonthu.CMRC_sample_Database_Consent
WHERE `out` <> 1
AND specimen = 'BC'
AND C_Date >= 20200000 #目前1915管
AND (back_yes regexp '1'
OR new_yes REGEXP '1')) as a
INNER JOIN 
(SELECT * FROM CMRC_DB_kaonthu_work.doctor_lin_20220805) as b
ON a.CMRC_id = b.CMRC_id  #2020 
UNION ALL
SELECT a.*,b.*
FROM
(SELECT * FROM CMRC_DB_kaonthu.CMRC_sample_Database_Consent
WHERE `out` <> 1
AND specimen = 'BC'
AND (back_yes regexp '1'
OR new_yes REGEXP '1')
) as a
INNER JOIN 
(SELECT * FROM CMRC_DB_kaonthu_work.doctor_lin_20220805) as b
ON a.CMRC_id = b.CMRC_id ;


CREATE TEMPORARY TABLE CMRC_DB_kaonthu_work.doctor_lin_20220805_outwork
SELECT a.*
FROM
(SELECT * FROM CMRC_DB_kaonthu.CMRC_sample_Database_Consent
WHERE `out` <> 1
AND specimen = 'BC'
AND C_Date >= 20200000 #目前1915管
AND (back_yes regexp '1'
OR new_yes REGEXP '1')) as a
INNER JOIN 
(SELECT * FROM CMRC_DB_kaonthu_work.doctor_lin_20220805) as b
ON a.CMRC_id = b.CMRC_id  #2020 
UNION ALL
SELECT a.*
FROM
(SELECT * FROM CMRC_DB_kaonthu.CMRC_sample_Database_Consent
WHERE `out` <> 1
AND specimen = 'BC'
AND (back_yes regexp '1'
OR new_yes REGEXP '1')
) as a
INNER JOIN 
(SELECT * FROM CMRC_DB_kaonthu_work.doctor_lin_20220805) as b
ON a.CMRC_id = b.CMRC_id ;

SELECT * FROM CMRC_DB_kaonthu_work.doctor_lin_20220805_outwork
GROUP BY CMRC_id;

SELECT a.CMRC_ID,a.New_CMRC_id,a.C_Date,a.C_number,
a.P_number,a.Fridge,a.Box,a.Site,a.Specimen
FROM CMRC_DB_kaonthu_work.doctor_lin_20220805_outwork as a
GROUP BY CMRC_id;


SELECT a.CMRC_ID,a.New_CMRC_id,a.C_Date,a.C_number,
a.P_number,a.Fridge,a.Box,a.Site,a.Specimen,b.`year`
FROM CMRC_DB_kaonthu_work.doctor_lin_20220805_outwork as a
INNER JOIN CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310_desc_last as b
ON a.CMRC_id = b.CMRC_id
GROUP BY CMRC_id;
