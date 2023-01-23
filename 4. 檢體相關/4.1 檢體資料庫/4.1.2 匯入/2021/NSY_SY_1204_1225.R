
f=function(date,person,speciem,Pstart,P_number_start,Cstart,C_number_start,Box_start,Site_start)

{
S_number_a <- rep(date,person*1)
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

OUT3 <- data.frame(OUT2,"SY",QC)

}else {  

 QC <- rep(c(0),person)
 OUT3 <- data.frame(OUT,"SY",QC)    }

print(OUT3[(dim(OUT3)[1]-10):dim(OUT3)[1],])
return(OUT3)

}

###########################################################

QC_miss_person <- NULL
QC_miss_number <- NULL
  
out_20211204 <- f(20211204,104,"SY","P10",1416,"C40",29522,715,65)

#################################################################

QC_miss_person <- NULL
QC_miss_number <- NULL

out_20211208 <- f(20211208,94,"SY","P10",1520,"C40",29626,716,69)

#################################################################

QC_miss_person <- NULL
QC_miss_number <- NULL

out_20211211 <- f(20211211,80,"SY","P10",1614,"C40",29720,717,63)

#################################################################

QC_miss_person <- NULL
QC_miss_number <- NULL

out_20211225 <- f(20211225,68,"SY","P10",1694,"C40",29800,718,43)

#################################################################

out_total <- rbind(out_20211204,out_20211208,out_20211211,out_20211225)


out <- data.frame(sid=out_total$S_number,P_number=out_total$P_number,
C_number=out_total$C_number,Box=out_total$Box,Site=out_total$Site,
ML = 0 ,Specimen = "SY",QC=out_total$QC,C_Date=out_total$S_number_a,
IN_time = 20220112,CMRC_Reserved=1,sup=0)

library(RMySQL)
library(DBI)

mysqlconnection = dbConnect(MySQL(), dbname = "kao_practice_5",user = 'kaonthu', password = 'asd123',host = '192.168.1.41')

#dbListTables(mysqlconnection)
#summary(mysqlconnection)

dbWriteTable(mysqlconnection,"Total_speciem_2021_1204_1225",out,append=TRUE)







