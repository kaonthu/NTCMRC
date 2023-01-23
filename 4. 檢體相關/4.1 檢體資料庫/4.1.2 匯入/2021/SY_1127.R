
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


QC_miss_person <- c(1,4,7,10,17,19,23,24,26,29,30,32,38,42,47,52,57,58,61,63,69,70,71,73,74,75,76,79,80,89,93,94,95,96,98,99,100,102,104,107)
QC_miss_number <- c(1,1,1,1,1,2,1,1,2,1,7,1,5,2,3,3,1,2,2,2,2,2,1,1,4,5,1,2,2,2,1,1,1,1,2,1,2,1,3,3)


out_20211127 <- f(20211127,108,"SY","P10",1223,"C04",92189,3909,91)


out <- data.frame(sid=out_20211127$S_number,P_number=out_20211127$P_number,
C_number=out_20211127$C_number,Box=out_20211127$Box,Site=out_20211127$Site,
ML = 0,Specimen ="SY",QC=out_20211127$QC,C_Date=out_20211127$S_number_a,
IN_time = 20211128,CMRC_Reserved=0,sup=0)


library(RMySQL)
library(DBI)

mysqlconnection = dbConnect(MySQL(), dbname = "kao_practice_5",user = 'kaonthu', password = 'asd123',host = '192.168.1.41')

#dbListTables(mysqlconnection)
#summary(mysqlconnection)


dbWriteTable(mysqlconnection,"Total_speciem_20211127",out,append=TRUE)


#library(RMySQL)
#cons <- dbListConnections(MySQL())
#for (con in cons)dbDisconnect(con)


