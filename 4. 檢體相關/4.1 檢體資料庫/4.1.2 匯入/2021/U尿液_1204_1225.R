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

who_U <- c(1,3,4,5,6,12,15,20,24,33,34,43,44,45,55,63,64,69,70,79,81,88,89,92,99)

number_U <- c(4,4,1,3,4,1,4,3,2,4,4,2,4,2,4,2,4,1,3,1,2,3,1,3,4)

last_ml <- c(10,9.5,12.5,12.5,4,12,9.5,7,10,9.5,11,11,9,6.5,5.5,10.5,4,12.5,12.5,12,12.5,7,12.5,12.5,11)

out_20211204 <- f(20211204,104,"P10",1416,"C05",04763,1471,6)

example <- cbind(who_U,number_U,last_ml)

write.table(example,"D:/基隆長庚社區醫學科研究中心/CMRC社區資料庫/20220112檢體登記/U_20211225.csv",sep=",")




#################################################################

who_U <- c(4,5,6,9,13,18,19,20,21,23,30,40,41,52,58,64,78,85,87,92,93)

number_U <- c(4,4,1,4,3,2,4,4,2,3,2,4,3,2,2,4,4,4,4,3,3)

last_ml <- c(4.5,5.5,12.5,7.5,7,12.5,7.5,4,4.5,3.5,6.5,6,8,12.5,7,6,7.5,7,7.5,4.5,12)

out_20211208 <- f(20211208,94,"P10",1520,"C05",05179,1473,4)

#################################################################

who_U <- c(1,2,3,6,7,8,9,12,13,14,20,22,23,25,28,30,31,33,36,38,39,42,43,47,48,53,60,62,63,64,66,68,70,73)

number_U <- c(3,4,2,3,3,3,1,4,3,4,3,3,1,4,4,4,4,1,2,4,3,3,4,4,4,2,2,3,2,3,4,2,2,4)

last_ml <- c(12.5,11,7,12.5,8,9,12.5,6.5,6,9.5,8.5,9,12.5,4,9,9.5,9.5,12.5,7,11,6.5,6.5,11,10,7,12.5,12.5,6.5,6.5,9.5,10,7.5,12.5,10)

out_20211211 <- f(20211211,80,"P10",1614,"C05",05555,1474,34)

#################################################################

who_U <- c(1,3,4,5,6,9,11,16,19,20,22,27,28,30,31,32,33,34,35,41,43,44,49,50,51,53,55,65)

number_U <- c(4,4,2,2,4,1,4,3,3,2,1,4,4,4,4,4,1,1,4,2,1,3,4,3,4,4,3,4)

last_ml <- c(8,8,9.5,9.5,7.5,11.5,8,12.5,3,5,12.5,8,7,10,7.5,7.5,11.5,12.5,10,6.5,10,8.5,10.5,8.5,11,10.5,3.5,12)

out_20211225 <- f(20211225,68,"P10",1694,"C05",05875,1477,28)

#################################################################
#cbind(who_U,number_U,last_ml)


out_total <- rbind(out_20211204,out_20211208,out_20211211,out_20211225)


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


dbWriteTable(mysqlconnection,"Total_speciem_2021_1204_1225",as.data.frame(out),append=TRUE)

#library(RMySQL)
#cons <- dbListConnections(MySQL())
#for (con in cons)dbDisconnect(con)
