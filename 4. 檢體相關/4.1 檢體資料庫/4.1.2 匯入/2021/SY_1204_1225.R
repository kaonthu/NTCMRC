
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

###########################################################

QC_miss_person <- c(1,6,7,8,10,13,14,15,16,18,
19,20,21,22,23,26,28,29,30,32,34,35,36,37,38,
41,42,48,50,52,55,
59,60,63,65,66,68,71,75,76,78,
79,80,81,82,83,84,86,87,88,89,90,91,92,93,94,95,97,98,
99,100,102,103,104)
QC_miss_number <- c(1,1,3,1,1,2,1,2,1,2,
1,2,1,1,1,2,1,2,2,2,1,2,1,2,1,
3,3,1,1,2,1,
1,1,1,1,2,2,1,2,4,1,
3,1,1,4,2,1,2,2,3,
1,3,1,2,1,2,2,2,3,3,2,2,5,2)

# 20211204

example <- cbind(QC_miss_person,QC_miss_number)

#write.table(example,"D:/基隆長庚社區醫學科研究中心/CMRC社區資料庫/20220112檢體登記/SY_20211225.csv",sep=",")

out_20211204 <- f(20211204,104,"SY","P10",1416,"C04",94119,3929,21)

#################################################################

QC_miss_person <- c(1,14,16,17,19,21,24,26,27,28,31,34,38,39,44,49,56,60,63,66,67,68,73,79,81,84,88,91,94)
QC_miss_number <- c(2,1,2,1,1,2,2,1,2,1,2,1,1,1,1,2,1,1,2,2,2,1,2,3,2,2,1,2,1)

out_20211208 <- f(20211208,94,"SY","P10",1520,"C04",95159,3939,61)

#################################################################
QC_miss_person <- c(2,3,4,10,13,14,15,16,19,20,22,24,25,27,38,40,42,43,44,45,48,49,50,51,52,55,56,57,59,60,
62,66,67,70,71,77,78,80)
QC_miss_number <- c(1,1,1,1,1,3,1,2,2,1,1,1,1,1,1,1,1,3,4,1,2,3,1,1,2,2,2,3,3,2,3,1,3,2,3,1,4,2)

out_20211211 <- f(20211211,80,"SY","P10",1614,"C04",96099,3949,1)

#################################################################

QC_miss_person <- c(1,2,5,9,11,12,14,15,17,18,19,
21,25,26,27,31,32,33,34,40,
47,48,50,53,60,61,63,66,67,68)

QC_miss_number <- c(1,1,1,2,2,2,2,2,1,3,1,
4,1,1,2,1,1,2,4,1,2,1,2,2,1,3,1,2,2,2)

out_20211225 <- f(20211225,68,"SY","P10",1694,"C04",96899,3957,1)

#################################################################

out_total <- rbind(out_20211204,out_20211208,out_20211211,out_20211225)


mysqlconnection = dbConnect(MySQL(), dbname = "kao_practice_5",user = 'kaonthu', password = 'asd123',host = '192.168.1.41')

#dbListTables(mysqlconnection)
#summary(mysqlconnection)

out <- data.frame(sid=out_total$S_number,P_number=out_total$P_number,
C_number=out_total$C_number,Box=out_total$Box,Site=out_total$Site,
ML = 0,Specimen ="SY",QC=out_total$QC,C_Date=out_total$S_number_a,
IN_time = 20220112,CMRC_Reserved=0,sup=0)

dbWriteTable(mysqlconnection,"Total_speciem_2021_1204_1225",as.data.frame(out),append=TRUE)


