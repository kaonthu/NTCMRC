SELECT * FROM CMRC_DB_kaonthu.CMRC_DNA_DB_kaonthu_back_DNA_consent 
WHERE back_yes regexp '1'
AND DNA_yes REGEXP '1'
GROUP BY p_id;

SELECT * FROM CMRC_DB_kaonthu.CMRC_DNA_DB_kaonthu_back_DNA_consent 
WHERE back_yes regexp '1'
AND DNA_yes REGEXP '1'
GROUP BY CMRC_ID;

SELECT * FROM CMRC_DB_kaonthu.doctor_ye_20220127
WHERE DNA_record = 0 ; #1084沒申請過

SELECT b.No,a.*
FROM 
(SELECT * FROM CMRC_DB_kaonthu.CMRC_DNA_DB_kaonthu_back_DNA_consent 
WHERE back_yes regexp '1'
AND DNA_yes REGEXP '1') as a
INNER JOIN 
(SELECT * 
FROM CMRC_DB_kaonthu.doctor_ye_20220127) 
as b
ON a.CMRC_ID = b.CMRC_number
GROUP BY b.CMRC_number
ORDER BY b.No; #630

SELECT b.No,a.*
FROM 
(SELECT * FROM CMRC_DB_kaonthu.CMRC_DNA_DB_kaonthu_back_DNA_consent 
WHERE stock_after_bk >= 1000
AND back_yes regexp '1'
AND DNA_yes REGEXP '1') as a
INNER JOIN 
(SELECT * 
FROM CMRC_DB_kaonthu.doctor_ye_20220127) 
as b
ON a.CMRC_ID = b.CMRC_number
GROUP BY b.CMRC_number
ORDER BY b.No; #617

SELECT b.No,a.*
FROM 
(SELECT * FROM CMRC_DB_kaonthu.CMRC_DNA_DB_kaonthu_back_DNA_consent 
WHERE stock_after_bk >= 5500
AND back_yes regexp '1'
AND DNA_yes REGEXP '1') as a
INNER JOIN 
(SELECT * 
FROM CMRC_DB_kaonthu.doctor_ye_20220127) 
as b
ON a.CMRC_ID = b.CMRC_number
GROUP BY b.CMRC_number
ORDER BY b.No; #578
 
 
SELECT b.No,a.*
FROM 
(SELECT * FROM CMRC_DB_kaonthu.CMRC_DNA_DB_kaonthu_back_DNA_consent 
WHERE back_yes regexp '1'
AND DNA_yes REGEXP '1') as a
INNER JOIN 
(SELECT * 
FROM CMRC_DB_kaonthu.doctor_ye_20220127
WHERE DNA_record = 0 ) 
as b
ON a.CMRC_ID = b.CMRC_number
GROUP BY b.CMRC_number
ORDER BY b.No; #492
 
 
SELECT b.No,a.*
FROM 
(SELECT * FROM CMRC_DB_kaonthu.CMRC_DNA_DB_kaonthu_back_DNA_consent 
WHERE stock_after_bk >= 1000
AND back_yes regexp '1'
AND DNA_yes REGEXP '1') as a
INNER JOIN 
(SELECT * 
FROM CMRC_DB_kaonthu.doctor_ye_20220127
WHERE DNA_record = 0 ) 
as b
ON a.CMRC_ID = b.CMRC_number
GROUP BY b.CMRC_number
ORDER BY b.No; #庫存 1000 且有同意書 480管 

SELECT b.No,a.*
FROM 
(SELECT * FROM CMRC_DB_kaonthu.CMRC_DNA_DB_kaonthu_back_DNA_consent 
WHERE stock_after_bk >= 5500
AND back_yes regexp '1'
AND DNA_yes REGEXP '1') as a
INNER JOIN 
(SELECT * 
FROM CMRC_DB_kaonthu.doctor_ye_20220127
WHERE DNA_record = 0 ) 
as b
ON a.CMRC_ID = b.CMRC_number
GROUP BY b.CMRC_number
ORDER BY b.No; #庫存 5500 且有同意書 451管 

SELECT b.No,a.*
FROM 
(SELECT * FROM CMRC_DB_kaonthu.CMRC_DNA_DB_kaonthu_back_DNA_consent ) as a
INNER JOIN 
(SELECT * 
FROM CMRC_DB_kaonthu.doctor_ye_20220127
WHERE DNA_record = 0 ) 
as b
ON a.CMRC_ID = b.CMRC_number
GROUP BY b.CMRC_number
ORDER BY b.No; #庫存 1082管 

###############################################################

ALTER TABLE `CMRC_DB_kaonthu_work`.`葉集孝20200929出庫結果` 
ADD COLUMN `p_id` VARCHAR(45) NULL AFTER `note`;

SELECT * FROM CMRC_DB_kaonthu_work.葉集孝20200929出庫結果;

ALTER TABLE `CMRC_DB_kaonthu_work`.`葉醫師出庫過DNA名單` 
ADD COLUMN `p_id` VARCHAR(45) NULL AFTER `address`;

UPDATE `CMRC_DB_kaonthu_work`.`葉集孝20200929出庫結果` as a
INNER JOIN kao_practice_3.CMRC_all_persontimes_desc_last_kaonthu as b
ON a.CMRC_id = b.CMRC_ID
Set a.p_id = b.p_id;

UPDATE `CMRC_DB_kaonthu_work`.`葉醫師出庫過DNA名單` as a
INNER JOIN kao_practice_3.CMRC_all_persontimes_desc_last_kaonthu as b
ON a.CMRC_id = b.CMRC_ID
Set a.p_id = b.p_id;

ALTER TABLE `CMRC_DB_kaonthu`.`doctor_ye_20220127` 
ADD COLUMN `DNA_50` INT(6) NULL AFTER `plasma_record`,
ADD COLUMN `DNA_52` INT(6) NULL AFTER `DNA_50`,
ADD COLUMN `DNA_371` INT(6) NULL AFTER `DNA_52`,
ADD COLUMN `DNA_648` INT(6) NULL AFTER `DNA_371`,
ADD COLUMN `DNA_Total` INT(6) NULL AFTER `DNA_648`;

UPDATE `CMRC_DB_kaonthu`.`doctor_ye_20220127` 
SET DNA_50 = 0 , DNA_52 = 0 ,DNA_371 = 0,DNA_648 = 0,DNA_1513 = 0;

UPDATE `CMRC_DB_kaonthu`.`doctor_ye_20220127`  as a
INNER JOIN (SELECT * FROM kao_practice_4.dr_yeh_20210623_kaonthu
WHERE `out` = 1) as b
ON a.p_id = b.p_ID
Set a.DNA_50 = 1;

UPDATE `CMRC_DB_kaonthu`.`doctor_ye_20220127`  as T1
INNER JOIN (SELECT a.*,b.CMRC_ID,c.p_id 
FROM CMRC_DB.CMRC_DNA_Release_DB as a
INNER JOIN  CMRC_DB.CMRC_DNA_DB as b
ON a.C_number = b.C_number 
INNER JOIN kao_practice_3.CMRC_all_persontimes_desc_last_kaonthu as c
ON b.CMRC_id = c.CMRC_ID
WHERE out_time = "2021-07-12" AND out_name != "CMRC") as T2
ON T1.p_id = T2.p_ID
Set T1.DNA_52 = 1;

UPDATE `CMRC_DB_kaonthu`.`doctor_ye_20220127`  as a
INNER JOIN CMRC_DB_kaonthu_work.`葉集孝20200929出庫結果` as b
ON a.p_id = b.p_ID
Set a.DNA_371 = 1;

UPDATE `CMRC_DB_kaonthu`.`doctor_ye_20220127`  as a
INNER JOIN CMRC_DB_kaonthu_work.`葉醫師出庫過DNA名單` as b
ON a.p_id = b.p_ID
Set a.DNA_648 = 1;

ALTER TABLE `CMRC_DB_kaonthu`.`doctor_ye_20220127` 
ADD COLUMN `DNA_1513` INT(6) NULL AFTER `DNA_648`;

SELECT a.*,b.CMRC_ID,c.p_id 
FROM CMRC_DB.CMRC_DNA_Release_DB as a
INNER JOIN  CMRC_DB.CMRC_DNA_DB as b
ON a.C_number = b.C_number 
INNER JOIN kao_practice_3.CMRC_all_persontimes_desc_last_kaonthu as c
ON b.CMRC_id = c.CMRC_ID
WHERE out_name IN ("賴旗俊","葉集孝");

UPDATE `CMRC_DB_kaonthu`.`doctor_ye_20220127`  as T1
INNER JOIN (SELECT a.*,b.CMRC_ID,c.p_id 
FROM CMRC_DB.CMRC_DNA_Release_DB as a
INNER JOIN  CMRC_DB.CMRC_DNA_DB as b
ON a.C_number = b.C_number 
INNER JOIN kao_practice_3.CMRC_all_persontimes_desc_last_kaonthu as c
ON b.CMRC_id = c.CMRC_ID
WHERE out_name IN ("賴旗俊","葉集孝")) as T2
ON T1.p_id = T2.p_ID
Set T1.DNA_1513 = 1;

UPDATE `CMRC_DB_kaonthu`.`doctor_ye_20220127`
Set DNA_Total = DNA_50+DNA_52+DNA_371+DNA_648+DNA_1513;

#####################################################################

SELECT b.No,a.*
FROM 
(SELECT * FROM CMRC_DB_kaonthu.CMRC_DNA_DB_kaonthu_back_DNA_consent 
WHERE back_yes regexp '1'
AND DNA_yes REGEXP '1') as a
INNER JOIN 
(SELECT * 
FROM CMRC_DB_kaonthu.doctor_ye_20220127
WHERE DNA_Total = 0 ) 
as b
ON a.CMRC_ID = b.CMRC_number
GROUP BY b.CMRC_number
ORDER BY b.No; #554
 
 
SELECT b.No,a.*
FROM 
(SELECT * FROM CMRC_DB_kaonthu.CMRC_DNA_DB_kaonthu_back_DNA_consent 
WHERE stock_after_bk >= 1000
AND back_yes regexp '1'
AND DNA_yes REGEXP '1') as a
INNER JOIN 
(SELECT * 
FROM CMRC_DB_kaonthu.doctor_ye_20220127
WHERE DNA_Total = 0 ) 
as b
ON a.CMRC_ID = b.CMRC_number
GROUP BY b.CMRC_number
ORDER BY b.No; #庫存 1000 且有同意書 541管 

SELECT b.No,a.*
FROM 
(SELECT * FROM CMRC_DB_kaonthu.CMRC_DNA_DB_kaonthu_back_DNA_consent 
WHERE stock_after_bk >= 5500
AND back_yes regexp '1'
AND DNA_yes REGEXP '1') as a
INNER JOIN 
(SELECT * 
FROM CMRC_DB_kaonthu.doctor_ye_20220127
WHERE DNA_Total = 0 ) 
as b
ON a.CMRC_ID = b.CMRC_number
GROUP BY b.CMRC_number
ORDER BY b.No; #庫存 5500 且有同意書 504管 

##################################################

SELECT *,GROUP_CONCAT(stock_out_ngs SEPARATOR '_')
FROM CMRC_DB_kaonthu.CMRC_DNA_DB_kaonthu_back_DNA_consent
WHERE p_id IN (SELECT p_id
FROM CMRC_DB_kaonthu.doctor_ye_20220127
WHERE DNA_1513 = 1)
AND out_names REGEXP '賴旗俊|葉集孝'
GROUP BY p_id 
ORDER BY p_id ;


SELECT a.*,b.*,sum(round((IFNULL((b.stock_out_ul),0)) * a.ng_ul / 1000,4)) as out_ug
FROM  
CMRC_DB.CMRC_DNA_DB as a
INNER JOIN 
CMRC_DB.CMRC_DNA_Release_DB as b
ON a.C_number = b.C_number 
WHERE p_id IN (SELECT p_id
FROM CMRC_DB_kaonthu.doctor_ye_20220127
WHERE DNA_1513 = 1)
AND out_name regexp '賴旗俊|葉集孝'
GROUP BY p_id
ORDER BY p_id; 

################################# 在這次申請的清單中，已經有多少人申請過了




