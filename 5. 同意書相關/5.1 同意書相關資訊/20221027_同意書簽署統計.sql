UPDATE CMRC_DB_kaonthu.CMRC_Consent_DB_kaonthu as a
SET ver_kao = REPLACE(ver_kao,'Version ', 'Version');


SELECT * FROM CMRC_DB_kaonthu.CMRC_Consent_DB_kaonthu;

SELECT type_kao,ver_kao,count(*) FROM (
SELECT * FROM CMRC_DB_kaonthu.CMRC_Consent_DB_kaonthu
WHERE type_kao regexp '回') as a
GROUP BY ver_kao
;

SELECT type_kao,ver_kao,count(*) FROM (
SELECT * FROM CMRC_DB_kaonthu.CMRC_Consent_DB_kaonthu
WHERE type_kao regexp '回'
GROUP by p_id) as a
GROUP BY ver_kao
;

SELECT type_kao,ver_kao,count(*) FROM (
SELECT * FROM CMRC_DB_kaonthu.CMRC_Consent_DB_kaonthu
WHERE type_kao regexp '回') as a
;

SELECT type_kao,ver_kao,count(*) FROM (
SELECT * FROM CMRC_DB_kaonthu.CMRC_Consent_DB_kaonthu
WHERE type_kao regexp '回'
GROUP by p_id) as a
;



SELECT ver,type_kao,ver_kao,count(*) FROM (
SELECT * FROM CMRC_DB_kaonthu.CMRC_Consent_DB_kaonthu
WHERE type_kao regexp '新') as a
GROUP BY ver_kao
;

SELECT ver,type_kao,ver_kao,count(*) FROM (
SELECT * FROM CMRC_DB_kaonthu.CMRC_Consent_DB_kaonthu
WHERE type_kao regexp '新'
GROUP by p_id) as a
GROUP BY ver_kao
;

SELECT type_kao,ver_kao,count(*) FROM (
SELECT * FROM CMRC_DB_kaonthu.CMRC_Consent_DB_kaonthu
WHERE type_kao regexp '新') as a
;

SELECT type_kao,ver_kao,count(*) FROM (
SELECT * FROM CMRC_DB_kaonthu.CMRC_Consent_DB_kaonthu
WHERE type_kao regexp '新'
GROUP by p_id) as a
;

################################################

SELECT ver,type_kao,ver_kao,count(*) FROM (
SELECT * FROM CMRC_DB_kaonthu.CMRC_Consent_DB_kaonthu
WHERE type_kao regexp 'DNA') as a
GROUP BY ver_kao
;

SELECT ver,type_kao,ver_kao,count(*) FROM (
SELECT * FROM CMRC_DB_kaonthu.CMRC_Consent_DB_kaonthu
WHERE type_kao regexp 'DNA'
GROUP by p_id) as a
GROUP BY ver_kao
;

SELECT type_kao,ver_kao,count(*) FROM (
SELECT * FROM CMRC_DB_kaonthu.CMRC_Consent_DB_kaonthu
WHERE type_kao regexp 'DNA') as a
;

SELECT type_kao,ver_kao,count(*) FROM (
SELECT * FROM CMRC_DB_kaonthu.CMRC_Consent_DB_kaonthu
WHERE type_kao regexp 'DNA'
GROUP by p_id) as a
;


SELECT p_id FROM CMRC_DB_kaonthu.CMRC_Consent_DB_kaonthu
WHERE (type_kao regexp '新'
AND ver_kao regexp '8') 
UNION 
SELECT a.p_id FROM 
(SELECT * FROM CMRC_DB_kaonthu.CMRC_Consent_DB_kaonthu
WHERE type_kao regexp 'DNA') as a
INNER JOIN 
(SELECT * FROM CMRC_DB_kaonthu.backup_CMRC_Consent_DB_kaonthu
WHERE type_kao regexp '回') as b
ON a.p_id = b.p_id
GROUP BY p_id;

################################################

SELECT * FROM CMRC_DB_kaonthu.CMRC_Consent_DB_kaonthu
WHERE yes_kao = 0
AND type_kao regexp '新'
GROUP BY p_id;


SELECT p_id FROM CMRC_DB_kaonthu.CMRC_Consent_DB_kaonthu
WHERE yes_kao = 1
AND type_kao regexp '新'
GROUP BY p_id;

#############################################
SELECT a.*,b.p_id 
FROM (SELECT * FROM CMRC_DB_kaonthu.CMRC_Consent_DB_kaonthu
WHERE yes_kao = 0
AND type_kao regexp '新') as a
LEFT JOIN 
(SELECT p_id FROM CMRC_DB_kaonthu.CMRC_Consent_DB_kaonthu
WHERE yes_kao = 1
AND type_kao regexp '新'
GROUP BY p_id) as b
ON a.p_id = b.p_id
WHERE b.p_id is NULL
GROUP BY a.p_id;


SELECT * FROM CMRC_DB_kaonthu.CMRC_Consent_DB_kaonthu
WHERE type_kao regexp '新'
AND p_id = '4860174'; #以前曾經有問題但是補簽過新版本

SELECT * FROM CMRC_DB_kaonthu.CMRC_Consent_DB_kaonthu
WHERE type_kao regexp '新'
AND p_id = '4354414'; #一直都有問題

#############################################################
SELECT a.*,b.p_id 
FROM (SELECT * FROM CMRC_DB_kaonthu.CMRC_Consent_DB_kaonthu
WHERE yes_kao = 0
AND type_kao regexp '回') as a
LEFT JOIN 
(SELECT p_id FROM CMRC_DB_kaonthu.CMRC_Consent_DB_kaonthu
WHERE yes_kao = 1
AND type_kao regexp '回'
GROUP BY p_id) as b
ON a.p_id = b.p_id
WHERE b.p_id is NULL
GROUP BY a.p_id;
########################################################
SELECT a.*,b.p_id 
FROM (SELECT * FROM CMRC_DB_kaonthu.CMRC_Consent_DB_kaonthu
WHERE yes_kao = 0
AND type_kao regexp 'DNA') as a
LEFT JOIN 
(SELECT p_id FROM CMRC_DB_kaonthu.CMRC_Consent_DB_kaonthu
WHERE yes_kao = 1
AND type_kao regexp 'DNA'
GROUP BY p_id) as b
ON a.p_id = b.p_id
WHERE b.p_id is NULL
GROUP BY a.p_id;








