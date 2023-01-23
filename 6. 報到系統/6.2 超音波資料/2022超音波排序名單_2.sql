SELECT distinct(p_id)
FROM CMRC_DB_kaonthu.CMRC_all_persontimes_20220110_kaonthu as a
WHERE  echo = "1" 
AND p_id not IN (SELECT distinct(p_id)
FROM CMRC_DB_kaonthu.CMRC_all_persontimes_20220110_kaonthu
WHERE  echo = "1" and data_exam >= 20180000); #2026 人是上次照已經在 2018/1/1之前了

SELECT distinct(p_id)
FROM CMRC_DB_kaonthu.CMRC_all_persontimes_20220110_kaonthu as a
WHERE  echo = "1" 
AND p_id IN (SELECT distinct(p_id)
FROM CMRC_DB_kaonthu.CMRC_all_persontimes_20220110_kaonthu
WHERE  echo = "1" and data_exam >= 20180000); #2026 人是上次照已經在 2018/1/1之前了


SELECT distinct(p_id)
FROM CMRC_DB_kaonthu.CMRC_all_persontimes_20220110_kaonthu as a
WHERE  echo = "1" and data_exam >= 20180000 ;# 1595 人 是在2018/1/1 ~ 2021/12/31 有照過


SELECT distinct(p_id)
FROM CMRC_DB_kaonthu.CMRC_all_persontimes_20220110_kaonthu as a
WHERE  echo = "1"; #3621 人是有照過超音波的

SELECT * 
FROM kao_practice_3.CMRC_all_persontimes_desc_last_kaonthu
WHERE data_exam < 20180000 
AND p_id IN (SELECT distinct(p_id)
FROM CMRC_DB_kaonthu.CMRC_all_persontimes_20220110_kaonthu as a
WHERE  echo = "1"); #884 人 有照過echo 且上次來在 2018/1/1之前

SELECT * 
FROM kao_practice_3.CMRC_all_persontimes_desc_last_kaonthu
WHERE data_exam < 20180000 
AND p_id not IN (SELECT distinct(p_id)
FROM CMRC_DB_kaonthu.CMRC_all_persontimes_20220110_kaonthu as a
WHERE  echo = "1"); 
#1636人 沒照過echo 且上次來在 2018/1/1之前，基本上不再來

SELECT * 
FROM kao_practice_3.CMRC_all_persontimes_desc_last_kaonthu
WHERE data_exam >= 20180000 
AND p_id not IN (SELECT distinct(p_id)
FROM CMRC_DB_kaonthu.CMRC_all_persontimes_20220110_kaonthu as a
WHERE  echo = "1");
#2450人 沒照過echo 且上次來在 2018/1/1之後，很可能再來

####################################################
SELECT * 
FROM kao_practice_3.CMRC_all_persontimes_desc_last_kaonthu
WHERE p_id not IN (SELECT distinct(p_id)
FROM CMRC_DB_kaonthu.CMRC_all_persontimes_20220110_kaonthu as a
WHERE  echo = "1");

SELECT T1.*,T2.SCORE,T2.echo_abnormal
FROM (
SELECT * 
FROM kao_practice_3.CMRC_all_persontimes_desc_last_kaonthu
WHERE p_id not IN (SELECT distinct(p_id)
FROM CMRC_DB_kaonthu.CMRC_all_persontimes_20220110_kaonthu as a
WHERE  echo = "1") 
)as T1
INNER JOIN 
CMRC_DB_kaonthu.new_CMRC_db_7707_Scale_desc_2 as T2
ON T1.p_id = T2.p_id
WHERE SCORE >= 2; 
#4086人完全沒照過超音波 且有病 1410

SELECT T1.*,T2.SCORE,T2.echo_abnormal
FROM (
SELECT * 
FROM kao_practice_3.CMRC_all_persontimes_desc_last_kaonthu
WHERE p_id not IN (SELECT distinct(p_id)
FROM CMRC_DB_kaonthu.CMRC_all_persontimes_20220110_kaonthu as a
WHERE  echo = "1") 
)as T1
INNER JOIN 
CMRC_DB_kaonthu.new_CMRC_db_7707_Scale_desc_2 as T2
ON T1.p_id = T2.p_id
WHERE SCORE < 2; 
#4086人完全沒照過超音波 且沒病 2676


SELECT * 
FROM CMRC_DB_kaonthu.CMRC_all_persontimes_20220110_kaonthu
WHERE p_id = "4904590";

SELECT * 
FROM CMRC_DB_kaonthu.Echo_list_Total_20220222_2
WHERE `病歷號` = "4904590";

SELECT * FROM CMRC_DB.CMRC_Record_Of_Echo
WHERE `病歷號` = "4904590"