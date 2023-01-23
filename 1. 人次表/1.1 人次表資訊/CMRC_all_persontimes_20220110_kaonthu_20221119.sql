
LOAD DATA LOCAL INFILE 
'D:/基隆長庚社區醫學科研究中心/CMRC社區資料庫/Li_Yu_Lee/總人次收案資訊/2022_匯入工作/CMRC_all_persontimes_20221119.csv'
INTO TABLE CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310
CHARACTER SET utf8 FIELDS 
TERMINATED BY ','  
LINES TERMINATED BY '\n' 
IGNORE 1 LINES; #20976 + 91 +90 + 71 + 77  肥胖門診M10B 61個人+ 補上肥胖門診M09B 4個人 + 75 + 95 + 106

/* DELETE FROM CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310
WHERE data_exam = 20220305;

DELETE FROM CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310
WHERE P_number = 691002; */

SELECT * FROM CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310;
#20976 + 91 +90 + 71 + 77 +61 + 4 + 75 + 95 + 106 + 87 + 119 + 100 + 102 +87 + 58 + 67 + 109 + 106 + 61 + 53 + 106 + 122
 
UPDATE CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310 as a
INNER JOIN (SELECT * FROM CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310
WHERE data_exam < 20221119
GROUP BY p_id) as b
ON a.p_id = b.p_id
SET a.CMRC_id = b.CMRC_id,a.New_CMRC_id = b.New_CMRC_id
WHERE a.data_exam >= 20221119;

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
WHERE data_exam = 20221119 AND `New_CMRC_id` = "";

#############################################################################

UPDATE CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310
SET CMRC_id = New_CMRC_id
WHERE CMRC_id = '';

#SELECT * FROM CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310
#WHERE CMRC_id = ''; #從 20220802 被告知出庫統一出舊的id 也就是說 CMRC_id 欄位不能是空的

###############################################################################

UPDATE CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310 as a
SET a.location = "安樂區",a.location2 = "新崙里",a.location3 = "新崙里2"
WHERE a.data_exam = 20221119;

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

INSERT INTO NTCMRC.CMRC_all_persontimes_desc
SELECT * FROM NTCMRC.CMRC_all_persontimes
ORDER BY data_exam DESC,P_dn DESC;
#要先truncate 

INSERT INTO NTCMRC.CMRC_all_persontimes_desc_last
SELECT * FROM NTCMRC.CMRC_all_persontimes_desc
GROUP BY p_id ;
#要先truncate 
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

SELECT *
FROM CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310_desc_last
WHERE ID = "CD00093280";

SELECT *
FROM CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310
WHERE p_id = "2182483"; 

SELECT *
FROM CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310
WHERE p_id = "4521550"; 

SELECT *
FROM CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310
WHERE p_id = "4532291"; 

SELECT *
FROM CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310
WHERE data_exam > 20220300; # 91+90+71+77+75+95+106+87+119+100+102+87+58+67+109+106+61+53+106+122

SELECT *
FROM CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310
WHERE length(P_dn) >= 12;

/* UPDATE CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310
SET P_dn = replace(P_dn,202208200,20220820)
WHERE length(P_dn) >= 12; */
