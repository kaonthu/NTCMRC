SELECT * FROM CMRC_DB_kaonthu.CMRC_sample_Database_Consent
WHERE `out` <> 1
AND specimen = 'BC'
AND C_Date >= 20210000 #20220815 扣除 陳志根 NTCMRC 合送目前剩1829管
AND CMRC_id not in
(SELECT CMRC_id 
FROM CMRC_DB_kaonthu_work.doctor_lin_20220805); 
#扣除掉主任欲申請出庫 302 管剩 1573 管 
#(實際數字為 1829 - 257實際能出給主任的 +2 兩管是舊檢體 -1 同意書有問題)

#DROP temporary TABLE CMRC_DB_kaonthu_work.doctor_joe_20220815_outwork_1573
CREATE temporary TABLE CMRC_DB_kaonthu_work.doctor_joe_20220815_outwork_1573
SELECT * FROM CMRC_DB_kaonthu.CMRC_sample_Database_Consent
WHERE `out` <> 1
AND specimen = 'BC'
AND C_Date >= 20210000 #20220815 扣除 陳志根 NTCMRC 合送目前剩1829管
AND CMRC_id not in
(SELECT CMRC_id 
FROM CMRC_DB_kaonthu_work.doctor_lin_20220805); #扣除掉主任欲申請出庫剩 1573 管

CREATE temporary TABLE CMRC_DB_kaonthu_work.doctor_joe_20220815_outwork_1573_2
SELECT a.CMRC_ID,a.New_CMRC_id,a.C_Date,a.C_number,
a.P_number,a.Fridge,a.Box,a.Site,a.Specimen,
b.stock_ng
FROM CMRC_DB_kaonthu_work.doctor_joe_20220815_outwork_1573 as a #1720是剩下的BC 去對DNA 庫存量 
LEFT JOIN 
(SELECT CMRC_id,New_CMRC_id,sum(stock_after_bk) as stock_ng
FROM
CMRC_DB_kaonthu.CMRC_DNA_DB_kaonthu_back_DNA_New_consent_New_CMRC_id
GROUP BY New_CMRC_id) as b #目前DNA人的庫存總量 
ON a.CMRC_id = b.CMRC_id
ORDER BY stock_ng 
;


CREATE TABLE CMRC_DB_kaonthu_work.doctor_joe_20220815_outwork_1573_final
SELECT a.*,b.`year` 
FROM 
CMRC_DB_kaonthu_work.doctor_joe_20220815_outwork_1573_2 as a 
INNER JOIN CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310_desc_last as b
ON a.CMRC_id = b.CMRC_id
ORDER BY P_Number
;

