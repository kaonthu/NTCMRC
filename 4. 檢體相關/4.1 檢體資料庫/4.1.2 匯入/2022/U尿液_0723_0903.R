f=function(date,person,Pstart,P_number_start,Cstart,C_number_start,Box_start,Site_start)

{
S_number_a <- rep(date,person*4)
S_number_b <- rep(sprintf('%0.3d', 1:person),each = 4)
S_number <- paste(S_number_a,S_number_b,sep="")

P_number_a <- rep(Pstart,person*4)
P_number_b <- rep(sprintf('%0.4d', (P_number_start):(P_number_start+person-1)),each = 4)
P_number  <-  paste(P_number_a,P_number_b,sep="")

C_number_a <- rep(Cstart,person*4)
C_number_b <- sprintf('%0.5d', (C_number_start):(C_number_start+person*4-1))
C_number  <-  paste(C_number_a,C_number_b,sep="")

ML <- rep(12.5,person*4)

Speciem <- rep(c("Uw","Uw","U","U"),person)

OUT <- data.frame(S_number_a,S_number,P_number,C_number,ML,Speciem)


QC_miss_person <- c(1:person)
QC_receive <- rep(0,person)


TEMP <- rep(0,person)  # 假設每個人一開始都是0管尿
TEMP[who_U] <- number_U # 有管的人是誰 需要輸入
QC_receive <- TEMP     #

QC_miss_number <- 4-QC_receive

QC_start <- rep(4,person)

if( length(QC_miss_person) > 0)

{

delete <- NULL

for (i in 1:length(QC_miss_person)) {

	if ( QC_receive[i] < 4) 
{
	QC_start[QC_miss_person[i]] <- QC_start[QC_miss_person[i]]-QC_miss_number[i]
	delete <- c(delete,(4*QC_miss_person[i]-QC_miss_number[i]+1) : (4*QC_miss_person[i]))
} else { 
	delete <- delete 
}

}

OUT2 <- OUT[-delete,]

QC <- rep(0,person*4 - length(delete))
QC[unique(cumsum(QC_start))] <- 1 #每個人的最後一管位置

OUT2$ML[unique(cumsum(QC_start))] <- last_ml

 Site <- ((Site_start-1  + 0:( dim(OUT2)[1]-1)) %% 36) + 1
 Box <- Box_start  + (Site_start + (-1):(dim(OUT2)[1]-2)) %/% 36
 OUT3 <- data.frame(OUT2[,c("S_number_a","S_number","P_number","C_number")],
         Box,Site,OUT2[,c("ML","Speciem")],QC)

}else {  
 QC <- rep(c(0,0,0,1),person)
 Site <- ((Site_start-1  + 0:( dim(OUT)[1]-1)) %% 36) + 1
 Box <- Box_start  + (Site_start + (-1):(dim(OUT3)[1]-2)) %/% 36
 OUT3 <- data.frame(OUT2[,c("S_number_a","S_number","P_number","C_number")],
         Box,Site,OUT2[,c("ML","Speciem")],QC)
 }

print(OUT3[(dim(OUT3)[1]-10):dim(OUT3)[1],])
return(OUT3)

}

#################################################################

who_U <- c(2,3,5,9,16,17,18,22,24,25,30,33,38,41,42,45,49,52,56,62,63,75)

number_U <- c(4,2,4,4,3,4,2,2,4,3,4,3,2,4,2,4,4,4,4,4,2,4)

last_ml <- c(8.5,5.5,8,7,12.5,8,12.5,12.5,9,12.5,8,11.5,12.5,7,12,7.5,2.5,8,8.5,8,7.5,7.5)

out_20220723 <- f(20220723,75,"P11",330,"C05",11317,1494,25)

#################################################################

who_U <- c(2,3,7,18,24,26,34,35,47,49,52,55,58,59,60,63,65,68,69,70,79,83,88,90,91,93,95)

number_U <- c(4,1,2,4,1,2,2,2,2,3,2,1,2,1,1,2,2,1,2,4,3,2,2,2,1,4,3)

last_ml <- c(6.5,12,12.5,5.5,12.5,12.5,9,9,12.5,10,5.5,12,4,12.5,12,5.5,12.5,12.5,5.5,6,7.5,5.5,10.5,9,12,8,4)

out_20220730 <- f(20220730,95,"P11",405,"C05",11617,1496,26)

#################################################################

who_U <- c(5,13,19,22,25,32,34,35,37,38,41,44,47,52,53,56,62,66,67,70,75,77,79,80,81,84,87,93,99,101,102,104)

number_U <- c(4,4,2,2,4,4,3,4,4,3,4,2,2,2,3,2,4,4,3,4,2,2,3,3,2,3,3,2,4,4,4,2)

last_ml <- c(3,3.5,12.5,4,11.5,11,10,3,3.5,6.5,8,3.5,8,11,5,5,7.5,8.5,8,6,4.5,9.5,4.5,2,6,12.5,12,8.5,8.5,7.5,4,12.5)

out_20220813 <- f(20220813,106,"P11",500,"C05",11997,1498,12)

#################################################################

who_U <- c(4,6,7,9,10,11,21,22,26,30,31,32,37,48,49,51,54,57,58,60,61,68,71,76,77,79,85,87)

number_U <- c(3,4,4,2,4,4,3,3,2,3,4,3,2,4,2,2,4,3,3,4,4,4,3,3,4,3,2,4)

last_ml <- c(4.5,9,11,7,9.5,9.5,7,10.5,8,5.5,6,6.5,10,10,3.5,4,8,6.5,7,9,6,10.5,5.5,7.5,2.5,3,6,7)

out_20220817 <- f(20220817,87,"P11",606,"C05",12421,1501,2)

#################################################################

who_U <- c(8,9,11,14,16,22,24,26,31,43,44,45,49,55,58,59,61,62,63,69,73,76,81,83,84,87,89,91,95,97,99,100,102,104,108,111,112,115,116)

number_U <- c(4,3,4,4,2,4,3,2,2,2,2,2,2,2,2,4,3,2,2,2,4,2,3,2,3,2,2,2,3,2,2,4,4,4,2,4,3,4,2)

last_ml <- c(10,12.5,8,8.5,12.5,11.5,8,12,12.5,12.5,8,9,5,8.5,3,5,4.5,12.5,9.5,12.5,10,12.5,12.5,4.5,8,6,12.5,12.5,9,12.5,6,9.5,7.5,5.5,4.5,7.5,8,7.5,12.5)

out_20220820 <- f(20220820,119,"P11",693,"C05",12769,1503,20)

#################################################################

who_U <- c(2,11,19,23,29,30,34,39,40,41,43,45,46,47,48,50,53,55,56,60,61,63,64,71,73,74,79,80,83,86,88,96,97,100)

number_U <- c(3,3,2,4,4,4,2,4,4,4,3,4,4,4,3,4,2,3,3,4,4,4,4,4,4,4,4,4,3,4,3,3,4,2)

last_ml <- c(7,6,12,3.5,11.5,9.5,12.5,10,10,9.5,12.5,8,7,10.5,3.5,3,12.5,5.5,4.5,6,10.5,9,8,3.5,10.5,8,8.5,8,11.5,6.5,12.5,5.5,8.5,12)

out_20220827 <- f(20220827,100,"P11",812,"C05",13245,1506,19)

#################################################################

who_U <- c(7,10,11,17,19,22,30,31,33,35,37,42,50,51,58,59,60,62,63,64,71,75,86,89,93,94,99)

number_U <- c(4,3,2,3,2,2,2,3,3,2,3,3,4,4,2,2,3,3,4,2,2,3,2,2,3,4,4)

last_ml <- c(10,10,12.5,4,10,12,6.5,10,9,11.5,12.5,10,4.5,10,12.5,9.5,12.5,12.5,9.5,12.5,4,8,6.5,4,12.5,4.5,9)

out_20220903 <- f(20220903,102,"P11",912,"C05",13645,1509,30)

#################################################################
#cbind(who_U,number_U,last_ml)

out_total <- rbind(out_20220723,out_20220730,out_20220813,out_20220817,out_20220820,out_20220827,out_20220903)


out <- data.frame(sid=out_total$S_number,P_number=out_total$P_number,
C_number=out_total$C_number,Box=out_total$Box,Site=out_total$Site,
ML = out_total$ML ,Specimen = out_total$Speciem,QC=out_total$QC,C_Date=out_total$S_number_a,
IN_time = 20220910,CMRC_Reserved=0,sup=0)

dim(out)


library(RMySQL)
library(DBI)

mysqlconnection = dbConnect(MySQL(), dbname = "kao_practice_5",user = 'kaonthu', password = 'asd123',host = '192.168.1.41')

#dbListTables(mysqlconnection)
#summary(mysqlconnection)


dbWriteTable(mysqlconnection,"Total_speciem_2022_0723_0903",out,append=TRUE)

#library(RMySQL)
#cons <- dbListConnections(MySQL())
#for (con in cons)dbDisconnect(con)
