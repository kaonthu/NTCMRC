SELECT * FROM CMRC_DB_kaonthu.CMRC_sample_Database_Consent
WHERE `out` <> 1
AND specimen = 'BC'
AND C_Date >= 20210000 #目前1915管
AND New_CMRC_id not in
(SELECT New_CMRC_id 
FROM CMRC_DB_kaonthu_work.doctor_chen_20220602); #扣除掉陳志根欣茹欲出庫59管剩1856

SELECT * FROM CMRC_DB_kaonthu.CMRC_sample_Database_Consent
WHERE `out` <> 1
AND specimen = 'BC'
AND C_Date >= 20210000 #目前1915管
AND (back_yes regexp '1'
OR new_yes REGEXP '1') ;

SELECT * FROM CMRC_DB_kaonthu.CMRC_sample_Database_Consent
WHERE `out` <> 1
AND specimen = 'BC'
AND C_Date >= 20210000 #目前1915管
AND (back_yes is NULL or back_yes not regexp '1')
AND (new_yes is NULL or new_yes not regexp '1') ; #有一個勾選剩檢不同意

######################################################################

SELECT * FROM CMRC_DB_kaonthu.CMRC_sample_Database_Consent
WHERE `out` <> 1
AND specimen = 'BC'
AND C_Date >= 20210000 #目前1915管
AND New_CMRC_id not in
(SELECT New_CMRC_id 
FROM CMRC_DB_kaonthu_work.doctor_chen_20220602); #扣除掉陳志根欣茹欲出庫59管剩1856管


SELECT * FROM CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310
WHERE `year` = 1
AND data_exam >= 20220000
AND P_dn not regexp '^M' ; #2022第一次來的 136人

SELECT * FROM CMRC_DB_kaonthu.CMRC_sample_Database_Consent
WHERE `out` <> 1
AND specimen = 'BC'
AND C_Date >= 20210000 #目前1915管
AND New_CMRC_id not in
(SELECT New_CMRC_id 
FROM CMRC_DB_kaonthu_work.doctor_chen_20220602)
AND New_CMRC_id in (
SELECT New_CMRC_id
FROM CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310
WHERE `year` = 1
AND data_exam >= 20220000
AND P_dn not regexp '^M'); 
#扣除掉陳志根欣茹欲出庫59管剩1856管 裡面2022年 第一次參加的 皆不在欣茹出庫名單 因此還有136

SELECT a.CMRC_ID,a.New_CMRC_id,a.C_Date,a.C_number,
a.P_number,a.Fridge,a.Box,a.Site,a.Specimen
FROM CMRC_DB_kaonthu.CMRC_sample_Database_Consent as a
WHERE `out` <> 1
AND specimen = 'BC'
AND C_Date >= 20210000 #目前1915管
AND New_CMRC_id not in
(SELECT New_CMRC_id 
FROM CMRC_DB_kaonthu_work.doctor_chen_20220602)
AND New_CMRC_id in (
SELECT New_CMRC_id
FROM CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310
WHERE `year` = 1
AND data_exam >= 20220000
AND P_dn not regexp '^M'); 
#扣除掉陳志根欣茹欲出庫59管剩1856管 裡面2022年 第一次參加的 皆不在欣茹出庫名單 因此還有136

###################################################################

CREATE TABLE CMRC_DB_kaonthu_work.doctor_joe_20220706_outwork_1720
SELECT * FROM CMRC_DB_kaonthu.CMRC_sample_Database_Consent
WHERE `out` <> 1
AND specimen = 'BC'
AND C_Date >= 20210000 #目前1915管
AND New_CMRC_id not in
(SELECT New_CMRC_id 
FROM CMRC_DB_kaonthu_work.doctor_chen_20220602)
AND New_CMRC_id not in (
SELECT New_CMRC_id
FROM CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310
WHERE `year` = 1
AND data_exam >= 20220000
AND P_dn not regexp '^M'); 
#扣除掉陳志根欣茹欲出庫59管剩1856管 裡面2022年 第一次參加的 皆不在欣茹出庫名單 因此還有136

SELECT a.CMRC_ID,a.New_CMRC_id,a.C_Date,a.C_number,
a.P_number,a.Fridge,a.Box,a.Site,a.Specimen,
b.stock_ng
FROM CMRC_DB_kaonthu_work.doctor_joe_20220706_outwork_1720 as a #1720是剩下的BC 去對DNA 庫存量 
LEFT JOIN 
(SELECT New_CMRC_id,sum(stock_after_bk) as stock_ng
FROM
CMRC_DB_kaonthu.CMRC_DNA_DB_kaonthu_back_DNA_New_consent_New_CMRC_id
GROUP BY New_CMRC_id) as b #目前DNA人的庫存總量 
ON a.New_CMRC_id = b.New_CMRC_id
ORDER BY stock_ng 
;

SELECT * 
FROM CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310_desc_last
WHERE New_CMRC_id IN (SELECT a.New_CMRC_id
FROM CMRC_DB_kaonthu_work.doctor_joe_20220706_outwork_1720 as a #1720是剩下的BC 去對DNA 庫存量 
LEFT JOIN 
(SELECT New_CMRC_id,sum(stock_after_bk) as stock_ng
FROM
CMRC_DB_kaonthu.CMRC_DNA_DB_kaonthu_back_DNA_New_consent_New_CMRC_id
GROUP BY New_CMRC_id) as b #目前DNA人的庫存總量 
ON a.New_CMRC_id = b.New_CMRC_id
WHERE stock_ng is NULL)
;



