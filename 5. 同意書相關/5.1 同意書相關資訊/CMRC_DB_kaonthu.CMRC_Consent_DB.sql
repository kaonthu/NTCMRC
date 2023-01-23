SELECT * FROM CMRC_DB.CMRC_Consent_DB;

CREATE TABLE CMRC_DB_kaonthu.CMRC_Consent_DB as
SELECT * FROM CMRC_DB.CMRC_Consent_DB;

CREATE TABLE CMRC_DB_kaonthu.`CMRC_Consent_DB_kaonthu` (
  `Session` varchar(30) DEFAULT NULL,
  `SID_old` varchar(30) DEFAULT NULL,
  `SID` varchar(20) DEFAULT NULL,
  `ID` varchar(15) DEFAULT NULL,
  `P_ID` varchar(15) DEFAULT NULL,
  `p_number` varchar(20) DEFAULT NULL,
  `cmrc_id` varchar(20) DEFAULT NULL,
  `DNA_CMRC_id` VARCHAR(20) DEFAULT NULL,
  `Name` varchar(26) DEFAULT NULL,
  `Consent_date` varchar(30) DEFAULT NULL,
  `Approve_date` varchar(30) DEFAULT NULL,
  `Ver` varchar(27) DEFAULT NULL,
  `Obtained_by` varchar(24) DEFAULT NULL,
  `Note` varchar(87) DEFAULT NULL,
  `Type` varchar(20) DEFAULT NULL,
  `date_kao` date DEFAULT NULL,
  `date_kao2` varchar(20) DEFAULT NULL,
  `ver_kao` varchar(20) DEFAULT NULL,
  `type_kao` varchar(10) DEFAULT NULL,
  `note_kao` varchar(87) DEFAULT NULL,
  `yes_kao` int(2) DEFAULT NULL,
  `sup` int(6) DEFAULT NULL,
  KEY `sid` (`SID`),
  KEY `pid` (`P_ID`),
  KEY `note` (`Note`),
  KEY `p_number` (`p_number`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

SELECT * FROM CMRC_DB_kaonthu.CMRC_Consent_DB_kaonthu;

SELECT count(*),LEFT(SID,4) 
FROM CMRC_DB_kaonthu.CMRC_Consent_DB_kaonthu
GROUP BY LEFT(SID,4) ; #檢查SID 格式有沒有錯

UPDATE CMRC_DB_kaonthu.CMRC_Consent_DB_kaonthu as a
INNER JOIN CMRC_DB_kaonthu.CMRC_all_persontimes_20220110_kaonthu as b
ON a.SID = b.P_dn
SET a.p_number = b.P_Number,
a.cmrc_id = b.cmrc_id,
a.DNA_CMRC_id = b.DNA_CMRC_id;#會發現有很多人對不回去，原檔案標記為無場次

UPDATE CMRC_DB_kaonthu.CMRC_Consent_DB_kaonthu as a
INNER JOIN CMRC_DB_kaonthu.CMRC_all_persontimes_20220110_kaonthu as b
ON a.SID = b.P_dn
SET a.p_number = b.P_Number,
a.cmrc_id = b.cmrc_id,
a.DNA_CMRC_id = b.DNA_CMRC_id;
#會發現有很多人對不回去，原檔案標記為無場次，如此只能用P_ID 要注意

SELECT type_kao,count(*) FROM CMRC_DB_kaonthu.CMRC_Consent_DB_kaonthu
GROUP BY type_kao;

CREATE VIEW kao_practice_3.Back_consent_kaonthu as
SELECT * FROM CMRC_DB_kaonthu.CMRC_Consent_DB_kaonthu 
WHERE type_kao REGEXP '\\(回\\)' ; 

CREATE VIEW kao_practice_3.New_consent_kaonthu as
SELECT * FROM CMRC_DB_kaonthu.CMRC_Consent_DB_kaonthu 
WHERE type_kao REGEXP '\\(新\\)' ; 

CREATE VIEW kao_practice_3.DNA_consent_kaonthu as
SELECT * FROM CMRC_DB_kaonthu.CMRC_Consent_DB_kaonthu 
WHERE type_kao REGEXP '\\(DNA\\)' ; 

CREATE VIEW kao_practice_3.TPMI_consent_kaonthu as
SELECT * FROM CMRC_DB_kaonthu.CMRC_Consent_DB_kaonthu 
WHERE type_kao REGEXP '\\(TPMI\\)' ; 

CREATE VIEW kao_practice_3.`生資_consent_kaonthu` as
SELECT * FROM CMRC_DB_kaonthu.CMRC_Consent_DB_kaonthu 
WHERE type_kao REGEXP '\\(生資\\)' ; 


CREATE VIEW kao_practice_3.CMRC_all_persontimes_last_kaonthu_back as
SELECT a.*,
group_concat(b.note SEPARATOR '_') as back_note,
group_concat(b.date_kao SEPARATOR '_') as back_date,
group_concat(b.ver_kao SEPARATOR '_') as back_ver,
group_concat(b.type_kao SEPARATOR '_') as back_type,
group_concat(b.yes_kao SEPARATOR '_') as back_yes
FROM 
CMRC_DB_kaonthu.CMRC_all_persontimes_last_kaonthu as a
LEFT JOIN
kao_practice_3.Back_consent_kaonthu as b
ON a.p_id = b.p_id 
GROUP BY p_id;

CREATE VIEW kao_practice_3.CMRC_all_persontimes_last_kaonthu_back_new as
SELECT a.*,
group_concat(b.note SEPARATOR '_') as new_note,
group_concat(b.date_kao SEPARATOR '_') as new_date,
group_concat(b.ver_kao SEPARATOR '_') as new_ver,
group_concat(b.type_kao SEPARATOR '_') as new_type,
group_concat(b.yes_kao SEPARATOR '_') as new_yes
FROM 
kao_practice_3.CMRC_all_persontimes_last_kaonthu_back as a
LEFT JOIN
kao_practice_3.New_consent_kaonthu as b
ON a.p_id = b.p_id 
GROUP BY p_id;

CREATE VIEW kao_practice_3.CMRC_all_persontimes_last_kaonthu_back_new_DNA as
SELECT a.*,
group_concat(b.note SEPARATOR '_') as DNA_note,
group_concat(b.date_kao SEPARATOR '_') as DNA_date,
group_concat(b.ver_kao SEPARATOR '_') as DNA_ver,
group_concat(b.type_kao SEPARATOR '_') as DNA_type,
group_concat(b.yes_kao SEPARATOR '_') as DNA_yes
FROM 
kao_practice_3.CMRC_all_persontimes_last_kaonthu_back_new as a
LEFT JOIN
kao_practice_3.DNA_consent_kaonthu as b
ON a.p_id = b.p_id 
GROUP BY p_id;

CREATE VIEW kao_practice_3.CMRC_all_persontimes_last_kaonthu_back_new_DNA_TMPI as
SELECT a.*,
group_concat(b.note SEPARATOR '_') as TMPI_note,
group_concat(b.date_kao SEPARATOR '_') as TMPI_date,
group_concat(b.ver_kao SEPARATOR '_') as TMPI_ver,
group_concat(b.type_kao SEPARATOR '_') as TMPI_type,
group_concat(b.yes_kao SEPARATOR '_') as TMPI_yes
FROM 
kao_practice_3.CMRC_all_persontimes_last_kaonthu_back_new_DNA as a
LEFT JOIN
kao_practice_3.TPMI_consent_kaonthu as b
ON a.p_id = b.p_id 
GROUP BY p_id;

CREATE VIEW CMRC_DB_kaonthu.`CMRC_all_persontimes_last_kaonthu_back_new_DNA_TMPI_生資` as
SELECT a.*,
group_concat(b.note SEPARATOR '_') as bio_note,
group_concat(b.date_kao SEPARATOR '_') as bio_date,
group_concat(b.ver_kao SEPARATOR '_') as bio_ver,
group_concat(b.type_kao SEPARATOR '_') as bio_type,
group_concat(b.yes_kao SEPARATOR '_') as bio_yes
FROM 
kao_practice_3.CMRC_all_persontimes_last_kaonthu_back_new_DNA_TMPI as a
LEFT JOIN
kao_practice_3.`生資_consent_kaonthu` as b
ON a.p_id = b.p_id 
GROUP BY p_id;




