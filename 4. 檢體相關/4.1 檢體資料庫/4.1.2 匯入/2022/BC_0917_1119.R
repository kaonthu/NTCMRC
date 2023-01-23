f=function(date,person,speciem,Pstart,P_number_start,Cstart,C_number_start,Box_start,Site_start)

{
S_number_a <- rep(date,person)
S_number_b <- rep(sprintf('%0.3d', 1:person),each = 1)
S_number <- paste(S_number_a,S_number_b,sep="")

P_number_a <- rep(Pstart,person*1)
P_number_b <- rep(sprintf('%0.4d', (P_number_start):(P_number_start+person-1)),each = 1)
P_number  <-  paste(P_number_a,P_number_b,sep="")

C_number_a <- rep(Cstart,person*1)
C_number_b <- sprintf('%0.5d', (C_number_start):(C_number_start+person*1-1))
C_number  <-  paste(C_number_a,C_number_b,sep="")


Site <- ((Site_start-1  + 0:(person*1-1)) %% 100) + 1

Box <- Box_start  + (Site_start + (-1):(person*1-2)) %/% 100

Box <- paste0("B",sprintf('%0.4d', Box))

OUT <- data.frame(S_number_a,S_number,P_number,C_number,Box,Site," ")

#print(data.frame(QC_miss_person,QC_miss_number))


QC_start <- rep(1,person)

if( length(QC_miss_person) > 0)

{

delete <- NULL

for (i in 1:length(QC_miss_person)) {
QC_start[QC_miss_person[i]] <- QC_start[QC_miss_person[i]]-QC_miss_number[i]
delete <- c(delete,(1*QC_miss_person[i]-QC_miss_number[i]+1) : (1*QC_miss_person[i]))
}

OUT2 <- OUT[-delete,]

QC <- rep(0,person*1 - length(delete))
QC[cumsum(QC_start)] <- 1


QC_start <- rep(1,person)

delete <- NULL

for (i in 1:length(QC_miss_person)) {
QC_start[QC_miss_person[i]] <- QC_start[QC_miss_person[i]]-QC_miss_number[i]
delete <- c(delete,(1*QC_miss_person[i]-QC_miss_number[i]+1) : (1*QC_miss_person[i]))
}

OUT2 <- OUT[-delete,]

QC <- rep(0,person*1 - length(delete))
QC[cumsum(QC_start)] <- 1

OUT3 <- data.frame(OUT2,"BC",QC)

}else {  

 QC <- rep(c(0),person)
 OUT3 <- data.frame(OUT,"BC",QC)    }

print(OUT3[(dim(OUT3)[1]-5):dim(OUT3)[1],])
return(OUT3)

}

#################################################################

QC_miss_person <- NULL
QC_miss_number <- NULL

out_20220917 <- f(20220917,87,"BC","P11",1014,"B00",1014,0011,14)

#################################################################

QC_miss_person <- NULL
QC_miss_number <- NULL

out_20220924 <- f(20220924,58,"BC","P11",1101,"B00",1101,0012,1)

#################################################################

QC_miss_person <- NULL
QC_miss_number <- NULL

out_20221001 <- f(20221001,67,"BC","P11",1159,"B00",1159,0012,59)

#################################################################

QC_miss_person <- NULL
QC_miss_number <- NULL

out_20221015 <- f(20221015,109,"BC","P11",1226,"B00",1226,0013,26)

#################################################################

QC_miss_person <- NULL
QC_miss_number <- NULL

out_20221022 <- f(20221022,106,"BC","P11",1335,"B00",1335,0014,35)

#################################################################

QC_miss_person <- NULL
QC_miss_number <- NULL

out_20221029 <- f(20221029,61,"BC","P11",1441,"B00",1441,0015,41)

#################################################################

QC_miss_person <- NULL
QC_miss_number <- NULL

out_20221105 <- f(20221105,53,"BC","P11",1502,"B00",1502,0016,2)

#################################################################

QC_miss_person <- NULL
QC_miss_number <- NULL

out_20221112 <- f(20221112,106,"BC","P11",1555,"B00",1555,0016,55)

#################################################################

QC_miss_person <- NULL
QC_miss_number <- NULL

out_20221119 <- f(20221119,122,"BC","P11",1661,"B00",1661,0017,61)

#################################################################

out_total <- rbind(out_20220917,out_20220924,out_20221001,out_20221015,out_20221022,
out_20221029,out_20221105,out_20221112,out_20221119)

out <- data.frame(sid=out_total$S_number,P_number=out_total$P_number,
C_number=out_total$C_number,Box=out_total$Box,Site=out_total$Site,
ML = 0 ,Specimen = "BC",QC=out_total$QC,C_Date=out_total$S_number_a,
IN_time = 20221125,CMRC_Reserved=0,sup=0)

library(RMySQL)
library(DBI)

mysqlconnection = dbConnect(MySQL(), dbname = "kao_practice_5",user = 'kaonthu', password = 'asd123',host = '192.168.1.41')

#dbListTables(mysqlconnection)
#summary(mysqlconnection)

dbWriteTable(mysqlconnection,"Total_speciem_2022_0917_1119",out,append=TRUE)
