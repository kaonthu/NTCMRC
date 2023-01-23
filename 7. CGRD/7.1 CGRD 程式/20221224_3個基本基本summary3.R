
result <- read.csv("I:/基隆長庚社區醫學科研究中心/其它老師交代/20221206_林志郎主任串聯CGRD/20230109_交接/data_lin.csv",sep=",",header=TRUE)



library(dplyr)

test <- result[c("cardio","Dysrhythmia","ap","ami","HF")]
test <- test %>% mutate(sum = rowSums(., na.rm = TRUE))
result$Coronary <- ifelse(test$sum>=1,1,0)


library(arsenal)

result2 <- apply(result,2,as.numeric)
result2 <- as.data.frame(result2)

dim(result2)


result2$ALDH2 <- result$ALDH2
result2$ADH1B <- result$ADH1B
result2$PNPLA3 <- result$PNPLA3
result2$CMRC_ID <- result$CMRC_ID
result2$sid <- result$sid

result2 <- as.data.frame(result2)

head(result2)

result2[1739,1:18] #開始檢查資料

####################################################################################################
table(result2$ALDH2)

result3 <- result2[-which(result2$ALDH2==c("")),]
result3 <- result3[-which(result3$ALDH2==c("NoCall")),]

dim(result3)

table_one <- tableby(ALDH2~ age+as.factor(sex)+BMI+as.factor(ms2)+
as.factor(CKD_determine)+
as.factor(Coronary)+
as.factor(hypertension)+as.factor(diabetes)+
Alb_Cre_ratio+Hb_A1c+Creatinine+AST_GOT+ALT_GPT+sodium+
Albumin+Total_Bilirubin+Total_Protein+Uric_Acid+T_CHOL_HDL_C+LDL_C_HDL_C+
T_Cholesterol+Insulin+HS_CRP+Ferritin+Adiponectin+Leptin,data=result3, total=TRUE)

table_one <- summary(table_one,title = "ALDH2_1734",text=TRUE,digits = 2)
table_one

##############################################################################

table(result2$ADH1B)

result4 <- result2

result4 <- result2[-which(result2$ADH1B==c("")),]
result4 <- result4[-which(result4$ADH1B==c("NoCTll")),]


table_one <- tableby(ADH1B~ age+as.factor(sex)+BMI+as.factor(ms2)+
as.factor(CKD_determine)+
as.factor(Coronary)+
as.factor(hypertension)+as.factor(diabetes)+
Alb_Cre_ratio+Hb_A1c+Creatinine+AST_GOT+ALT_GPT+sodium+
Albumin+Total_Bilirubin+Total_Protein+Uric_Acid+T_CHOL_HDL_C+LDL_C_HDL_C+
T_Cholesterol+Insulin+HS_CRP+Ferritin+Adiponectin+Leptin,data=result4, total=TRUE)

table_one <- summary(table_one,title = "ADH1B_1293",text=TRUE,digits = 2)
table_one

#################################################################################

table(result2$PNPLA3)

result5 <- result2

result5 <- result5[-which(result5$PNPLA3==c("")),]


table_one <- tableby(PNPLA3~ age+as.factor(sex)+BMI+as.factor(ms2)+
as.factor(CKD_determine)+
as.factor(Coronary)+
as.factor(hypertension)+as.factor(diabetes)+
Alb_Cre_ratio+Hb_A1c+Creatinine+AST_GOT+ALT_GPT+sodium+
Albumin+Total_Bilirubin+Total_Protein+Uric_Acid+T_CHOL_HDL_C+LDL_C_HDL_C+
T_Cholesterol+Insulin+HS_CRP+Ferritin+Adiponectin+Leptin,data=result5, total=TRUE)

table_one <- summary(table_one,title = "PNPLA3_1614",text=TRUE,digits = 2)
table_one


