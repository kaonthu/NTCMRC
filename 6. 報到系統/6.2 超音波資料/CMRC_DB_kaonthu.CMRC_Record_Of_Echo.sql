SELECT * FROM CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310
WHERE P_dn = 20150912077 or P_dn = 20150912008;


SELECT *,count(*) as co
FROM 
(
SELECT a.sid,b.*
FROM CMRC_DB_2022_import_work.new_CMRC_db_testing_question_scalebigtable_20220625 as a
LEFT JOIN (SELECT * FROM CMRC_DB_kaonthu.CMRC_Record_Of_Echo) as b
ON a.sid = b.`流水號`) as T1
GROUP BY sid; #20150912008 20150912077 原本有問題已修正

SELECT a.sid,b.*
FROM CMRC_DB_2022_import_work.new_CMRC_db_testing_question_scalebigtable_20220625 as a
LEFT JOIN (SELECT * FROM CMRC_DB_kaonthu.CMRC_Record_Of_Echo) as b
ON a.sid = b.`流水號`
ORDER BY a.sid;
