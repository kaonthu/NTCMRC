UPDATE CMRC_DB_2022_import_work.new_CMRC_db_20963_20220310
SET HS_CRP = replace(HS_CRP,"<","");
UPDATE CMRC_DB_2022_import_work.new_CMRC_db_20963_20220310
SET HS_CRP = replace(HS_CRP," ","");

UPDATE CMRC_DB_2022_import_work.new_CMRC_db_20963_20220310 as a 
INNER JOIN 
CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310 as b
ON a.sid = b.P_dn 
SET a.CMRC_id = b.CMRC_id , a.New_CMRC_id = b.New_CMRC_id 
WHERE a.CMRC_id ='';

UPDATE CMRC_DB_2022_import_work.new_CMRC_db_20963_desc_20220310 as a 
INNER JOIN 
CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310 as b
ON a.sid = b.P_dn 
SET a.CMRC_id = b.CMRC_id , a.New_CMRC_id = b.New_CMRC_id 
WHERE a.CMRC_id ='';

INSERT INTO CMRC_DB_2022_import_work.new_CMRC_db_20963_20220310
(sid,P_Number,n_1,CMRC_id,New_CMRC_id,p_id,sex,birth,data_exam,age,data_year,year_come)
SELECT P_dn,P_Number,`Name`,CMRC_id,New_CMRC_id,p_id,sex,birthday,data_exam,age,left(data_exam,4),`year`
FROM CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310
WHERE data_exam = 20221105;

SELECT sid,P_Number,n_1,CMRC_id,New_CMRC_id,p_id,sex,birth,age,data_exam,data_year,year_come
FROM CMRC_DB_2022_import_work.new_CMRC_db_20963_20220310;

CREATE TABLE kao_practice_6.CMRC_20221105 (
  `number` varchar(30) DEFAULT NULL,
  `檢驗代號` varchar(30) DEFAULT NULL,
  `姓名` varchar(30) DEFAULT NULL,
  `病歷號` varchar(30) DEFAULT NULL,
  `性別` varchar(30) DEFAULT NULL,
  `生日` varchar(30) DEFAULT NULL,
  `Age` varchar(30) DEFAULT NULL,
  `height` varchar(30) DEFAULT NULL,
  `weight` varchar(30) DEFAULT NULL,
  `waist` varchar(30) DEFAULT NULL,
  `systolic` varchar(30) DEFAULT NULL,
  `diastolic` varchar(30) DEFAULT NULL,
  `heartbeat` varchar(30) DEFAULT NULL,
  `arm_circumference` varchar(30) DEFAULT NULL,
  `calf_circumference` varchar(30) DEFAULT NULL,
  `Thigh_circumference` varchar(30) DEFAULT NULL,
  `Glucose_AC_y` varchar(30) DEFAULT NULL,
  `Triglyceride_y` varchar(30) DEFAULT NULL,
  `HDL_C_y` varchar(30) DEFAULT NULL,
  `WBCb` varchar(30) DEFAULT NULL,
  `RBCb` varchar(30) DEFAULT NULL,
  `Hemoglobin` varchar(30) DEFAULT NULL,
  `Hematocrit` varchar(30) DEFAULT NULL,
  `MCV` varchar(30) DEFAULT NULL,
  `MCH` varchar(30) DEFAULT NULL,
  `MCHC` varchar(30) DEFAULT NULL,
  `RDW` varchar(30) DEFAULT NULL,
  `Platelets` varchar(30) DEFAULT NULL,
  `Transferrin` varchar(30) DEFAULT NULL,
  `Ferritin` varchar(30) DEFAULT NULL,
  `Folate` varchar(30) DEFAULT NULL,
  `AST_GOT` varchar(30) DEFAULT NULL,
  `ALT_GPT` varchar(30) DEFAULT NULL,
  `ALK_P` varchar(30) DEFAULT NULL,
  `Total_Bilirubin` varchar(30) DEFAULT NULL,
  `D_Bilirubin` varchar(30) DEFAULT NULL,
  `γ-GT` varchar(30) DEFAULT NULL,
  `AFP` varchar(30) DEFAULT NULL,
  `Insulin` varchar(30) DEFAULT NULL,
  `T_Cholesterol` varchar(30) DEFAULT NULL,
  `LDL_C_direct_` varchar(30) DEFAULT NULL,
  `VLDL_C` varchar(30) DEFAULT NULL,
  `Non_HDL_C` varchar(30) DEFAULT NULL,
  `T_CHOL_HDL_C` varchar(30) DEFAULT NULL,
  `LDL_C_HDL_C` varchar(30) DEFAULT NULL,
  `HS_CRP` varchar(30) DEFAULT NULL,
  `BUN` varchar(30) DEFAULT NULL,
  `Creatinine` varchar(30) DEFAULT NULL,
  `Estimated_GFR_x` varchar(30) DEFAULT NULL,
  `Na` varchar(30) DEFAULT NULL,
  `K` varchar(30) DEFAULT NULL,
  `Cl` varchar(30) DEFAULT NULL,
  `CO2` varchar(30) DEFAULT NULL,
  `Calcium` varchar(30) DEFAULT NULL,
  `Inorganic_P` varchar(30) DEFAULT NULL,
  `Albumin` varchar(30) DEFAULT NULL,
  `T-Protein(U)` varchar(30) DEFAULT NULL,
  `Hb_A1c` varchar(30) DEFAULT NULL,
  `Estimated_AG` varchar(30) DEFAULT NULL,
  `Intact_PTH` varchar(30) DEFAULT NULL,
  `Uric_Acid_b` varchar(30) DEFAULT NULL,
  `HBsAg_x` varchar(30) DEFAULT NULL,
  `RPR` varchar(30) DEFAULT NULL,
  `RF` varchar(30) DEFAULT NULL,
  `H_PYAB` varchar(30) DEFAULT NULL,
  `Anti_HCV_x` varchar(30) DEFAULT NULL,
  `Color` varchar(30) DEFAULT NULL,
  `Turbidity` varchar(30) DEFAULT NULL,
  `SP_Gravity` varchar(30) DEFAULT NULL,
  `pH` varchar(30) DEFAULT NULL,
  `Leukocyte` varchar(30) DEFAULT NULL,
  `Nitrite` varchar(60) DEFAULT NULL,
  `Protein` varchar(30) DEFAULT NULL,
  `Glucose` varchar(30) DEFAULT NULL,
  `Ketone` varchar(30) DEFAULT NULL,
  `Urobilinogen` varchar(50) DEFAULT NULL,
  `Bilirubin` varchar(30) DEFAULT NULL,
  `Blood` varchar(30) DEFAULT NULL,
  `RBCu` varchar(30) DEFAULT NULL,
  `WBCu` varchar(30) DEFAULT NULL,
  `Squamus_Epi` varchar(30) DEFAULT NULL,
  `UreaNU` varchar(30) DEFAULT NULL,
  `MicroALB_U` varchar(30) DEFAULT NULL,
  `Creatinine_U` varchar(30) DEFAULT NULL,
  `TP_U` varchar(30) DEFAULT NULL,
  `Alb_Cre_ratio` varchar(30) DEFAULT NULL,
  `TP_U_Cre_ratio` varchar(30) DEFAULT NULL,
  `HOMA_IR` varchar(30) DEFAULT NULL,
  `Insulin_GLU` varchar(30) DEFAULT NULL,
  `Adiponectin` varchar(30) DEFAULT NULL,
  `Leptin` varchar(30) DEFAULT NULL,
  `Vitamin_B12` varchar(30) DEFAULT NULL,
  `Lymphocyte` varchar(30) DEFAULT NULL,
  `Monocyte` varchar(30) DEFAULT NULL,
  `Eosinophil` varchar(30) DEFAULT NULL,
  `Basophil` varchar(30) DEFAULT NULL,
  `Segment` varchar(30) DEFAULT NULL,
  `YEAR` varchar(30) DEFAULT NULL,
  `date_exam` varchar(30) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4
;
# `TotalVitaminD` varchar(30) DEFAULT NULL, 20220802 被拿掉

LOAD DATA LOCAL INFILE 
'D:/Leeyu/JupyterWorkplace/20211229_kaonthu_report/檢驗值匯入Mysql/20221105_report_檢驗值.csv'
INTO TABLE kao_practice_6.CMRC_20221105
CHARACTER SET utf8 FIELDS 
TERMINATED BY ','  
LINES TERMINATED BY '\n' 
IGNORE 1 LINES;

#ALTER TABLE `CMRC_DB_2022_import_work`.`new_CMRC_db_20963_20220310` 
#CHANGE COLUMN `Nitrite` `Nitrite` VARCHAR(30) NULL DEFAULT NULL ,
#CHANGE COLUMN `Urobilinogen` `Urobilinogen` VARCHAR(30) NULL DEFAULT NULL ;

#ALTER TABLE `CMRC_DB_2022_import_work`.`new_CMRC_db_20963_20220310` 
#CHANGE COLUMN `SP_Gravity` `SP_Gravity` VARCHAR(30) NULL DEFAULT NULL ;


UPDATE CMRC_DB_2022_import_work.new_CMRC_db_20963_20220310 as t1
INNER JOIN kao_practice_6.CMRC_20221105 as t2
ON t1.p_id = t2.`病歷號`
SET
t1.`height_y`=t2.`height`,
t1.`weight_y`=t2.`weight`,
t1.`waist_y`=t2.`waist`,
t1.`systolic_y`=t2.`systolic`,
t1.`diastolic_y`=t2.`diastolic`,
t1.`heartbeat_y`=t2.`heartbeat`,
t1.`arm_circumference`=t2.`arm_circumference`,
t1.`calf_circumference`=t2.`calf_circumference`,
t1.`Thigh_circumference`=t2.`Thigh_circumference`,
t1.`Glucose_AC_y`=t2.`Glucose_AC_y`,
t1.`Triglyceride_y`=t2.`Triglyceride_y`,
t1.`HDL_C_y`=t2.`HDL_C_y`,
t1.`WBCb`=t2.`WBCb`,
t1.`RBCb`=t2.`RBCb`,
t1.`Hemoglobin`=t2.`Hemoglobin`,
t1.`Hematocrit`=t2.`Hematocrit`,
t1.`MCV`=t2.`MCV`,
t1.`MCH`=t2.`MCH`,
t1.`MCHC`=t2.`MCHC`,
t1.`RDW`=t2.`RDW`,
t1.`Platelets`=t2.`Platelets`,
t1.`Transferrin`=t2.`Transferrin`,
t1.`Ferritin`=t2.`Ferritin`,
t1.`Folate`=t2.`Folate`,
t1.`AST_GOT`=t2.`AST_GOT`,
t1.`ALT_GPT`=t2.`ALT_GPT`,
t1.`ALK_P`=t2.`ALK_P`,
t1.`Total_Bilirubin`=t2.`Total_Bilirubin`,
t1.`D_Bilirubin`=t2.`D_Bilirubin`,
t1.`gamgt`=t2.`γ-GT`,
t1.`AFP`=t2.`AFP`,
t1.`Insulin`=t2.`Insulin`,
t1.`T_Cholesterol`=t2.`T_Cholesterol`,
t1.`LDL_C_direct`=t2.`LDL_C_direct_`,
t1.`VLDL_C`=t2.`VLDL_C`,
t1.`Non_HDL_C`=t2.`Non_HDL_C`,
t1.`T_CHOL_HDL_C`=t2.`T_CHOL_HDL_C`,
t1.`LDL_C_HDL_C`=t2.`LDL_C_HDL_C`,
t1.`HS_CRP`=t2.`HS_CRP`,
t1.`BUN`=t2.`BUN`,
t1.`Creatinine`=t2.`Creatinine`,
t1.`Estimated_GFR_x`=t2.`Estimated_GFR_x`,
t1.`sodium`=t2.`Na`,
t1.`K`=t2.`K`,
t1.`Cl`=t2.`Cl`,
t1.`CO2`=t2.`CO2`,
t1.`Calcium`=t2.`Calcium`,
t1.`Inorganic_P`=t2.`Inorganic_P`,
t1.`Albumin`=t2.`Albumin`,
t1.`Total_Protein`=t2.`T-Protein(U)`,
t1.`Hb_A1c`=t2.`Hb_A1c`,
t1.`Estimated_AG`=t2.`Estimated_AG`,
t1.`Intact_PTH`=t2.`Intact_PTH`,
t1.`Uric_Acid`=t2.`Uric_Acid_b`,
t1.`HBsAg_x`=t2.`HBsAg_x`,
t1.`RPR`=t2.`RPR`,
t1.`RF`=t2.`RF`,
t1.`H_PYAB_x`=t2.`H_PYAB`,
t1.`Anti_HCV_x`=t2.`Anti_HCV_x`,
t1.`Color`=t2.`Color`,
t1.`Turbidity`=t2.`Turbidity`,
t1.`SP_Gravity`=t2.`SP_Gravity`,
t1.`pH`=t2.`pH`,
t1.`Leukocyte`=t2.`Leukocyte`,
t1.`Nitrite`=t2.`Nitrite`,
t1.`Protein`=t2.`Protein`,
t1.`Glucose`=t2.`Glucose`,
t1.`Ketone`=t2.`Ketone`,
t1.`Urobilinogen`=t2.`Urobilinogen`,
t1.`Bilirubin`=t2.`Bilirubin`,
t1.`octBlood`=t2.`Blood`,
t1.`RBCu`=t2.`RBCu`,
t1.`WBCu`=t2.`WBCu`,
t1.`Squamus_Epi`=t2.`Squamus_Epi`,
t1.`UreaNU`=t2.`UreaNU`,
t1.`MicroALB_U`=t2.`MicroALB_U`,
t1.`Creatinine_U`=t2.`Creatinine_U`,
t1.`TP_U`=t2.`TP_U`,
t1.`Alb_Cre_ratio`=t2.`Alb_Cre_ratio`,
t1.`TP_U_Cre_ratio`=t2.`TP_U_Cre_ratio`,
t1.`HOMA_IR`=t2.`HOMA_IR`,
t1.`Insulin_GLU`=t2.`Insulin_GLU`,
t1.`Adiponectin`=t2.`Adiponectin`,
t1.`Leptin`=t2.`Leptin`,
t1.`Vitamin_B12`=t2.`Vitamin_B12`,
t1.`Lymphocyte`=t2.`Lymphocyte`,
t1.`Monocyte`=t2.`Monocyte`,
t1.`Eosinophil`=t2.`Eosinophil`,
t1.`Basophil`=t2.`Basophil`,
t1.`Segment`=t2.`Segment`,
t1.`year_come`=t2.`YEAR`
WHERE t1.data_exam = 20221105;

#t1.`TotalVitaminD`=t2.`TotalVitaminD`, 20220802被拿掉

SELECT sid
FROM CMRC_DB_2022_import_work.new_CMRC_db_20963_20220310
WHERE length(sid) >= 12;

UPDATE CMRC_DB_2022_import_work.new_CMRC_db_20963_20220310
SET sid = replace(sid,202208200,20220820)
WHERE length(sid) >= 12; 

UPDATE CMRC_DB_2022_import_work.new_CMRC_db_20963_20220310
SET sid = replace(sid,202208130,20220813)
WHERE length(sid) >= 12; 

UPDATE CMRC_DB_2022_import_work.new_CMRC_db_20963_20220310
SET sid = replace(sid,202208270,20220827)
WHERE length(sid) >= 12; 

ALTER TABLE `CMRC_DB_2022_import_work`.`new_CMRC_db_20963_desc_20220310` 
CHANGE COLUMN `SP_Gravity` `SP_Gravity` VARCHAR(30) NULL DEFAULT NULL ;

INSERT INTO CMRC_DB_2022_import_work.new_CMRC_db_20963_desc_20220310 
SELECT * FROM CMRC_DB_2022_import_work.new_CMRC_db_20963_20220310
ORDER BY data_exam DESC; #反過來排序alter 要先truncate

SELECT sid, n_1, p_id, sex, birth, age, height_y, weight_y, waist_y, systolic_y, diastolic_y, heartbeat_y, arm_circumference, calf_circumference, Thigh_circumference, Glucose_AC_y, Triglyceride_y, HDL_C_y, WBCb, RBCb,
    Hemoglobin, Hematocrit, MCV, MCH, MCHC, RDW, Platelets, Transferrin, Ferritin, Folate, AST_GOT, ALT_GPT, ALK_P, Total_Bilirubin, D_Bilirubin, gamgt, AFP, Insulin, T_Cholesterol, LDL_C_direct, VLDL_C, Non_HDL_C, T_CHOL_HDL_C, LDL_C_HDL_C, HS_CRP,
    BUN, Creatinine, Estimated_GFR_x, sodium, K, Cl, CO2, Calcium, Inorganic_P, Albumin, Total_Protein, Hb_A1c, Estimated_AG, Intact_PTH, Uric_Acid, HBsAg_x, RPR, RF, H_PYAB_x, Anti_HCV_x, Color, Turbidity, SP_Gravity, pH, Leukocyte, Nitrite, Protein,
    Glucose, Ketone, Urobilinogen, Bilirubin, octBlood, RBCu, WBCu, Squamus_Epi, UreaNU, MicroALB_U, Creatinine_U, TP_U, Alb_Cre_ratio, TP_U_Cre_ratio, HOMA_IR, Insulin_GLU, Adiponectin, Leptin, TotalVitaminD, Vitamin_B12, Lymphocyte, Monocyte,
    Eosinophil, Basophil, Segment, year_come
    FROM CMRC_DB_2022_import_work.new_CMRC_db_20963_desc_20220310
	WHERE data_exam >= 20221105 ;
    
    SELECT sid, n_1, p_id, sex, birth, Leukocyte, Nitrite, Protein,
    Glucose, Ketone, Urobilinogen, Bilirubin, octBlood, RBCu, WBCu, Squamus_Epi, UreaNU, MicroALB_U, Creatinine_U, TP_U, Alb_Cre_ratio, TP_U_Cre_ratio, HOMA_IR, Insulin_GLU, Adiponectin, Leptin, TotalVitaminD, Vitamin_B12, Lymphocyte, Monocyte,
    Eosinophil, Basophil, Segment, year_come
    FROM CMRC_DB_2022_import_work.new_CMRC_db_20963_desc_20220310
	WHERE data_exam >= 20220300 ;
    
	SELECT sid, n_1, p_id, sex, birth, Leukocyte, Nitrite, Protein,
    Glucose, Ketone, Urobilinogen, Bilirubin, octBlood, RBCu, WBCu, Squamus_Epi, UreaNU, MicroALB_U, Creatinine_U, TP_U, Alb_Cre_ratio, TP_U_Cre_ratio, HOMA_IR, Insulin_GLU, Adiponectin, Leptin, TotalVitaminD, Vitamin_B12, Lymphocyte, Monocyte,
    Eosinophil, Basophil, Segment, year_come
    FROM CMRC_DB_2022_import_work.new_CMRC_db_20963_desc_20220310
	WHERE data_exam >= 20200000 AND data_exam <= 20210000 ;
    
    
    