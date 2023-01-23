SELECT * FROM CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310
WHERE death = 1
GROUP BY p_id; #165 新增到 172

SELECT * FROM CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310
WHERE death_cgrd = 1
GROUP BY p_id;

SELECT * FROM CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310
WHERE move = 1
GROUP BY p_id; #29 到 32

SELECT * FROM CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310
WHERE reject = 1
GROUP BY p_id; #118 到 120

SELECT * FROM CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310
WHERE death = 1 or move = 1 or reject = 1
GROUP BY p_id; 


SELECT p_id FROM CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310
WHERE location2 ='嘉仁里' AND `name` ='林國棟' AND tel =24315908 UNION
SELECT p_id FROM CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310
WHERE location2 ='貢寮里' AND `name` ='吳錦榮' AND tel =24941672 UNION
SELECT p_id FROM CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310
WHERE location2 ='貢寮里' AND `name` ='簡義勝' AND tel =24941668 UNION
SELECT p_id FROM CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310
WHERE location2 ='貢寮里' AND `name` ='楊宗霖' AND tel =24941430 UNION
SELECT p_id FROM CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310
WHERE location2 ='壯觀里' AND `name` ='蔡火土' AND tel =24330156 UNION
SELECT p_id FROM CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310
WHERE location2 ='壯觀里' AND `name` ='朱潘玉里' AND tel =24330245 UNION
SELECT p_id FROM CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310
WHERE location2 ='壯觀里' AND `name` ='朱文樹' AND tel =24330245 UNION
SELECT p_id FROM CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310
WHERE location2 ='壯觀里' AND `name` ='朱國鴻' AND tel =24330245 UNION
SELECT p_id FROM CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310
WHERE location2 ='壯觀里' AND `name` ='許惠國' AND tel =24330409 UNION
SELECT p_id FROM CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310
WHERE location2 ='壯觀里' AND `name` ='蘇淑女' AND tel =24349300 UNION
SELECT p_id FROM CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310
WHERE location2 ='野柳里' AND `name` ='邱勇' AND tel =24923577 UNION
SELECT p_id FROM CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310
WHERE location2 ='野柳里' AND `name` ='蔡騰蚊' AND tel =24923055 UNION
SELECT p_id FROM CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310
WHERE location2 ='大鵬里' AND `name` ='蔡許麗美' AND tel =24981494 UNION
SELECT p_id FROM CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310
WHERE location2 ='大鵬里' AND `name` ='簡忠勲' AND tel =24981728;

##############################################################

SELECT location2,`name`,tel 
FROM CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310
WHERE p_id IN (7207570,4314782,962494,2365421,4086723,4881428,4178317,4146932,4270892)
GROUP BY p_id
ORDER BY FIELD(p_id,7207570,4314782,962494,2365421,4086723,4881428,4178317,4146932,4270892);

UPDATE CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310
SET death = 1
WHERE p_id IN (7207570,4314782,962494,2365421,4086723,4881428,4178317,4146932,4270892)
;
########################################################################

SELECT location2,`name`,tel 
FROM CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310
WHERE p_id IN (4585770,4337550,3031185)
GROUP BY p_id
ORDER BY FIELD(p_id,4585770,4337550,3031185);

UPDATE CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310
SET move = 1
WHERE p_id IN (4585770,4337550,3031185);

#############################################################

SELECT location2,`name`,tel 
FROM CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310
WHERE p_id IN (4037309,4925277)
GROUP BY p_id
ORDER BY FIELD(p_id,4037309,4925277);

UPDATE CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310
SET reject = 1
WHERE p_id IN (4037309,4925277);

################################################################








