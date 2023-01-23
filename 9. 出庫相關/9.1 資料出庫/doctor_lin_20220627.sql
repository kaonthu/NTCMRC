CREATE TEMPORARY TABLE CMRC_DB_kaonthu_work.doctor_ye_20220627_outwork_3947 AS 
SELECT 
NULL AS `code`,new_CMRC_id,NULL AS nu
,NULL AS `name`,P_Number,sex,birth,age,data_exam,year_come,height_y,weight_y,waist_y,arm_circumference,calf_circumference,
Thigh_circumference,systolic_y,diastolic_y,heartbeat_y,Glucose_AC_y,Triglyceride_y,HDL_C_y,WBCb,RBCb,Hemoglobin,Hematocrit,MCV,
MCH,MCHC,RDW,Platelets,Transferrin,Ferritin,Folate,AST_GOT,ALT_GPT,ALK_P,Total_Bilirubin,D_Bilirubin,gamgt,AFP,Insulin,
T_Cholesterol,LDL_C_direct,VLDL_C,Non_HDL_C,T_CHOL_HDL_C,LDL_C_HDL_C,HS_CRP,BUN,Creatinine,Estimated_GFR_x,sodium,K,
Cl,CO2,Calcium,Inorganic_P,Albumin,Total_Protein,Hb_A1c,Estimated_AG,Intact_PTH,Uric_Acid,HBsAg_x,RPR,RF,H_PYAB_x,Anti_HCV_x,
Color,Turbidity,SP_Gravity,pH,Leukocyte,Nitrite,Protein,Glucose,Ketone,Urobilinogen,Bilirubin,octBlood,RBCu,WBCu,Squamus_Epi,
UreaNU,MicroALB_U,Creatinine_U,TP_U,Alb_Cre_ratio,TP_U_Cre_ratio,HOMA_IR,Insulin_GLU,Adiponectin,Leptin,TNF_A,Vitamin_B12,
TotalVitaminD,Lymphocyte,Monocyte,Eosinophil,Basophil,Segment,0 AS echo,bloodtype,bloodtype_rh,diet,diet_1,education,job,job_1,
job_t,job_c,job_q,job_qt,religion,religion_2,f_clan,f_land,f_land1,m_clan,m_land,m_land1,mstatus,marriyr,children,fam_self,
fam_p,fam_sp,fam_bs,fam_chi,fam_lawchi,fam_grandchi,fam_o,child_num,grandchild,others,live_place1,live_place2,year1,year2,
selfcare,care_self,care_p,care_sp,care_bs,care_chi,care_lawchi,care_n,care_o,caregiver_1,eco_self,eco_p,eco_sp,eco_bs,eco_chi,
eco_lawchi,eco_gov,eco_f,eco_o,ecosource_1,insurance,insurance_1,screening,screening_o,together,together_1,together_2,
smoke,s_smoke,smoke_t,smoke_q,smoke_qt1,smoke_qt2,smoke_f,smoke_n,smoke_second,tea,tea_c,tea_1,tea_t,tea_q,tea_f,tea_v,
coffee,coffee_c,coffee_t,coffee_q,coffee_f,coffee_v,betel,s_betel,betel_clt1,betel_clt2,betel_clt3,betel_clt4,betel_clt5,
betel_clt6,betel_o,betel_t,betel_q,betel_f,betel_n,activity_t,carryh,sport,sport_1,sport_d,sport_t,cardio,hypertension,
Dysrhythmia,ap,ami,Hyperlipidemia,HF,f_cardio,f_hyper,f_dys,f_ap,f_ami,f_lipid,f_hf,m_cardio,m_hyper,m_dys,m_ap,m_ami,
m_lipid,m_hf,bs_cardio,bs_hyper,bs_hyper_1,bs_dys,bs_dys_1,bs_ap,bs_ap1,bs_ami,bs_ami_1,bs_lipid,bs_lipid_1,bs_hf,bs_hf_1,
chi_cardio,chi_hyper,chi_dys,chi_ap,chi_ami,chi_lipid,chi_hf,endocrine,diabetes,Thyroid,f_dm,f_Thyroid,m_dm,m_Thyroid,bs_dm,
bs_dm_1,bs_Thyroid,bs_Thyroid_1,chi_dm,chi_Thyroid,pepticulcer,gastritis,hbv,hcv,hepatitis_o,FLD,fibrosis,Cirrhosis,
Polyposis,ibs,f_pud,f_hbv,f_hcv,f_liver,f_fld,f_f,f_lc,f_polyp,f_ibs,m_pud,m_hbv,m_hcv,m_liver,m_fld,m_f,m_lc,m_polyp,
m_ibs,bs_pud,bs_pud_1,bs_hbv,bs_hbv_1,bs_hcv,bs_hcv_1,bs_liver,bs_fld,bs_fld_1,bs_f,bs_f_1,bs_lc,bs_lc_1,bs_polyp,bs_polyp_1,
bs_ibs,bs_ibs_1,chi_pud,chi_hbv,chi_hcv,chi_liver,chi_fld,chi_f,chi_lc,chi_polyp,chi_ibs,respiratory,tb,Asthma,apnea,
copd,f_resp,f_Asthma,f_apnea,f_copd,m_resp,m_Asthma,m_apnea,m_copd,bs_resp,bs_Asthma,bs_Asthma_1,bs_apnea,bs_apnea_1,bs_copd,
bs_copd_1,chi_resp,chi_Asthma,chi_apnea,chi_copd,anemia,Hemophilia,f_anemia,f_h,m_anemia,m_h,bs_anemia,bs_anemia_1,bs_h,
bs_h_1,chi_anemia,chi_h,stroke,brainbleed,head_injury,epilepsy,Parkinsons,dementia,Huntingtons,f_stroke,f_brainbleed,
f_hi,f_epilep,f_pd,f_demen,f_hd,m_stroke,m_brainbleed,m_hi,m_epilep,m_pd,m_demen,m_hd,bs_stroke,bs_stroke_1,bs_brainbleed,
bs_brainbleed_1,bs_hi,bs_hi_1,bs_epilep,bs_epilep_1,bs_pd,bs_pd_1,bs_demen,bs_demen_1,bs_hd,bs_hd_1,chi_stroke,chi_brainbleed,
chi_hi,chi_epilep,chi_pd,chi_demen,chi_hd,insomnia,Depression,mdd_dx,mental,f_mdd,f_mdd_dx,f_mental,m_mdd,m_mdd_dx,m_mental,
bs_mdd,bs_mdd_1,bs_mdd_dx,bs_mental,chi_mdd,chi_mdd_dx,chi_mental,re_1,dialysis,gout,stone,bpn,f_re,f_ckd,f_dialysis,f_stone,
f_bpn,m_re,m_ckd,m_dialysis,m_stone,m_bpn,bs_re,bs_ckd,bs_ckd_1,bs_dialysis,bs_dialysis_1,bs_stone,bs_stone_1,bs_bpn,bs_bpn_1,
chi_re,chi_ckd,chi_dialysis,chi_stone,chi_bpn,cataract,glau,retina,sicca,f_cata,f_glau,f_retina,f_sicca,m_cata,m_glau,m_retina,
m_sicca,bs_cata,bs_cata_1,bs_glau,bs_glau_1,bs_retina,bs_retina_1,bs_sicca,bs_sicca_1,chi_cata,chi_glau,chi_retina,chi_sicca,
cancer,cancer_1,cantime,cancer_mi,lungcan,breastcna,colican,gastrican,livercan,cancer_o,f_can,f_can_1,f_canmi,f_lung,f_breast,
f_coli,f_gastric,f_liver_c,f_can_o,m_can,m_can_1,m_canmi,m_lung,m_breast,m_coli,m_gastric,m_liver_c,m_can_o,bs_can,bs_can_1,
bs_canmi,bs_lung,bs_lung_1,bs_breast,bs_breast_1,bs_coli,bs_coli_1,bs_gastric,bs_gastric_1,bs_liver_c,bs_liver_c_1,bs_can_o,
chi_can,chi_can_1,chi_canmi,chi_lung,chi_breast,chi_coli,chi_gastric,chi_liver_c,chi_can_o,ndisease,fn,mn,bsn,chin,`UNKNOWN`,
funknown,munknown,bsunknown,chiunknown,autoimmu,dis_o,f_dis_o,f_disable,m_dis_o,m_disable,bs_dis_o,bs_disable,chi_dis_o,
chi_disable,Syr_drug,Hypnotic,drug,drug_w,drug_yr,drug_diag,drug_cont,hyper_drug,hyper_drugn,hyper_druga,hyper_confir,
hyper_cont,dm_drug,dm_w,dm_yr,dm_diag,dm_cont,hor_drug,hor_w,hor_yr,hor_diag,hor_diag1,hor_cont,lipiddrug,lipidw,lipidyr,
lipiddiag,lipiddiag1,lipidcont,supply,gasdrug,cmed,hf_none,hf_vit,hf_wgl,hf_foil,hf_ca,hf_p,hf_p1,hf_p2,hf_chic,hf_clam,
hf_e,hf_lutein,hf_collagen,hf_other,hf_fmed,hf_unknown,hf_1,plastic_1,plastic_2,plastic_3,plastic_4,plastic_5,plastic_6,
plastic_7,BI_1,BI_2,BI_3,SF36_1,SF36_2,sf36_3_a,sf36_3_b,sf36_3_c,sf36_3_d,sf36_3_e,sf36_3_f,sf36_3_g,sf36_3_h,sf36_3_i,
sf36_3_j,sf36_4_a,sf36_4_b,sf36_4_c,sf36_4_d,sf36_5_a,sf36_5_b,sf36_5_c,sf36_6,sf36_7,sf36_8,sf36_9_a,sf36_9_b,sf36_9_c,
sf36_9_d,sf36_9_e,sf36_9_f,sf36_9_g,sf36_9_h,sf36_9_i,sf36_10,sf36_11_a,sf36_11_b,sf36_11_c,sf36_11_d,beda,bedb,bedt,waketa,
waketb,sleepta,sleeptb,sleep1,sleep2,sleep3,sleep4,sleep5,sleep6,sleep7,sleep8,sleep9,sleep10,sleep10a,sleep11,sleep12,
sleep13,sleep14,sleep15,c1_Sleep_Quality,c2_Latency,c3_Duration,c4_Efficiency,c5_Disturbance,c6_Use_Medicatin,
c7_Daytime_dysfunction,PSQI,hads_1,hads_2,hads_3,hads_4,hads_5,hads_6,hads_7,hads_8,hads_9,hads_10,hads_11,hads_12,hads_13,
hads_14,check7,uls8_1,uls8_2,uls8_3,uls8_4,uls8_5,uls8_6,uls8_7,uls8_8,check8,ad8_1,ad8_2,ad8_3,ad8_4,ad8_5,ad8_6,ad8_7,ad8_8,
check9,ecog12a,ecog12a1,ecog12b1,ecog12b2,ecog12b3,ecog12b4,ecog12b5,ecog12b6,ecog12b7,ecog12b8,ecog12b9,ecog12b10,ecog12b11,
ecog12b12,check10,mna_1,mna_2,mna_3,mna_4,mna_5,mna_6,mna_7,mna_8,mna_9,mna_10,mna_11,mna_12,mna_13,mna_14,mna_15,check11,
sarcf_1,sarcf_2,sarcf_3,sarcf_4,sarcf_5,check12,d2_drink,d2_drinkt,d2_drinkav,d2_drinkday,d2_drinkcat,d2_drinknote,d2_drinkvol,
past2_drinkav,past2_drinkday,past2_drink,past2_drinkcat,past2_drinknote,past2_drinkvol,past1_drink,d2_drinks,drink_k1,drink_k2,
drink_k3,drink_k4,drink_k5,drink_k6,drink_k7,drink_k7_o,drink_t,drink_q,drink_qt1,drink_qt2,drink_red,B_1_1,B_1_2,B_1_3,B_1_4,
B_1_5,B_1_6,B_1_7,B_1_8,B_1_9,B_1_10,AUDIT,B_2_1,B_2_2,B_2_3,B_2_4,check13,life1,life2,life3,life4,life5,life6,life7,life8,
life9,life10,life11,life12,life13,life14,life15,life16,life17,life18,life19,life20,life21,life22,life23,life24,depres_11,
depres_12,depres_13,depres_14,depres_15,depres_16,depres_17,depres_18,depres_19,depres_110,depres_111,depres_112,depres_113,
depres_114,depres_115,depres_116,depres_117,depres_118,health_1,health_2,health_3,health_4,health_5,health_6,health_7,health_8,
health_9,health_10,RAND36_PF,RAND36_RP,RAND36_RE,RAND36_EF,RAND36_EWB,RAND36_SF,RAND36_BP,RAND36_GH,AGG_PHYS1,PSY_PHYS1,
100.00 AS PCS,100.00 AS MCS,egfrn,BMI,ckd,DM_determine,w,hyper,fg,HDL,trig,mst,ms2
FROM CMRC_DB_2022_import_work.new_CMRC_db_testing_question_scalebigtable_20220625
WHERE data_exam >= 20200000 OR P_number REGEXP '^M09|^M10';

DROP TEMPORARY TABLE CMRC_DB_kaonthu_work.doctor_ye_20220627_outwork_3947;

UPDATE CMRC_DB_kaonthu_work.doctor_ye_20220627_outwork_3947 AS a 
INNER JOIN CMRC_DB_2022_import_work.CMRC_all_persontimes_20220110_kaonthu_20220310 AS b
ON a.P_Number = b.P_Number
SET a.echo = b.echo
WHERE b.echo = 1;

UPDATE CMRC_DB_kaonthu_work.doctor_ye_20220627_outwork_3947 
SET PCS = 10*AGG_PHYS1+50,MCS = 10*PSY_PHYS1+50


SELECT * FROM CMRC_DB_kaonthu_work.doctor_ye_20220627_outwork_3947;