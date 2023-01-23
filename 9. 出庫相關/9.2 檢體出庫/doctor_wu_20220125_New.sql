UPDATE CMRC_DB_kaonthu.doctor_wu_20220125_New
set co = NULL;

UPDATE CMRC_DB_kaonthu.doctor_wu_20220125_New as T1
INNER JOIN (SELECT count(*) as cc,a.*,b.* 
FROM doctor_wu_20220125_New as a
INNER JOIN 
(SELECT * FROM CMRC_DB_kaonthu.CMRC_sample_Database_Consent
WHERE Specimen IN ("SY","SR") and CMRC_reserved != 1 ) as b 
ON a.CMRC_number = b.CMRC_id AND a.dataexam = b.C_Date
GROUP BY OriginalID) as T2
ON T1.OriginalID = T2.OriginalID
SET T1.co = T2.cc; #確認一下是哪16個名單 co是曾經有過的庫存

SELECT a.*,b.*
FROM
(SELECT * FROM CMRC_DB_kaonthu.doctor_wu_20220125_New
WHERE co is NULL ) as a
INNER JOIN 
CMRC_DB_kaonthu.CMRC_sample_Database_Consent as b
ON a.CMRC_number = b.CMRC_ID; 
#去找會發現有這些人，且也有SR但對方既然不想要就算了

#####################################################
UPDATE CMRC_DB_kaonthu.doctor_wu_20220125_New as T1
SET T1.QC_SYk = NULL;

UPDATE CMRC_DB_kaonthu.doctor_wu_20220125_New as T1
INNER JOIN (SELECT count(*) as cc,a.*,b.* 
FROM doctor_wu_20220125_New as a
INNER JOIN 
(SELECT * FROM CMRC_DB_kaonthu.CMRC_sample_Database_Consent
WHERE Specimen regexp 'SY|SR|SYk' and CMRC_reserved != 1 AND `out` != 1) as b 
ON a.CMRC_number = b.CMRC_id AND a.dataexam = b.C_Date
GROUP BY OriginalID) as T2
ON T1.OriginalID = T2.OriginalID
SET T1.QC_SYk = T2.cc; 

UPDATE CMRC_DB_kaonthu.doctor_wu_20220125_New as T1
INNER JOIN (SELECT count(*) as cc,a.*,b.* 
FROM doctor_wu_20220125_New as a
INNER JOIN 
(SELECT * FROM CMRC_DB_kaonthu.CMRC_sample_Database_Consent
WHERE Specimen IN ("SY","SR") and CMRC_reserved != 1 AND `out` != 1) as b 
ON a.CMRC_number = b.CMRC_id AND a.dataexam = b.C_Date
GROUP BY OriginalID) as T2
ON T1.OriginalID = T2.OriginalID
SET T1.QC_noSYk = T2.cc; 

##############################################################
ALTER TABLE `CMRC_DB_kaonthu`.`doctor_wu_20220125_New` 
ADD COLUMN `back_yes` VARCHAR(8) NULL AFTER `QC_noSYk`,
ADD COLUMN `new_yes` VARCHAR(8) NULL AFTER `back_yes`;

UPDATE CMRC_DB_kaonthu.doctor_wu_20220125_New as U1
INNER JOIN
CMRC_DB_kaonthu.`CMRC_all_persontimes_last_kaonthu_back_new_DNA_TMPI_生資` AS U2
ON U1.CMRC_number = U2.CMRC_id
SET U1.back_yes = U2.back_yes; 

UPDATE CMRC_DB_kaonthu.doctor_wu_20220125_New as U1
INNER JOIN
CMRC_DB_kaonthu.`CMRC_all_persontimes_last_kaonthu_back_new_DNA_TMPI_生資` AS U2
ON U1.CMRC_number = U2.CMRC_id
SET U1.new_yes = U2.new_yes; 

SELECT * FROM CMRC_DB_kaonthu.doctor_wu_20220125_New
WHERE back_yes is NULL AND new_yes is NULL; #124 完全沒簽過

SELECT * FROM CMRC_DB_kaonthu.doctor_wu_20220125_New
WHERE (back_yes is not NULL) or (new_yes is not NULL); #vs 146 有簽過

SELECT * FROM CMRC_DB_kaonthu.doctor_wu_20220125_New
WHERE (back_yes is NULL or back_yes not regexp '1') AND (new_yes is NULL or new_yes not regexp '1');
#126 沒有簽或有簽但無效;

SELECT * FROM CMRC_DB_kaonthu.doctor_wu_20220125
WHERE back_yes regexp '1' OR new_yes regexp '1';
#vs 144 簽過且有效

###############################################################

UPDATE CMRC_DB_kaonthu.doctor_wu_20220125_New as U1
SET U1.class = NULL; 

UPDATE CMRC_DB_kaonthu.doctor_wu_20220125_New as U1
SET U1.class = 0
WHERE (back_yes not regexp '1' OR back_yes is NULL) 
AND (new_yes not regexp '1' OR new_yes is NULL); 
#124+2個 沒有有同意書

UPDATE CMRC_DB_kaonthu.doctor_wu_20220125_New as U1
SET U1.class = 0.1
WHERE QC_noSYk is NULL and (back_yes regexp '1' or new_yes regexp '1');
#13個有同意書但沒庫存

UPDATE CMRC_DB_kaonthu.doctor_wu_20220125_New as U1
SET U1.class = 1
WHERE (back_yes regexp '1' or new_yes regexp '1') AND QC_noSYk IN (1,2);
#38個出庫2管涉及最後1管

UPDATE CMRC_DB_kaonthu.doctor_wu_20220125_New as U1
SET U1.class = 2
WHERE (back_yes regexp '1' or new_yes regexp '1') AND QC_noSYk >= 3 ;
#93個庫存有3管以上

####################################################################

SELECT a.*,b.Specimen,b.QC
FROM (SELECT * FROM CMRC_DB_kaonthu.doctor_wu_20220125_New
WHERE class = 1) as a
INNER JOIN 
(SELECT * FROM CMRC_DB_kaonthu.CMRC_sample_Database_Consent
WHERE Specimen IN ("SY","SR") and CMRC_reserved != 1 AND `out` != 1 ) as b 
ON a.CMRC_number = b.CMRC_id AND a.dataexam = b.C_Date;


SELECT *,count(*) 
FROM CMRC_DB_kaonthu.doctor_wu_20220125_New
GROUP BY class;

#####################################################################

CREATE TABLE CMRC_DB_kaonthu_work.doctor_wu_20220125_outwork as 
SELECT a.p_id,a.class,a.MMRCID,a.OriginalID,b.* 
FROM (SELECT * FROM CMRC_DB_kaonthu.doctor_wu_20220125_New 
WHERE back_yes regexp '1' OR new_yes regexp '1' ) as a
INNER JOIN 
(SELECT * FROM CMRC_DB_kaonthu.CMRC_sample_Database_Consent
WHERE Specimen IN ("SY","SR") and CMRC_reserved != 1 AND `out` != 1) as b 
ON a.CMRC_number = b.CMRC_id AND a.dataexam = b.C_Date
ORDER BY OriginalID,fridge,box,site;


SELECT a.* 
FROM CMRC_DB_kaonthu_work.doctor_wu_20220125_outwork as a
INNER JOIN  (
SELECT `order`
FROM CMRC_DB_kaonthu_work.doctor_wu_20220125_outwork
GROUP BY OriginalID
Union 
SELECT `order`+1
FROM CMRC_DB_kaonthu_work.doctor_wu_20220125_outwork
GROUP BY OriginalID) as b
ON a.`order` = b.`order`;


