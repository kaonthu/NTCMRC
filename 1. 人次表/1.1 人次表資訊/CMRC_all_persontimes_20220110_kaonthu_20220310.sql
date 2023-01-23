CREATE DATABASE CMRC_DB_2022_import_work;

CREATE TABLE CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310 (
  `CMRC_id` varchar(20) DEFAULT NULL,
  `New_CMRC_id` varchar(20) DEFAULT NULL,
  `data_exam` double DEFAULT NULL,
  `P_dn` varchar(20) NOT NULL,
  `P_Number` varchar(7) DEFAULT NULL,
  `Name` varchar(26) DEFAULT NULL,
  `ID` varchar(10) DEFAULT NULL,
  `p_id` varchar(8) DEFAULT NULL,
  `address` varchar(116) DEFAULT NULL,
  `birthday` varchar(6) DEFAULT NULL,
  `tel` varchar(29) DEFAULT NULL,
  `tel_1` varchar(29) DEFAULT NULL,
  `tel_2` varchar(29) DEFAULT NULL,
  `tel_3` varchar(29) DEFAULT NULL,
  `phone` varchar(22) DEFAULT NULL,
  `phone_2_original` varchar(29) DEFAULT NULL,
  `phone_1` varchar(29) DEFAULT NULL,
  `phone_2` varchar(29) DEFAULT NULL,
  `sex` varchar(3) DEFAULT NULL,
  `age` varchar(2) DEFAULT NULL,
  `agree` varchar(1) DEFAULT NULL,
  `remark` varchar(95) DEFAULT NULL,
  `year` varchar(1) DEFAULT NULL,
  `echo` varchar(1) DEFAULT NULL,
  `DNA` varchar(24) DEFAULT NULL,
  `GS` varchar(1) DEFAULT NULL,
  `old` varchar(24) DEFAULT NULL,
  `聯絡人` varchar(12) DEFAULT NULL,
  `患者之關係` varchar(6) DEFAULT NULL,
  `電話` varchar(29) DEFAULT NULL,
  `手機` varchar(10) DEFAULT NULL,
  `地址` varchar(48) DEFAULT NULL,
  `location` varchar(10) DEFAULT NULL,
  `location2` varchar(10) DEFAULT NULL,
  `location3` varchar(10) DEFAULT NULL,
  `need_back` int(2) DEFAULT NULL,
  `family` int(6) DEFAULT NULL,
  `family2` int(6) DEFAULT NULL,
  `family3` int(6) DEFAULT NULL,
  `family4` int(6) DEFAULT NULL,
  `together` int(2) DEFAULT NULL,
  `together_1` varchar(20) DEFAULT NULL,
  `together_2` varchar(20) DEFAULT NULL,
  `together_pid` varchar(20) DEFAULT NULL,
  `together_pid2` varchar(20) DEFAULT NULL,
  `together_pid3` varchar(20) DEFAULT NULL,
  `death` int(6) DEFAULT NULL,
  `death_cgrd` int(6) DEFAULT NULL,
  `reject` int(6) DEFAULT NULL,
  `move` int(6) DEFAULT NULL,
  `sup` int(6) DEFAULT NULL,
  PRIMARY KEY (`P_dn`),
  KEY `idx_p` (`P_Number`),
  KEY `idx_cmrc_id` (`CMRC_id`),
  KEY `p_id` (`p_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4
;

INSERT INTO CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310
SELECT * FROM CMRC_DB_kaonthu.CMRC_all_persontimes_20220110_kaonthu;

LOAD DATA LOCAL INFILE 
'D:/基隆長庚社區醫學科研究中心/CMRC社區資料庫/Li_Yu_Lee/總人次收案資訊/2022_匯入工作/CMRC_all_persontimes_20220305.csv'
INTO TABLE CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310
CHARACTER SET utf8 FIELDS 
TERMINATED BY ','  
LINES TERMINATED BY '\n' 
IGNORE 1 LINES;

/* DELETE FROM CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310
WHERE data_exam = 20220305;

DELETE FROM CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310
WHERE P_number = 691002; */

SELECT * FROM CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310;

UPDATE CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310 as a
INNER JOIN (SELECT * FROM CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310
WHERE data_exam < 20220305
GROUP BY p_id) as b
ON a.p_id = b.p_id
SET a.CMRC_id = b.CMRC_id,a.New_CMRC_id = b.New_CMRC_id
WHERE a.data_exam >= 20220305;

UPDATE CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310
SET New_CMRC_id = 
IF(LENGTH(P_dn)=11,
CONCAT(
char(65+floor(1+rand()*25)),  #"亂數英文1碼"
floor(rand()*10),             #"亂數數字1碼"
SUBSTRING(P_dn,1,4)* 3,  #"流水號年份4碼"
char(65+floor(1+rand()*25)),  #"亂數英文1碼"
floor(rand()*10),             #"亂數數字1碼"
SUBSTRING(P_dn,5,4),       #"流水號月日4碼"
floor(rand()*10)  ,  #"亂數英文1碼"
LPAD(RIGHT(P_dn,3)* 7,3,0),#"流水號末3碼
floor(rand()*10)             #"亂數數字1碼"

),

CONCAT(

char(65+floor(1+rand()*25)),  #"亂數英文1碼"
floor(rand()*10),             #"亂數數字1碼"
SUBSTRING(P_dn,1,4),       #"M+年份+學組代碼4碼"
char(65+floor(1+rand()*25)),  #"亂數英文1碼"
floor(rand()*10),             #"亂數數字1碼"
LPAD(SUBSTRING(P_dn,5,3)*7,3,0), #"流水號3碼"
char(65+floor(1+rand()*25)),  #"亂數英文1碼"
floor(rand()*10)              #"亂數數字1碼"
)
) 
WHERE data_exam = 20220305 AND `New_CMRC_id` = "";


UPDATE CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310 as a
SET a.location = "貢寮區",a.location2 = "福隆里",a.location3 = "福隆里"
WHERE a.data_exam = 20220305;

##################################################################

UPDATE CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310 as a
INNER JOIN 
(SELECT *,(@val := @val + 1)  AS value 
FROM CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310, 
(SELECT @val := 0) AS tt) as b
ON a.P_dn = b.P_dn 
SET a.sup = b.value;
#更新sup 流水號
#####################################################################

CREATE TABLE CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310_desc (
  `CMRC_id` varchar(20) DEFAULT NULL,
  `New_CMRC_id` varchar(20) DEFAULT NULL,
  `data_exam` double DEFAULT NULL,
  `P_dn` varchar(20) NOT NULL,
  `P_Number` varchar(7) DEFAULT NULL,
  `Name` varchar(26) DEFAULT NULL,
  `ID` varchar(10) DEFAULT NULL,
  `p_id` varchar(8) DEFAULT NULL,
  `address` varchar(116) DEFAULT NULL,
  `birthday` varchar(6) DEFAULT NULL,
  `tel` varchar(29) DEFAULT NULL,
  `tel_1` varchar(29) DEFAULT NULL,
  `tel_2` varchar(29) DEFAULT NULL,
  `tel_3` varchar(29) DEFAULT NULL,
  `phone` varchar(22) DEFAULT NULL,
  `phone_2_original` varchar(29) DEFAULT NULL,
  `phone_1` varchar(29) DEFAULT NULL,
  `phone_2` varchar(29) DEFAULT NULL,
  `sex` varchar(3) DEFAULT NULL,
  `age` varchar(2) DEFAULT NULL,
  `agree` varchar(1) DEFAULT NULL,
  `remark` varchar(95) DEFAULT NULL,
  `year` varchar(1) DEFAULT NULL,
  `echo` varchar(1) DEFAULT NULL,
  `DNA` varchar(24) DEFAULT NULL,
  `GS` varchar(1) DEFAULT NULL,
  `old` varchar(24) DEFAULT NULL,
  `聯絡人` varchar(12) DEFAULT NULL,
  `患者之關係` varchar(6) DEFAULT NULL,
  `電話` varchar(29) DEFAULT NULL,
  `手機` varchar(10) DEFAULT NULL,
  `地址` varchar(48) DEFAULT NULL,
  `location` varchar(10) DEFAULT NULL,
  `location2` varchar(10) DEFAULT NULL,
  `location3` varchar(10) DEFAULT NULL,
  `need_back` int(2) DEFAULT NULL,
  `family` int(6) DEFAULT NULL,
  `family2` int(6) DEFAULT NULL,
  `family3` int(6) DEFAULT NULL,
  `family4` int(6) DEFAULT NULL,
  `together` int(2) DEFAULT NULL,
  `together_1` varchar(20) DEFAULT NULL,
  `together_2` varchar(20) DEFAULT NULL,
  `together_pid` varchar(20) DEFAULT NULL,
  `together_pid2` varchar(20) DEFAULT NULL,
  `together_pid3` varchar(20) DEFAULT NULL,
  `death` int(6) DEFAULT NULL,
  `death_cgrd` int(6) DEFAULT NULL,
  `reject` int(6) DEFAULT NULL,
  `move` int(6) DEFAULT NULL,
  `sup` int(6) DEFAULT NULL,
  PRIMARY KEY (`P_dn`),
  KEY `idx_p` (`P_Number`),
  KEY `idx_cmrc_id` (`CMRC_id`),
  KEY `p_id` (`p_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4
;

INSERT INTO CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310_desc
SELECT * FROM CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310
ORDER BY data_exam DESC;

CREATE TABLE CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310_desc_last (
  `CMRC_id` varchar(20) DEFAULT NULL,
  `New_CMRC_id` varchar(20) DEFAULT NULL,
  `data_exam` double DEFAULT NULL,
  `P_dn` varchar(20) NOT NULL,
  `P_Number` varchar(7) DEFAULT NULL,
  `Name` varchar(26) DEFAULT NULL,
  `ID` varchar(10) DEFAULT NULL,
  `p_id` varchar(8) DEFAULT NULL,
  `address` varchar(116) DEFAULT NULL,
  `birthday` varchar(6) DEFAULT NULL,
  `tel` varchar(29) DEFAULT NULL,
  `tel_1` varchar(29) DEFAULT NULL,
  `tel_2` varchar(29) DEFAULT NULL,
  `tel_3` varchar(29) DEFAULT NULL,
  `phone` varchar(22) DEFAULT NULL,
  `phone_2_original` varchar(29) DEFAULT NULL,
  `phone_1` varchar(29) DEFAULT NULL,
  `phone_2` varchar(29) DEFAULT NULL,
  `sex` varchar(3) DEFAULT NULL,
  `age` varchar(2) DEFAULT NULL,
  `agree` varchar(1) DEFAULT NULL,
  `remark` varchar(95) DEFAULT NULL,
  `year` varchar(1) DEFAULT NULL,
  `echo` varchar(1) DEFAULT NULL,
  `DNA` varchar(24) DEFAULT NULL,
  `GS` varchar(1) DEFAULT NULL,
  `old` varchar(24) DEFAULT NULL,
  `聯絡人` varchar(12) DEFAULT NULL,
  `患者之關係` varchar(6) DEFAULT NULL,
  `電話` varchar(29) DEFAULT NULL,
  `手機` varchar(10) DEFAULT NULL,
  `地址` varchar(48) DEFAULT NULL,
  `location` varchar(10) DEFAULT NULL,
  `location2` varchar(10) DEFAULT NULL,
  `location3` varchar(10) DEFAULT NULL,
  `need_back` int(2) DEFAULT NULL,
  `family` int(6) DEFAULT NULL,
  `family2` int(6) DEFAULT NULL,
  `family3` int(6) DEFAULT NULL,
  `family4` int(6) DEFAULT NULL,
  `together` int(2) DEFAULT NULL,
  `together_1` varchar(20) DEFAULT NULL,
  `together_2` varchar(20) DEFAULT NULL,
  `together_pid` varchar(20) DEFAULT NULL,
  `together_pid2` varchar(20) DEFAULT NULL,
  `together_pid3` varchar(20) DEFAULT NULL,
  `death` int(6) DEFAULT NULL,
  `death_cgrd` int(6) DEFAULT NULL,
  `reject` int(6) DEFAULT NULL,
  `move` int(6) DEFAULT NULL,
  `sup` int(6) DEFAULT NULL,
  PRIMARY KEY (`P_dn`),
  KEY `idx_p` (`P_Number`),
  KEY `idx_cmrc_id` (`CMRC_id`),
  KEY `p_id` (`p_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4
;

INSERT INTO CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310_desc_last
SELECT * FROM CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310_desc
GROUP BY p_id ;

#############################################################

SELECT a.`year`,b.*,a.`year` - b.ordercount
FROM CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310_desc_last as a
INNER JOIN 
(SELECT @rank:=@rank+1 AS rank, p_id, COUNT(*) as ordercount
FROM CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310
GROUP BY p_id 
ORDER BY rank DESC) as b
ON a.p_id = b.p_id ;
#此指令用來確認每個人最後一次來的次數是否正確;