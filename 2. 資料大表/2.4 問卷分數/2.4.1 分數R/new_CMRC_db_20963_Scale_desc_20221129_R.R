
library(RMySQL)
library(DBI)
library(magrittr)
library(ggplot2)
library(plyr)


mysqlconnection = dbConnect(MySQL(), dbname = "NTCMRC",user = 'kaonthu', password = 'asd123',host = '192.168.1.41')

dbListTables(mysqlconnection)
summary(mysqlconnection)

dbSendQuery(mysqlconnection,"SET NAMES latin1")

sqlStatement <- paste("
SELECT p_id,sid,sex,age,
hads_1,hads_2,hads_3,hads_4,hads_5,hads_6,
hads_7,hads_8,hads_9,hads_10,hads_11,hads_12,
hads_13,hads_14,depres_11,depres_12,depres_13,
depres_14,depres_15,depres_16,depres_17,depres_18,
depres_19,depres_110,depres_111,depres_112,depres_113,
depres_114,depres_115,depres_116,depres_117,depres_118
FROM NTCMRC.new_CMRC_db_desc;
")

result = dbGetQuery(mysqlconnection, sqlStatement)
head(result) 
dim(result)



question <- c("hads_1","hads_2","hads_3","hads_4","hads_5","hads_6","hads_7","hads_8",
"hads_9","hads_10","hads_11","hads_12","hads_13","hads_14",
"depres_11","depres_12","depres_13","depres_14","depres_15","depres_16","depres_17","depres_18","depres_19",
"depres_110","depres_111","depres_112","depres_113","depres_114","depres_115","depres_116","depres_117","depres_118"
)

m = function(x) {
ifelse(x %in% c(1,2,3,4),x,"NA")
} #如果問卷回應是非1 2 3 4 都改為NA

had_anti <- apply(result[,question[c(1,3,5,6,8,10,11,13)]],2,m) 
had_anti <- apply(had_anti,2,as.numeric) 
had_anti <- 4-had_anti    #反向題 1 2 3 4 計分為3 2 1 0  

had <- apply(result[,question[c(2,4,7,9,12,14)]],2,m) 
had <- apply(had,2,as.numeric) 
had <- had-1 #正向題 1 2 3 4 計分為0 1 2 3 

dim(had_anti)
dim(had)

HAD <- apply(cbind(had_anti,had),1,sum)
length(which(HAD>8)) #1381 個HAD > 8分

############################################################

anxiety_anti <- apply(result[,question[c(1,3,5,11,13)]],2,m) 
anxiety_anti <- apply(anxiety_anti,2,as.numeric) 
anxiety_anti <- 4-anxiety_anti    #反向題 1 2 3 4 計分為3 2 1 0  

anxiety <- apply(result[,question[c(7,9)]],2,m) 
anxiety <- apply(anxiety,2,as.numeric) 
anxiety <- anxiety-1 #正向題 1 2 3 4 計分為0 1 2 3 

Anxiety <-  apply(cbind(anxiety_anti,anxiety),1,sum)
length(which(Anxiety>=8)) #Anxiety >= 8分 583

#############################################################

depression_anti <- apply(result[,question[c(6,8,10)]],2,m) 
depression_anti <- apply(depression_anti,2,as.numeric) 
depression_anti <- 4-depression_anti    #反向題 1 2 3 4 計分為3 2 1 0  

depression <- apply(result[,question[c(2,4,12,14)]],2,m) 
depression <- apply(depression,2,as.numeric) 
depression <- depression-1 #正向題 1 2 3 4 計分為0 1 2 3 

Depression <-  apply(cbind(depression_anti,depression),1,sum)
length(which(Depression>=8)) #Depression >= 8分 547
length(which(Depression>=8)) / length(which(Depression>=0)) 

#######################################################

tdq <- apply(result[,question[c(15:32)]],2,m) 
tdq <- apply(tdq,2,as.numeric) 

head(tdq[18000:18200,])
tdq <- tdq-1  #矩陣每個都-1

dim(tdq)
head(tdq[18000:18200,])

TDQ <- apply(tdq,1,sum)
length(which(TDQ>=19)) #989 個HAD > 8分
length(which(TDQ>=19))/length(which(TDQ>=0))

#############################################################################################

sqlStatement2 <- paste("
SELECT p_id,sid,sex,age,
ad8_1,ad8_2,ad8_3,ad8_4,ad8_5,ad8_6,ad8_7,ad8_8
FROM NTCMRC.new_CMRC_db_desc;
")

result2 = dbGetQuery(mysqlconnection, sqlStatement2)
head(result2) 
dim(result2)

question2 <- c("ad8_1","ad8_2","ad8_3","ad8_4","ad8_5","ad8_6","ad8_7","ad8_8")

apply(result2,2,table) #summary看看回答

m = function(x) {
ifelse(x %in% c(0,1,9),x,"NA")
} #如果問卷回應是非0 1 9 都改為NA

ad8 <- apply(result2,2,m) 
ad8 <- apply(ad8,2,as.numeric) 

n = function(x) {
sum(x==1)
} #有多少回答1

AD8 <- apply(ad8[,question2[c(1:8)]],1,n) 

#############################################################################################

sqlStatement3 <- paste("
SELECT sid,beda,bedb,bedt,waketa,waketb,sleepta,sleeptb,
sleep1,sleep2,sleep3,sleep4,sleep5,sleep6,sleep7,sleep8,
sleep9,sleep10,sleep10a,sleep11,sleep12,sleep13,sleep14,sleep15
FROM NTCMRC.new_CMRC_db_desc;
")


result3 = dbGetQuery(mysqlconnection, sqlStatement3)
head(result3) 
dim(result3)


SID <- result3$sid # SID轉成數字格式門診資料會不見，把sid資料另外抽出

#as.numeric(result3[,c(1:3,5:10)])

#apply(result3[,c(1:3,5:10)],2,as.numeric)

#lapply(result3,as.numeric)

result3 <- apply(result3,2,as.character)
result3 <- apply(result3,2,as.numeric)
result3 <- as.data.frame(result3)

names(result3) <- c("sid","beda","bedb","bedt","waketa","waketb",
"sleepta","sleeptb","sleep1","sleep2","sleep3","sleep4","sleep5",
"sleep6","sleep7","sleep8","sleep9","sleep10","sleep10a","sleep11",
"sleep12","sleep13","sleep14","sleep15")


CPSQI <- data.frame(sid=SID)

head(CPSQI) 

CPSQI$Q1 <- result3$beda + result3$bedb/60 #幾點躺床
CPSQI$Q2 <- result3$bedt
CPSQI$Q3 <- result3$waketa + result3$waketb/60 #起點起床
CPSQI$Q4 <-  result3$sleepta + result3$sleeptb/60 #睡眠總時數，這邊暫時先換算成小時制方便
CPSQI$Q5_a <- result3$sleep1
CPSQI$Q5_b <- result3$sleep2
CPSQI$Q5_c <- result3$sleep3
CPSQI$Q5_d <- result3$sleep4
CPSQI$Q5_e <- as.numeric(result3$sleep5)
CPSQI$Q5_f <- result3$sleep6
CPSQI$Q5_g <- result3$sleep7
CPSQI$Q5_h <- result3$sleep8
CPSQI$Q5_i <- result3$sleep9
CPSQI$Q5_j <- result3$sleep10

CPSQI$Q6 <- result3$sleep12
CPSQI$Q7 <- result3$sleep13
CPSQI$Q8 <- result3$sleep14
CPSQI$Q9 <- result3$sleep11

################# 轉換成9大題 匹茲堡睡眠品質量表          ######################################
NAME <- c("c1_Sleep_Quality","c2_Latency","c3_Duration","c4_Efficiency","c5_Disturbance","c6_Use_Medicatin","c7_Daytime_dysfunction","Total")

SCORE <- data.frame(sid=SID)

SCORE$c1_Sleep_Quality <- CPSQI$Q9
SCORE$c1_Sleep_Quality[SCORE$c1_Sleep_Quality==4] <- "NA" #裡面有人回答非0 1 2 3
SCORE$c1_Sleep_Quality  <- as.numeric(SCORE$c1_Sleep_Quality) 

table(SCORE$c1_Sleep_Quality,exclude = NULL)

#####################################

SCORE$c2_Latency <- rep("NA",length(CPSQI$Q2))

tem <- NULL 
tem[as.numeric(CPSQI$Q2) <= 15] <- 0
tem[as.numeric(CPSQI$Q2) >  15 & as.numeric(CPSQI$Q2) <= 30] <- 1
tem[as.numeric(CPSQI$Q2) >  31 & as.numeric(CPSQI$Q2) <= 60] <- 2
tem[as.numeric(CPSQI$Q2) >  60 ] <- 3

SCORE$c2_Latency[(tem+CPSQI$Q5_a)==0] <- 0
SCORE$c2_Latency[(tem+CPSQI$Q5_a) >= 1 & (tem+CPSQI$Q5_a) <= 2] <- 1
SCORE$c2_Latency[(tem+CPSQI$Q5_a) >= 3 & (tem+CPSQI$Q5_a) <= 4] <- 2
SCORE$c2_Latency[(tem+CPSQI$Q5_a) >= 5 & (tem+CPSQI$Q5_a) <= 6] <- 3

SCORE$c2_Latency <- as.numeric(SCORE$c2_Latency)
barplot(table(SCORE$c2_Latency,exclude = NULL))

######################################

SCORE$c3_Duration <- CPSQI$Q4

SCORE$c3_Duration[CPSQI$Q4>7] <- 0
SCORE$c3_Duration[CPSQI$Q4>6 & CPSQI$Q4<=7 ] <- 1
SCORE$c3_Duration[CPSQI$Q4>=5 & CPSQI$Q4<=6 ] <- 2
SCORE$c3_Duration[CPSQI$Q4<5 ] <- 3

barplot(table(SCORE$c3_Duration,exclude = NULL))


#######################################
library(magrittr)

lie_down <- rep("NA",length(CPSQI$Q3)) #躺床時間是空的

case1 <- which(CPSQI$Q3-CPSQI$Q1 < 0)
lie_down[case1] <- (CPSQI$Q3-CPSQI$Q1+24)[case1]  # Q3起床 -  Q1睡覺 若是負的代表事隔了一天

case2 <- which(CPSQI$Q3-CPSQI$Q1 > 0)
lie_down[case2] <- (CPSQI$Q3-CPSQI$Q1)[case2]   #Q3起床 -  Q1睡覺 若正的代表是在同一天

length(which(CPSQI$Q4>20)) #回應實際睡超過20小時 有21筆 異常值

CPSQI$Q4[which(CPSQI$Q4>20)] #哪21筆

lie_down[which(CPSQI$Q4>20)] <- "NA"

lie_down <- lie_down %>% as.numeric()

length(which(lie_down>15)) #躺床超過15小時 有312筆 異常值 大部份為24小時制填錯，或者本身回應就很奇怪都拿掉
lie_down[which(lie_down>15)] <- "NA"

lie_down <- lie_down %>% as.numeric()

length(which(CPSQI$Q4>lie_down)) #回應實際睡著時間大於躺床時間 有1228筆 
lie_down[which(CPSQI$Q4>lie_down)] <- "NA"

lie_down <- lie_down %>% as.numeric()

M<- matrix(c(CPSQI$Q1,CPSQI$Q3,lie_down,CPSQI$Q4,lie_down-12),ncol=5)

colnames(M) <- c("躺床","起床","計算躺床時數","回應實際睡眠","填錯24小時制")

plot(M[,c("計算躺床時數","回應實際睡眠")],cex=0.5,pch=16,col="blue",bty="l",ylim=c(0,20))

abline(coef=c(0,1),col="red",lty=1,lwd=1)

summary(lie_down)
boxplot(lie_down)

SCORE$c4_Efficiency <- rep("NA",length(CPSQI$Q1))

SCORE$c4_Efficiency[ (100*CPSQI$Q4 / lie_down) >=85 & (100*CPSQI$Q4 / lie_down) <= 200] <- 0
SCORE$c4_Efficiency[ (100*CPSQI$Q4 / lie_down) >=75 & (100*CPSQI$Q4 / lie_down) < 85] <- 1
SCORE$c4_Efficiency[ (100*CPSQI$Q4 / lie_down) >=65 & (100*CPSQI$Q4 / lie_down) < 75] <- 2
SCORE$c4_Efficiency[ (100*CPSQI$Q4 / lie_down) >=0 & (100*CPSQI$Q4 / lie_down) < 65] <- 3

SCORE$c4_Efficiency <- as.numeric(SCORE$c4_Efficiency)

barplot(table(SCORE$c4_Efficiency,exclude = NULL))


############################################
s <- CPSQI$Q5_b+CPSQI$Q5_c+CPSQI$Q5_d+CPSQI$Q5_e+CPSQI$Q5_f+CPSQI$Q5_g+CPSQI$Q5_h+CPSQI$Q5_i+ifelse(is.na(CPSQI$Q5_j),0,CPSQI$Q5_j)

SCORE$c5_Disturbance <- s

SCORE$c5_Disturbance[s %in% c(19:27)] <- 3
SCORE$c5_Disturbance[s %in% c(10:18)] <- 2
SCORE$c5_Disturbance[s %in% c(1:9)] <- 1
SCORE$c5_Disturbance[s %in% c(0)  ] <- 0

barplot(table(SCORE$c5_Disturbance,exclude = NULL))

###############################################

SCORE$c6_Use_Medicatin <- CPSQI$Q6

SCORE$c6_Use_Medicatin[SCORE$c6_Use_Medicatin==4] <- "NA" #裡面有人回答非0 1 2 3 
 
SCORE$c6_Use_Medicatin <- as.numeric(SCORE$c6_Use_Medicatin)

barplot(table(SCORE$c6_Use_Medicatin,exclude = NULL))

###############################################
CPSQI$Q7[CPSQI$Q7==4] <- "NA"
CPSQI$Q8[CPSQI$Q8==4] <- "NA"

SCORE$c7_Daytime_dysfunction <- as.numeric(CPSQI$Q7) + as.numeric(CPSQI$Q8)

SCORE$c7_Daytime_dysfunction[(as.numeric(CPSQI$Q7) + as.numeric(CPSQI$Q8)) %in% c(0)] <- 0
SCORE$c7_Daytime_dysfunction[(as.numeric(CPSQI$Q7) + as.numeric(CPSQI$Q8)) %in% c(1,2)] <- 1
SCORE$c7_Daytime_dysfunction[(as.numeric(CPSQI$Q7) + as.numeric(CPSQI$Q8)) %in% c(3,4)] <- 2
SCORE$c7_Daytime_dysfunction[(as.numeric(CPSQI$Q7) + as.numeric(CPSQI$Q8)) %in% c(5,6)] <- 3

barplot(table(SCORE$c7_Daytime_dysfunction,exclude = NULL))
##################################################

S_M <- SCORE[,c("c1_Sleep_Quality",
"c2_Latency",
"c3_Duration",
"c4_Efficiency",
"c5_Disturbance",
"c6_Use_Medicatin",
"c7_Daytime_dysfunction")]

dim(S_M)

S_M <- apply(S_M,2,as.numeric)

PSQI <- apply(S_M,1,sum)

#################################################################################################################

sqlStatement4 <- paste("
SELECT sid,n_1,p_id,
B_1_1,B_1_2,B_1_3,B_1_4,B_1_5,B_1_6,B_1_7,B_1_8,B_1_9,B_1_10
FROM NTCMRC.new_CMRC_db_desc;
") #留著最完整的資料

result4 = dbGetQuery(mysqlconnection,sqlStatement4)

df <- apply(result4[,4:13], 2 , as.numeric) #先把問卷矩陣改成數字

library(magrittr) 
library(ggplot2)

df_1 <- apply(df,1,sum) %>% is.na() %>% table() %>% as.data.frame() #把10個問題數字加總成是否為NA值

df_1$. <- c("完整","部分缺失")

p<-ggplot(data=df_1, aes(x=., y=Freq)) +
   geom_bar(stat="identity",fill="steelblue") + 
   geom_text(aes(label=Freq), vjust= -0.3, size=3.5)+
   labs(title="有效問卷", y = "Freq")+
  theme(axis.text=element_text(size=12,face="bold"),plot.title=element_text(hjust = 0.5,face="bold",size=15))

df_2 <- apply(df,1,sum) %>% table(exclude = NULL) %>% as.data.frame() #把10個問題數字加總畫圖

AUDIT <- apply(df,1,sum)

#################################################################################################################

sqlStatement5 <- paste("
SELECT sid,Platelets,HDL_C_y,Glucose_AC_y,Insulin,Lymphocyte,Segment,Monocyte,Eosinophil,Basophil
FROM NTCMRC.new_CMRC_db_desc;
") #留著最完整的資料

result5 = dbGetQuery(mysqlconnection,sqlStatement5)

SID <- result5$sid

result5 <- apply(result5,2,as.numeric)
result5 <- as.data.frame(result5)

t <- (-0.005*result5$Platelets)-
   (0.029*result5$HDL_C_y)-
  0.376*log10(result5$Glucose_AC_y/result5$Insulin)+
  0.854*log10(result5$Lymphocyte/result5$Segment)-
  0.015*result5$Platelets*(result5$Lymphocyte/result5$Segment)-
  0.062*(result5$Glucose_AC_y/result5$Insulin)*(result5$Lymphocyte/result5$Segment)+4.253

inspect <- result5$Lymphocyte+result5$Monocyte+result5$Eosinophil+result5$Basophil+result5$Segment

inspect2 <- result5$Lymphocyte+result5$Segment

R=exp(t) / (1+ exp(t))

##############################################################################
out <- data.frame(sid=result$sid,
p_id=result$p_id,sex=result$sex,age=result$age,
Anxiety=Anxiety,Depression=Depression,HAD=HAD,TDQ=TDQ,AD8=AD8,
c1_Sleep_Quality=SCORE[,c("c1_Sleep_Quality")],
c2_Latency=SCORE[,c("c2_Latency")],
c3_Duration=SCORE[,c("c3_Duration")],
c4_Efficiency=SCORE[,c("c4_Efficiency")],
c5_Disturbance=SCORE[,c("c5_Disturbance")],
c6_Use_Medicatin=SCORE[,c("c6_Use_Medicatin")],
c7_Daytime_dysfunction=SCORE[,c("c7_Daytime_dysfunction")],
PSQI=PSQI,
AUDIT=AUDIT,R=R)

dbWriteTable(mysqlconnection,"new_CMRC_db_Scale_desc_R",out,append=TRUE)












