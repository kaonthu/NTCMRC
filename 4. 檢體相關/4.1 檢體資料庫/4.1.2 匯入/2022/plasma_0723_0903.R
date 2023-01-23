
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

QC_miss_person <- c(6)
QC_miss_number <- c(1)

out_20220723 <- f(20220723,75,"P","P11",330,"C06",1646,17,46)

#################################################################

QC_miss_person <- c(7,11,15,17,20,23,25,26,29,30,32,33,35,36,40,41,44,47,50,52,55,58,60,61,63,64,69,72,80,86,93)
QC_miss_number <- c(1,3,2,2,3,1,4,1,3,1,1,1,1,1,1,1,1,1,1,1,1,1,3,1,2,3,2,1,1,2,2)


out_20220730 <- f(20220730,95,"P","P11",405,"C06",2021,21,21)

#################################################################

QC_miss_person <- c(47,62)
QC_miss_number <- c(1,2)


out_20220813 <- f(20220813,106,"P","P11",500,"C06",2496,25,96)

#################################################################

QC_miss_person <- c(14,59,83,86)
QC_miss_number <- c(2,1,2,2)

out_20220817 <- f(20220817,87,"P","P11",606,"C06",3026,31,26)

#################################################################

QC_miss_person <- c(2,24,69,72,73,78,82,84,91,95,97,114,115)
QC_miss_number <- c(1,1,1,1,1,1,2,1,1,1,1,2,1)

out_20220820 <- f(20220820,119,"P","P11",693,"C06",3461,35,61)

#################################################################

QC_miss_person <- c(73,100)
QC_miss_number <- c(1,3)


out_20220827 <- f(20220827,100,"P","P11",812,"C06",4056,41,56)

#################################################################

QC_miss_person <- c(28,38,68,75,79,83,89)
QC_miss_number <- c(1,1,1,2,1,1,1)


out_20220903 <- f(20220903,102,"P","P11",912,"C06",4556,46,56)

#################################################################

out_total <- rbind(out_20220723,out_20220730,out_20220813,out_20220817,out_20220820,out_20220827,out_20220903)

out <- data.frame(sid=out_total$S_number,P_number=out_total$P_number,
C_number=out_total$C_number,Box=out_total$Box,Site=out_total$Site,
ML = 0 ,Specimen = "P",QC=out_total$QC,C_Date=out_total$S_number_a,
IN_time = 20220910,CMRC_Reserved=0,sup=0)

library(RMySQL)
library(DBI)

mysqlconnection = dbConnect(MySQL(), dbname = "kao_practice_5",user = 'kaonthu', password = 'asd123',host = '192.168.1.41')

dbListTables(mysqlconnection)
summary(mysqlconnection)

dbWriteTable(mysqlconnection,"Total_speciem_2022_0723_0903",out,append=TRUE)
