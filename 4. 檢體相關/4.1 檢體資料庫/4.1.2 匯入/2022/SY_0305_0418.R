
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

###########################################################

QC_miss_person <- c(5,6,12,13,16,20,21,24,25,26,28,33,35,38,41,42,43,
44,45,46,50,55,57,62,66,67,72,73,77,79,86,87,90)

QC_miss_number <- c(1,1,1,2,2,2,1,3,2,1,2,2,2,2,2,2,2,2,2,2,2,1,2,3,3,1,3,1,1,4,4,1,1)

out_20220305 <- f(20220305,91,"SY","P11",1,"C07",1,1,1)

#################################################################

QC_miss_person <- c(5,8,9,11,12,14,16,18,19,20,21,22,24,25,26,27,31,33,34,35,36,37,38,40,
41,43,44,45,46,48,49,50,51,52,53,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,
75,76,77,78,80,81,82,83,84,85,86,87,88,89)

QC_miss_number <- c(2,4,1,4,1,2,1,1,1,3,1,3,2,1,2,1,2,2,2,2,3,4,3,4,3,1,2,1,1,2,1,4,2,1,3,
3,2,2,1,2,2,4,1,3,2,2,1,3,2,3,3,4,4,3,2,2,3,4,4,3,2,1,1,2,3,2,5,2)

out_20220312 <- f(20220312,90,"SY","P11",92,"C07",911,10,11)

#################################################################
QC_miss_person <- c(2,9,20,25,39,43,64)
QC_miss_number <- c(1,1,1,1,1,1,4)

out_20220319 <- f(20220319,71,"SY","P11",182,"C07",1811,19,11)

#################################################################

QC_miss_person <- c(4,6,10,17,18,22,23,26,30,32,36,39,41,46,47,50,52,53,56,58,60,63,66,69,73,75,76,77)

QC_miss_number <- c(3,6,6,4,2,4,4,3,3,2,4,1,4,3,1,3,1,3,2,3,4,2,4,2,1,1,4,3)

out_20220418 <- f(20220418,77,"SY","P11",253,"C07",2521,26,21)

#################################################################

out_total <- rbind(out_20220305,out_20220312,out_20220319,out_20220418)

library(RMySQL)
library(DBI)

mysqlconnection = dbConnect(MySQL(), dbname = "kao_practice_5",user = 'kaonthu', password = 'asd123',host = '192.168.1.41')

#dbListTables(mysqlconnection)
#summary(mysqlconnection)

out <- data.frame(sid=out_total$S_number,P_number=out_total$P_number,
C_number=out_total$C_number,Box=out_total$Box,Site=out_total$Site,
ML = 0,Specimen ="SY",QC=out_total$QC,C_Date=out_total$S_number_a,
IN_time = 20220606,CMRC_Reserved=0,sup=0)

dbWriteTable(mysqlconnection,"Total_speciem_2022_0305_0418",as.data.frame(out),append=TRUE)


