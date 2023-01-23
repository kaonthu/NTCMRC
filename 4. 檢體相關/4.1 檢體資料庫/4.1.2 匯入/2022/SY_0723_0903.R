
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

QC_miss_person <- c(3,5,6,7,8,10,11,12,15,16,17,18,19,20,21,22,23,24,25,26,28,29,30,32,33,34,35,37,38,39,40,42,44,46,51,52,58,60,61,63,65,68,70,73,74,75)
QC_miss_number <- c(3,4,1,3,1,1,2,1,4,1,2,4,1,3,3,1,1,1,1,3,2,1,3,1,4,1,3,3,3,3,4,1,2,2,2,2,2,1,2,2,2,6,3,1,4,2)

out_20220723 <- f(20220723,75,"SY","P11",330,"C07",3291,33,91)

#################################################################

QC_miss_person <- c(4,5,8,9,10,14,16,25,28,30,32,35,38,39,43,45,46,48,50,53,55,56,59,62,65,67,70,78,81,83,86,93)
QC_miss_number <- c(2,3,3,2,1,2,3,4,2,2,4,4,3,1,2,1,1,3,1,2,3,1,2,1,2,1,2,1,1,1,1,5)


out_20220730 <- f(20220730,95,"SY","P11",405,"C07",4041,41,41)

#################################################################

QC_miss_person <- c(2,4,7,8,9,10,11,12,13,14,16,17,18,20,21,22,24,25,26,27,28,29,30,31,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,
48,49,50,51,53,54,55,59,82,83,88,89,90,96,98,99)
QC_miss_number <- c(3,2,2,3,2,1,2,1,2,2,2,2,2,2,2,1,2,1,3,1,1,1,2,2,1,2,1,2,1,2,2,2,2,3,4,2,2,3,3,1,4,4,1,1,1,3,2,3,1,2,2,3,1,1,1)


out_20220813 <- f(20220813,106,"SY","P11",500,"C07",4991,50,91)

#################################################################

QC_miss_person <- c(6,10,14,33,44,46,49,53,56,61,71,84)
QC_miss_number <- c(1,1,1,3,1,1,1,1,1,1,1,1)

out_20220817 <- f(20220817,87,"SY","P11",606,"C07",6051,61,51)

#################################################################

QC_miss_person <- c(3,5,7,14,49,59,60,62,63,65,68,72,73,74,78)
QC_miss_number <- c(1,1,1,5,1,1,1,1,1,1,1,1,3,1,2)

out_20220820 <- f(20220820,119,"SY","P11",693,"C07",6921,70,21)

#################################################################

QC_miss_person <- c(7,15,22,36,64,68,73,77,81,88,91,94,96,99)
QC_miss_number <- c(1,1,3,1,1,1,1,1,2,6,1,2,1,2)


out_20220827 <- f(20220827,100,"SY","P11",812,"C07",8111,82,11)

#################################################################

QC_miss_person <- c(5,9,10,16,17,30,31,33,34,44,45,51,52,55,56,57,58,60,61,62,63,64,65,66,67,68,70,71,72,73,74,75,76,78,79,80,81,83,
84,85,86,87,89,90,91,92,93,94,95,96,97,98,99,100,101)
QC_miss_number <- c(3,1,3,2,1,3,1,1,2,1,2,2,2,3,2,1,4,3,1,2,3,1,3,1,1,2,5,2,2,1,3,6,1,1,3,2,1,3,1,1,2,1,3,1,1,1,3,2,1,3,1,3,3,3,1)


out_20220903 <- f(20220903,102,"SY","P11",912,"C07",9111,92,11)

#################################################################

out_total <- rbind(out_20220723,out_20220730,out_20220813,out_20220817,out_20220820,out_20220827,out_20220903)

library(RMySQL)
library(DBI)

mysqlconnection = dbConnect(MySQL(), dbname = "kao_practice_5",user = 'kaonthu', password = 'asd123',host = '192.168.1.41')

#dbListTables(mysqlconnection)
#summary(mysqlconnection)

out <- data.frame(sid=out_total$S_number,P_number=out_total$P_number,
C_number=out_total$C_number,Box=out_total$Box,Site=out_total$Site,
ML = 0,Specimen ="SY",QC=out_total$QC,C_Date=out_total$S_number_a,
IN_time = 20220910,CMRC_Reserved=0,sup=0)

dbWriteTable(mysqlconnection,"Total_speciem_2022_0723_0903",out,append=TRUE)

