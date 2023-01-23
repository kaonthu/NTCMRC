SELECT * FROM CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310
GROUP BY p_id; #全部人次 7976

SELECT * FROM CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310
WHERE death = 1 or move = 1 or reject = 1
GROUP BY p_id; 

SELECT * FROM CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310
WHERE death = 0 and move = 0 and reject = 0
GROUP BY p_id; #扣除死亡搬遷拒簽剩 7681


UPDATE CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310 as a
INNER JOIN CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310 as b
ON a.p_id = b.p_id
SET a.death = 1
WHERE b.death = 1 ;

UPDATE CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310 as a
INNER JOIN CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310 as b
ON a.p_id = b.p_id
SET a.reject = 1
WHERE b.reject = 1 ;

UPDATE CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310 as a
INNER JOIN CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310 as b
ON a.p_id = b.p_id
SET a.move = 1
WHERE b.move= 1 ;

SELECT * FROM CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310
WHERE need_back = 0
GROUP BY p_id; #2024要回簽

SELECT * FROM CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310
WHERE need_back = 1
GROUP BY p_id; #5952不需要回簽

SELECT * FROM CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310
WHERE death = 0 and move = 0 and reject = 0 and need_back = 1
GROUP BY p_id; #扣除死亡搬遷拒簽 未回簽 剩 5,860

SELECT * FROM CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310
WHERE death = 1 or move = 1 or reject = 1 or need_back = 0
GROUP BY p_id; #扣除死亡搬遷拒簽 未回簽 剩 2,116


SELECT * FROM 
CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310
WHERE p_id IN (
SELECT p_id 
FROM CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310
WHERE death = 1
GROUP BY p_id)
AND death = 0;

SELECT * FROM 
CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310
WHERE p_id IN (
SELECT p_id 
FROM CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310
WHERE reject = 1
GROUP BY p_id)
AND reject = 0;

SELECT * FROM 
CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310
WHERE p_id IN (
SELECT p_id 
FROM CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310
WHERE move = 1
GROUP BY p_id)
AND move = 0;

