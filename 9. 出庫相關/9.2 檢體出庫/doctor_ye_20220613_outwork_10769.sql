CREATE TABLE CMRC_DB_kaonthu_work.doctor_ye_20220613_outwork_10769_1
SELECT b.* 
FROM CMRC_DB_kaonthu_work.doctor_ye_20220613_outwork_3288_2 as a
INNER JOIN CMRC_DB_kaonthu.new_CMRC_db_testing_question_scalebigtable_20220316 AS b
ON a.P_ID = b.p_id
ORDER BY p_id,data_exam DESC;


