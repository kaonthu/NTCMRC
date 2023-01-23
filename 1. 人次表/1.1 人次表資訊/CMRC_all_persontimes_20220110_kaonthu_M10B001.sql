#DELETE FROM CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310
#WHERE P_dn regexp '^M10B';

LOAD DATA LOCAL INFILE 
'D:/基隆長庚社區醫學科研究中心/CMRC社區資料庫/Li_Yu_Lee/總人次收案資訊/2022_匯入工作/CMRC_all_persontimes_20220319.csv'
INTO TABLE CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310
CHARACTER SET utf8 FIELDS 
TERMINATED BY ','  
LINES TERMINATED BY '\n' 
IGNORE 1 LINES; #20976 + 91 +90 + 71 + 61 肥胖門診

SELECT p_id,`year`
FROM CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310
WHERE P_dn regexp '^M10B' ; #M10B 61個沒有 year 資訊需自己對

UPDATE CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310 as a 
set a.`year` =  1 
WHERE a.P_dn regexp '^M10B'; #要先假設每個人都是第一次來

#######################################################
SELECT p_id,`year`
FROM CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310_desc_last
WHERE p_id IN ( SELECT p_id
FROM CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310
WHERE P_dn regexp '^M10B'); #但事實上有可能有來過的人 
#會藏在CMRC_all_persontimes_20220110_kaonthu_20220310_desc_last 這裡面還沒有匯入M10B
# M10B 61門診收案 其中已經有9人來過了 對應對後一次的 year 表格

UPDATE CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310 as a 
INNER JOIN (
SELECT p_id,`year`
FROM CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310_desc_last
WHERE p_id IN ( SELECT p_id
FROM CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310
WHERE P_dn regexp '^M10B')
) as b
ON a.p_id = b.p_id 
set a.`year` = b.`year` + 1 
WHERE a.P_dn regexp '^M10B'; #有可能有人重覆來過了 更新這9個人最後來的次數

SELECT * FROM CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310;
 #20976 + 91 +90 + 71 + 61 肥胖門診
 
UPDATE CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310 as a
INNER JOIN (SELECT * FROM CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310
WHERE P_dn not regexp '^M10B'
GROUP BY p_id) as b
ON a.p_id = b.p_id
SET a.CMRC_id = b.CMRC_id,a.New_CMRC_id = b.New_CMRC_id
WHERE a.P_dn regexp '^M10B'; #更新New_CMRC_id 有來過的 9個不需要新編制

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
WHERE P_dn regexp '^M10B' AND `New_CMRC_id` = ""; #沒來過的52個要新編


UPDATE CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310 as a
SET a.location = "門診",a.location2 = "門診",a.location3 = "門診"
WHERE P_dn regexp '^M10B';

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

INSERT INTO CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310_desc
SELECT * FROM CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310
ORDER BY data_exam DESC;
#要先truncate 

INSERT INTO CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310_desc_last
SELECT * FROM CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310_desc
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

####################################################
SELECT * FROM CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310 
WHERE p_id = "4532291"; #4532291 這個人特別奇怪 20211127 來過 然後20211125 又去門診收案
