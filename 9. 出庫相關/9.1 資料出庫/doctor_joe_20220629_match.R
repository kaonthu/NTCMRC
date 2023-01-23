library(RMySQL)
library(DBI)

mysqlconnection = dbConnect(MySQL(), dbname = "kao_practice_3",user = 'kaonthu', password = 'asd123',host = '192.168.1.41')

dbListTables(mysqlconnection)
summary(mysqlconnection)

sqlStatement <- paste("
SELECT p_id,sex,age FROM CMRC_DB_2022_import_work.new_CMRC_db_20963_desc_20220310
WHERE p_id IN (SELECT P_ID FROM CMRC_DB_kaonthu_work.doctor_joe_20220616_outwork_54)
GROUP BY P_ID;
")

result = dbGetQuery(mysqlconnection, sqlStatement)
head(result) 
dim(result)

PLAN1_case = result

PLAN1_case$ma <- 1

##################################################################
sqlStatement2 <- paste("
SELECT p_id,sex,age FROM CMRC_DB_2022_import_work.new_CMRC_db_20963_desc_20220310
WHERE p_id not IN (SELECT P_ID FROM CMRC_DB_kaonthu_work.doctor_joe_20220616_outwork_54)
AND p_id IN (SELECT p_id FROM CMRC_DB_2022_import_work.new_CMRC_db_testing_question_scalebigtable_20220625
WHERE `HBV_` = 0 AND `HCV_` = 0 AND fibrosis = 0 AND Cirrhosis = 0 AND hepatitis_o = 0
AND cancer = 0 AND (cancer_o is NULL or cancer_o =''))
GROUP BY P_ID ;
")


#sqlStatement2 <- paste("
#SELECT p_id,sex,age FROM CMRC_DB_2022_import_work.new_CMRC_db_20963_desc_20220310
#WHERE p_id not IN (SELECT P_ID FROM CMRC_DB_kaonthu_work.doctor_joe_20220616_outwork_54)
#AND p_id IN (SELECT p_id FROM CMRC_DB_2022_import_work.new_CMRC_db_testing_question_scalebigtable_20220625
#WHERE `HBV_` = 0 AND `HCV_` = 0 AND fibrosis = 0 AND Cirrhosis = 0 AND hepatitis_o = 0
#AND cancer = 0 AND lungcan = 0 AND breastcna = 0 AND colican = 0 AND
#gastrican = 0 AND livercan = 0 AND (cancer_o is NULL or cancer_o =''))
#GROUP BY P_ID;
#")

result2 = dbGetQuery(mysqlconnection, sqlStatement2)
head(result2) 
dim(result2)

PLAN1_control = result2

PLAN1_control$ma <- 0

PLAN1 <- rbind(PLAN1_control,PLAN1_case)
head(PLAN1)
dim(PLAN1)

#install.packages('MatchIt')
library(MatchIt)
library(arsenal)

PLAN1$sex = as.numeric(PLAN1$sex)
PLAN1$age = as.numeric(PLAN1$age)



data_match1 <- matchit(ma ~ sex+age, data = PLAN1, ratio=4, caliper = 0.1,method = "nearest")
summary(data_match1)
dim(match.data(data_match1))


table_one_1 <- tableby(ma~factor(sex)+age,data=match.data(data_match1))
table_one_1 <- summary(table_one_1,title = "GS",text=TRUE,digits = 2)
table_one_1

out = as.data.frame(match.data(data_match1))

dbWriteTable(mysqlconnection,"doctor_joe_20220629_match",out,append=TRUE)

