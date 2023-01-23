CREATE TEMPORARY TABLE doctor_ye_20220127_outwork_1269 AS 
SELECT 
a.NO,a.CMRC_ID,a.C_Date,a.C_number,a.P_number,a.Fridge,a.Box,a.Site
FROM CMRC_DB_kaonthu_work.doctor_ye_20220127_outwork_763 AS a
WHERE a.CMRC_ID NOT IN ("G42016Z20130N4073","U52014G30608H3041","M12013C70915H6018","W42015O20801R0042","E82018Y50825V9101")
UNION ALL
SELECT 
b.NO,b.CMRC_ID,b.C_Date,b.C_number,b.P_number,b.Fridge,b.Box,b.Site
FROM CMRC_DB_kaonthu_work.doctor_ye_20220127_outwork_763 AS a
INNER JOIN CMRC_DB_kaonthu_work.doctor_ye_20220127_outwork_10141 AS b
ON a.CMRC_ID = b.CMRC_ID
WHERE DATEDIFF(b.C_Date,a.C_Date) >= 720 AND b.QC != 1 AND
b.CMRC_ID NOT IN ("G42016Z20130N4073","H82013H50915C8016","M12013C70915H6018","U52014G30608H3041","W42015O20801R0042")
GROUP BY a.CMRC_id;
# -5 -5 = 1269 

SELECT * FROM doctor_ye_20220127_outwork_1269;

SELECT a.No,a.CMRC_ID,a.C_Date,a.C_number,a.P_number,a.Fridge,a.Box,a.Site,a.Specimen
FROM CMRC_DB_kaonthu_work.doctor_ye_20220127_outwork_10141 AS a
WHERE C_number IN (SELECT C_number FROM doctor_ye_20220127_outwork_1269)
ORDER BY a.Fridge+0,a.Box,a.Site+0;

SELECT *
FROM CMRC_DB_kaonthu.CMRC_sample_Database_Consent AS a
WHERE C_number IN (SELECT C_number FROM doctor_ye_20220127_outwork_1269);

DROP TEMPORARY TABLE CMRC_DB_kaonthu_work.doctor_ye_20220127_outwork_1269_records;


CREATE TEMPORARY TABLE CMRC_DB_kaonthu_work.doctor_ye_20220127_outwork_1269_records AS
SELECT C_number,'1' AS `out`,'2022-04-07' AS `out_time`,out_name,NOW() AS entry_time
FROM CMRC_DB_kaonthu.CMRC_sample_Database_Consent AS a
WHERE C_number IN (SELECT C_number FROM doctor_ye_20220127_outwork_1269);


ALTER TABLE CMRC_DB_kaonthu_work.doctor_ye_20220127_outwork_1269_records 
ADD PRIMARY KEY (`C_number`);
#確定 C_number 唯一 1269筆

ALTER TABLE CMRC_DB_kaonthu_work.doctor_ye_20220127_outwork_1269_records  
CHANGE COLUMN `out_name` `out_name` VARCHAR(45) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL ;

UPDATE CMRC_DB_kaonthu_work.doctor_ye_20220127_outwork_1269_records  
SET `out_name` = "葉集孝";

INSERT INTO CMRC_DB_kaonthu_work.doctor_ye_20220127_outwork_1269_records
(C_number,out_name)
VALUES
("C0342202","葉集孝"),
("C0342872","葉集孝"),
("C0343152","葉集孝"),
("C0343972","葉集孝"),
("C0421828","葉集孝"),
("C0421998","葉集孝"),
("C0422128","葉集孝"),
("C0422134","葉集孝"),
("C0422453","葉集孝"),
("C0423463","葉集孝"),
("C0422133","CMRC"); #新出的11管

UPDATE CMRC_DB_kaonthu_work.doctor_ye_20220127_outwork_1269_records
SET out_name = "CMRC"
WHERE C_number IN 
("C0342201",
"C0342871",
"C0343151",
"C0343971",
"C0421827",
"C0421997",
"C0422127",
"C0422132",
"C0422452",
"C0423462",
"C0191421");

UPDATE CMRC_DB_kaonthu_work.doctor_ye_20220127_outwork_1269_records
SET `out` = 1,`out_time` = '2022-05-03',`entry_time` = NOW(); 

SELECT * FROM CMRC_DB_kaonthu_work.doctor_ye_20220127_outwork_1269_records;

INSERT INTO CMRC_DB_kaonthu.CMRC_Sample_status
(`C_number`, `out`, `out_time`, `out_name`, `entry_time`)
SELECT * FROM CMRC_DB_kaonthu_work.doctor_ye_20220127_outwork_1269_records;

SELECT * FROM CMRC_DB_kaonthu.CMRC_sample_Database_Consent
WHERE C_number IN 
("C0342201",
"C0342871",
"C0343151",
"C0343971",
"C0421827",
"C0421997",
"C0422127",
"C0422132","C0422133",
"C0422452",
"C0423462");

SELECT a.CMRC_ID,a.C_Date,a.C_number,a.P_number,a.Fridge,a.Box,a.Site,a.Specimen 
FROM CMRC_DB_kaonthu.CMRC_sample_Database_Consent as a
WHERE box IN  ("1621");

SELECT a.CMRC_ID,a.C_Date,a.C_number,a.P_number,a.Fridge,a.Box,a.Site,a.Specimen 
FROM CMRC_DB_kaonthu.CMRC_sample_Database_Consent as a
WHERE box IN  ("1664","1694");

SELECT a.CMRC_ID,a.C_Date,a.C_number,a.P_number,a.Fridge,a.Box,a.Site,a.Specimen 
FROM CMRC_DB_kaonthu.CMRC_sample_Database_Consent as a
WHERE box IN  ("1688","1695");

SELECT a.CMRC_ID,a.C_Date,a.C_number,a.P_number,a.Fridge,a.Box,a.Site,a.Specimen 
FROM CMRC_DB_kaonthu.CMRC_sample_Database_Consent as a
WHERE box >= 1664 and box <=1720;

############################################################



