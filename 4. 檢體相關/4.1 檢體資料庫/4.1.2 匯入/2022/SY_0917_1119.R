
f=function(date,person,speciem,Pstart,P_number_start,Cstart,C_number_start,Box_start,Site_start)

{
S_number_a <- rep(date,person*10)
S_number_b <- rep(sprintf('%0.3d', 1:person),each = 10)
S_number <- paste(S_number_a,S_number_b,sep="")

P_number_a <- rep(Pstart,person*10)
P_number_b <- rep(sprintf('%0.4d', (P_number_start):(P_number_start+person-1)),each = 10)
P_number  <-  paste(P_number_a,P_number_b,sep="")

C_number_a <- rep(Cstart,person*10)
C_number_b <- sprintf('%0.5d', (C_number_start):(C_number_start+person*10-1))
C_number  <-  paste(C_number_a,C_number_b,sep="")


Site <- ((Site_start-1  + 0:(person*10-1)) %% 100) + 1

Box <- Box_start  + (Site_start + (-1):(person*10-2)) %/% 100

Box <- paste0("S",sprintf('%0.4d', Box))

OUT <- data.frame(S_number_a,S_number,P_number,C_number,Box,Site," ")

print(data.frame(QC_miss_person,QC_miss_number))


QC_start <- rep(10,person)

if( length(QC_miss_person) > 0)

{

delete <- NULL

for (i in 1:length(QC_miss_person)) {
QC_start[QC_miss_person[i]] <- QC_start[QC_miss_person[i]]-QC_miss_number[i]
delete <- c(delete,(10*QC_miss_person[i]-QC_miss_number[i]+1) : (10*QC_miss_person[i]))
}

OUT2 <- OUT[-delete,]

QC <- rep(0,person*10 - length(delete))
QC[cumsum(QC_start)] <- 1


QC_start <- rep(10,person)

delete <- NULL

for (i in 1:length(QC_miss_person)) {
QC_start[QC_miss_person[i]] <- QC_start[QC_miss_person[i]]-QC_miss_number[i]
delete <- c(delete,(10*QC_miss_person[i]-QC_miss_number[i]+1) : (10*QC_miss_person[i]))
}

OUT2 <- OUT[-delete,]

QC <- rep(0,person*10 - length(delete))
QC[cumsum(QC_start)] <- 1

OUT3 <- data.frame(OUT2,"SY",QC)

}else {  

 QC <- rep(c(0,0,0,0,1),person)
 OUT3 <- data.frame(OUT,"SY",QC)    }

print(OUT3[(dim(OUT3)[1]-10):dim(OUT3)[1],])
return(OUT3)

}


#################################################################

QC_miss_person <- c(1,6,12,19,23,29,30,32,38,41,42,49,53,55,56,63)
QC_miss_number <- c(1,2,1,1,2,3,1,1,2,1,2,2,1,1,1,1)

out_20220917 <- f(20220917,87,"SY","P11",1014,"C07",10131,102,31)

#################################################################

QC_miss_person <- c(2,3,4,5,8,10,11,13,14,15,16,17,18,24,25,26,27,28,29,30,38,48,49,54,55,58)
QC_miss_number <- c(1,2,1,1,1,3,1,1,2,1,1,2,3,3,1,2,1,3,2,1,1,3,1,1,1,1)


out_20220924 <- f(20220924,58,"SY","P11",1101,"C07",11001,111,1)

#################################################################

QC_miss_person <- c(21,22,30,34,57)
QC_miss_number <- c(5,3,3,1,3)

out_20221001 <- f(20221001,67,"SY","P11",1159,"C07",11581,116,81)

#################################################################

QC_miss_person <- c(4,16,18,19,20,22,23,24,26,34,35,37,40,41,49,50,52,56,58,60,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,
81,82,83,85,86,87,89,90,92,93,94,95,96,97,98,99,101,102,103,104,105,106,107,108,109)
QC_miss_number <- c(2,2,2,1,1,1,1,2,3,1,1,2,1,1,2,1,2,2,1,1,3,2,2,2,2,3,2,1,3,3,2,4,2,1,3,2,4,3,3,2,1,4,4,2,4,4,1,1,1,3,4,3,3,1,4,1,3,2,2,1,4,4,3)

out_20221015 <- f(20221015,109,"SY","P11",1226,"C07",12251,123,51)

#################################################################

QC_miss_person <- c(57,63,74,75)
QC_miss_number <- c(1,1,1,3)

out_20221022 <- f(20221022,106,"SY","P11",1335,"C07",13341,134,41)

#################################################################

QC_miss_person <- c(2,3,4,7,8,10,12,14,16,17,18,20,21,22,24,25,27,28,29,30,32,36,39)
QC_miss_number <- c(1,2,1,3,1,1,1,2,1,1,2,1,2,2,2,3,3,2,2,3,1,2,1)

out_20221029 <- f(20221029,61,"SY","P11",1441,"C07",14401,145,1)

#################################################################

QC_miss_person <- c(6,7,9,25,28,33,37,39,43)
QC_miss_number <- c(1,2,2,1,4,3,1,3,3)

out_20221105 <- f(20221105,53,"SY","P11",1502,"C07",15011,151,11)

#################################################################

QC_miss_person <- c(6,7,9,10,11,13,15,16,18,19,20,24,25,27,28,34,37,39,40,41,42,44,45,46,47,49,50,51,58,63,64,72,78,80,83,85,87,88,94,95,96,99,100,105)
QC_miss_number <- c(1,1,1,4,2,2,1,2,3,2,1,1,4,3,2,3,2,3,1,2,1,3,1,4,1,4,3,3,2,4,4,5,1,2,1,4,2,1,10,1,1,1,2,1)

out_20221112 <- f(20221112,106,"SY","P11",1555,"C07",15541,156,41)

#################################################################

QC_miss_person <- c(7,13,17,19,22,27,33,36,38,43,46,49,50,55,59,60,61,69,70,74,78,81,85,88,90,91,92,95,96,99,100,101,106,111,120)
QC_miss_number <- c(2,1,1,2,2,2,1,1,4,4,1,3,2,2,1,1,3,1,4,2,1,2,1,1,4,2,2,2,1,3,1,2,1,2,1)

out_20221119 <- f(20221119,122,"SY","P11",1661,"C07",16601,167,1)

#################################################################

out_total <- rbind(out_20220917,out_20220924,out_20221001,out_20221015,out_20221022,
out_20221029,out_20221105,out_20221112,out_20221119)

dim(out_total)

library(RMySQL)
library(DBI)

mysqlconnection = dbConnect(MySQL(), dbname = "kao_practice_5",user = 'kaonthu', password = 'asd123',host = '192.168.1.41')

#dbListTables(mysqlconnection)
#summary(mysqlconnection)

out <- data.frame(sid=out_total$S_number,P_number=out_total$P_number,
C_number=out_total$C_number,Box=out_total$Box,Site=out_total$Site,
ML = 0,Specimen ="SY",QC=out_total$QC,C_Date=out_total$S_number_a,
IN_time = 20221125,CMRC_Reserved=0,sup=0)

dbWriteTable(mysqlconnection,"Total_speciem_2022_0917_1119",out,append=TRUE)

