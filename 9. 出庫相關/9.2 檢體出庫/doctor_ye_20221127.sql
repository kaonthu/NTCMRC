SELECT * FROM CMRC_DB_kaonthu_2.doctor_ye_20221127;

ALTER TABLE `CMRC_DB_kaonthu_2`.`doctor_ye_20221127` 
CHANGE COLUMN `p_id` `p_id_pri` VARCHAR(17) NULL DEFAULT NULL ;

ALTER TABLE `CMRC_DB_kaonthu_2`.`doctor_ye_20221127` 
ADD COLUMN `p_id` VARCHAR(20) NULL AFTER `data_exam`;

ALTER TABLE `CMRC_DB_kaonthu_2`.`doctor_ye_20221127` 
CHANGE COLUMN `CMRC_ID` `CMRC_ID_pri` VARCHAR(17) NULL DEFAULT NULL ;

ALTER TABLE `CMRC_DB_kaonthu_2`.`doctor_ye_20221127` 
ADD COLUMN `CMRC_ID` VARCHAR(20) NULL AFTER `p_id`;

UPDATE CMRC_DB_kaonthu_2.doctor_ye_20221127 as a
INNER JOIN NTCMRC.CMRC_all_persontimes_desc_last as b
ON a.p_id_pri = b.p_id
SET a.p_id = b.p_id;

UPDATE CMRC_DB_kaonthu_2.doctor_ye_20221127 as a
INNER JOIN NTCMRC.CMRC_all_persontimes_desc_last as b
ON a.p_id = b.p_id
SET a.CMRC_ID = b.CMRC_ID;

SELECT *,count(*) 
FROM CMRC_DB_kaonthu_2.doctor_ye_20221127
GROUP BY p_id;

SELECT a.*,b.*
FROM CMRC_DB_kaonthu_2.doctor_ye_20221127 as a
INNER JOIN NTCMRC.`CMRC_all_persontimes_desc_last_back_new_DNA_TMPI_生資` as b
ON a.p_id = b.p_id
WHERE back_yes regexp '1'
OR new_yes REGEXP '1';

SELECT a.*,b.back_yes,b.new_yes
FROM CMRC_DB_kaonthu_2.doctor_ye_20221127 as a
INNER JOIN NTCMRC.`CMRC_all_persontimes_desc_last_back_new_DNA_TMPI_生資` as b
ON a.p_id = b.p_id
WHERE back_yes regexp '1'
OR new_yes REGEXP '1'; #符合同意書規範 有968個

###############################################
CREATE TABLE CMRC_DB_kaonthu_2.doctor_ye_20221127_964
SELECT a.*,b.sup
FROM 
(SELECT * FROM NTCMRC.CMRC_sample_Database_Consent
WHERE qc <> 1
AND cmrc_reserved <> 1
AND `out` <> 1
AND specimen = 'p'
AND (back_yes regexp '1'
OR new_yes REGEXP '1') ) as a
INNER JOIN 
(SELECT * 
FROM CMRC_DB_kaonthu_2.doctor_ye_20221127) 
as b
ON a.CMRC_ID = b.CMRC_ID
GROUP BY b.sup
ORDER BY b.sup; #庫存  有916個能正常出庫非最後一管

#ALTER TABLE CMRC_DB_kaonthu_2.doctor_ye_20221127_916
#CHANGE COLUMN `CMRC_ID` `CMRC_ID` VARCHAR(40) CHARACTER SET 'utf8mb4' NOT NULL ,
#ADD PRIMARY KEY (`CMRC_ID`);
###############################

SELECT a.* ,b.*
FROM CMRC_DB_kaonthu_2.doctor_ye_20221127_964 as a
RIGHT JOIN 
(SELECT * 
FROM CMRC_DB_kaonthu_2.doctor_ye_20221127) 
as b
ON a.sup = b.sup
WHERE a.C_number is NULL
ORDER BY b.sup
; #庫存  加上最後一管仍只有964/981 管能正常出庫

###################################################################
CREATE TABLE CMRC_DB_kaonthu_2.doctor_ye_20221127_925
SELECT a.*,b.sup
FROM 
(SELECT * FROM NTCMRC.CMRC_sample_Database_Consent
WHERE qc <> 1
AND cmrc_reserved <> 1
AND `out` <> 1
AND specimen = 'p'
AND (back_yes regexp '1'
OR new_yes REGEXP '1') ) as a
INNER JOIN 
(SELECT * 
FROM CMRC_DB_kaonthu_2.doctor_ye_20221127) 
as b
ON a.CMRC_ID = b.CMRC_ID and left(b.data_exam,4) = left(a.C_Date,4)
GROUP BY b.sup
ORDER BY b.sup; #庫存  若是要時間同一年則檢體更少925

INSERT INTO doctor_ye_20221127_925
SELECT a.*,b.sup
FROM 
(SELECT * FROM NTCMRC.CMRC_sample_Database_Consent
WHERE cmrc_reserved <> 1
AND `out` <> 1
AND specimen = 'p'
AND (back_yes regexp '1'
OR new_yes REGEXP '1') ) as a
INNER JOIN 
(SELECT * 
FROM CMRC_DB_kaonthu_2.doctor_ye_20221127) 
as b
ON a.CMRC_ID = b.CMRC_ID and left(b.data_exam,4) = left(a.C_Date,4)
WHERE a.CMRC_ID not IN (SELECT CMRC_ID FROM CMRC_DB_kaonthu_2.doctor_ye_20221127_925);

###################################################################

SELECT a.* ,b.*
FROM CMRC_DB_kaonthu_2.doctor_ye_20221127_925 as a
RIGHT JOIN 
(SELECT * 
FROM CMRC_DB_kaonthu_2.doctor_ye_20221127) 
as b
ON a.sup = b.sup
WHERE a.C_number is NULL
ORDER BY b.sup
; #庫存  加上最後一管仍只有925/981 管能正常出庫

###################### 檢體缺少原因 #############################################

SELECT * FROM NTCMRC.CMRC_sample_Database_Consent
where P_number regexp '^M10';
#第一個問題是沒有匯入門診收案 M10 的檢體

SELECT * FROM NTCMRC.CMRC_sample_Database_Consent
where P_number regexp '^M08';


SELECT * FROM NTCMRC.CMRC_all_persontimes
WHERE p_id IN (
SELECT b.p_id
FROM CMRC_DB_kaonthu_2.doctor_ye_20221127_842 as a
RIGHT JOIN 
(SELECT * 
FROM CMRC_DB_kaonthu_2.doctor_ye_20221127) 
as b
ON a.sup = b.sup
WHERE a.C_number is NULL
ORDER BY b.sup)
; #139管沒有的檢體 有48個是 M10B 的檢體 4個 M08B


SELECT a.CMRC_id,b.CMRC_id 
FROM CMRC_DB_kaonthu_2.doctor_ye_20221127_842 as a
LEFT JOIN CMRC_DB_kaonthu_2.doctor_ye_20221127_805 as b
ON a.CMRC_ID = b.CMRC_ID;
#第二個問題是要求指定同年份

SELECT * FROM NTCMRC.CMRC_sample_Database_Consent
where CMRC_id regexp 'A52015O10124Z3029'; 

SELECT * FROM NTCMRC.CMRC_all_persontimes
where CMRC_id regexp 'A52015O10124Z3029'; #這個人 沒有在 20210917來過卻要 20210917的檢體

###################################################

SELECT * FROM NTCMRC.CMRC_sample_Database_Consent
where CMRC_id regexp 'A42015A70829P9001'
and Specimen in ("P"); #沒簽同意書

SELECT * FROM CMRC_DB_kaonthu_2.test
WHERE CMRC_ID IN ("H12014R90118L4035"); 

#############################################################

SELECT a.sup,b.data_exam,a.CMRC_ID,a.C_Date,a.C_number,a.P_number,a.Fridge,a.Box,a.Site,a.Specimen
FROM CMRC_DB_kaonthu_2.doctor_ye_20221127_877 as a
INNER JOIN CMRC_DB_kaonthu_2.doctor_ye_20221127 as b
ON a.sup = b.sup
ORDER BY a.Fridge+0,a.Box,a.Site+0;


