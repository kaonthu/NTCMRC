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

who_U <- c(2,3,4,7,9,12,16,17,18,19,23,27,28,30,34,37,38,40,41,42,46,47,48,49,52,56,57,59,61,
62,64,65,66,67,68,71,72,73,77,79,80,83,84,86,87,89,91)

number_U <- c(4,4,4,1,2,3,4,4,4,3,3,2,2,4,4,2,3,4,4,4,3,4,2,4,2,4,4,4,2,4,2,1,1,3,4,4,4,4,4,3,3,2,3,2,2,2,4)

last_ml <- c(10,9.5,4.5,12.5,9,12.5,10,10,10.5,12.5,10,4,7.5,7.5,8,5,12.5,7,6.5,6,9.5,3.5,5.5,7.5,10.5,9.5,11,
8.5,9.5,8,7.5,11,12,2.5,7.5,8.5,8,4.5,9.5,3.5,5.5,3,7.5,12.5,12.5,12.5,6.5)

out_20220305 <- f(20220305,91,"P11",1,"C05",10001,1480,4)

#################################################################

who_U <- c(1,2,4,5,6,7,11,12,13,15,16,17,18,21,24,26,27,28,37,41,44,46,48,52,55,56,57,58,59,60,61,
62,63,64,65,67,71,76,78,80,88,89)

number_U <- c(4,2,2,2,2,2,2,1,2,3,4,3,2,2,4,4,4,2,3,2,3,2,3,4,3,3,4,3,2,4,2,3,4,2,4,4,4,4,2,4,4,4)

last_ml <- c(9,12.5,3,5,12.5,12.5,7,10,4.5,11,10,11.5,7,12.5,10,9,9.5,7.5,11.5,3,9,9,8,4,11,3,5.5,5,
10,5,6,5,8,12.5,8.5,10,8,9,12,4,9,8.5)

out_20220312 <- f(20220312,90,"P11",92,"C05",10365,1484,6)

#################################################################

who_U <- c(1,2,3,4,7,8,10,11,12,17,24,25,26,28,30,32,33,34,37,39,42,43,44,45,48,52,54,55,56,59,60,63,
64,67,69,71)

number_U <- c(4,4,3,3,4,3,2,2,3,4,4,3,2,4,2,4,3,2,4,4,3,3,3,4,4,4,4,1,2,1,2,1,4,4,4,4)

last_ml <- c(5,10,11.5,11.5,7.5,10,3.5,3.5,8,5,9.5,9.5,8,9.5,3,9.5,7.5,4,8,9.5,4.5,7.5,8,10.5,10,10.5,10,
9.5,9,12.5,9,12.5,7.5,10,9,8)

out_20220319 <- f(20220319,71,"P11",182,"C05",10725,1487,22)

#################################################################

who_U <- c(1,2,3,5,6,8,9,10,12,13,14,16,17,18,20,21,22,25,26,27,28,29,30,31,34,35,36,39,40,41,42,43,44,45,46,48,49,52,54,55,56,57,60,61,63,64,65,66,67,68,69,73,75,76,77)

number_U <- c(2,2,4,4,3,2,2,1,4,1,4,1,1,3,2,3,3,2,1,3,2,1,1,2,2,4,4,3,2,1,2,2,4,4,3,2,2,2,3,4,4,2,4,2,2,2,2,4,3,4,2,2,4,4,3)

last_ml <- c(8.5,6.5,7.5,6.5,12.5,8,5.5,11.5,7.5,11.5,6,9.5,7,12.5,8.5,8,7.5,11.5,11,8.5,7.5,7.5,10,2.5,8,9.5,5.5,11,11.5,12,3,11.5,9,7,9.5,6.5,12.5,11.5,12.5,8,8,10.5,5,7,5,5,4,7.5,5,9,9,10.5,8,3.5,6)

out_20220418 <- f(20220418,77,"P11",253,"C05",11009,1490,26)

#################################################################
#cbind(who_U,number_U,last_ml)


out_total <- rbind(out_20220305,out_20220312,out_20220319,out_20220418)


out <- data.frame(sid=out_total$S_number,P_number=out_total$P_number,
C_number=out_total$C_number,Box=out_total$Box,Site=out_total$Site,
ML = out_total$ML ,Specimen = out_total$Speciem,QC=out_total$QC,C_Date=out_total$S_number_a,
IN_time = 20220606,CMRC_Reserved=0,sup=0)

dim(out)


library(RMySQL)
library(DBI)

mysqlconnection = dbConnect(MySQL(), dbname = "kao_practice_5",user = 'kaonthu', password = 'asd123',host = '192.168.1.41')

#dbListTables(mysqlconnection)
#summary(mysqlconnection)


dbWriteTable(mysqlconnection,"Total_speciem_2022_0305_0418",as.data.frame(out),append=TRUE)

#library(RMySQL)
#cons <- dbListConnections(MySQL())
#for (con in cons)dbDisconnect(con)
