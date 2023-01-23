CREATE TABLE CMRC_DB_kaonthu_work.doctor_joe_20220616_outwork_250_1 AS 
SELECT b.* 
FROM CMRC_DB_kaonthu_work.doctor_joe_20220616_outwork_54 AS a
INNER JOIN 
CMRC_DB_kaonthu.new_CMRC_db_testing_question_scalebigtable_20220316 AS b
ON a.P_ID = b.p_id
ORDER BY p_id,data_exam DESC;

SHOW WARNINGS;

SELECT * FROM CMRC_DB_kaonthu_work.doctor_joe_20220616_outwork_250_1
GROUP BY p_id;

ALTER TABLE `CMRC_DB_kaonthu`.`new_CMRC_db_testing_question_scalebigtable_20220316` 
DROP COLUMN `hfood`;


SELECT hfood
FROM 
CMRC_DB_kaonthu.new_CMRC_db_testing_question_scalebigtable_20220316 