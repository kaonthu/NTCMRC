SELECT sid,P_Number,n_1,p_id,birth,data_exam,CMRC_id,New_CMRC_id,sex,age,data_year,year_come,AUDIT,
d2_drink,d2_drinkt,d2_drinkav,d2_drinkday,d2_drinkcat,d2_drinknote,d2_drinkvol,past2_drinkav,past2_drinkday,
past2_drink,past2_drinkcat,past2_drinknote,past2_drinkvol,past1_drink,d2_drinks,drink_k1,drink_k2,drink_k3,
drink_k4,drink_k5,drink_k6,drink_k7,drink_k7_o,drink_k7_1,drink_k7_2,drink_k7_3,drink_k7_4,drink_k7_5,drink_k7_6,
drink_t,drink_q,drink_qt1,drink_qt2,drink_red,B_1_1,B_1_2,B_1_3,B_1_4,B_1_5,B_1_6,B_1_7,B_1_8,B_1_9,B_1_10,B_2_1,
B_2_2,B_2_3,B_2_4,check13
FROM new_CMRC_db_testing_question_scalebigtable_20220128;

SELECT sid,P_Number,n_1,p_id,birth,data_exam,CMRC_id,New_CMRC_id,sex,age,data_year,year_come,AUDIT,
B_1_1,B_1_2,B_1_3,B_1_4,B_1_5,B_1_6,B_1_7,B_1_8,B_1_9,B_1_10,B_2_1,B_2_2,B_2_3,B_2_4,check13
FROM new_CMRC_db_testing_question_scalebigtable_20220128
WHERE data_exam >= 20190930 AND data_exam <= 20211001
GROUP BY p_id; #2365

SELECT sid,P_Number,n_1,p_id,birth,data_exam,CMRC_id,New_CMRC_id,sex,age,data_year,year_come,AUDIT,
B_1_1,B_1_2,B_1_3,B_1_4,B_1_5,B_1_6,B_1_7,B_1_8,B_1_9,B_1_10,B_2_1,B_2_2,B_2_3,B_2_4,check13
FROM new_CMRC_db_testing_question_scalebigtable_20220128
WHERE data_exam >= 20190930 AND data_exam <= 20211001 AND AUDIT >= 0
GROUP BY p_id; #2131

SELECT sid,P_Number,n_1,p_id,birth,data_exam,CMRC_id,New_CMRC_id,sex,age,data_year,year_come,AUDIT,
B_1_1,B_1_2,B_1_3,B_1_4,B_1_5,B_1_6,B_1_7,B_1_8,B_1_9,B_1_10,B_2_1,B_2_2,B_2_3,B_2_4,check13
FROM new_CMRC_db_testing_question_scalebigtable_20220128
WHERE data_exam >= 20190930 AND data_exam <= 20211001 AND AUDIT >= 1
GROUP BY p_id; #1098

SELECT sid,P_Number,n_1,p_id,birth,data_exam,CMRC_id,New_CMRC_id,sex,age,data_year,year_come,AUDIT,
B_1_1,B_1_2,B_1_3,B_1_4,B_1_5,B_1_6,B_1_7,B_1_8,B_1_9,B_1_10,B_2_1,B_2_2,B_2_3,B_2_4,check13
FROM new_CMRC_db_testing_question_scalebigtable_20220128
WHERE data_exam >= 20190930 AND data_exam <= 20211001 AND AUDIT >= 8
GROUP BY p_id; #19

##################################################################################

SELECT sid,P_Number,n_1,p_id,birth,data_exam,CMRC_id,New_CMRC_id,sex,age,data_year,year_come,AUDIT,
B_1_1,B_1_2,B_1_3,B_1_4,B_1_5,B_1_6,B_1_7,B_1_8,B_1_9,B_1_10,B_2_1,B_2_2,B_2_3,B_2_4,check13
FROM new_CMRC_db_testing_question_scalebigtable_20220128
WHERE data_exam >= 20190930 AND data_exam <= 20211001 AND year_come = 1
GROUP BY p_id; #2365

SELECT sid,P_Number,n_1,p_id,birth,data_exam,CMRC_id,New_CMRC_id,sex,age,data_year,year_come,AUDIT,
B_1_1,B_1_2,B_1_3,B_1_4,B_1_5,B_1_6,B_1_7,B_1_8,B_1_9,B_1_10,B_2_1,B_2_2,B_2_3,B_2_4,check13
FROM new_CMRC_db_testing_question_scalebigtable_20220128
WHERE data_exam >= 20190930 AND data_exam <= 20211001 AND AUDIT >= 0 AND year_come = 1
GROUP BY p_id; #2131

SELECT sid,P_Number,n_1,p_id,birth,data_exam,CMRC_id,New_CMRC_id,sex,age,data_year,year_come,AUDIT,
B_1_1,B_1_2,B_1_3,B_1_4,B_1_5,B_1_6,B_1_7,B_1_8,B_1_9,B_1_10,B_2_1,B_2_2,B_2_3,B_2_4,check13
FROM new_CMRC_db_testing_question_scalebigtable_20220128
WHERE data_exam >= 20190930 AND data_exam <= 20211001 AND AUDIT >= 1 AND year_come = 1
GROUP BY p_id; #1098

SELECT sid,P_Number,n_1,p_id,birth,data_exam,CMRC_id,New_CMRC_id,sex,age,data_year,year_come,AUDIT,
B_1_1,B_1_2,B_1_3,B_1_4,B_1_5,B_1_6,B_1_7,B_1_8,B_1_9,B_1_10,B_2_1,B_2_2,B_2_3,B_2_4,check13
FROM new_CMRC_db_testing_question_scalebigtable_20220128
WHERE data_exam >= 20190930 AND data_exam <= 20211001 AND AUDIT >= 8 AND year_come = 1
GROUP BY p_id; #19

######################################################

SELECT sid,P_Number,n_1,p_id,birth,data_exam,CMRC_id,New_CMRC_id,sex,age,data_year,year_come,AUDIT,
B_1_1,B_1_2,B_1_3,B_1_4,B_1_5,B_1_6,B_1_7,B_1_8,B_1_9,B_1_10,B_2_1,B_2_2,B_2_3,B_2_4,check13
FROM new_CMRC_db_testing_question_scalebigtable_20220128
WHERE data_exam >= 20190930 AND AUDIT >= 8
GROUP BY p_id; #134人

SELECT sid,P_Number,n_1,p_id,birth,data_exam,CMRC_id,New_CMRC_id,sex,age,data_year,year_come,AUDIT,
B_1_1,B_1_2,B_1_3,B_1_4,B_1_5,B_1_6,B_1_7,B_1_8,B_1_9,B_1_10,check13
FROM new_CMRC_db_testing_question_scalebigtable_20220128
WHERE data_exam >= 20190930 AND data_exam <= 20211001 AND AUDIT >= 8
GROUP BY p_id; #119人

SELECT sid,P_Number,n_1,p_id,birth,data_exam,CMRC_id,New_CMRC_id,sex,age,data_year,year_come,AUDIT,
B_1_1,B_1_2,B_1_3,B_1_4,B_1_5,B_1_6,B_1_7,B_1_8,B_1_9,B_1_10,B_2_1,B_2_2,B_2_3,B_2_4,check13
FROM new_CMRC_db_testing_question_scalebigtable_20220128
WHERE data_exam >= 20190930 AND data_exam <= 20211001 AND AUDIT >= 8 AND year_come = 1
GROUP BY p_id; #38

SELECT sid,P_Number,n_1,p_id,birth,data_exam,CMRC_id,New_CMRC_id,sex,age,data_year,year_come,AUDIT,
B_1_1,B_1_2,B_1_3,B_1_4,B_1_5,B_1_6,B_1_7,B_1_8,B_1_9,B_1_10,B_2_1,B_2_2,B_2_3,B_2_4,check13
FROM new_CMRC_db_testing_question_scalebigtable_20220128
WHERE data_exam >= 20190930 AND AUDIT >= 8 AND year_come = 1
GROUP BY p_id; #40

#########################################################

SELECT a.*,b.location
FROM
(SELECT birth,data_exam,New_CMRC_id,sex,age,data_year,year_come,
height_y,weight_y,waist_y,systolic_y,diastolic_y,heartbeat_y,arm_circumference,calf_circumference,Thigh_circumference,
AUDIT,B_1_1,B_1_2,B_1_3,B_1_4,B_1_5,B_1_6,B_1_7,B_1_8,B_1_9,B_1_10,check13
FROM new_CMRC_db_testing_question_scalebigtable_20220128
WHERE data_exam >= 20190930 AND data_exam <= 20211001 AND AUDIT >= 8
GROUP BY p_id) as a
INNER JOIN CMRC_DB_kaonthu.CMRC_all_persontimes_20220110_kaonthu_desc as b
ON a.New_CMRC_id = b.New_CMRC_id and a.data_exam = b.data_exam
ORDER BY year_come; #119人

############################################################

SELECT sid,P_Number,n_1,p_id,birth,data_exam,CMRC_id,New_CMRC_id,sex,age,data_year,year_come,AUDIT,
B_1_1,B_1_2,B_1_3,B_1_4,B_1_5,B_1_6,B_1_7,B_1_8,B_1_9,B_1_10,check13
FROM new_CMRC_db_testing_question_scalebigtable_20220128
WHERE data_exam >= 20190930 AND data_exam <= 20211001 AND AUDIT >= 8
GROUP BY p_id; #119人

SELECT p_id,SNP_OB,WES,WGS,SNP_LIN,GWAS_alco,GWAS_YE,SNP,GWAS,DNA_total 
FROM kao_practice_3.new_CMRC_db_7636_desc_20210906
WHERE SNP = 1;


SELECT a.p_id,a.birth,a.data_exam,a.data_year,a.year_come,a.AUDIT,
b.p_id,b.SNP_OB,b.SNP_LIN,b.SNP,b.DNA_total
FROM( SELECT * FROM new_CMRC_db_testing_question_scalebigtable_20220128 
WHERE data_exam >= 20190930 AND data_exam <= 20211001 AND AUDIT >= 8
GROUP BY p_id) as a
INNER JOIN 
(SELECT * 
FROM kao_practice_3.new_CMRC_db_7636_desc_20210906
WHERE SNP = 0) as b
ON a.p_id = b.p_id ; #119人


SELECT sid,P_Number,n_1,p_id,birth,data_exam,CMRC_id,New_CMRC_id,sex,age,data_year,year_come,AUDIT,
B_1_1,B_1_2,B_1_3,B_1_4,B_1_5,B_1_6,B_1_7,B_1_8,B_1_9,B_1_10,check13
FROM new_CMRC_db_testing_question_scalebigtable_20220128
WHERE data_exam >= 20190930 AND data_exam <= 20211001 AND AUDIT >= 8
AND p_id not IN (SELECT p_id
FROM kao_practice_3.new_CMRC_db_7636_desc_20210906
WHERE SNP = 1)
GROUP BY p_id; #119人

SELECT sid,P_Number,n_1,p_id,birth,data_exam,CMRC_id,New_CMRC_id,sex,age,data_year,year_come,AUDIT,
B_1_1,B_1_2,B_1_3,B_1_4,B_1_5,B_1_6,B_1_7,B_1_8,B_1_9,B_1_10,check13
FROM new_CMRC_db_testing_question_scalebigtable_20220128
WHERE data_exam >= 20190930 AND data_exam <= 20211001 AND AUDIT >= 8
AND p_id not IN (SELECT p_id
FROM kao_practice_3.new_CMRC_db_7636_desc_20210906
WHERE SNP_OB = 1)
GROUP BY p_id; #119人

SELECT sid,P_Number,n_1,p_id,birth,data_exam,CMRC_id,New_CMRC_id,sex,age,data_year,year_come,AUDIT,
B_1_1,B_1_2,B_1_3,B_1_4,B_1_5,B_1_6,B_1_7,B_1_8,B_1_9,B_1_10,check13
FROM new_CMRC_db_testing_question_scalebigtable_20220128
WHERE data_exam >= 20190930 AND data_exam <= 20211001 AND AUDIT >= 8
AND p_id not IN (SELECT p_id
FROM kao_practice_3.new_CMRC_db_7636_desc_20210906
WHERE SNP_LIN = 1)
GROUP BY p_id; #119人

##########################################################################

SELECT sid,P_Number,n_1,p_id,birth,data_exam,CMRC_id,New_CMRC_id,sex,age,data_year,year_come,AUDIT,
height_y,weight_y,waist_y,systolic_y,diastolic_y,heartbeat_y,arm_circumference,calf_circumference,Thigh_circumference,
B_1_1,B_1_2,B_1_3,B_1_4,B_1_5,B_1_6,B_1_7,B_1_8,B_1_9,B_1_10,check13
FROM new_CMRC_db_testing_question_scalebigtable_20220128
WHERE data_exam >= 20190930 AND data_exam <= 20211001 AND AUDIT >= 8
AND p_id not IN (SELECT p_id
FROM kao_practice_3.new_CMRC_db_7636_desc_20210906
WHERE SNP = 1)
GROUP BY p_id; #83人 扣除snp 的人

##########################################################################

SELECT sid,P_Number,n_1,p_id,if(left(sid,1)="M","門診","社區") as `收案方式`,birth,data_exam,CMRC_id,New_CMRC_id,sex,age,data_year,year_come,AUDIT,
height_y,weight_y,waist_y,systolic_y,diastolic_y,heartbeat_y,arm_circumference,calf_circumference,Thigh_circumference,
B_1_1,B_1_2,B_1_3,B_1_4,B_1_5,B_1_6,B_1_7,B_1_8,B_1_9,B_1_10,check13
FROM CMRC_DB_kaonthu.new_CMRC_db_testing_question_scalebigtable_20220128
WHERE data_exam >= 20190930 AND data_exam <= 20211001 
AND p_id not IN (SELECT p_id
FROM kao_practice_3.new_CMRC_db_7636_desc_20210906
WHERE SNP = 1)
AND AUDIT >= 0
GROUP BY p_id; #83人 扣除snp 的人
