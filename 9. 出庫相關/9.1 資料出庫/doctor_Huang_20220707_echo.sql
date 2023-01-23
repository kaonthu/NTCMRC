CREATE TABLE CMRC_DB_kaonthu.CMRC_Record_Of_Echo (
  `流水號` char(15) NOT NULL,
  `第幾年檢查` int(2) DEFAULT NULL,
  `檢驗代號` varchar(20) DEFAULT NULL,
  `姓名` varchar(32) DEFAULT NULL,
  `id` varchar(10) DEFAULT NULL,
  `病歷號` varchar(32) NOT NULL,
  `日期` date DEFAULT NULL,
  `肝臟` int(2) DEFAULT NULL,
  `脂肪肝` int(2) DEFAULT NULL,
  `肝實質` int(2) DEFAULT NULL,
  `肝硬化` int(2) DEFAULT NULL,
  `肝囊腫` int(2) DEFAULT NULL,
  `肝囊腫_左葉` int(2) DEFAULT NULL,
  `肝囊腫_左葉公分` varchar(12) DEFAULT NULL,
  `肝囊腫_右葉` int(2) DEFAULT NULL,
  `肝囊腫_右葉公分` varchar(12) DEFAULT NULL,
  `肝囊腫_雙葉` int(2) DEFAULT NULL,
  `肝囊腫_雙葉公分` varchar(12) DEFAULT NULL,
  `血管瘤` int(2) DEFAULT NULL,
  `血管瘤_左葉` int(2) DEFAULT NULL,
  `血管瘤_左葉公分` varchar(12) DEFAULT NULL,
  `血管瘤_右葉` int(2) DEFAULT NULL,
  `血管瘤_右葉公分` varchar(12) DEFAULT NULL,
  `血管瘤_雙葉` int(2) DEFAULT NULL,
  `血管瘤_雙葉公分` varchar(12) DEFAULT NULL,
  `肝內鈣化點` int(2) DEFAULT NULL,
  `肝內鈣化點_左葉` int(2) DEFAULT NULL,
  `肝內鈣化點_左葉公分` varchar(12) DEFAULT NULL,
  `肝內鈣化點_右葉` int(2) DEFAULT NULL,
  `肝內鈣化點_右葉公分` varchar(12) DEFAULT NULL,
  `肝內鈣化點_雙葉` int(2) DEFAULT NULL,
  `肝內鈣化點_雙葉公分` varchar(12) DEFAULT NULL,
  `肝腫瘤` varchar(80) DEFAULT NULL,
  `肝腫瘤_左葉` int(2) DEFAULT NULL,
  `肝腫瘤_左葉公分` varchar(12) DEFAULT NULL,
  `肝腫瘤_右葉` int(2) DEFAULT NULL,
  `肝腫瘤_右葉公分` varchar(12) DEFAULT NULL,
  `肝腫瘤_雙葉` int(2) DEFAULT NULL,
  `肝腫瘤_雙葉公分` varchar(12) DEFAULT NULL,
  `肝結節` int(2) DEFAULT NULL,
  `肝結節_左葉` int(2) DEFAULT NULL,
  `肝結節_左葉公分` varchar(12) DEFAULT NULL,
  `肝結節_右葉` int(2) DEFAULT NULL,
  `肝結節_右葉公分` varchar(12) DEFAULT NULL,
  `肝結節_雙葉` int(2) DEFAULT NULL,
  `肝結節_雙葉公分` varchar(12) DEFAULT NULL,
  `膽囊` varchar(80) DEFAULT NULL,
  `膽結石` varchar(80) DEFAULT NULL,
  `膽結石_單一或多發` int(2) DEFAULT NULL,
  `膽結石_公分` varchar(12) DEFAULT NULL,
  `膽息肉` varchar(80) DEFAULT NULL,
  `膽息肉_單一或多發` int(2) DEFAULT NULL,
  `膽息肉_公分` varchar(12) DEFAULT NULL,
  `CBD` varchar(20) DEFAULT NULL,
  `PV` varchar(20) DEFAULT NULL,
  `腎臟` int(2) DEFAULT NULL,
  `腎結石` int(2) DEFAULT NULL,
  `腎結石_左腎` int(2) DEFAULT NULL,
  `腎結石_左腎公分` varchar(12) DEFAULT NULL,
  `腎結石_右腎` int(2) DEFAULT NULL,
  `腎結石_右腎公分` varchar(12) DEFAULT NULL,
  `腎囊腫` int(2) DEFAULT NULL,
  `腎囊腫_左腎` int(2) DEFAULT NULL,
  `腎囊腫_左腎公分` varchar(12) DEFAULT NULL,
  `腎囊腫_右腎` int(2) DEFAULT NULL,
  `腎囊腫_右腎公分` varchar(12) DEFAULT NULL,
  `腎腫瘤` int(2) DEFAULT NULL,
  `腎腫瘤_左腎` int(2) DEFAULT NULL,
  `腎腫瘤_左腎公分` varchar(12) DEFAULT NULL,
  `腎腫瘤_右腎` int(2) DEFAULT NULL,
  `腎腫瘤_右腎公分` varchar(12) DEFAULT NULL,
  `腎結節` int(2) DEFAULT NULL,
  `腎結節_左腎` int(2) DEFAULT NULL,
  `腎結節_左腎公分` varchar(12) DEFAULT NULL,
  `腎結節_右腎` int(2) DEFAULT NULL,
  `腎結節_右腎公分` varchar(12) DEFAULT NULL,
  `脾臟` varchar(80) DEFAULT NULL,
  `spleen_long_axis_cm` varchar(100) DEFAULT NULL,
  `spleen_short_axis_cm` varchar(100) DEFAULT NULL,
  `脾面積` varchar(100) DEFAULT NULL,
  `other` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`流水號`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOAD DATA LOCAL INFILE 
'D:/Leeyu/JupyterWorkplace/ReceptionSystem/超音波資料/超音波總檔2013-20220319.csv'
INTO TABLE CMRC_DB_kaonthu.CMRC_Record_Of_Echo
CHARACTER SET utf8 FIELDS 
TERMINATED BY ','  
LINES TERMINATED BY '\n' 
IGNORE 1 LINES; 

SELECT * FROM CMRC_DB_kaonthu.CMRC_Record_Of_Echo
WHERE `流水號` = '';

SELECT a.`流水號`,a.`檢驗代號`,a.`姓名`,a.id,a.`病歷號`,a.`日期`,b.* 
FROM CMRC_DB_kaonthu.CMRC_Record_Of_Echo as a
INNER JOIN CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310 as b
ON a.id = b.ID 
WHERE a.`流水號` = ''
;

SELECT a.`檢驗代號`,a.`姓名`,a.id,a.`病歷號`,a.`日期` 
FROM CMRC_DB_kaonthu.CMRC_Record_Of_Echo as a
INNER JOIN CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310 as b
ON a.id = b.ID and a.`日期` = b.data_exam
;

UPDATE CMRC_DB_kaonthu.CMRC_Record_Of_Echo as a
INNER JOIN CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310 as b
ON a.id = b.ID and a.`日期` = b.data_exam
SET a.`流水號` = b.P_dn;

UPDATE CMRC_DB_kaonthu.CMRC_Record_Of_Echo as a
INNER JOIN CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310 as b
ON a.`病歷號` = b.p_id and a.`日期` = b.data_exam
SET a.`流水號` = b.P_dn
WHERE a.`流水號` = '';

SELECT * FROM CMRC_DB_kaonthu.CMRC_Record_Of_Echo
WHERE `日期` >=20201000 and `日期` <= 20211000;


SELECT * FROM CMRC_DB_kaonthu.CMRC_Record_Of_Echo
WHERE `日期` >=20211000 
GROUP BY `病歷號`;

SELECT * FROM CMRC_DB_kaonthu.CMRC_Record_Of_Echo
WHERE `日期` >=20211000 
GROUP BY `日期`;

SELECT * FROM CMRC_DB_kaonthu.CMRC_Record_Of_Echo
WHERE `日期` >=20201000
GROUP BY `病歷號`;