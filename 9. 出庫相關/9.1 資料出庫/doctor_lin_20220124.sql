SELECT * FROM CMRC_DB_kaonthu.doctor_lin_20220124;

SELECT b.* 
FROM CMRC_DB_kaonthu.doctor_lin_20220124 AS a
INNER JOIN new_CMRC_db_20963_desc_20220105 AS b
ON a.pid = b.p_id;

SELECT sex FROM new_CMRC_db_20963_desc_20220105;

SELECT * 
FROM CMRC_all_persontimes_20220110_kaonthu 
WHERE p_id IN ("4006670");


SELECT * 
FROM CMRC_DB.CMRC_all_persontimes_20210907
WHERE p_id IN ("4006670");

SELECT * 
FROM CMRC_DB.CMRC_all_persontimes_20210907
WHERE CMRC_id IN ("V42015S90411F7017");

SELECT a.pid AS PI,b.* 
FROM CMRC_DB_kaonthu.doctor_lin_20220124 AS a
LEFT JOIN new_CMRC_db_20963_desc_20220105 AS b
ON a.cmrc_id = b.cmrc_id
GROUP BY p_id;

SELECT T1.*,
T2.BMI,T2.egfrn,T2.CKD_determine,T2.DM_determine,T2.w,T2.hyper,T2.fg,T2.HDL,T2.trig,T2.sarcf,
T2.RAND36_PF,T2.RAND36_RP,T2.RAND36_RE,T2.RAND36_EF,T2.RAND36_EWB,T2.RAND36_SF,T2.RAND36_BP,
T2.RAND36_GH,T2.mst,T2.ms2,T2.AGG_PHYS1,T2.PSY_PHYS1,
T2.Anxiety,T2.Depresscore,T2.HAD,T2.TDQ,T2.AD8,T2.PSQI,T2.AUDIT,T2.R
FROM
(SELECT b.* 
FROM CMRC_DB_kaonthu.doctor_lin_20220124 AS a
LEFT JOIN new_CMRC_db_20963_desc_20220105 AS b
ON a.cmrc_id = b.cmrc_id ) AS T1
LEFT JOIN 
new_CMRC_db_20963_Scale_Total_20220105 AS T2 
ON T1.sid = T2.sid 
GROUP BY p_id;

SELECT T1.*,
T2.BMI,T2.egfrn,T2.CKD_determine,T2.DM_determine,T2.w,T2.hyper,T2.fg,T2.HDL,T2.trig,T2.sarcf,
T2.RAND36_PF,T2.RAND36_RP,T2.RAND36_RE,T2.RAND36_EF,T2.RAND36_EWB,T2.RAND36_SF,T2.RAND36_BP,
T2.RAND36_GH,T2.mst,T2.ms2,T2.AGG_PHYS1,T2.PSY_PHYS1,
T2.Anxiety,T2.Depresscore,T2.HAD,T2.TDQ,T2.AD8,T2.PSQI,T2.AUDIT,T2.R
FROM
(SELECT b.* 
FROM CMRC_DB_kaonthu.doctor_lin_20220124 AS a
LEFT JOIN new_CMRC_db_20963_desc_20220105 AS b
ON a.cmrc_id = b.cmrc_id ) AS T1
LEFT JOIN 
new_CMRC_db_20963_Scale_Total_20220105 AS T2 
ON T1.sid = T2.sid ;


SELECT T1.*,
T2.BMI,T2.egfrn,T2.CKD_determine,T2.DM_determine,T2.w,T2.hyper,T2.fg,T2.HDL,T2.trig,T2.sarcf,
T2.RAND36_PF,T2.RAND36_RP,T2.RAND36_RE,T2.RAND36_EF,T2.RAND36_EWB,T2.RAND36_SF,T2.RAND36_BP,
T2.RAND36_GH,T2.mst,T2.ms2,T2.AGG_PHYS1,T2.PSY_PHYS1,
T2.Anxiety,T2.Depresscore,T2.HAD,T2.TDQ,T2.AD8,T2.PSQI,T2.AUDIT,T2.R,T2.HBV_,T2.HCV_
FROM
(SELECT b.* 
FROM CMRC_DB_kaonthu.doctor_lin_20220124 AS a
LEFT JOIN new_CMRC_db_20963_desc_20220105 AS b
ON a.cmrc_id = b.cmrc_id ) AS T1
INNER JOIN 
new_CMRC_db_20963_Scale_Total_20220105 AS T2 
ON T1.sid = T2.sid ;


SELECT U1.*,U2.back_ver,U2.back_yes,U2.new_ver,U2.new_yes
FROM 
(
SELECT T1.*,
T2.BMI,T2.egfrn,T2.CKD_determine,T2.DM_determine,T2.w,T2.hyper,T2.fg,T2.HDL,T2.trig,T2.sarcf,
T2.RAND36_PF,T2.RAND36_RP,T2.RAND36_RE,T2.RAND36_EF,T2.RAND36_EWB,T2.RAND36_SF,T2.RAND36_BP,
T2.RAND36_GH,T2.mst,T2.ms2,T2.AGG_PHYS1,T2.PSY_PHYS1,
T2.Anxiety,T2.Depresscore,T2.HAD,T2.TDQ,T2.AD8,T2.PSQI,T2.AUDIT,T2.R,T2.HBV_,T2.HCV_
FROM
(SELECT b.* 
FROM CMRC_DB_kaonthu.doctor_lin_20220124 AS a
LEFT JOIN new_CMRC_db_20963_desc_20220105 AS b
ON a.cmrc_id = b.cmrc_id ) AS T1
INNER JOIN 
new_CMRC_db_20963_Scale_Total_20220105 AS T2 
ON T1.sid = T2.sid ) AS U1
INNER JOIN CMRC_DB_kaonthu.CMRC_all_persontimes_last_kaonthu_back_new_DNA_TMPI_生資 AS U2
ON U1.p_id = U2.p_id
GROUP BY p_id ;

#######################################################

SELECT U1.*,U2.back_ver,U2.back_yes,U2.new_ver,U2.new_yes
FROM 
(
SELECT T1.*,
T2.BMI,T2.egfrn,T2.CKD_determine,T2.DM_determine,T2.w,T2.hyper,T2.fg,T2.HDL,T2.trig,T2.sarcf,
T2.RAND36_PF,T2.RAND36_RP,T2.RAND36_RE,T2.RAND36_EF,T2.RAND36_EWB,T2.RAND36_SF,T2.RAND36_BP,
T2.RAND36_GH,T2.mst,T2.ms2,T2.AGG_PHYS1,T2.PSY_PHYS1,
T2.Anxiety,T2.Depresscore,T2.HAD,T2.TDQ,T2.AD8,T2.PSQI,T2.AUDIT,T2.R,T2.HBV_,T2.HCV_
FROM
(SELECT b.* 
FROM CMRC_DB_kaonthu.doctor_lin_20220124 AS a
LEFT JOIN new_CMRC_db_20963_desc_20220105 AS b
ON a.cmrc_id = b.cmrc_id ) AS T1
INNER JOIN 
new_CMRC_db_20963_Scale_Total_20220105 AS T2 
ON T1.sid = T2.sid ) AS U1
INNER JOIN CMRC_DB_kaonthu.CMRC_all_persontimes_last_kaonthu_back_new_DNA_TMPI_生資 AS U2
ON U1.p_id = U2.p_id
ORDER BY U1.p_id ; #All_370_his_20220130

#########################################################

SELECT U1.*,U2.back_ver,U2.back_yes,U2.new_ver,U2.new_yes
FROM 
(
SELECT T1.*,
T2.BMI,T2.egfrn,T2.CKD_determine,T2.DM_determine,T2.w,T2.hyper,T2.fg,T2.HDL,T2.trig,T2.sarcf,
T2.RAND36_PF,T2.RAND36_RP,T2.RAND36_RE,T2.RAND36_EF,T2.RAND36_EWB,T2.RAND36_SF,T2.RAND36_BP,
T2.RAND36_GH,T2.mst,T2.ms2,T2.AGG_PHYS1,T2.PSY_PHYS1,
T2.Anxiety,T2.Depresscore,T2.HAD,T2.TDQ,T2.AD8,T2.PSQI,T2.AUDIT,T2.R,T2.HBV_,T2.HCV_
FROM
(SELECT b.* 
FROM CMRC_DB_kaonthu.doctor_lin_20220124 AS a
LEFT JOIN new_CMRC_db_20963_desc_20220105 AS b
ON a.cmrc_id = b.cmrc_id 
GROUP BY p_id) AS T1
INNER JOIN 
new_CMRC_db_20963_Scale_Total_20220105 AS T2 
ON T1.sid = T2.sid ) AS U1
INNER JOIN CMRC_DB_kaonthu.CMRC_all_persontimes_last_kaonthu_back_new_DNA_TMPI_生資 AS U2
ON U1.p_id = U2.p_id
ORDER BY U1.p_id ; #All_370_his_20220130
