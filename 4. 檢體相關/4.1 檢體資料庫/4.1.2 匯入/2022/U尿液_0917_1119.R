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

who_U <- c(3,9,11,22,25,28,37,38,40,49,51,52,56,57,61,63,64,67,72,78,82,84,87)

number_U <- c(4,4,4,3,3,4,4,4,3,4,2,4,4,2,3,3,3,4,2,4,3,3,4)

last_ml <- c(9.5,7.5,7.5,12.5,5,9,8,8,12.5,6.5,12.5,8,7,12.5,8,12.5,12.5,7,5,8,7,6,9.5)

out_20220917 <- f(20220917,87,"P11",1014,"C05",14053,1511,34)

#################################################################

who_U <- c(3,4,6,7,9,10,21,22,24,28,39,45,49,53,58)

number_U <- c(3,2,3,3,4,3,3,4,4,3,3,4,2,3,2)

last_ml <- c(8,8.5,4,12.5,10,12,7,10,10,5.5,10,8,6,12.5,12.5)

out_20220924 <- f(20220924,58,"P11",1101,"C05",14401,1514,4)

#################################################################

who_U <- c(8,9,13,16,20,38,39,41,44,45,47,48,50,63,67)

number_U <- c(4,3,3,2,4,2,2,3,2,2,3,2,3,4,3)

last_ml <- c(8,5,10,8.5,11,12.5,12.5,12,7.5,12.5,10,5.5,8,6,5)

out_20221001 <- f(20221001,67,"P11",1159,"C05",14633,1515,14)

#################################################################

who_U <- c(5,9,11,12,14,20,23,28,32,39,42,46,48,50,62,64,70,72,73,74,78,83,88,89,91,92,94,103)

number_U <- c(4,2,1,4,3,3,3,3,3,3,1,3,4,4,4,3,4,4,4,4,4,4,4,1,1,4,4,3)

last_ml <- c(6,12.5,12.5,6.5,12.5,3,12.5,8.5,12.5,4.5,12.5,8.5,5,7.5,9.5,12.5,8,9.5,9.5,8.5,9,8,5.5,11.5,11.5,7.5,2,2)

out_20221015 <- f(20221015,109,"P11",1226,"C05",14901,1516,20)

#################################################################

who_U <- c(2,6,7,8,14,27,51,60,92,93,95,99,103,105)

number_U <- c(4,4,2,4,2,3,2,2,4,4,3,4,3,4)

last_ml <- c(9,5.5,11.5,9.5,10.5,12.5,12.5,12.5,5.5,10,10.5,7.5,6.5,9)

out_20221022 <- f(20221022,106,"P11",1335,"C05",15337,1519,1)

#################################################################

who_U <- c(2,3,12,17,20,22,25,31,42,46,58,60)

number_U <- c(2,4,4,3,3,3,4,2,2,3,4,2)

last_ml <- c(8.5,4.5,5,11.5,10,9,4,11.5,12.5,12.5,8,12.5)

out_20221029 <- f(20221029,61,"P11",1441,"C05",15761,1520,10)

#################################################################

who_U <- c(1,8,9,12,16,17,18,21,26,29,30,31,33,49)

number_U <- c(2,3,3,2,3,3,3,3,3,4,4,3,3,3)

last_ml <- c(11,12,6.5,10,12.5,12.5,4.5,12.5,5,8,6.5,3,12.5,12)

out_20221105 <- f(20221105,53,"P11",1502,"C05",16005,1521,10)

#################################################################

who_U <- c(5,7,11,15,17,18,21,27,28,30,33,36,37,42,47,49,55,59,64,66,70,73,80,98,99,101,103)

number_U <- c(3,4,3,4,4,3,3,3,2,4,4,3,2,4,4,4,2,4,2,2,4,4,3,2,3,2,4)

last_ml <- c(12.5,5,4,7.5,7,12.5,9,4.5,6.5,9,9,10,7,5.5,4,9,10.5,7.5,4.5,11.5,12.5,6,12.5,12.5,12.5,11.5,9)

out_20221112 <- f(20221112,106,"P11",1555,"C05",16217,1522,16)

#################################################################

who_U <- c(1,5,9,10,12,14,15,17,19,35,36,37,38,41,48,50,51,57,64,82,85,94,101,102,111,118,119)

number_U <- c(4,4,4,2,4,2,2,3,1,2,3,4,4,2,3,4,3,2,4,2,2,4,2,4,4,4,2)

last_ml <- c(10,4.5,8,9,7.5,10.5,4.5,11,12.5,12.5,12.5,9.5,8,11,11.5,11.5,12.5,7.5,9.5,12,12.5,7.5,10,8.5,5,8,12.5)

out_20221119 <- f(20221119,122,"P11",1661,"C05",16641,1524,30)

#################################################################

#cbind(who_U,number_U,last_ml)

out_total <- rbind(out_20220917,out_20220924,out_20221001,out_20221015,out_20221022,
out_20221029,out_20221105,out_20221112,out_20221119)


out <- data.frame(sid=out_total$S_number,P_number=out_total$P_number,
C_number=out_total$C_number,Box=out_total$Box,Site=out_total$Site,
ML = out_total$ML ,Specimen = out_total$Speciem,QC=out_total$QC,C_Date=out_total$S_number_a,
IN_time = 20221125,CMRC_Reserved=0,sup=0)

dim(out)


library(RMySQL)
library(DBI)

mysqlconnection = dbConnect(MySQL(), dbname = "kao_practice_5",user = 'kaonthu', password = 'asd123',host = '192.168.1.41')

#dbListTables(mysqlconnection)
#summary(mysqlconnection)


dbWriteTable(mysqlconnection,"Total_speciem_2022_0917_1119",out,append=TRUE)

#library(RMySQL)
#cons <- dbListConnections(MySQL())
#for (con in cons)dbDisconnect(con)
