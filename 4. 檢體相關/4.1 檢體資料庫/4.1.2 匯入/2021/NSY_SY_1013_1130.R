
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

# 20211013  

out_20211013 <- f(20211013,53,"NSY","P10",435,"C04",28541,705,84)

#################################################################

QC_miss_person <- NULL
QC_miss_number <- NULL

# 20211016 

out_20211016 <- f(20211016,108,"NSY","P10",488,"C04",28594,706,37)

#################################################################

QC_miss_person <- NULL
QC_miss_number <- NULL
# 20211023

out_20211023 <- f(20211023,86,"NSY","P10",596,"C04",28702,707,45)

#################################################################

QC_miss_person <- NULL
QC_miss_number <- NULL
# 20211027

out_20211027 <- f(20211027,46,"NSY","P10",682,"C04",28788,708,31)

#################################################################

QC_miss_person <- NULL
QC_miss_number <- NULL
# 20211030

out_20211030 <- f(20211030,60,"NSY","P10",728,"C04",28834,708,77)

###########################################################

QC_miss_person <- NULL
QC_miss_number <- NULL
  
out_20211103 <- f(20211103,66,"SY","P10",788,"C40",28894,709,37)

#################################################################

QC_miss_person <- NULL
QC_miss_number <- NULL

out_20211113 <- f(20211113,108,"SY","P10",854,"C40",28960,710,3)

#################################################################

QC_miss_person <- NULL
QC_miss_number <- NULL

out_20211117 <- f(20211117,76,"SY","P10",962,"C40",29068,711,11)

#################################################################

QC_miss_person <- NULL
QC_miss_number <- NULL

out_20211120 <- f(20211120,94,"SY","P10",1038,"C40",29144,711,87)

#################################################################

QC_miss_person <- NULL
QC_miss_number <- NULL

out_20211124 <- f(20211124,91,"SY","P10",1132,"C40",29238,712,81)

#################################################################

QC_miss_person <- NULL
QC_miss_number <- NULL

out_20211127 <- f(20211127,108,"SY","P10",1223,"C40",29329,713,72)

#################################################################

QC_miss_person <- NULL
QC_miss_number <- NULL

out_20211130 <- f(20211130,85,"SY","P10",1331,"C40",29437,714,80)

#################################################################

out_total <- rbind(out_20211013,out_20211016,out_20211023,out_20211027,out_20211030,
out_20211103,out_20211113,out_20211117,out_20211120,out_20211124,out_20211127,out_20211130)

out <- data.frame(sid=out_total$S_number,P_number=out_total$P_number,
C_number=out_total$C_number,Box=out_total$Box,Site=out_total$Site,
ML = 0 ,Specimen = "SY",QC=out_total$QC,C_Date=out_total$S_number_a,
IN_time = 20211201,CMRC_Reserved=1,sup=0)

library(RMySQL)
library(DBI)

library(RMySQL)
library(DBI)

mysqlconnection = dbConnect(MySQL(), dbname = "kao_practice_5",user = 'kaonthu', password = 'asd123',host = '192.168.1.41')

#dbListTables(mysqlconnection)
#summary(mysqlconnection)

dbWriteTable(mysqlconnection,"Total_speciem_2021_1013_1130",out,append=TRUE)

#library(RMySQL)
#cons <- dbListConnections(MySQL())
#for (con in cons)dbDisconnect(con)







