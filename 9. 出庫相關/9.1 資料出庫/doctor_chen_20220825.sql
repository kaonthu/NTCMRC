ALTER TABLE `CMRC_DB_2022_import_work`.`CMRC_all_persontimes_20220110_kaonthu_20220310` 
ADD COLUMN `SNP_LIN` INT(2) NULL AFTER `sup`;

ALTER TABLE `CMRC_DB_2022_import_work`.`CMRC_all_persontimes_20220110_kaonthu_20220310` 
ADD COLUMN `GWAS_alco` INT(2) NULL AFTER `SNP_LIN`,
ADD COLUMN `GWAS_YE` INT(2) NULL AFTER `GWAS_alco`;

UPDATE CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310 as a
SET a.SNP_LIN = 0;

UPDATE CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310 as a
SET a.GWAS_alco = 0,a.GWAS_YE = 0;

UPDATE CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310 as a
INNER JOIN 
kao_practice_3.new_CMRC_db_7636_desc_20210906 as b
ON a.p_id = b.p_id 
SET a.SNP_LIN = b.SNP_LIN;

UPDATE CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310 as a
INNER JOIN 
kao_practice_3.new_CMRC_db_7636_desc_20210906 as b
ON a.p_id = b.p_id 
SET a.GWAS_alco = b.GWAS_alco,a.GWAS_YE = b.GWAS_YE;

UPDATE CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310 as a
SET a.SNP_LIN = 1
WHERE CMRC_ID IN ("Y22014E01004J9014","E52015P00801X1034");

SELECT * FROM 
CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310
WHERE SNP_LIN = 1
GROUP BY p_id;

SELECT * FROM 
CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310
WHERE GWAS_alco = 1
GROUP BY p_id;

UPDATE CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310 as a
SET a.GWAS_YE = 1
WHERE CMRC_ID IN ("T42016F91001P9025");

SELECT * FROM 
CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310
WHERE GWAS_YE = 1
GROUP BY p_id;


CREATE table CMRC_DB_kaonthu_work.doctor_chen_20220825 as
SELECT a.*,b.SNP_LIN,b.GWAS_alco,b.GWAS_YE 
FROM
CMRC_DB_2022_import_work.new_CMRC_db_testing_question_scalebigtable_20220625 as a
INNER JOIN CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310 as b
ON a.p_id = b.p_id
WHERE b.SNP_LIN = 1 or b.GWAS_alco = 1 or b.GWAS_YE = 1
GROUP BY p_id,data_year
ORDER BY CMRC_id,data_year desc;

SELECT p_id,data_year,year_come
FROM CMRC_DB_kaonthu_work.doctor_chen_20220825
GROUP BY p_id,data_year
