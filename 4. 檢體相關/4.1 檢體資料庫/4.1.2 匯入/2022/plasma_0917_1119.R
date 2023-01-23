
f=function(date,person,speciem,Pstart,P_number_start,Cstart,C_number_start,Box_start,Site_start)

{
S_number_a <- rep(date,person*5)
S_number_b <- rep(sprintf('%0.3d', 1:person),each = 5)
S_number <- paste(S_number_a,S_number_b,sep="")

P_number_a <- rep(Pstart,person*5)
P_number_b <- rep(sprintf('%0.4d', (P_number_start):(P_number_start+person-1)),each = 5)
P_number  <-  paste(P_number_a,P_number_b,sep="")

C_number_a <- rep(Cstart,person*5)
C_number_b <- sprintf('%0.5d', (C_number_start):(C_number_start+person*5-1))
C_number  <-  paste(C_number_a,C_number_b,sep="")


Site <- ((Site_start-1  + 0:(person*5-1)) %% 100) + 1

Box <- Box_start  + (Site_start + (-1):(person*5-2)) %/% 100

Box <- paste0("P",sprintf('%0.4d', Box))

OUT <- data.frame(S_number_a,S_number,P_number,C_number,Box,Site," ")

print(data.frame(QC_miss_person,QC_miss_number))


QC_start <- rep(5,person)

if( length(QC_miss_person) > 0)

{

delete <- NULL

for (i in 1:length(QC_miss_person)) {
QC_start[QC_miss_person[i]] <- QC_start[QC_miss_person[i]]-QC_miss_number[i]
delete <- c(delete,(5*QC_miss_person[i]-QC_miss_number[i]+1) : (5*QC_miss_person[i]))
}

OUT2 <- OUT[-delete,]

QC <- rep(0,person*5 - length(delete))
QC[cumsum(QC_start)] <- 1


QC_start <- rep(5,person)

delete <- NULL

for (i in 1:length(QC_miss_person)) {
QC_start[QC_miss_person[i]] <- QC_start[QC_miss_person[i]]-QC_miss_number[i]
delete <- c(delete,(5*QC_miss_person[i]-QC_miss_number[i]+1) : (5*QC_miss_person[i]))
}

OUT2 <- OUT[-delete,]

QC <- rep(0,person*5 - length(delete))
QC[cumsum(QC_start)] <- 1

OUT3 <- data.frame(OUT2,"P",QC)

}else {  

 QC <- rep(c(0,0,0,0,1),person)
 OUT3 <- data.frame(OUT,"P",QC)    }

print(OUT3[(dim(OUT3)[1]-5):dim(OUT3)[1],])
return(OUT3)

}

#################################################################

QC_miss_person <- c(53)
QC_miss_number <- c(1)

out_20220917 <- f(20220917,87,"P","P11",1014,"C06",5066,51,66)

#################################################################

QC_miss_person <- NULL
QC_miss_number <- NULL

out_20220924 <- f(20220924,58,"P","P11",1101,"C06",5501,56,1)

#################################################################

QC_miss_person <- c(21,22,23,24,25,30)
QC_miss_number <- c(3,1,2,1,2,1)

out_20221001 <- f(20221001,67,"P","P11",1159,"C06",5791,58,91)

#################################################################

QC_miss_person <- c(55,56,57,64,80,85,86,107)
QC_miss_number <- c(1,2,1,1,2,1,1,1)

out_20221015 <- f(20221015,109,"P","P11",1226,"C06",6126,62,26)

#################################################################

QC_miss_person <- c(18,42)
QC_miss_number <- c(1,1)

out_20221022 <- f(20221022,106,"P","P11",1335,"C06",6671,67,71)

#################################################################

QC_miss_person <- c(21)
QC_miss_number <- c(1)


out_20221029 <- f(20221029,61,"P","P11",1441,"C06",7201,73,1)

#################################################################

QC_miss_person <- NULL
QC_miss_number <- NULL

out_20221105 <- f(20221105,53,"P","P11",1502,"C06",7506,76,6)

#################################################################

QC_miss_person <- c(10,37,46,94,100)
QC_miss_number <- c(1,1,1,5,3)

out_20221112 <- f(20221112,106,"P","P11",1555,"C06",7771,78,71)

#################################################################

QC_miss_person <- c(19,38,43,50,94,95)
QC_miss_number <- c(2,2,2,3,1,1)

out_20221119 <- f(20221119,122,"P","P11",1661,"C06",8301,84,1)

#################################################################


out_total <- rbind(out_20220917,out_20220924,out_20221001,out_20221015,out_20221022,
out_20221029,out_20221105,out_20221112,out_20221119)

dim(out_total)

out <- data.frame(sid=out_total$S_number,P_number=out_total$P_number,
C_number=out_total$C_number,Box=out_total$Box,Site=out_total$Site,
ML = 0 ,Specimen = "P",QC=out_total$QC,C_Date=out_total$S_number_a,
IN_time = 20220910,CMRC_Reserved=0,sup=0)

library(RMySQL)
library(DBI)

mysqlconnection = dbConnect(MySQL(), dbname = "kao_practice_5",user = 'kaonthu', password = 'asd123',host = '192.168.1.41')

dbListTables(mysqlconnection)
summary(mysqlconnection)

dbWriteTable(mysqlconnection,"Total_speciem_2022_0917_1119",out,append=TRUE)
