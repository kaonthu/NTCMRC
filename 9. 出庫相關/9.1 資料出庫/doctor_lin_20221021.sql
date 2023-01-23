SELECT * FROM CMRC_DB_kaonthu_work.doctor_lin_20221021;


SELECT a.*,b.New_CMRC_id,b.CMRC_id
FROM CMRC_DB_kaonthu_work.doctor_lin_20221021 as a
LEFT JOIN CMRC_all_persontimes_20220110_kaonthu_20220310 as b
ON a.New_CMRC_id = b.New_CMRC_id and a.data_exam = b.data_exam;


ALTER TABLE `CMRC_DB_kaonthu_work`.`doctor_lin_20221021` 
CHANGE COLUMN `data_exam` `data_exam` VARCHAR(17) NULL DEFAULT NULL ,
CHANGE COLUMN `Old_CMRC_id` `Old_CMRC_id` VARCHAR(20) NULL DEFAULT NULL ;

UPDATE CMRC_DB_kaonthu_work.doctor_lin_20221021 as a
INNER JOIN  CMRC_all_persontimes_20220110_kaonthu_20220310 as b
ON a.New_CMRC_id = b.New_CMRC_id and a.data_exam = b.data_exam
SET a.Old_CMRC_id = b.CMRC_id;
