SELECT * FROM CMRC_DB_kaonthu_work.doctor_chen_20220530;

SELECT completeAUDIT,count(*)
FROM CMRC_DB_kaonthu_work.doctor_chen_20220530
GROUP BY completeAUDIT; #0 有1697 1有3387

SELECT s_number,pid,completeAUDIT,AUDITscore,CompleteTDQ01,TDQscore
FROM CMRC_DB_kaonthu_work.doctor_chen_20220530
WHERE completeAUDIT = 0; #0 有1697 1有3387

SELECT s_number,pid,completeAUDIT,AUDITscore,CompleteTDQ01,TDQscore
FROM CMRC_DB_kaonthu_work.doctor_chen_20220530
WHERE completeAUDIT = 1; #0 有1697 1有3387


SELECT p_id,d2_drink,d2_drinkt,d2_drinkav,d2_drinkday,
d2_drinkcat,d2_drinknote,d2_drinkvol,past2_drinkav,past2_drinkday,past2_drink,past2_drinkcat,
past2_drinknote,past2_drinkvol,past1_drink,d2_drinks,
drink_k1,drink_k2,drink_k3,drink_k4,drink_k5,drink_k6,drink_k7,drink_k7_o,
drink_t,drink_q,drink_qt1,drink_qt2,drink_red,
B_1_1,B_1_2,B_1_3,B_1_4,B_1_5,B_1_6,B_1_7,B_1_8,B_1_9,B_1_10,B_2_1,B_2_2,B_2_3,B_2_4,
hf_none,hf_vit,hf_wgl,hf_foil,hf_ca,hf_p,hf_chic,hf_clam,hf_e,hf_fmed
FROM CMRC_DB_2022_import_work.new_CMRC_db_20963_20220310;


SELECT a.s_number,a.pid,a.completeAUDIT,a.AUDITscore,a.CompleteTDQ01,a.TDQscore,
b.d2_drink,b.d2_drinkt,b.d2_drinkav,b.d2_drinkday,
b.B_1_1,b.B_1_2,b.B_1_3,b.B_1_4,b.B_1_5,b.B_1_6,b.B_1_7,b.B_1_8,b.B_1_9,b.B_1_10,b.B_2_1,b.B_2_2,b.B_2_3,b.B_2_4,
b.drink_k1,b.drink_k2,b.drink_k3,b.drink_k4,b.drink_k5,b.drink_k6,b.drink_k7,
b.hf_none,b.hf_vit,b.hf_wgl,b.hf_foil,b.hf_ca,b.hf_p,b.hf_chic,b.hf_clam,b.hf_e,b.hf_fmed
FROM CMRC_DB_kaonthu_work.doctor_chen_20220530 as a
INNER JOIN 
(SELECT sid,hf_none,hf_vit,hf_wgl,hf_foil,hf_ca,hf_p,hf_chic,hf_clam,hf_e,hf_fmed,
d2_drink,d2_drinkt,d2_drinkav,d2_drinkday,
drink_k1,drink_k2,drink_k3,drink_k4,drink_k5,drink_k6,drink_k7,
B_1_1,B_1_2,B_1_3,B_1_4,B_1_5,B_1_6,B_1_7,B_1_8,B_1_9,B_1_10,B_2_1,B_2_2,B_2_3,B_2_4
FROM CMRC_DB_2022_import_work.new_CMRC_db_20963_20220310 ) as b
ON a.s_number = b.sid;


SELECT sid,hf_none,d2_drink,d2_drinkt,d2_drinkav,d2_drinkday
FROM CMRC_DB_2022_import_work.new_CMRC_db_20963_20220310;
#hf_none 是20181219之後才有的問題
#633/634 20140315 後才有的問題 20181219之後沒有 
#回答的情況不是很好 d2_drinkav 3658/5084個NULL，d2_drinkday 1081/5084個NULL

UPDATE CMRC_DB_kaonthu_work.doctor_chen_20220530 as a
INNER JOIN 
(SELECT sid,hf_none,hf_vit,hf_wgl,hf_foil,hf_ca,hf_p,hf_chic,hf_clam,hf_e,hf_fmed,
d2_drink,d2_drinkt,d2_drinkav,d2_drinkday,
drink_k1,drink_k2,drink_k3,drink_k4,drink_k5,drink_k6,drink_k7,
B_1_1,B_1_2,B_1_3,B_1_4,B_1_5,B_1_6,B_1_7,B_1_8,B_1_9,B_1_10,B_2_1,B_2_2,B_2_3,B_2_4
FROM CMRC_DB_2022_import_work.new_CMRC_db_20963_20220310 ) as b
ON a.s_number = b.sid
SET 
a.hf_none = b.hf_none,
a.hf_foilCodliveroiluse = b.hf_foil,
a.hf_vit = b.hf_vit ,
a.hf_wgl = b.hf_wgl,
a.hf_ca = b.hf_ca,
a.hf_p = b.hf_p,
a.hf_chic = b.hf_chic,
a.hf_clam = b.hf_clam,
a.hf_e = b.hf_e,
a.hf_fmed = b.hf_fmed
WHERE a.hf_none is NULL and a.hf_foilCodliveroiluse is NULL;

UPDATE CMRC_DB_kaonthu_work.doctor_chen_20220530
SET hf_none = IF(hf_vit+hf_wgl+hf_foilCodliveroiluse+hf_ca+hf_p+hf_chic+hf_clam+hf_e+hf_fmed>0,1,0)
WHERE hf_none is NULL;

UPDATE CMRC_DB_kaonthu_work.doctor_chen_20220530
SET hf_none = NULL
WHERE hf_vit is NULL and hf_wgl is NULL;

ALTER TABLE `CMRC_DB_kaonthu_work`.`doctor_chen_20220530` 
ADD COLUMN `alco_days_drink_old` VARCHAR(5) NULL AFTER `drink_k7`,
ADD COLUMN `alco_days_drink_new` VARCHAR(5) NULL AFTER `alco_days_drink_old`;

ALTER TABLE `CMRC_DB_kaonthu_work`.`doctor_chen_20220530` 
ADD COLUMN `B_1_1` VARCHAR(5) NULL AFTER `alco_days_drink_old`;

UPDATE CMRC_DB_kaonthu_work.doctor_chen_20220530 as a
INNER JOIN 
(SELECT sid,hf_none,hf_vit,hf_wgl,hf_foil,hf_ca,hf_p,hf_chic,hf_clam,hf_e,hf_fmed,
d2_drink,d2_drinkt,d2_drinkav,d2_drinkday,
drink_k1,drink_k2,drink_k3,drink_k4,drink_k5,drink_k6,drink_k7,
B_1_1,B_1_2,B_1_3,B_1_4,B_1_5,B_1_6,B_1_7,B_1_8,B_1_9,B_1_10,B_2_1,B_2_2,B_2_3,B_2_4
FROM CMRC_DB_2022_import_work.new_CMRC_db_20963_20220310 ) as b
ON a.s_number = b.sid
SET 
a.drink_k1 = b.drink_k1,
a.drink_k2 = b.drink_k2,
a.drink_k3 = b.drink_k3,
a.drink_k4 = b.drink_k4,
a.drink_k5 = b.drink_k5,
a.drink_k6 = b.drink_k6,
a.drink_k7 = b.drink_k7,
a.d2_drinkav = b.d2_drinkav,
a.d2_drinkday = b.d2_drinkday,
a.B_1_1 = b.B_1_1 ;


UPDATE CMRC_DB_kaonthu_work.doctor_chen_20220530 as a
SET a.alco_days_drink_old = 365 / a.d2_drinkday
WHERE a.d2_drinkav = 3;

UPDATE CMRC_DB_kaonthu_work.doctor_chen_20220530 as a
SET a.alco_days_drink_old = 30 / a.d2_drinkday
WHERE a.d2_drinkav = 2;

UPDATE CMRC_DB_kaonthu_work.doctor_chen_20220530 as a
SET a.alco_days_drink_old = 7 / a.d2_drinkday
WHERE a.d2_drinkav = 1;

UPDATE CMRC_DB_kaonthu_work.doctor_chen_20220530 as a
SET a.alco_days_drink_new = 0
WHERE a.B_1_1 = 0;

UPDATE CMRC_DB_kaonthu_work.doctor_chen_20220530 as a
SET a.alco_days_drink_new = 30
WHERE a.B_1_1 = 1;

UPDATE CMRC_DB_kaonthu_work.doctor_chen_20220530 as a
SET a.alco_days_drink_new = 10
WHERE a.B_1_1 = 2;

UPDATE CMRC_DB_kaonthu_work.doctor_chen_20220530 as a
SET a.alco_days_drink_new = 2.8
WHERE a.B_1_1 = 3;

UPDATE CMRC_DB_kaonthu_work.doctor_chen_20220530 as a
SET a.alco_days_drink_new = 1.75
WHERE a.B_1_1 = 4;

###############################################################
ALTER TABLE `CMRC_DB_kaonthu_work`.`doctor_chen_20220530` 
ADD COLUMN `B_1_2` VARCHAR(5) NULL DEFAULT NULL AFTER `alco_days_drink_new`,
ADD COLUMN `B_1_3` VARCHAR(5) NULL DEFAULT NULL AFTER `B_1_2`,
ADD COLUMN `B_1_4` VARCHAR(5) NULL DEFAULT NULL AFTER `B_1_3`,
ADD COLUMN `B_1_5` VARCHAR(5) NULL DEFAULT NULL AFTER `B_1_4`,
ADD COLUMN `B_1_6` VARCHAR(5) NULL DEFAULT NULL AFTER `B_1_5`,
ADD COLUMN `B_1_7` VARCHAR(5) NULL DEFAULT NULL AFTER `B_1_6`,
ADD COLUMN `B_1_8` VARCHAR(5) NULL DEFAULT NULL AFTER `B_1_7`,
ADD COLUMN `B_1_9` VARCHAR(5) NULL DEFAULT NULL AFTER `B_1_8`,
ADD COLUMN `B_1_10` VARCHAR(5) NULL DEFAULT NULL AFTER `B_1_9`,
ADD COLUMN `B_2_1` VARCHAR(5) NULL DEFAULT NULL AFTER `B_1_10`,
ADD COLUMN `B_2_2` VARCHAR(5) NULL DEFAULT NULL AFTER `B_2_1`,
ADD COLUMN `B_2_3` VARCHAR(5) NULL DEFAULT NULL AFTER `B_2_2`,
ADD COLUMN `B_2_4` VARCHAR(5) NULL DEFAULT NULL AFTER `B_2_3`;


UPDATE CMRC_DB_kaonthu_work.doctor_chen_20220530 as a
INNER JOIN 
(SELECT sid,hf_none,hf_vit,hf_wgl,hf_foil,hf_ca,hf_p,hf_chic,hf_clam,hf_e,hf_fmed,
d2_drink,d2_drinkt,d2_drinkav,d2_drinkday,
drink_k1,drink_k2,drink_k3,drink_k4,drink_k5,drink_k6,drink_k7,
B_1_1,B_1_2,B_1_3,B_1_4,B_1_5,B_1_6,B_1_7,B_1_8,B_1_9,B_1_10,B_2_1,B_2_2,B_2_3,B_2_4
FROM CMRC_DB_2022_import_work.new_CMRC_db_20963_20220310 ) as b
ON a.s_number = b.sid
SET 
a.B_1_2 = b.B_1_2,
a.B_1_3 = b.B_1_3,
a.B_1_4 = b.B_1_4,
a.B_1_5 = b.B_1_5,
a.B_1_6 = b.B_1_6,
a.B_1_7 = b.B_1_7,
a.B_1_8 = b.B_1_8,
a.B_1_9 = b.B_1_9,
a.B_1_10 = b.B_1_10,
a.B_2_1 = b.B_2_1,
a.B_2_2 = b.B_2_2,
a.B_2_3 = b.B_2_3,
a.B_2_4 = b.B_2_4;

SELECT * FROM CMRC_DB_kaonthu_work.doctor_chen_20220530;

UPDATE CMRC_DB_kaonthu_work.doctor_chen_20220530 as a
SET B_1_2 = NULL 
WHERE B_1_1 is NULL and B_1_3 is NULL and B_1_4 is NULL and B_1_5 is NULL; #將明明其它是NULL 但B_1_2 有值的刪除