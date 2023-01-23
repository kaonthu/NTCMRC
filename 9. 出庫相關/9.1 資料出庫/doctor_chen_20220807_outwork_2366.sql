
CREATE temporary table CMRC_DB_kaonthu_work.doctor_chen_20220807_temp as
SELECT a.*
FROM kao_practice_5.ob_SNP_907_20211217 as a
INNER JOIN CMRC_DB_kaonthu_work.Depresion_SNP_regression_20220713 as b
ON a.ob_id = b.ID
WHERE (`case` = 0 or `case3` = 1)
order by p_id;

DROP temporary table CMRC_DB_kaonthu_work.doctor_chen_20220807_temp;

SELECT * FROM CMRC_DB_kaonthu_work.doctor_chen_20220807_temp;


CREATE table CMRC_DB_kaonthu_work.doctor_chen_20220807 as
SELECT a.* FROM
CMRC_DB_2022_import_work.new_CMRC_db_testing_question_scalebigtable_20220625 as a
INNER JOIN CMRC_DB_kaonthu_work.doctor_chen_20220807_temp as b
ON a.p_id = b.p_id;