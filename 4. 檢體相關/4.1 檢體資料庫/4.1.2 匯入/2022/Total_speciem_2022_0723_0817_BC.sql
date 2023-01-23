SELECT * FROM kao_practice_5.Total_speciem_2022_0723_0817
WHERE Specimen = 'BC'; #75+95+106+87

CREATE temporary table kao_practice_5.Total_speciem_2021_2022_BC as
SELECT * FROM kao_practice_5.Total_speciem_2022_0723_0817
WHERE Specimen = 'BC'; #1761-81 + 329 = 2009;

SELECT * FROM kao_practice_5.Total_speciem_2021_2022_BC;

UPDATE kao_practice_5.Total_speciem_2021_2022_BC as a
INNER JOIN CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310 as b
ON a.P_number = b.P_number
SET a.C_Date = b.data_exam,a.sid = b.P_dn,a.IN_time = 20220824;

UPDATE kao_practice_5.Total_speciem_2021_2022_BC
SET box = REPLACE(box,'B','') 
WHERE C_Date < 20220000;

INSERT INTO CMRC_DB_kaonthu.CMRC_Sample_info 
(P_number,C_number,ML,Specimen,QC,C_Date,CMRC_Reserved,In_time)
SELECT P_number,C_number,ML,Specimen,QC,C_Date,CMRC_Reserved,In_time
FROM kao_practice_5.Total_speciem_2021_2022_BC;

INSERT INTO CMRC_DB_kaonthu.CMRC_Sample_status
(P_number,C_number,Box,Site,`out`,entry_time)
SELECT P_number,C_number,Box,Site,0,now()
FROM kao_practice_5.Total_speciem_2021_2022_BC;

UPDATE CMRC_DB_kaonthu.CMRC_Sample_info as a
INNER JOIN CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310 as b
ON a.P_number = b.P_number
SET a.CMRC_ID = b.CMRC_ID,a.New_CMRC_id = b.New_CMRC_id
WHERE In_time = 20220824
AND Specimen = 'BC';

SELECT a.CMRC_ID,a.New_CMRC_id,a.C_Date,a.C_number,
a.P_number,a.Fridge,a.Box,a.Site,a.Specimen,b.`year`
FROM
(SELECT * FROM CMRC_DB_kaonthu.CMRC_sample_Database_Consent
WHERE Specimen = 'BC'
AND `out` = 0
AND C_date >= 20220723) as a
INNER JOIN CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310_desc_last as b
ON a.CMRC_id = b.CMRC_id

/* CREATE temporary table kao_practice_5.Total_speciem_2021_BC_out as
SELECT * FROM kao_practice_5.Total_speciem_2022_0723_0817
WHERE Specimen = 'BC'
AND P_number IN (
"P100955","P100963","P101003","P101005","P101010","P101011","P101015","P101032",
"P101042","P101053","P101065","P101066","P101078","P101081","P101110","P101144",
"P101171","P101245","P101260","P101278","P101408","P101409","P101420","P101444",
"P101467","P101514","P101557","P101611","P100099","P100177","P100196","P100213",
"P100214","P100219","P100235","P100261","P100263","P100269","P100270","P100271",
"P100277","P100278","P100381","P100395","P100590","P100632","P100643","P100658",
"P100674","P100699","P100744","P100763","P100764","P100824","P100841","P100842",
"P100849","P100852","P100853","P100882","P100952","P100958","P100965","P100983",
"P101016","P101074","P101108","P101120","P101126","P101127","P101155","P101165",
"P101207","P101220","P101222","P101252","P101333","P101418","P101459","P101484",
"P101494","P101496","P101503","P101504","P101507","P101525","P101528","P101583",
"P101597","P101612","P101621","P101629","P101673","P101681");

INSERT INTO CMRC_DB_kaonthu.CMRC_Sample_status
(`C_number`, `out`, `out_time`, `out_name`, `entry_time`)
SELECT C_number,'1','20220626','CMRC',now()
FROM kao_practice_5.Total_speciem_2021_BC_out; */



#UPDATE CMRC_DB_kaonthu.CMRC_Sample_status
#SET `out` = 0 
#WHERE `out` is NULL
#AND out_time is NULL;

