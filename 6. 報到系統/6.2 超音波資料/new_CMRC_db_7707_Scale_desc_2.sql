SELECT `病歷號` FROM CMRC_DB.CMRC_Record_Of_Echo
WHERE `肝臟` = 1 AND `病歷號` != ""
GROUP BY `病歷號`; #超音波有異常的 2782人

SELECT * FROM CMRC_DB_kaonthu.new_CMRC_db_7707_Scale_desc_2;

ALTER TABLE `CMRC_DB_kaonthu`.`new_CMRC_db_7707_Scale_desc_2` 
ADD COLUMN `echo_abnormal` INT(2) NULL AFTER `HCV`;

DELETE 
FROM CMRC_DB_kaonthu.new_CMRC_db_7707_Scale_desc_2
WHERE row_names is NULL;

UPDATE `CMRC_DB_kaonthu`.`new_CMRC_db_7707_Scale_desc_2` 
SET echo_abnormal = 0 ;

UPDATE `CMRC_DB_kaonthu`.`new_CMRC_db_7707_Scale_desc_2`  as a 
INNER JOIN 
(SELECT `病歷號` FROM CMRC_DB.CMRC_Record_Of_Echo
WHERE `肝臟` = 1 AND `病歷號` != ""
GROUP BY `病歷號`) as b
ON a.p_id = b.`病歷號`
SET echo_abnormal = 2 ; #超音波有異常的 2763


UPDATE `CMRC_DB_kaonthu`.`new_CMRC_db_7707_Scale_desc_2`  as a 
SET SCORE = age75+BMI27+CKD_determine+DM_determine+D+HBV+HCV+echo_abnormal;

SELECT SCORE,age75+BMI27+CKD_determine+DM_determine+D+HBV+HCV as a,
SCORE-(age75+BMI27+CKD_determine+DM_determine+D+HBV+HCV) as b,
echo_abnormal
FROM `CMRC_DB_kaonthu`.`new_CMRC_db_7707_Scale_desc_2`;


