SELECT * FROM CMRC_DB_kaonthu.Echo_list_Total_20220222;
#建立一個有照超音波總人次資訊5,508人次的表
#從超音波總當 2013-2020 + 雅銘 2021 給的 150人名單

/* UPDATE CMRC_DB_kaonthu.Echo_list_Total_20220222 as a
INNER JOIN CMRC_DB_kaonthu.CMRC_all_persontimes_20220110_kaonthu as b
ON a.id = b.ID and a.日期2 = b.data_exam
Set a.sid = b.P_dn , a.`year` = b.`year` , a.`name` = b.`Name`;

UPDATE CMRC_DB_kaonthu.Echo_list_Total_20220222_2 as a
INNER JOIN CMRC_DB_kaonthu.CMRC_all_persontimes_20220110_kaonthu as b
ON a.sid_sign = b.P_dn
Set a.`year` = b.`year` , a.`name` = b.`Name`; */
#必須先為總表手動 新增 sid_sign 不然對很慢

UPDATE CMRC_DB_kaonthu.Echo_list_Total_20220222_2 as a
Set a.`sid` = NULL;
#在超音波 5508 總人次里面並不是全部人都對的回總人次表

UPDATE CMRC_DB_kaonthu.Echo_list_Total_20220222_2 as a
INNER JOIN CMRC_DB_kaonthu.CMRC_all_persontimes_20220110_kaonthu as b
ON a.sid_sign = b.P_dn
Set a.`sid` = a.`sid_sign`;
#其中只有5467人次對地回去 少了41人次

UPDATE CMRC_DB_kaonthu.Echo_list_Total_20220222_2 as a
INNER JOIN CMRC_DB_kaonthu.CMRC_all_persontimes_20220110_kaonthu as b
ON a.sid_sign = b.P_dn
Set a.`病歷號` = b.`p_id`;

SELECT a.Name,a.ID,a.p_id,a.data_exam,a.echo,b.sid_sign,b.sid
FROM CMRC_DB_kaonthu.CMRC_all_persontimes_20220110_kaonthu as a
INNER JOIN CMRC_DB_kaonthu.Echo_list_Total_20220222_2 as b
ON a.P_dn = b.sid_sign
WHERE echo = 0; #原本總人次裡面的echo 資訊 可能明明有照但echo 顯示0 737個

SELECT a.Name,a.ID,a.p_id,a.data_exam,a.echo,b.sid_sign,b.sid
FROM CMRC_DB_kaonthu.CMRC_all_persontimes_20220110_kaonthu as a
INNER JOIN CMRC_DB_kaonthu.Echo_list_Total_20220222_2 as b
ON a.P_dn = b.sid_sign
WHERE echo = 1; #更新過後 補足5467人次皆有照 echo = 1 
 
SELECT a.Name,a.ID,a.p_id,a.data_exam,a.echo,count(*)
FROM CMRC_DB_kaonthu.CMRC_all_persontimes_20220110_kaonthu as a
GROUP BY echo; # 15,509 vs 5,467

UPDATE CMRC_DB_kaonthu.CMRC_all_persontimes_20220110_kaonthu
SET echo = 0; # 先全部設echo = 0

UPDATE CMRC_DB_kaonthu.CMRC_all_persontimes_20220110_kaonthu as a
INNER JOIN CMRC_DB_kaonthu.Echo_list_Total_20220222_2 as b
ON a.P_dn = b.sid_sign
SET echo = 1; # 有在超音波5467 = 5508-41 人次的設定為1


SELECT *
FROM CMRC_DB_kaonthu.Echo_list_Total_20220222_2
WHERE sid is not NULL; 

SELECT *,count(*) 
FROM CMRC_DB_kaonthu.Echo_list_Total_20220222_2
WHERE sid is not NULL
GROUP BY `病歷號`; #在超音波檔案中顯示有 3,621人是有照過的

SELECT *,left(`日期2`,4),count(*) 
FROM CMRC_DB_kaonthu.Echo_list_Total_20220222_2
WHERE sid is not NULL
GROUP BY left(`日期2`,4); #在超音波檔案中顯示有 3,621人是有照過的

SELECT a.data_exam,a.p_id,a.echo
FROM CMRC_DB_kaonthu.CMRC_all_persontimes_20220110_kaonthu_desc as a
INNER JOIN 
(SELECT p_id FROM CMRC_DB_kaonthu.CMRC_all_persontimes_20220110_kaonthu 
WHERE echo = 1
GROUP BY p_id) as b 
ON a.p_id = b.p_id
GROUP BY p_id;

SELECT * FROM kao_practice_3.CMRC_all_persontimes_desc_last_kaonthu 
WHERE echo = "1"; #但是上次來有照的人有 1,611人 可能不用照

SELECT * FROM kao_practice_3.CMRC_all_persontimes_desc_last_kaonthu
WHERE echo = "1"
and data_exam >= 20180000;
#這942個是不用照超音波的名單

SELECT * FROM kao_practice_3.CMRC_all_persontimes_desc_last_kaonthu
WHERE data_exam < 20180000; #2520 上次來在五年之前 2017/12/31 之前 基本上不會再來了

SELECT p_id FROM kao_practice_3.CMRC_all_persontimes_desc_last_kaonthu
WHERE data_exam < 20180000; #2520 上次來在五年之前 2017/12/31 之前 基本上不會再來了

SELECT a.data_exam,a.p_id,a.echo
FROM CMRC_DB_kaonthu.CMRC_all_persontimes_20220110_kaonthu_desc as a
WHERE a.data_exam >= 20180101
GROUP BY p_id ;#這5187人是在 2018/1/1 之後來參加過的過的人

SELECT a.data_exam,a.ID,a.p_id,a.echo
FROM CMRC_DB_kaonthu.CMRC_all_persontimes_20220110_kaonthu_desc as a
WHERE a.data_exam >= 20180101 AND echo = "1"
GROUP BY p_id ;#這5187人中 只有 1,595人是在 2018之後來過且照過超音波的人

SELECT a.data_exam,a.p_id,a.echo
FROM CMRC_DB_kaonthu.CMRC_all_persontimes_20220110_kaonthu_desc as a
WHERE a.data_exam < 20180101 AND echo = "1"
GROUP BY p_id ;#這5187人中 只有 1,595人是在 2018之後來過且照過超音波的人

SELECT * FROM kao_practice_3.CMRC_all_persontimes_desc_last_kaonthu
WHERE data_exam >= 20180000
AND p_id not in (SELECT a.p_id
FROM CMRC_DB_kaonthu.CMRC_all_persontimes_20220110_kaonthu_desc as a
WHERE a.data_exam >= 20180101 AND echo = "1"
GROUP BY p_id ); #3592人是在 20180101~20211225之間參加過 但是完全沒照過超音波

SELECT T1.*,T2.SCORE 
FROM (
SELECT * FROM kao_practice_3.CMRC_all_persontimes_desc_last_kaonthu
WHERE data_exam >= 20180000
AND p_id not in (SELECT a.p_id
FROM CMRC_DB_kaonthu.CMRC_all_persontimes_20220110_kaonthu_desc as a
WHERE a.data_exam >= 20180101 AND echo = "1"
GROUP BY p_id )
) as T1
INNER JOIN 
CMRC_DB_kaonthu.new_CMRC_db_7707_Scale_desc_2 as T2
ON T1.p_id = T2.p_id
WHERE SCORE >= 2; #3592人是在 20180101~20211225之間參加過 但是完全沒照過超音波



SELECT * 
FROM CMRC_DB_kaonthu.CMRC_all_persontimes_20220110_kaonthu 
WHERE p_id not IN ( SELECT a.p_id
FROM CMRC_DB_kaonthu.CMRC_all_persontimes_20220110_kaonthu_desc as a
WHERE a.data_exam >= 20180101 AND echo = "1"
GROUP BY p_id 
) 
AND data_exam >= 20180101 
GROUP BY p_id ;#驗算1



SELECT * 
FROM CMRC_DB_kaonthu.CMRC_all_persontimes_20220110_kaonthu 
WHERE data_exam >= 20180101 AND echo = "1"
GROUP BY p_id 
