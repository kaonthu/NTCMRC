/* SELECT * FROM CMRC_DB_kaonthu.doctor_ye_20220127
WHERE plasma_record = 0 ; #1120沒申請過 */

SELECT a.*,b.*
FROM CMRC_DB_kaonthu.doctor_ye_20220127 as a
INNER JOIN CMRC_DB_kaonthu.`CMRC_all_persontimes_last_kaonthu_back_new_DNA_TMPI_生資` as b
ON a.p_id = b.p_id
WHERE back_yes regexp '1'
OR new_yes REGEXP '1';

SELECT a.*,b.back_yes,b.new_yes
FROM CMRC_DB_kaonthu.doctor_ye_20220127 as a
INNER JOIN CMRC_DB_kaonthu.`CMRC_all_persontimes_last_kaonthu_back_new_DNA_TMPI_生資` as b
ON a.p_id = b.p_id
WHERE back_yes regexp '1'
OR new_yes REGEXP '1'; #符合同意書規範 有933個

##########################################

SELECT b.No,a.*
FROM 
(SELECT * FROM CMRC_DB_kaonthu.CMRC_sample_Database_Consent
WHERE qc <> 1
AND cmrc_reserved <> 1
AND `out` <> 1
AND specimen = 'p'
AND (back_yes regexp '1'
OR new_yes REGEXP '1') ) as a
INNER JOIN 
(SELECT * 
FROM CMRC_DB_kaonthu.doctor_ye_20220127) 
as b
ON a.CMRC_ID = b.CMRC_number
GROUP BY b.CMRC_number
ORDER BY b.No; #庫存  有933個能正常出庫非最後一管

SELECT b.No,a.*
FROM 
(SELECT * FROM CMRC_DB_kaonthu.CMRC_sample_Database_Consent
WHERE qc <> 1
AND cmrc_reserved <> 1
AND `out` <> 1
AND specimen = 'p' ) as a
INNER JOIN 
(SELECT * 
FROM CMRC_DB_kaonthu.doctor_ye_20220127
WHERE plasma_record = 0) 
as b
ON a.CMRC_ID = b.CMRC_number
GROUP BY b.CMRC_number
ORDER BY b.No; #庫存  1120管 

SELECT b.No,a.*
FROM 
(SELECT * FROM CMRC_DB_kaonthu.CMRC_sample_Database_Consent
WHERE qc <> 1
AND cmrc_reserved <> 1
AND `out` <> 1
AND specimen = 'p' 
AND back_yes regexp '1'
AND new_yes REGEXP '1') as a
INNER JOIN 
(SELECT * 
FROM CMRC_DB_kaonthu.doctor_ye_20220127
WHERE plasma_record = 0) 
as b
ON a.CMRC_ID = b.CMRC_number
GROUP BY b.CMRC_number
ORDER BY b.No; #庫存 且有同意書 561管 

#######################################################

CREATE TEMPORARY TABLE test as
SELECT * FROM CMRC_DB_kaonthu.CMRC_sample_Database_Consent
WHERE specimen = "P" AND `out` = 1 AND out_name IN ("賴旗俊","葉集孝");

UPDATE `CMRC_DB_kaonthu`.`doctor_ye_20220127`
SET plasma_1649 = 0;

SELECT a.*,b.p_id 
FROM test as a
INNER JOIN kao_practice_3.CMRC_all_persontimes_desc_last_kaonthu as b
ON a.CMRC_id = b.CMRC_ID;

UPDATE `CMRC_DB_kaonthu`.`doctor_ye_20220127`  as a
INNER JOIN (SELECT a.*,b.p_id 
FROM test as a
INNER JOIN kao_practice_3.CMRC_all_persontimes_desc_last_kaonthu as b
ON a.CMRC_id = b.CMRC_ID) as b
ON a.p_id = b.p_ID
Set a.plasma_1649 = 1;

###########################################################


SELECT b.No,a.*
FROM 
(SELECT * FROM CMRC_DB_kaonthu.CMRC_sample_Database_Consent
WHERE qc <> 1
AND cmrc_reserved <> 1
AND `out` <> 1
AND specimen = 'p' ) as a
INNER JOIN 
(SELECT * 
FROM CMRC_DB_kaonthu.doctor_ye_20220127
WHERE plasma_1649 = 0) 
as b
ON a.CMRC_ID = b.CMRC_number
GROUP BY b.CMRC_number
ORDER BY b.No; #庫存  扣除掉已出庫過的 還有1073非最後一管能出庫 

SELECT b.No,a.*
FROM 
(SELECT * FROM CMRC_DB_kaonthu.CMRC_sample_Database_Consent
WHERE qc <> 1
AND cmrc_reserved <> 1
AND `out` <> 1
AND specimen = 'p' 
AND (back_yes regexp '1'
OR new_yes REGEXP '1')) as a
INNER JOIN 
(SELECT * 
FROM CMRC_DB_kaonthu.doctor_ye_20220127
WHERE plasma_1649 = 0) 
as b
ON a.CMRC_ID = b.CMRC_number
GROUP BY b.CMRC_number
ORDER BY b.No; #庫存 且有同意書 763管 

###########################################################



SELECT T2.No,T1.*
FROM CMRC_DB_kaonthu.doctor_ye_20220127 as T1
LEFT JOIN (
SELECT b.No,a.*
FROM 
(SELECT * FROM CMRC_DB_kaonthu.CMRC_sample_Database_Consent
WHERE qc <> 1
AND cmrc_reserved <> 1
AND `out` <> 1
AND specimen = 'p'
AND (back_yes regexp '1'
OR new_yes REGEXP '1') ) as a
INNER JOIN 
(SELECT * 
FROM CMRC_DB_kaonthu.doctor_ye_20220127) 
as b
ON a.CMRC_ID = b.CMRC_number
GROUP BY b.CMRC_number
ORDER BY b.No) as T2
ON T1.CMRC_number = T2.CMRC_ID; #庫存  扣除掉已出庫過的 還有1073非最後一管能出庫 
#沒有同意書 

CREATE TABLE CMRC_DB_kaonthu_work.doctor_ye_20220127_outwork_763
SELECT b.No,a.*
FROM 
(SELECT * FROM CMRC_DB_kaonthu.CMRC_sample_Database_Consent
WHERE qc <> 1
AND cmrc_reserved <> 1
AND `out` <> 1
AND specimen = 'p' 
AND (back_yes regexp '1'
OR new_yes REGEXP '1')) as a
INNER JOIN 
(SELECT * 
FROM CMRC_DB_kaonthu.doctor_ye_20220127
WHERE plasma_1649 = 0) 
as b
ON a.CMRC_ID = b.CMRC_number
GROUP BY b.CMRC_number
ORDER BY b.No; #庫存 且有同意書 763管 

SELECT a.No,a.CMRC_ID,a.C_Date,a.C_number,a.P_number,a.Fridge,a.Box,a.Site,a.Specimen
FROM CMRC_DB_kaonthu_work.doctor_ye_20220127_outwork as a
ORDER BY a.Fridge+0,a.Box,a.Site+0;

############################################################################################################
############################################################################################################

CREATE TABLE CMRC_DB_kaonthu_work.doctor_ye_20220127_outwork_10141
SELECT b.No,a.*
FROM 
(SELECT * FROM CMRC_DB_kaonthu.CMRC_sample_Database_Consent
WHERE cmrc_reserved <> 1
AND `out` <> 1
AND specimen = 'p' 
AND (back_yes regexp '1'
OR new_yes REGEXP '1')) as a
INNER JOIN 
(SELECT * 
FROM CMRC_DB_kaonthu.doctor_ye_20220127
WHERE plasma_1649 = 0) 
as b
ON a.CMRC_ID = b.CMRC_number
ORDER BY b.No; #庫存 且有同意書 10141管 

################################################################
SELECT 
DATEDIFF(b.C_Date,a.C_Date) as dif,
b.P_number as P_number_10141,
b.C_number as C_number_10141,
b.C_Date as C_Date_10141,
b.In_time as In_time_10141,
b.QC as QC_10141,
a.*
FROM CMRC_DB_kaonthu_work.doctor_ye_20220127_outwork_763 as a
INNER JOIN CMRC_DB_kaonthu_work.doctor_ye_20220127_outwork_10141 as b
ON a.CMRC_ID = b.CMRC_ID
WHERE a.C_number != b.C_number
GROUP BY a.CMRC_id; #每個人都有第二管

SELECT 
DATEDIFF(b.C_Date,a.C_Date) as dif,
b.P_number as P_number_10141,
b.C_number as C_number_10141,
b.C_Date as C_Date_10141,
b.In_time as In_time_10141,
b.QC as QC_10141,
a.*
FROM CMRC_DB_kaonthu_work.doctor_ye_20220127_outwork_763 as a
INNER JOIN CMRC_DB_kaonthu_work.doctor_ye_20220127_outwork_10141 as b
ON a.CMRC_ID = b.CMRC_ID
WHERE DATEDIFF(b.C_Date,a.C_Date) >= 360 
AND b.QC <> 1 
GROUP BY a.CMRC_id;
#間隔1年 360天 以上 595 管 不管有沒有算最後一管都是 595管

SELECT 
DATEDIFF(b.C_Date,a.C_Date) as dif,
b.P_number as P_number_10141,
b.C_number as C_number_10141,
b.C_Date as C_Date_10141,
b.In_time as In_time_10141,
b.QC as QC_10141,
b.CMRC_ID,
a.*
FROM CMRC_DB_kaonthu_work.doctor_ye_20220127_outwork_763 as a
INNER JOIN CMRC_DB_kaonthu_work.doctor_ye_20220127_outwork_10141 as b
ON a.CMRC_ID = b.CMRC_ID
WHERE DATEDIFF(b.C_Date,a.C_Date) >= 720 
GROUP BY a.CMRC_id;
#間隔2年 720天 以上 516 管 不管有沒有算最後一管都是 516管


SELECT DATEDIFF("2019-04-01","2019-04-30");

SELECT 
b.NO,b.CMRC_ID,b.C_Date,b.C_number,b.P_number,b.Fridge,b.Box,b.Site
FROM CMRC_DB_kaonthu_work.doctor_ye_20220127_outwork_763 as a
INNER JOIN CMRC_DB_kaonthu_work.doctor_ye_20220127_outwork_10141 as b
ON a.CMRC_ID = b.CMRC_ID
WHERE DATEDIFF(b.C_Date,a.C_Date) >= 720 
GROUP BY a.CMRC_id;
#間隔2年 720天 以上 516 管 不管有沒有算最後一管都是 516管

########################################################

DROP TEMPORARY TABLE doctor_ye_20220127_outwork_1269 ;
# 763 + 516 = 1279

CREATE TEMPORARY TABLE doctor_ye_20220127_outwork_1269 as 
SELECT 
a.NO,a.CMRC_ID,a.C_Date,a.C_number,a.P_number,a.Fridge,a.Box,a.Site
FROM CMRC_DB_kaonthu_work.doctor_ye_20220127_outwork_763 as a
WHERE a.CMRC_ID not IN ("G42016Z20130N4073","U52014G30608H3041","M12013C70915H6018","W42015O20801R0042","E82018Y50825V9101")
UNION ALL
SELECT 
b.NO,b.CMRC_ID,b.C_Date,b.C_number,b.P_number,b.Fridge,b.Box,b.Site
FROM CMRC_DB_kaonthu_work.doctor_ye_20220127_outwork_763 as a
INNER JOIN CMRC_DB_kaonthu_work.doctor_ye_20220127_outwork_10141 as b
ON a.CMRC_ID = b.CMRC_ID
WHERE DATEDIFF(b.C_Date,a.C_Date) >= 720 AND b.QC != 1 AND
b.CMRC_ID not IN ("G42016Z20130N4073","H82013H50915C8016","M12013C70915H6018","U52014G30608H3041","W42015O20801R0042")
GROUP BY a.CMRC_id;
# -5 -5 = 1269 

SELECT * FROM doctor_ye_20220127_outwork_1269;

SELECT a.No,a.CMRC_ID,a.C_Date,a.C_number,a.P_number,a.Fridge,a.Box,a.Site,a.Specimen
FROM CMRC_DB_kaonthu_work.doctor_ye_20220127_outwork_10141 as a
WHERE C_number IN (SELECT C_number FROM doctor_ye_20220127_outwork_1269)
ORDER BY a.Fridge+0,a.Box,a.Site+0;

SELECT *
FROM CMRC_DB_kaonthu.CMRC_sample_Database_Consent as a
WHERE C_number IN (SELECT C_number FROM doctor_ye_20220127_outwork_1269);


/* SELECT *,group_concat(C_Date),count(*) as co
FROM doctor_ye_20220127_outwork_1279
GROUP BY `NO`;


SELECT * FROM (
SELECT *,group_concat(C_Date),count(*) as co
FROM doctor_ye_20220127_outwork_1279
GROUP BY `CMRC_ID`) as a
WHERE co >= 2 ; */

SELECT a.CMRC_ID,a.C_Date,a.C_number,a.P_number,a.Fridge,a.Box,a.Site,a.Specimen 
FROM CMRC_DB_kaonthu.CMRC_sample_Database_Consent as a
WHERE a.box regexp '^751|^775'
ORDER BY a.Fridge+0,a.Box,a.Site+0;


