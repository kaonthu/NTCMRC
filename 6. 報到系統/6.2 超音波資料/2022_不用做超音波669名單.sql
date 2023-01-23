SELECT * FROM CMRC_DB_kaonthu.CMRC_all_persontimes_20220110_kaonthu 
WHERE echo = "1";

SELECT * FROM kao_practice_3.CMRC_all_persontimes_desc_last_kaonthu
WHERE echo = "1"
and data_exam < 20180000;
#這669個是不用照超音波的名單

SELECT b.id,a.* 
FROM CMRC_all_persontimes_20220110_kaonthu as a
INNER JOIN CMRC_DB.CMRC_Record_Of_Echo as b
ON a.p_id = b.`病歷號` and a.data_exam = b.`日期`;

SELECT b.id,a.* 
FROM kao_practice_3.CMRC_all_persontimes_desc_last_kaonthu as a
INNER JOIN CMRC_DB.CMRC_Record_Of_Echo as b
ON a.p_id = b.`病歷號` and a.data_exam = b.`日期`;