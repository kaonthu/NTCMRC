CREATE VIEW kao_practice_6.Scale_connect1_new_CMRC_db_20963_desc 
AS 
(
SELECT sid,n_1,CMRC_id,p_id,sex,birth,age,weight_y,height_y,
ROUND(weight_y/POWER(height_y/100,2),2) AS BMI,
Creatinine,protein,Alb_Cre_ratio,TP_U_Cre_ratio,dm_drug,hyper_drug,lipiddrug,


ROUND(IF(sex=0, 
		175*POWER(Creatinine, -1.154)* POWER(age,-0.203)*0.742, 
		175*POWER(Creatinine, -1.154)*POWER(age,-0.203)*1), 2)
		AS egfrn,
        
	IF(	( IF(sex=0, 
		175*POWER(Creatinine, -1.154)* POWER(age,-0.203)*0.742, 
		175*POWER(Creatinine, -1.154)*POWER(age,-0.203)*1) < 60)
		OR (protein REGEXP '[+]' OR Alb_Cre_ratio>=30 OR TP_U_Cre_ratio>=150)
			,1,0) AS CKD_determine ,
            
	IF((glucose_ac_y >= 126) OR (Hb_A1c >= 6.5) OR (diabetes = 1) OR (dm_drug = 1), 1, 0) AS DM_determine,
    IF(HBsAg_x regexp '陽性|^Reactive',1,IF((HBsAg_x regexp '陰性|^nonreactive|Nonreact'),0,NULL)) as HBV_,
    IF(Anti_HCV_x regexp '陽性|^Reactive',1,IF((Anti_HCV_x regexp '陰性|^nonreactive|Nonreact'),0,NULL)) as HCV_,
		IF((sex=0 AND waist_y >= 80) OR (sex=1 AND waist_y >= 90),1,0) AS w,
		IF((systolic_y >= 130) OR (diastolic_y >= 85), 1, 0) AS hyper,
		IF(glucose_ac_y >= 100, 1, 0) AS fg,
		IF((sex=0 AND HDL_c_y < 50) OR (sex=1 AND HDL_c_y < 40), 1, 0) AS HDL,
		IF(triglyceride_y >= 150, 1, 0) AS trig,
        
	sarcf_1+sarcf_2+sarcf_3+sarcf_4+sarcf_5 AS sarcf,
    
	IF (`sf36_3_a` IN (1,2,3)
			AND `sf36_3_b` IN (1,2,3)
			AND `sf36_3_c` IN (1,2,3)
			AND `sf36_3_d` IN (1,2,3)
			AND `sf36_3_e` IN (1,2,3)
			AND `sf36_3_f` IN (1,2,3)
			AND `sf36_3_g` IN (1,2,3)
			AND `sf36_3_h` IN (1,2,3)
			AND `sf36_3_i` IN (1,2,3)
			AND `sf36_3_j` IN (1,2,3),
		(`sf36_3_a`
			+`sf36_3_b`
			+`sf36_3_c`
			+`sf36_3_d`
			+`sf36_3_e`
			+`sf36_3_f`
			+`sf36_3_g`
			+`sf36_3_h`
			+`sf36_3_i`
			+`sf36_3_j`
			- 10) * 5, 
		NULL) AS RAND36_PF,
	IF (`sf36_4_a` IN (1,2)
			AND `sf36_4_b` IN (1,2)
			AND `sf36_4_c` IN (1,2)
			AND `sf36_4_d` IN (1,2),
		(`sf36_4_a`
			+`sf36_4_b`
			+`sf36_4_c`
			+`sf36_4_d`
			- 4) * 25,
			NULL) AS RAND36_RP,
	IF (`sf36_5_a` IN (1,2)
			AND `sf36_5_b` IN (1,2)
			AND `sf36_5_c` IN (1,2),
		ROUND((`sf36_5_a`
			+`sf36_5_b`
			+`sf36_5_c`
			- 3) * 100/3, 1),
			NULL) AS RAND36_RE,
	IF (`sf36_9_a` IN (1,2,3,4,5,6)
			AND `sf36_9_e` IN (1,2,3,4,5,6)
			AND `sf36_9_g` IN (1,2,3,4,5,6)
			AND `sf36_9_i` IN (1,2,3,4,5,6),
		((7-`sf36_9_a`)
			+(7-`sf36_9_e`)
			+`sf36_9_g`
			+`sf36_9_i`
			- 4) * 5,
			NULL) AS RAND36_EF,
	IF (`sf36_9_b` IN (1,2,3,4,5,6)
			AND `sf36_9_c` IN (1,2,3,4,5,6)
			AND `sf36_9_f` IN (1,2,3,4,5,6)
			AND `sf36_9_d` IN (1,2,3,4,5,6)
			AND `sf36_9_h` IN (1,2,3,4,5,6),
		(`sf36_9_b`
			+`sf36_9_c`
			+`sf36_9_f`
			+(7-`sf36_9_d`)
			+(7-`sf36_9_h`)
			- 5) * 4,
			NULL) AS RAND36_EWB,
	IF (`sf36_6` IN (1,2,3,4,5,6)
			AND `sf36_10` IN (1,2,3,4,5),
		((6-`sf36_6`)
			+`sf36_10`
			-2)*12.5,
			NULL) AS RAND36_SF,
	IF (`sf36_7` IN (1,2,3,4,5)
			AND `sf36_8` IN (1,2,3,4,5),
		(((7-`sf36_7`-1)*20)
			+((6-`sf36_8`-1)*25))/2,
			NULL) AS RAND36_BP,
	IF (`SF36_1` IN (1,2,3,4,5)
			AND `sf36_11_b` IN (1,2,3,4,5)
			AND `sf36_11_d` IN (1,2,3,4,5)
			AND `sf36_11_a` IN (1,2,3,4,5)
			AND `sf36_11_c` IN (1,2,3,4,5),
		((6- `SF36_1`)
			+(6- `sf36_11_b`)
			+(6- `sf36_11_d`)
			+`sf36_11_a`
			+`sf36_11_c`
			-5)*5,
			NULL) AS RAND36_GH,
            mna_1+mna_2+mna_3+mna_4+mna_5+
IF(ROUND((weight_y / POW((height_y / 100),2)),2)<19,0,
IF(ROUND((weight_y / POW((height_y / 100),2)),2)<21,1,
IF(ROUND((weight_y / POW((height_y / 100),2)),2)<23,2,3))) AS MNA_part1,
mna_6+mna_7+mna_8+mna_9+`mna_10`/2+mna_11+`mna_12`/2+mna_13+mna_14+IF(mna_15<=2,`mna_15`/2,2)
+IF(arm_circumference<21,0,IF(arm_circumference<22,0.5,1))+IF(calf_circumference<31,0,1)
 AS MNA_part2,
IF(ecog12b1=9,0,ecog12b1)+IF(ecog12b2=9,0,ecog12b2)+IF(ecog12b3=9,0,ecog12b3)+IF(ecog12b4=9,0,ecog12b4)+
IF(ecog12b5=9,0,ecog12b5)+IF(ecog12b6=9,0,ecog12b6)+IF(ecog12b7=9,0,ecog12b7)+IF(ecog12b8=9,0,ecog12b8)+
IF(ecog12b9=9,0,ecog12b9)+IF(ecog12b10=9,0,ecog12b10)+IF(ecog12b11=9,0,ecog12b11)+IF(ecog12b12=9,0,ecog12b12) AS ECOG_sum,
12-(IF(ecog12b1=9,1,0)+IF(ecog12b2=9,1,0)+IF(ecog12b3=9,1,0)+IF(ecog12b4=9,1,0)+IF(ecog12b5=9,1,0)+IF(ecog12b6=9,1,0)+
IF(ecog12b7=9,1,0)+IF(ecog12b8=9,1,0)+IF(ecog12b9=9,1,0)+IF(ecog12b10=9,1,0)+IF(ecog12b11=9,1,0)+IF(ecog12b12=9,1,0)) AS ECOG_9
 FROM CMRC_DB_kaonthu.new_CMRC_db_20963_desc_20220105 );
 
 #20220303新增 MNA & ECOG 量表 SCALE 
 
 
CREATE VIEW kao_practice_6.Scale_connect2_Scale_connect1
AS 
SELECT *,
w+hyper+fg+HDL+trig AS mst,
IF(w+hyper+fg+HDL+trig >= 3, 1,0) AS ms2,
ROUND(((RAND36_PF - 82.96845) / 23.83795)*0.42402
	+((RAND36_RP - 77.93107) / 35.34865)*0.35119
	+((RAND36_BP - 70.22865) / 23.35310)*0.31754
	+((RAND36_GH - 70.10060) / 21.35900)*0.24954
	+((RAND36_EF - 56.99917) / 21.12677)*0.02877
	+((RAND36_SF - 83.56494) / 23.02758)*-0.00753
	+((RAND36_RE - 83.10276) / 31.64149)*-0.19206
	+((RAND36_EWB - 75.21913) / 17.60698)*0.22069, 2) AS AGG_PHYS1,
	ROUND(((RAND36_PF - 82.96845) / 23.83795)*-0.22999
	+((RAND36_RP - 77.93107) / 35.34865)*-0.12329
	+((RAND36_BP - 70.22865) / 23.35310)*-0.09731
	+((RAND36_GH - 70.10060) / 21.35900)*0.01571
	+((RAND36_EF - 56.99917) / 21.12677)*0.23534
	+((RAND36_SF - 83.56494) / 23.02758)*0.26876
	+((RAND36_RE - 83.10276) / 31.64149)*0.43407
	+((RAND36_EWB - 75.21913) / 17.60698)*0.48581, 2) AS PSY_PHYS1,
	MNA_part1+MNA_part2 AS MNA,
	ROUND(ECOG_sum/ECOG_9,4) AS ECOG
FROM kao_practice_6.Scale_connect1_new_CMRC_db_20963_desc;

CREATE VIEW CMRC_DB_kaonthu.new_CMRC_db_20963_Scale_Total_20220105
AS SELECT a.row_names,b.*,a.Anxiety,a.Depression as Depresscore,a.HAD,a.TDQ,a.AD8,a.PSQI,a.AUDIT,a.R
FROM 
CMRC_DB_kaonthu.new_CMRC_db_20963_Scale_desc_20220105_R AS a
INNER JOIN 
kao_practice_6.Scale_connect2_Scale_connect1 AS b
ON a.sid = b.sid;

SELECT a.sid,a.CKD,b.CKD,a.CKD-b.CKD,
a.egfrn,b.egfrn,a.egfrn-b.egfrn,
a.DM,b.DM,a.DM-b.DM
FROM 
kao_practice_3.new_CMRC_db_20526_Scale_20211127_New AS a
INNER JOIN
CMRC_DB_kaonthu.new_CMRC_db_20963_Scale_Total_20220105_R AS b 
ON a.sid = b.sid;
#有檢查過了跟之前算的一樣