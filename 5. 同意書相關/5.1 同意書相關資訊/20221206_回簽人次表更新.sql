SELECT * FROM NTCMRC.CMRC_all_persontimes
WHERE data_exam < 20180302
GROUP BY p_id; #共有6162人需要回簽

UPDATE NTCMRC.CMRC_all_persontimes
SET need_back = 1 ; #假設每個人都不用回簽

UPDATE NTCMRC.CMRC_all_persontimes as a
INNER JOIN (SELECT * FROM NTCMRC.CMRC_all_persontimes
WHERE data_exam < 20180302
GROUP BY p_id) as b
ON a.p_id = b.p_id
SET a.need_back = 0; #修正在20180302前參加的都要回簽

SELECT * FROM NTCMRC.CMRC_all_persontimes
WHERE need_back = 0
GROUP BY p_id; #0是尚未回簽/要回簽的 共6175人

UPDATE NTCMRC.CMRC_all_persontimes as a
INNER JOIN (SELECT * FROM NTCMRC.CMRC_Consent_DB_kaonthu
WHERE type_kao regexp '回'
GROUP by p_id) as b
ON a.p_id = b.p_id
SET a.need_back = 1; #更新同意書已經簽過回簽同意書的人

SELECT * FROM NTCMRC.CMRC_all_persontimes
WHERE need_back = 0
GROUP BY p_id; #0 剩下要回簽的人還有1957人

SELECT * FROM NTCMRC.CMRC_all_persontimes_desc
WHERE need_back = 0
GROUP BY p_id; #0 剩下要回簽的人還有1957人


#######################################################

SELECT * FROM NTCMRC.CMRC_Consent_DB_kaonthu
WHERE type_kao regexp '回'
GROUP by p_id; #表格1 #4411 

SELECT * FROM NTCMRC.CMRC_Consent_DB_kaonthu
WHERE type_kao regexp '回'
AND yes_kao = 1
GROUP by p_id; #表格2 #4276

SELECT * FROM NTCMRC.CMRC_Consent_DB_kaonthu
WHERE type_kao regexp '回'
or (type_kao regexp '新' AND ver_kao regexp '8')
GROUP by p_id; #表格3 #5064

SELECT * FROM NTCMRC.CMRC_Consent_DB_kaonthu
WHERE type_kao regexp '回'
or (type_kao regexp '新' AND ver_kao regexp '8' AND yes_kao = 1)
GROUP by p_id; #表格4 #5058

SELECT * FROM NTCMRC.CMRC_Consent_DB_kaonthu
WHERE (type_kao regexp '回' AND yes_kao = 1)
or (type_kao regexp '新' AND ver_kao regexp '8')
GROUP by p_id; #表格5 #4979

SELECT * FROM NTCMRC.CMRC_Consent_DB_kaonthu
WHERE (type_kao regexp '回' AND yes_kao = 1)
or (type_kao regexp '新' AND ver_kao regexp '8' AND yes_kao = 1)
GROUP by p_id; #表格6 #4973