SELECT b.*,a.* FROM CMRC_DB_kaonthu.new_CMRC_db_testing_question_scalebigtable_20220316 as a
INNER JOIN CMRC_DB_kaonthu_work.doctor_lin_20220401 as b
on a.CMRC_ID = b.CMRC_ID OR a.New_CMRC_ID = b.CMRC_ID ;

SELECT * FROM CMRC_DB_kaonthu.new_CMRC_db_testing_question_scalebigtable_20220316 
WHERE CMRC_ID IN (SELECT * FROM CMRC_DB_kaonthu_work.doctor_lin_20220401)
OR New_CMRC_ID IN (SELECT * FROM CMRC_DB_kaonthu_work.doctor_lin_20220401);

SELECT CMRC_ID FROM CMRC_DB_kaonthu.new_CMRC_db_testing_question_scalebigtable_20220316
WHERE CMRC_ID IN (SELECT * FROM CMRC_DB_kaonthu_work.doctor_lin_20220401)
GROUP BY CMRC_ID;

SELECT CMRC_ID FROM CMRC_DB_kaonthu.new_CMRC_db_testing_question_scalebigtable_20220316
WHERE CMRC_ID IN (SELECT * FROM CMRC_DB_kaonthu_work.doctor_lin_20220401)
GROUP BY CMRC_ID;

SELECT * FROM CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310
WHERE CMRC_ID IN (SELECT * FROM CMRC_DB_kaonthu_work.doctor_lin_20220401)
GROUP BY p_id;

SELECT * FROM CMRC_DB_kaonthu_work.doctor_lin_20220401
WHERE CMRC_ID not IN (SELECT CMRC_ID FROM CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310);

SELECT * FROM CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310
WHERE New_CMRC_id IN (
"C06042V1061533641",
"F46045S2060690289",
"V66042T7061543712",
"Y86045I0050920919");

SELECT * FROM CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310
WHERE CMRC_id IN (
"X42016R91202L3065");

SELECT * FROM CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310_desc
WHERE CMRC_id IN ("R5M080F2009H7","I7M080K5010H1","H0M080P7017Y9");

SELECT * FROM CMRC_DB_kaonthu.new_CMRC_db_testing_question_scalebigtable_20220316
WHERE p_id IN ("7018428","8365733","4088105");

