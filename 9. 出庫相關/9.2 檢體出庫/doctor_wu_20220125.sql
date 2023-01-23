SELECT *,count(*) FROM CMRC_DB_kaonthu.doctor_wu_20220125
GROUP BY CMRC_number,dataexam;

SELECT * FROM CMRC_DB_kaonthu.doctor_wu_20220125
GROUP BY OriginalID;

SELECT count(*),a.*,b.* 
FROM doctor_wu_20220125 as a
INNER JOIN 
(SELECT * FROM CMRC_DB_kaonthu.CMRC_sample_Database_Consent
WHERE Specimen regexp 'SY|SR|SYk' and CMRC_reserved != 1) as b 
ON a.CMRC_number = b.CMRC_id AND a.dataexam = b.C_Date
WHERE `out` != 1
GROUP BY OriginalID;

SELECT a.*,b.* 
FROM doctor_wu_20220125 as a
INNER JOIN 
(SELECT * FROM CMRC_DB_kaonthu.CMRC_sample_Database_Consent
WHERE Specimen regexp 'SY|SR|SYk' and CMRC_reserved != 1) as b 
ON a.CMRC_number = b.CMRC_id AND a.dataexam = b.In_time;

############################################################
SELECT C_Date,count(*) FROM CMRC_DB_kaonthu.CMRC_sample_Database_Consent
GROUP BY C_Date ; # C_Date 檢體日期

SELECT count(*),a.*,b.* 
FROM doctor_wu_20220125 as a
INNER JOIN 
(SELECT * FROM CMRC_DB_kaonthu.CMRC_sample_Database_Consent
WHERE Specimen regexp 'SY|SR|SYk' and CMRC_reserved != 1 ) as b 
ON a.CMRC_number = b.CMRC_id AND a.dataexam = b.C_Date
GROUP BY OriginalID; #申請的270人只能對到254 剩下16人完全對不到東西

UPDATE CMRC_DB_kaonthu.doctor_wu_20220125 as T1
INNER JOIN (SELECT count(*) as cc,a.*,b.* 
FROM doctor_wu_20220125 as a
INNER JOIN 
(SELECT * FROM CMRC_DB_kaonthu.CMRC_sample_Database_Consent
WHERE Specimen regexp 'SY|SR|SYk' and CMRC_reserved != 1 ) as b 
ON a.CMRC_number = b.CMRC_id AND a.dataexam = b.C_Date
GROUP BY OriginalID) as T2
ON T1.OriginalID = T2.OriginalID
SET T1.co = T2.cc; #確認一下是哪16個名單

SELECT a.*,b.*
FROM
(SELECT * FROM CMRC_DB_kaonthu.doctor_wu_20220125
WHERE co is NULL ) as a
INNER JOIN 
CMRC_DB_kaonthu.CMRC_sample_Database_Consent as b
ON a.CMRC_number = b.CMRC_ID
GROUP BY b.CMRC_ID; #去找會發現有這些人，且也有SR但對方既然不想要就算了

SELECT count(*) as cc,a.*,b.* 
FROM doctor_wu_20220125 as a
INNER JOIN 
(SELECT * FROM CMRC_DB_kaonthu.CMRC_sample_Database_Consent
WHERE Specimen regexp 'SY|SR|SYk' and CMRC_reserved != 1 AND `out` != 1) as b 
ON a.CMRC_number = b.CMRC_id AND a.dataexam = b.C_Date
GROUP BY OriginalID; #申請的270人只能對到254 out !=1 代表還有庫存的，包含QC最後一管，包含SYk

#####################################################################

UPDATE CMRC_DB_kaonthu.doctor_wu_20220125 as T1
INNER JOIN (SELECT count(*) as cc,a.*,b.* 
FROM doctor_wu_20220125 as a
INNER JOIN 
(SELECT * FROM CMRC_DB_kaonthu.CMRC_sample_Database_Consent
WHERE Specimen regexp 'SY|SR|SYk' and CMRC_reserved != 1 AND `out` != 1) as b 
ON a.CMRC_number = b.CMRC_id AND a.dataexam = b.C_Date
GROUP BY OriginalID) as T2
ON T1.OriginalID = T2.OriginalID
SET T1.QC_SYk = T2.cc; 

UPDATE CMRC_DB_kaonthu.doctor_wu_20220125 as T1
INNER JOIN (SELECT count(*) as cc,a.*,b.* 
FROM doctor_wu_20220125 as a
INNER JOIN 
(SELECT * FROM CMRC_DB_kaonthu.CMRC_sample_Database_Consent
WHERE Specimen regexp 'SY|SR|SYk' and CMRC_reserved != 1 AND `out` != 1 AND `QC` != 1) as b 
ON a.CMRC_number = b.CMRC_id AND a.dataexam = b.C_Date
GROUP BY OriginalID) as T2
ON T1.OriginalID = T2.OriginalID
SET T1.noQC_SYk = T2.cc; 

UPDATE CMRC_DB_kaonthu.doctor_wu_20220125 as T1
INNER JOIN (SELECT count(*) as cc,a.*,b.* 
FROM doctor_wu_20220125 as a
INNER JOIN 
(SELECT * FROM CMRC_DB_kaonthu.CMRC_sample_Database_Consent
WHERE Specimen regexp 'SY|SR' and CMRC_reserved != 1 AND `out` != 1 ) as b 
ON a.CMRC_number = b.CMRC_id AND a.dataexam = b.C_Date
GROUP BY OriginalID) as T2
ON T1.OriginalID = T2.OriginalID
SET T1.QC_noSYk = T2.cc; 

UPDATE CMRC_DB_kaonthu.doctor_wu_20220125 as T1
INNER JOIN (SELECT count(*) as cc,a.*,b.* 
FROM doctor_wu_20220125 as a
INNER JOIN 
(SELECT * FROM CMRC_DB_kaonthu.CMRC_sample_Database_Consent
WHERE Specimen regexp 'SY|SR' and CMRC_reserved != 1 AND `out` != 1 AND `QC` != 1) as b 
ON a.CMRC_number = b.CMRC_id AND a.dataexam = b.C_Date
GROUP BY OriginalID) as T2
ON T1.OriginalID = T2.OriginalID
SET T1.noQC_noSYk = T2.cc; 


ALTER TABLE `CMRC_DB_kaonthu`.`doctor_wu_20220125` 
ADD COLUMN `back_yes` VARCHAR(8) NULL AFTER `noQC_noSYk`,
ADD COLUMN `new_yes` VARCHAR(8) NULL AFTER `back_yes`;


UPDATE CMRC_DB_kaonthu.doctor_wu_20220125 as U1
INNER JOIN
CMRC_DB_kaonthu.`CMRC_all_persontimes_last_kaonthu_back_new_DNA_TMPI_生資` AS U2
ON U1.CMRC_number = U2.CMRC_id
SET U1.back_yes = U2.back_yes; 

UPDATE CMRC_DB_kaonthu.doctor_wu_20220125 as U1
INNER JOIN
CMRC_DB_kaonthu.`CMRC_all_persontimes_last_kaonthu_back_new_DNA_TMPI_生資` AS U2
ON U1.CMRC_number = U2.CMRC_id
SET U1.new_yes = U2.new_yes; 

UPDATE CMRC_DB_kaonthu.doctor_wu_20220125 as U1
INNER JOIN
CMRC_DB_kaonthu.`CMRC_all_persontimes_last_kaonthu_back_new_DNA_TMPI_生資` AS U2
ON U1.CMRC_number = U2.CMRC_id
SET U1.p_id = U2.p_id; 

SELECT U1.*,U2.back_ver,U2.back_yes,U2.new_ver,U2.new_yes 
FROM
CMRC_DB_kaonthu.doctor_wu_20220125 as U1
INNER JOIN
CMRC_DB_kaonthu.`CMRC_all_persontimes_last_kaonthu_back_new_DNA_TMPI_生資` AS U2
ON U1.CMRC_number = U2.CMRC_id
WHERE (back_yes regexp '1' OR new_yes regexp '1') ;


/* SELECT U1.*,U2.back_ver,U2.back_yes,U2.new_ver,U2.new_yes 
FROM
CMRC_DB_kaonthu.doctor_wu_20220125 as U1
INNER JOIN
CMRC_DB_kaonthu.`CMRC_all_persontimes_last_kaonthu_back_new_DNA_TMPI_生資` AS U2
ON U1.CMRC_number = U2.CMRC_id
WHERE (back_yes not regexp '1' OR back_yes is NULL) AND (new_yes not regexp '1' OR new_yes is NULL); */


SELECT U1.*,U2.back_ver,U2.back_yes,U2.new_ver,U2.new_yes 
FROM
CMRC_DB_kaonthu.doctor_wu_20220125 as U1
INNER JOIN
CMRC_DB_kaonthu.`CMRC_all_persontimes_last_kaonthu_back_new_DNA_TMPI_生資` AS U2
ON U1.CMRC_number = U2.CMRC_id
WHERE back_yes is NULL AND new_yes is NULL; #這124真的都沒有回簽和簽新同意書


SELECT * FROM CMRC_Consent_DB_kaonthu
WHERE CMRC_id IN (
SELECT CMRC_number FROM 
(
SELECT U1.*,U2.back_ver,U2.back_yes,U2.new_ver,U2.new_yes 
FROM
CMRC_DB_kaonthu.doctor_wu_20220125 as U1
INNER JOIN
CMRC_DB_kaonthu.`CMRC_all_persontimes_last_kaonthu_back_new_DNA_TMPI_生資` AS U2
ON U1.CMRC_number = U2.CMRC_id
WHERE back_yes is NULL AND new_yes is NULL
) 
as V1)
; #這124 (裡面只包含123 獨立的人真的都沒有回簽和簽新同意書)


SELECT a.*,b.*,group_concat(data_exam)
FROM CMRC_all_persontimes_20220110_kaonthu as a
RIGHT JOIN 
(
SELECT U1.*,U2.back_ver,U2.back_yes,U2.new_ver,U2.new_yes 
FROM
CMRC_DB_kaonthu.doctor_wu_20220125 as U1
LEFT JOIN
CMRC_DB_kaonthu.`CMRC_all_persontimes_last_kaonthu_back_new_DNA_TMPI_生資` AS U2
ON U1.CMRC_number = U2.CMRC_id
WHERE back_yes is NULL AND new_yes is NULL
GROUP BY CMRC_number
) as b
ON a.CMRC_id = b.CMRC_number
WHERE data_exam <= 20180302
GROUP BY CMRC_id; #這123 個人真的都在20180302前來參與過 標記需要回簽的名單


SELECT * FROM CMRC_DB_kaonthu.doctor_wu_20220125
WHERE back_yes is NULL AND new_yes is NULL
GROUP BY CMRC_number;
#這124 (裡面只包含123 獨立的人真的都沒有回簽和簽新同意書)

###############################################################################

SELECT * FROM CMRC_DB_kaonthu.doctor_wu_20220125
WHERE back_yes is NULL AND new_yes is NULL; #124 完全沒簽過

SELECT * FROM CMRC_DB_kaonthu.doctor_wu_20220125
WHERE (back_yes is not NULL) or (new_yes is not NULL); #vs 146 有簽過

#########################################################

SELECT * FROM CMRC_DB_kaonthu.doctor_wu_20220125
WHERE (back_yes is NULL or back_yes not regexp '1') AND (new_yes is NULL or new_yes not regexp '1');
#126 有簽過但無效

SELECT * FROM CMRC_DB_kaonthu.doctor_wu_20220125
WHERE back_yes regexp '1' OR new_yes regexp '1';
#vs 144 簽過且有效

SELECT a.*,b.* 
FROM doctor_wu_20220125 as a
INNER JOIN 
(SELECT * FROM CMRC_DB_kaonthu.CMRC_sample_Database_Consent
WHERE Specimen IN ("SY","SR") and CMRC_reserved != 1 AND `out` != 1 ) as b 
ON a.CMRC_number = b.CMRC_id AND a.dataexam = b.C_Date; # 申請270 對過去有1080

SELECT a.*,b.* 
FROM (SELECT * FROM CMRC_DB_kaonthu.doctor_wu_20220125
WHERE back_yes regexp '1' OR new_yes regexp '1') as a
INNER JOIN 
(SELECT * FROM CMRC_DB_kaonthu.CMRC_sample_Database_Consent
WHERE Specimen IN ("SY","SR") and CMRC_reserved != 1 AND `out` != 1 ) as b 
ON a.CMRC_number = b.CMRC_id AND a.dataexam = b.C_Date; #有同意書的對過去 519

SELECT count(*) as co,a.*,b.* 
FROM (SELECT * FROM CMRC_DB_kaonthu.doctor_wu_20220125
WHERE back_yes regexp '1' OR new_yes regexp '1') as a
INNER JOIN 
(SELECT * FROM CMRC_DB_kaonthu.CMRC_sample_Database_Consent
WHERE Specimen IN ("SY","SR") and CMRC_reserved != 1 AND `out` != 1 ) as b 
ON a.CMRC_number = b.CMRC_id AND a.dataexam = b.C_Date
GROUP BY OriginalID; #有同意書的對過去 131

SELECT count(*) as co,a.*,b.* 
FROM (SELECT * FROM CMRC_DB_kaonthu.doctor_wu_20220125
WHERE back_yes regexp '1' OR new_yes regexp '1') as a
INNER JOIN 
(SELECT * FROM CMRC_DB_kaonthu.CMRC_sample_Database_Consent
WHERE Specimen IN ("SY","SR","SYk") and CMRC_reserved != 1 AND `out` != 1 ) as b 
ON a.CMRC_number = b.CMRC_id AND a.dataexam = b.C_Date
GROUP BY OriginalID; #有同意書的對過去 131


/* SELECT a.*,b.* 
FROM (SELECT * FROM CMRC_DB_kaonthu.doctor_wu_20220125
WHERE CMRC_number IN("E42015I10829R1026","L22013C01023E8093","R12015H20725X2101",
"R72014T11213M8039","U72015A50418Q7015","I52013O91023A5004")) as a
INNER JOIN 
(SELECT * FROM CMRC_DB_kaonthu.CMRC_sample_Database_Consent
WHERE Specimen IN ("SY","SR") and CMRC_reserved != 1 AND `out` != 1 ) as b 
ON a.CMRC_number = b.CMRC_id AND a.dataexam = b.C_Date; #有同意書的對過去 131

SELECT a.*,b.* 
FROM (SELECT * FROM CMRC_DB_kaonthu.doctor_wu_20220125
WHERE CMRC_number IN("E42015I10829R1026","L22013C01023E8093","R12015H20725X2101",
"R72014T11213M8039","U72015A50418Q7015","I52013O91023A5004")) as a
INNER JOIN 
(SELECT * FROM CMRC_DB_kaonthu.CMRC_sample_Database_Consent
WHERE Specimen IN ("SY","SR") and CMRC_reserved != 1 AND `out` != 1 ) as b 
ON a.CMRC_number = b.CMRC_id AND a.dataexam = b.C_Date; #有同意書的對過去 131 */


SELECT count(*) as co,a.*,b.* 
FROM (SELECT * FROM CMRC_DB_kaonthu.doctor_wu_20220125
WHERE back_yes regexp '1' OR new_yes regexp '1') as a
INNER JOIN 
(SELECT * FROM CMRC_DB_kaonthu.CMRC_sample_Database_Consent
WHERE Specimen IN ("SY","SR") and CMRC_reserved != 1 AND `out` != 1 ) as b 
ON a.CMRC_number = b.CMRC_id AND a.dataexam = b.C_Date
GROUP BY OriginalID; #有同意書的對過去 131


SELECT T1.OriginalID as label,T2.* FROM CMRC_DB_kaonthu.doctor_wu_20220125 as T1
LEFT JOIN (
SELECT count(*) as co1,a.MMRCID,a.OriginalID,a.chtno,a.CMRC_number,
a.uridate,a.dataexam,a.case,a.normal,a.co,a.back_yes as back_yes_1,a.new_yes as new_yes_1,b.* 
FROM (SELECT * FROM CMRC_DB_kaonthu.doctor_wu_20220125
WHERE back_yes regexp '1' OR new_yes regexp '1') as a
INNER JOIN 
(SELECT * FROM CMRC_DB_kaonthu.CMRC_sample_Database_Consent
WHERE Specimen IN ("SY","SR") and CMRC_reserved != 1 AND `out` != 1 ) as b 
ON a.CMRC_number = b.CMRC_id AND a.dataexam = b.C_Date
GROUP BY OriginalID ) as T2
ON T1.OriginalID = T2.OriginalID
ORDER BY co desc,back_yes,new_yes;

CREATE TABLE doctor_wu_20220125_2 as 
SELECT T1.p_id,T1.MMRCID as MMRCID_pri,
T1.OriginalID as OriginalID_pri,
T1.chtno as chtno_pri,
T1.CMRC_number as CMRC_number_pri,
T1.uridate as uridate_pri,
T1.dataexam as dataexam_pri,
T1.case as case_pri,
T1.normal as normal_pri,
T1.co as co_pri,
T1.QC_SYk as QC_SYk_pri,
T1.noQC_SYk as noQC_SYk_pri,
T1.QC_noSYk as QC_noSYk_pri,
T1.noQC_noSYk as noQC_noSYk_pri,
T1.back_yes as back_yes_pri,
T1.new_yes as new_yes_pri,T2.* 
FROM CMRC_DB_kaonthu.doctor_wu_20220125 as T1
LEFT JOIN (
SELECT count(*) as co1,a.MMRCID,a.OriginalID,a.chtno,a.CMRC_number,
a.uridate,a.dataexam,a.case,a.normal,a.co,a.back_yes as back_yes_1,a.new_yes as new_yes_1,b.* 
FROM (SELECT * FROM CMRC_DB_kaonthu.doctor_wu_20220125
WHERE back_yes regexp '1' OR new_yes regexp '1') as a
INNER JOIN 
(SELECT * FROM CMRC_DB_kaonthu.CMRC_sample_Database_Consent
WHERE Specimen IN ("SY","SR") and CMRC_reserved != 1 AND `out` != 1 ) as b 
ON a.CMRC_number = b.CMRC_id AND a.dataexam = b.C_Date
GROUP BY OriginalID ) as T2
ON T1.OriginalID = T2.OriginalID
ORDER BY co desc,back_yes,new_yes;

################################
UPDATE CMRC_DB_kaonthu.doctor_wu_20220125_2 as U1
SET U1.class = NULL; 

UPDATE CMRC_DB_kaonthu.doctor_wu_20220125_2 as U1
SET U1.class = 0
WHERE (back_yes_pri not regexp '1' OR back_yes_pri is NULL) 
AND (new_yes_pri not regexp '1' OR new_yes_pri is NULL); 
#124+2個 沒有有同意書

UPDATE CMRC_DB_kaonthu.doctor_wu_20220125_2 as U1
SET U1.class = 0.1
WHERE co1 is NULL and (back_yes_pri regexp '1' or new_yes_pri regexp '1');
#13個有同意書但沒庫存

UPDATE CMRC_DB_kaonthu.doctor_wu_20220125_2 as U1
SET U1.class = 1
WHERE co1 IN (1,2);
#38個出庫2管涉及最後1管

UPDATE CMRC_DB_kaonthu.doctor_wu_20220125_2 as U1
SET U1.class = 2
WHERE co1 >= 3;
#93個庫存有3管以上

SELECT a.*,b.* 
FROM (SELECT * FROM CMRC_DB_kaonthu.doctor_wu_20220125
WHERE CMRC_number IN("L22013C01023E8093")) as a
INNER JOIN 
(SELECT * FROM CMRC_DB_kaonthu.CMRC_sample_Database_Consent
WHERE Specimen IN ("SY","SR") and CMRC_reserved != 1 AND `out` != 1 ) as b 
ON a.CMRC_number = b.CMRC_id AND a.dataexam = b.C_Date; #有同意書的對過去 131 */
