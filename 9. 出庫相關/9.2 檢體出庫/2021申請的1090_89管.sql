SELECT * FROM kao_practice_4.dr_yeh_20210623_kaonthu;

SELECT * FROM CMRC_DB.dr_yeh_20210611;


SELECT a.*,b.CMRC_ID 
FROM CMRC_DB.CMRC_DNA_Release_DB as a
INNER JOIN  CMRC_DB.CMRC_DNA_DB as b
ON a.C_number = b.C_number 
WHERE out_time = "2021-06-23";


CREATE TABLE kao_practice_4.dr_yeh_20210623_kaonthu 
(
  `CMRC_id` varchar(20) DEFAULT NULL,
  `date` double DEFAULT NULL,
   `sup` int(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


ALTER TABLE `kao_practice_4`.`dr_yeh_20210623_kaonthu` 
ADD COLUMN `out` INT(1) NULL AFTER `sup`;

ALTER TABLE `kao_practice_4`.`dr_yeh_20210623_kaonthu` 
ADD COLUMN `p_id` VARCHAR(20) NULL AFTER `out`;

UPDATE `kao_practice_4`.`dr_yeh_20210623_kaonthu` as c
INNER JOIN
(SELECT a.*,b.CMRC_ID 
FROM CMRC_DB.CMRC_DNA_Release_DB as a
INNER JOIN CMRC_DNA_DB as b
ON a.C_number = b.C_number 
WHERE out_time = "2021-06-23") as d
ON c.CMRC_ID = d.CMRC_ID
SET c.`out` = 1
; #標記最後中瑜出的50 管

UPDATE `kao_practice_4`.`dr_yeh_20210623_kaonthu` as c
INNER JOIN
(SELECT CMRC_ID,p_id 
FROM CMRC_DB.CMRC_DNA_DB ) as d
ON c.CMRC_ID = d.CMRC_ID
SET c.p_id = d.p_id
; #標記最後中瑜出的50 管

UPDATE `kao_practice_4`.`dr_yeh_20210623_kaonthu` as c
INNER JOIN
(SELECT CMRC_ID,p_id 
FROM CMRC_DB.new_CMRC_db ) as d
ON c.CMRC_ID = d.CMRC_ID
SET c.p_id = d.p_id
; 

SELECT * 
FROM (
SELECT t1.sid,t1.p_id,t1.cmrc_id,t1.date_exam,t1.P_number,t1.C_number,t1.Box,t1.Site,t1.Specimen,
t1.stock_after_bk,t1.stock_remain_ng,
t1.consent,t1.dna_consent,t1.reconsent,t1.out_names,
    t3.CMRC_id as TT,t3.out
	FROM CMRC_DB.CMRC_DNA_Stock_DB AS t1  #預約後的量再加上 陳志根林哲名魏怡嘉預約的量
    INNER JOIN (SELECT p_id, MAX(stock_after_bk) AS stock_after_bk
	FROM CMRC_DB.CMRC_DNA_Stock_DB
    	WHERE DNA_consent REGEXP '^\\(DNA\\)$'
		AND reconsent REGEXP '\\(回\\)$' 
	GROUP BY p_id) AS t2
	ON t1.p_id = t2.p_id
    	AND t1.stock_after_bk = t2.stock_after_bk #第二步去對應CMRC_DNA_Stock_DB 裡面
    RIGHT JOIN `kao_practice_4`.`dr_yeh_20210623_kaonthu` AS t3
	ON t1.p_id = t3.p_id ) as F 
    GROUP BY TT; #將申請的1090 管去看他的同意書、庫存等問題
    
    
SELECT *
FROM CMRC_DNA_Stock_DB
    WHERE CMRC_ID IN ("Z92014O50315V9067")
