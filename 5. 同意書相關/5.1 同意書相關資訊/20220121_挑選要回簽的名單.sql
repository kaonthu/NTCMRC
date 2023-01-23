
CREATE TABLE `20220121_挑選要回簽的名單`as 
SELECT * FROM CMRC_DB_kaonthu.CMRC_all_persontimes_last_kaonthu_back_new_DNA_TMPI_生資
;

ALTER TABLE `CMRC_DB_kaonthu`.`20220121_挑選要回簽的名單` 
ADD COLUMN `condintion1` INT(6) NULL AFTER `sup`,
ADD COLUMN `condintion2` INT(6) NULL AFTER `condintion1`,
ADD COLUMN `condintion3` INT(6) NULL AFTER `condintion2`,
ADD COLUMN `condintion4` INT(6) NULL AFTER `condintion3`,
ADD COLUMN `condintion5` INT(6) NULL AFTER `condintion4`,
ADD COLUMN `Total` INT(6) NULL AFTER `condintion5`;

UPDATE `CMRC_DB_kaonthu`.`20220121_挑選要回簽的名單` as a
SET condintion1 = 0,condintion2 = 0,condintion3 = 0,condintion4 = 0,condintion5=0;

#################################################

UPDATE `CMRC_DB_kaonthu`.`20220121_挑選要回簽的名單` 
set condintion1 = 1 
WHERE new_ver regexp '8.1' ; #1734人

/* UPDATE `CMRC_DB_kaonthu`.`20220121_挑選要回簽的名單` 
set condintion1 = 1 
WHERE new_ver regexp '8.1' AND new_yes regexp '_1|1' ; */ #1728人

SELECT condintion1,new_note,new_date,new_ver,new_type,new_yes 
FROM CMRC_DB_kaonthu.`20220121_挑選要回簽的名單`
WHERE condintion1 = 1;

SELECT condintion1,new_note,new_date,new_ver,new_type,new_yes 
FROM CMRC_DB_kaonthu.`20220121_挑選要回簽的名單`
WHERE new_ver regexp '8.1' AND new_yes not regexp '_1|1' = 1; #6個有問題的

#################################################

UPDATE `CMRC_DB_kaonthu`.`20220121_挑選要回簽的名單` 
set condintion2 = 1 
WHERE back_ver regexp '7.2' ; #198人

/* UPDATE `CMRC_DB_kaonthu`.`20220121_挑選要回簽的名單` 
set condintion2 = 1 
WHERE back_ver regexp '7.2' AND back_yes regexp '_1|1' ; */ #195人

SELECT condintion2,back_note,back_date,back_ver,back_type,back_yes 
FROM CMRC_DB_kaonthu.`20220121_挑選要回簽的名單`
WHERE condintion2 = 1;

SELECT condintion2,back_note,back_date,back_ver,back_type,back_yes 
FROM CMRC_DB_kaonthu.`20220121_挑選要回簽的名單`
WHERE back_ver regexp '7.2' AND back_yes not regexp '_1|1' = 1; #3個有問題的

###############################################

UPDATE `CMRC_DB_kaonthu`.`20220121_挑選要回簽的名單` as a
INNER JOIN (SELECT distinct(p_id) 
FROM CMRC_DB_kaonthu.CMRC_all_persontimes_20220110_kaonthu
WHERE data_exam < 20180302) as b
ON a.p_id = b.p_id
set condintion3 = 1 ; #6175人

###################################################

UPDATE `CMRC_DB_kaonthu`.`20220121_挑選要回簽的名單` 
set condintion4 = 1
WHERE back_ver is not NULL  ; #4279人

###################################################

UPDATE `CMRC_DB_kaonthu`.`20220121_挑選要回簽的名單` 
set condintion4 = 1
WHERE DNA_ver is not NULL  ; #1328 有簽過DNA 

SELECT * 
FROM `CMRC_DB_kaonthu`.`20220121_挑選要回簽的名單` 
WHERE DNA_yes not regexp '1' ; #很多人簽DNA 同意書是有問題的 


SELECT * FROM 
CMRC_DB_kaonthu_work.`20220121_挑選要回簽的名單`
WHERE new_type regexp '新';

SELECT * FROM CMRC_all_persontimes_20220110_kaonthu
WHERE need_back = 1
GROUP BY p_id;

SELECT * FROM CMRC_all_persontimes_20220110_kaonthu
WHERE need_back = 0
GROUP BY p_id; #0是尚未回簽/要回簽的 2096人
