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


who_U <- c(3,4,5,8,11,17,20,21,22,23,25,27,28,29,37,38,41,42,43,46,47,48,49,52,53,55,56,58,60,61,62,65)

number_U <- c(3,3,4,4,2,3,2,2,3,3,2,4,3,3,2,3,2,4,4,3,2,3,2,3,4,2,4,4,3,1,2,4)

last_ml <- c(10,10,9.5,6,7,10,3.5,10.5,7.5,6,12.5,7,10,8.5,12.5,6.5,6.5,7,9,12.5,9.5,12,7.5,8.5,6.5,9.5,9.5,3.5,4.5,12,12.5,8.5)

out_20211103 <- f(20211103,66,"P10",788,"C05",02251,1451,36)

#################################################################

who_U <- c(1,3,7,12,24,26,29,31,36,39,40,46,51,52,54,59,61,72,93,94,96,99,100,102,104,105)

number_U <- c(4,4,4,3,4,4,4,4,2,4,4,3,4,3,3,3,4,3,2,4,2,4,4,4,4,3)

last_ml <- c(11,11,9,5.5,10.5,11.5,7.5,9.5,12.5,8.5,7,4,9,8,8,5,8.5,11.5,12,6.5,8.5,5.5,7,9,10,3.5)

out_20211113 <- f(20211113,108,"P10",854,"C05",02515,1454,21)

#################################################################

who_U <- c(2,3,4,6,7,8,9,11,15,17,18,19,20,21,22,24,25,26,28,29,31,34,36,38,41,42,44,45,46,49,50,51,52,53,54,55,58,60,64,69,71,73,74)

number_U <- c(1,3,2,4,2,4,4,4,4,4,4,4,3,4,3,4,4,2,4,4,2,3,4,4,3,4,4,4,4,4,4,4,3,3,2,4,4,2,4,4,4,4,1)

last_ml <- c(12.5,12.5,12.5,7.5,12.5,5.5,11,10,10,10,8,9.5,10,9,8.5,8,3.5,10.5,8,6,9.5,8.5,9,6.5,10,10.5,10,11.5,10.5,9.5,10,11.5,10.5,12.5,5,9.5,9,4.5,9,9,6,8.5,9)

out_20211117 <- f(20211117,76,"P10",962,"C05",02947,1457,4)

#################################################################

who_U <- c(4,5,6,17,22,23,26,27,28,29,32,33,36,38,39,41,42,43,44,49,50,52,55,57,59,60,61,62,66,67,71,72,76,78,79,83,84,88,89,90,92)

number_U <- c(1,2,4,2,1,4,2,1,4,4,3,3,2,3,4,3,4,4,2,2,4,2,2,3,4,2,4,3,4,3,1,2,4,1,3,4,3,4,1,2,2)

last_ml <- c(12,3,7,8.5,12.5,9,11.5,11.5,8.5,7,7,8,6,3.5,4,9,8.5,8.5,11,2,9,6.5,6,5,4.5,11,4.5,12.5,4.5,12,11.5,7.5,10.5,12.5,6,7,3.5,7.5,9,12.5,7)

out_20211120 <- f(20211120,94,"P10",1038,"C05",03251,1461,7)

#################################################################

who_U <- c(6,9,10,13,14,20,22,23,25,31,37,39,40,44,47,48,52,61,63,69,71,76,80,82,86,88,89,91)

number_U <- c(3,3,2,4,2,3,3,3,1,3,1,4,2,4,2,3,4,3,3,4,4,4,4,2,2,3,2,3)

last_ml <- c(4.5,4.5,12.5,6,12.5,5.5,12.5,5.5,12.5,12.5,12.5,5,6.5,8.5,12.5,7,4,7.5,3.5,6,9.5,8.5,9.5,9.5,9,8,6,8)

out_20211124 <- f(20211124,91,"P10",1132,"C05",03627,1464,12)

#################################################################

who_U <- c(11,12,15,17,20,22,23,24,30,31,33,38,45,49,50,54,55,63,76,87,93,97,108)

number_U <- c(3,4,2,2,3,4,2,4,4,2,2,4,4,4,3,3,3,3,4,3,4,3,2)

last_ml <- c(12.5,7.5,6.5,4,12.5,5.5,5,9,7,10,5,9,9,4.5,3,9,12.5,12.5,8.5,8.5,7,3,10.5)

out_20211127 <- f(20211127,108,"P10",1223,"C05",03991,1466,21)

#################################################################

who_U <- c(1,3,10,11,14,16,18,24,25,30,33,39,41,43,44,45,50,51,53,63,65,71,73,74,75,77,79,83)

number_U <- c(4,3,3,3,3,4,2,2,3,1,4,4,4,3,3,1,3,4,3,4,4,4,4,4,4,4,4,4)

last_ml <- c(9,6,10,7.5,11,8,11.5,11,4,12.5,8,8,9,12.5,12.5,12.5,12.5,9,4,6.5,7,9,10,5.5,9.5,9.5,9.5,10)

out_20211130 <- f(20211130,85,"P10",1331,"C05",04423,1468,21)


out_total <- rbind(out_20211103,out_20211113,out_20211117,out_20211120,out_20211124,out_20211127,out_20211130)


out <- data.frame(sid=out_total$S_number,P_number=out_total$P_number,
C_number=out_total$C_number,Box=out_total$Box,Site=out_total$Site,
ML = out_total$ML ,Specimen = out_total$Speciem,QC=out_total$QC,C_Date=out_total$S_number_a,
IN_time = 20211207,CMRC_Reserved=0,sup=0)

dim(out)


library(RMySQL)
library(DBI)

mysqlconnection = dbConnect(MySQL(), dbname = "kao_practice_5",user = 'kaonthu', password = 'asd123',host = '192.168.1.41')

#dbListTables(mysqlconnection)
#summary(mysqlconnection)


dbWriteTable(mysqlconnection,"Total_Urine_202111",out,append=TRUE)

#library(RMySQL)
#cons <- dbListConnections(MySQL())
#for (con in cons)dbDisconnect(con)
