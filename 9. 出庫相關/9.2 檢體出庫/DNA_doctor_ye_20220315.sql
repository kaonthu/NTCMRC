SELECT * FROM CMRC_DB_kaonthu.CMRC_DNA_DB_kaonthu_back_DNA_New_consent 
WHERE back_yes regexp '1'
AND DNA_yes REGEXP '1'
GROUP BY p_id;

SELECT * FROM CMRC_DB_kaonthu.CMRC_DNA_DB_kaonthu_back_DNA_New_consent 
WHERE back_yes regexp '1'
AND DNA_yes REGEXP '1'
GROUP BY CMRC_ID;

SELECT * FROM CMRC_DB_kaonthu.doctor_ye_20220127
WHERE DNA_record = 0 ; #1084沒申請過

SELECT b.No,a.*
FROM 
(SELECT * FROM CMRC_DB_kaonthu.CMRC_DNA_DB_kaonthu_back_DNA_New_consent 
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
(SELECT * FROM CMRC_DB_kaonthu.CMRC_DNA_DB_kaonthu_back_DNA_New_consent 
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
(SELECT * FROM CMRC_DB_kaonthu.CMRC_DNA_DB_kaonthu_back_DNA_New_consent 
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
(SELECT * FROM CMRC_DB_kaonthu.CMRC_DNA_DB_kaonthu_back_DNA_New_consent 
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
(SELECT * FROM CMRC_DB_kaonthu.CMRC_DNA_DB_kaonthu_back_DNA_New_consent 
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
(SELECT * FROM CMRC_DB_kaonthu.CMRC_DNA_DB_kaonthu_back_DNA_New_consent 
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
(SELECT * FROM CMRC_DB_kaonthu.CMRC_DNA_DB_kaonthu_back_DNA_New_consent ) as a
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
(SELECT * FROM CMRC_DB_kaonthu.CMRC_DNA_DB_kaonthu_back_DNA_New_consent 
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
(SELECT * FROM CMRC_DB_kaonthu.CMRC_DNA_DB_kaonthu_back_DNA_New_consent 
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
(SELECT * FROM CMRC_DB_kaonthu.CMRC_DNA_DB_kaonthu_back_DNA_New_consent 
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

#######################################################################################################

SELECT b.No,a.*
FROM 
(SELECT * FROM CMRC_DB_kaonthu.CMRC_DNA_DB_kaonthu_back_DNA_New_consent 
WHERE 
((back_yes regexp '1' AND DNA_yes REGEXP '1')
OR
New_ver regexp '8')) as a
INNER JOIN 
(SELECT * 
FROM CMRC_DB_kaonthu.doctor_ye_20220127) 
as b
ON a.CMRC_ID = b.CMRC_number
GROUP BY b.CMRC_number
ORDER BY b.No; #554
 
 
SELECT b.No,a.*
FROM 
(SELECT * FROM CMRC_DB_kaonthu.CMRC_DNA_DB_kaonthu_back_DNA_New_consent 
WHERE stock_after_bk >= 1000
AND ((back_yes regexp '1' AND DNA_yes REGEXP '1')
OR
New_ver regexp '8')) as a
INNER JOIN 
(SELECT * 
FROM CMRC_DB_kaonthu.doctor_ye_20220127) 
as b
ON a.CMRC_ID = b.CMRC_number
GROUP BY b.CMRC_number
ORDER BY b.No; #庫存 1000 且有同意書 541管 

SELECT b.No,a.*
FROM 
(SELECT * FROM CMRC_DB_kaonthu.CMRC_DNA_DB_kaonthu_back_DNA_New_consent 
WHERE stock_after_bk >= 5500
AND ((back_yes regexp '1' AND DNA_yes REGEXP '1')
OR
New_ver regexp '8')) as a
INNER JOIN 
(SELECT * 
FROM CMRC_DB_kaonthu.doctor_ye_20220127) 
as b
ON a.CMRC_ID = b.CMRC_number
GROUP BY b.CMRC_number
ORDER BY b.No; #庫存 5500 且有同意書 504管 

#################################

SELECT b.No,a.*
FROM 
(SELECT * FROM CMRC_DB_kaonthu.CMRC_DNA_DB_kaonthu_back_DNA_New_consent 
WHERE 
((back_yes regexp '1' AND DNA_yes REGEXP '1')
OR
New_ver regexp '8')) as a
INNER JOIN 
(SELECT * 
FROM CMRC_DB_kaonthu.doctor_ye_20220127
WHERE DNA_Total = 0) 
as b
ON a.CMRC_ID = b.CMRC_number
GROUP BY b.CMRC_number
ORDER BY b.No; #649
 
 
SELECT b.No,a.*
FROM 
(SELECT * FROM CMRC_DB_kaonthu.CMRC_DNA_DB_kaonthu_back_DNA_New_consent 
WHERE stock_after_bk >= 1000
AND ((back_yes regexp '1' AND DNA_yes REGEXP '1')
OR
New_ver regexp '8')) as a
INNER JOIN 
(SELECT * 
FROM CMRC_DB_kaonthu.doctor_ye_20220127
WHERE DNA_Total = 0) 
as b
ON a.CMRC_ID = b.CMRC_number
GROUP BY b.CMRC_number
ORDER BY b.No; #庫存 1000 且有同意書 636管 

SELECT b.No,a.*
FROM 
(SELECT * FROM CMRC_DB_kaonthu.CMRC_DNA_DB_kaonthu_back_DNA_New_consent 
WHERE stock_after_bk >= 5500
AND ((back_yes regexp '1' AND DNA_yes REGEXP '1')
OR
New_ver regexp '8')) as a
INNER JOIN 
(SELECT * 
FROM CMRC_DB_kaonthu.doctor_ye_20220127
WHERE DNA_Total = 0) 
as b
ON a.CMRC_ID = b.CMRC_number
GROUP BY b.CMRC_number
ORDER BY b.No; #庫存 5500 且有同意書 592管 

####################  20220315 有91個人已經出庫過了 ##################

SELECT b.No,a.*
FROM 
(SELECT * FROM CMRC_DB_kaonthu.CMRC_DNA_DB_kaonthu_back_DNA_New_consent 
WHERE 
((back_yes regexp '1' AND DNA_yes REGEXP '1')
OR
New_ver regexp '8')) as a
INNER JOIN 
(SELECT * 
FROM CMRC_DB_kaonthu.doctor_ye_20220127
WHERE DNA_Total > 0) 
as b
ON a.CMRC_ID = b.CMRC_number
GROUP BY b.CMRC_number
ORDER BY b.No; #81

######################################################

SELECT b.p_id
FROM 
(SELECT * FROM CMRC_DB_kaonthu.CMRC_DNA_DB_kaonthu_back_DNA_New_consent 
WHERE 
((back_yes regexp '1' AND DNA_yes REGEXP '1')
OR
New_ver regexp '8')) as a
RIGHT JOIN 
(SELECT * 
FROM CMRC_DB_kaonthu.doctor_ye_20220127
WHERE DNA_Total > 0) 
as b
ON a.CMRC_ID = b.CMRC_number
WHERE a.sid is NULL
GROUP BY b.CMRC_number
ORDER BY b.No
; #這10個人是之前出庫過但同意書不合格

SELECT * FROM CMRC_DB_kaonthu.CMRC_DNA_DB_kaonthu_back_DNA_New_consent
WHERE p_id IN (SELECT b.p_id
FROM 
(SELECT * FROM CMRC_DB_kaonthu.CMRC_DNA_DB_kaonthu_back_DNA_New_consent 
WHERE 
((back_yes regexp '1' AND DNA_yes REGEXP '1')
OR
New_ver regexp '8')) as a
RIGHT JOIN 
(SELECT * 
FROM CMRC_DB_kaonthu.doctor_ye_20220127
WHERE DNA_Total > 0) 
as b
ON a.CMRC_ID = b.CMRC_number
WHERE a.sid is NULL
GROUP BY b.CMRC_number
ORDER BY b.No); #確認的確是這樣 猜測有可能是之前只要簽過就可以

###############################################################################


SELECT b.No,a.*
FROM 
(SELECT * FROM CMRC_DB_kaonthu.CMRC_DNA_DB_kaonthu_back_DNA_New_consent 
WHERE 
((back_yes regexp '1' AND DNA_yes REGEXP '1')
OR
New_ver regexp '8')) as a
INNER JOIN 
(SELECT * 
FROM CMRC_DB_kaonthu.doctor_ye_20220127
WHERE DNA_Total > 0) 
as b
ON a.CMRC_ID = b.CMRC_number
GROUP BY b.CMRC_number
ORDER BY b.No; # 81 個已出庫過的

####################################################################

SELECT *,GROUP_CONCAT(stock_out_ngs SEPARATOR '_')
FROM CMRC_DB_kaonthu.CMRC_DNA_DB_kaonthu_back_DNA_consent
WHERE p_id IN (SELECT p_id
FROM CMRC_DB_kaonthu.doctor_ye_20220127
WHERE DNA_1513 = 1)
AND out_names REGEXP '賴旗俊|葉集孝'
GROUP BY p_id 
ORDER BY p_id ;


DROP TEMPORARY TABLE CMRC_DB_kaonthu.doctor_ye_20220127_out_record_91;

CREATE TEMPORARY TABLE CMRC_DB_kaonthu.doctor_ye_20220127_out_record_91 as
SELECT a.p_id,a.CMRC_id,b.*,sum(round((IFNULL((b.stock_out_ul),0)) * a.ng_ul / 1000,4)) as out_ug,
5.5-sum(round((IFNULL((b.stock_out_ul),0)) * a.ng_ul / 1000,4)) as Replenish
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

SELECT *
FROM CMRC_DB_kaonthu.doctor_ye_20220127_out_record_91;

##############################

SELECT 1000 * b.Replenish as Replenish,a.*
FROM 
(SELECT * FROM CMRC_DB_kaonthu.CMRC_DNA_DB_kaonthu_back_DNA_New_consent 
WHERE 
((back_yes regexp '1' AND DNA_yes REGEXP '1')
OR
New_ver regexp '8')) as a
INNER JOIN 
(SELECT *
FROM CMRC_DB_kaonthu.doctor_ye_20220127_out_record_91) 
as b
ON a.CMRC_ID = b.CMRC_ID
WHERE stock_after_bk > 1000 * Replenish
GROUP BY p_id
; # 81個補庫存 

############################################################

CREATE TABLE CMRC_DB_kaonthu.doctor_ye_20220127_out_list_649 as
SELECT 5.500 as out_ug,b.No,a.*,max(stock_after_bk) as ma
FROM 
(SELECT * FROM CMRC_DB_kaonthu.CMRC_DNA_DB_kaonthu_back_DNA_New_consent 
WHERE 
((back_yes regexp '1' AND DNA_yes REGEXP '1')
OR
New_ver regexp '8')) as a
INNER JOIN 
(SELECT * 
FROM CMRC_DB_kaonthu.doctor_ye_20220127
WHERE DNA_Total = 0) 
as b
ON a.CMRC_ID = b.CMRC_number
GROUP BY b.CMRC_number
ORDER BY b.No; #649

ALTER TABLE `CMRC_DB_kaonthu`.`doctor_ye_20220127_out_list_649` 
CHANGE COLUMN `P_ID` `P_ID` VARCHAR(20) CHARACTER SET 'utf8mb4' NOT NULL ,
ADD PRIMARY KEY (`P_ID`);

ALTER TABLE `CMRC_DB_kaonthu`.`doctor_ye_20220127_out_list_649` 
ENGINE = MyISAM ;


INSERT INTO CMRC_DB_kaonthu.doctor_ye_20220127_out_list_649
SELECT ROUND(b.Replenish,3) , 0 ,a.*,max(stock_after_bk) as ma
FROM 
(SELECT * FROM CMRC_DB_kaonthu.CMRC_DNA_DB_kaonthu_back_DNA_New_consent 
WHERE 
((back_yes regexp '1' AND DNA_yes REGEXP '1')
OR
New_ver regexp '8')) as a
INNER JOIN 
(SELECT *
FROM CMRC_DB_kaonthu.doctor_ye_20220127_out_record_91) 
as b
ON a.CMRC_ID = b.CMRC_ID
WHERE stock_after_bk > 1000 * Replenish
AND 1000 * Replenish > 0 
GROUP BY p_id
; # 81個補庫存 


UPDATE `CMRC_DB_kaonthu`.`doctor_ye_20220127_out_list_649` as a
INNER JOIN 
`CMRC_DB_kaonthu`.`doctor_ye_20220127` as b
ON a.p_id = b.p_id
SET a.`No` = b.`No`;

#####################################################

SELECT a.*,b.p_id 
FROM (
SELECT * 
FROM CMRC_DB_kaonthu.CMRC_DNA_DB_kaonthu_back_DNA_New_consent 
WHERE p_id IN 
(SELECT p_id FROM CMRC_DB_kaonthu.doctor_ye_20220127_out_list_649) ) as a
LEFT JOIN 
(
SELECT * 
FROM CMRC_DB_kaonthu.CMRC_DNA_DB_kaonthu_back_DNA_New_consent 
WHERE p_id IN 
(SELECT p_id FROM CMRC_DB_kaonthu.doctor_ye_20220127_out_list_649) ) as b
ON a.p_id = b.p_id and a.stock_after_bk < b.stock_after_bk 
WHERE b.p_id is NULL;

###### 要切記現在選的位置並非最大位置的那個 日後出庫若有必要要從最大庫存量的出

#######################################################################
SELECT CMRC_ID,group_concat(out_names SEPARATOR '_'),group_concat(out_times  SEPARATOR '_'),group_concat(stock_out_ngs  SEPARATOR '_')
FROM CMRC_DB_kaonthu.CMRC_DNA_DB_kaonthu_back_DNA_New_consent 
WHERE CMRC_ID IN (
"E82014L50719W0001",
"S42014F70517G1003",
"K82014Y70628M8082",
"O02013J01214Q6039",
"B62015U20815V3051",
"Q92014F20628C8006",
"S92015S50919B4055",
"D92017V30819S1018",
"T42016Z40416R6006",
"I32014V10611R5072",
"W12014W70628E1075",
"L22015V40919L2073",
"R72013T71214O9003",
"C82013W91130L6072",
"Y62017I81028Q5053",
"Y72014D10517B1025",
"A62014H70920H3049",
"B52015B70801G0073",
"T22015I61031E9033",
"B22013T21008W5044",
"G32017F60902L7036",
"C22017Y80909N6040",
"E52015P00801X1034",
"C52013R01108V9094",
"N32014A60719E5086",
"F22014G80719M7052",
"D02014D40719S2004",
"H02017T00304O3085",
"J22016R90117V1079",
"P22015U40124Z1023",
"O42014A10719R9030",
"Z82016S50812D0073",
"H32014J00719D0073",
"C12014X50628I1036",
"T92014W70719T5070",
"U72014R00719V5116",
"V32015A10725O0024",
"P42018C30410B9023")
AND out_names regexp '賴旗俊|葉集孝'
GROUP BY CMRC_ID;

############################################################################

CREATE TABLE CMRC_DB_kaonthu_work.doctor_ye_20220127_out_list_630
SELECT round(1000*T2.out_ug/T1.ng_ul,1) as out_ul_now,round(T2.out_ug,1) as out_ug_now,T2.`No`,T1.*
FROM 
(
SELECT a.*
FROM (
SELECT * 
FROM CMRC_DB_kaonthu.CMRC_DNA_DB_kaonthu_back_DNA_New_consent 
WHERE p_id IN 
(SELECT p_id FROM CMRC_DB_kaonthu.doctor_ye_20220127_out_list_649) ) as a
LEFT JOIN 
(
SELECT * 
FROM CMRC_DB_kaonthu.CMRC_DNA_DB_kaonthu_back_DNA_New_consent 
WHERE p_id IN 
(SELECT p_id FROM CMRC_DB_kaonthu.doctor_ye_20220127_out_list_649) ) as b
ON a.p_id = b.p_id and a.stock_after_bk < b.stock_after_bk 
WHERE b.p_id is NULL
) as T1
INNER JOIN CMRC_DB_kaonthu.doctor_ye_20220127_out_list_649 as T2
ON T1.P_ID = T2.P_ID
WHERE T1.stock_after_bk >= out_ug * 1000 AND out_ug >= 1;

SELECT * FROM CMRC_DB_kaonthu_work.doctor_ye_20220127_out_list_630
WHERE CMRC_ID not IN (SELECT CMRC_number FROM CMRC_DB_kaonthu_work.`20220408_收到DNA不要62個`)
ORDER BY BOX,Site;



