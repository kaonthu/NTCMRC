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

Box <- paste0("New",sprintf('%0.4d', Box))

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

OUT3 <- data.frame(OUT2,"P",QC)

}else {  

 QC <- rep(c(0),person)
 OUT3 <- data.frame(OUT,"P",QC)    }

print(OUT3[(dim(OUT3)[1]-5):dim(OUT3)[1],])
return(OUT3)

}

#################################################################

QC_miss_person <- NULL
QC_miss_number <- NULL

out_20220723 <- f(20220723,75,"P","P11",330,"C60",330,1004,30)


#################################################################

QC_miss_person <- NULL
QC_miss_number <- NULL


out_20220730 <- f(20220730,95,"P","P11",405,"C60",405,1005,5)

#################################################################

QC_miss_person <- NULL
QC_miss_number <- NULL


out_20220813 <- f(20220813,106,"P","P11",500,"C60",500,1005,100)

#################################################################

QC_miss_person <- NULL
QC_miss_number <- NULL

out_20220817 <- f(20220817,87,"P","P11",606,"C60",606,1007,6)

#################################################################

QC_miss_person <- NULL
QC_miss_number <- NULL

out_20220820 <- f(20220820,119,"P","P11",693,"C60",693,1007,93)

#################################################################

QC_miss_person <- NULL
QC_miss_number <- NULL

out_20220827 <- f(20220827,100,"P","P11",812,"C60",812,1009,12)

#################################################################

QC_miss_person <- NULL
QC_miss_number <- NULL

out_20220903 <- f(20220903,102,"P","P11",912,"C60",912,1010,12)

#################################################################

out_total <- rbind(out_20220723,out_20220730,out_20220813,out_20220817,out_20220820,out_20220827,out_20220903)

out <- data.frame(sid=out_total$S_number,P_number=out_total$P_number,
C_number=out_total$C_number,Box=out_total$Box,Site=out_total$Site,
ML = 0 ,Specimen = "P",QC=out_total$QC,C_Date=out_total$S_number_a,
IN_time = 20220910,CMRC_Reserved=1,sup=0)

library(RMySQL)
library(DBI)

mysqlconnection = dbConnect(MySQL(), dbname = "kao_practice_5",user = 'kaonthu', password = 'asd123',host = '192.168.1.41')

#dbListTables(mysqlconnection)
#summary(mysqlconnection)

dbWriteTable(mysqlconnection,"Total_speciem_2022_0723_0903",out,append=TRUE)
