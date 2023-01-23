
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

QC_miss_person <- c(2,4,5,6,7,12,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,32,33,34,35,36,38,42,43,44,45,46,47,48,49,50,51,52,55,57,61,62)
QC_miss_number <- c(1,4,3,2,2,1,3,1,1,1,2,3,2,3,1,4,2,5,3,3,2,1,2,1,1,2,2,2,3,3,1,2,3,2,2,2,2,2,3,2,2,1,2)
# 20211103

out_20211103 <- f(20211103,66,"SY","P10",788,"C04",87839,3866,41)

#################################################################

QC_miss_person <- c(1,2,6,9,10,12,15,17,19,20,21,23,24,26,28,30,31,32,33,39,41,42,43,44,45,46,48,49,50,51,53,54,57,59,60,61,62,63,65,66,67,68,69,70,71,74,75,77,78,80,81,82,83,84,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,105,106,107)
QC_miss_number <- c(3,6,1,1,2,1,2,2,2,2,3,3,4,2,3,1,1,2,3,1,1,3,1,1,1,1,2,2,2,2,2,1,1,4,1,2,1,1,1,1,2,2,3,2,4,1,2,1,2,3,1,1,1,2,2,1,5,3,2,3,3,1,4,1,4,4,2,3,2,2,2,1,1,4,1)

out_20211113 <- f(20211113,108,"SY","P10",854,"C04",88499,3873,1)

#################################################################

QC_miss_person <- c(5,6,7,8,11,12,15,16,18,20,24,25,26,31,32,34,36,37,38,42,44,59,61,70,75,76)
QC_miss_number <- c(1,1,2,1,3,1,1,1,3,5,3,1,2,2,3,3,1,1,6,1,2,1,1,4,1,1)


out_20211117 <- f(20211117,76,"SY","P10",962,"C04",89579,3883,81)

#################################################################

QC_miss_person <- c(3,6,9,13,15,19,37,43,45,48,49,53,56,59,62,63,68,71,73,75,77,78,79,80,81,82,83,84,87,88,89,90,92,93,94)
QC_miss_number <- c(4,2,2,3,1,1,2,1,2,4,1,1,1,1,1,1,4,3,1,2,4,1,1,3,2,3,3,1,4,4,2,2,2,2,3)

out_20211120 <- f(20211120,94,"SY","P10",1038,"C04",90339,3891,41)

#################################################################

QC_miss_person <- c(7,11,14,17,19,21,23,24,26,27,28,29,31,32,33,34,35,36,40,43,53,54,55,57,60)
QC_miss_number <- c(2,1,2,2,1,2,2,1,1,1,1,2,1,2,4,1,1,2,2,1,4,1,2,1,2)


out_20211124 <- f(20211124,91,"SY","P10",1132,"C04",91279,3900,81)



out_total <- rbind(out_20211103,out_20211113,out_20211117,out_20211120,out_20211124)

write.table(out_total,"C:/Users/labuser/Desktop/基隆長庚社區醫學科研究中心/CMRC社區資料庫/Li_Yu_Lee/2021_11月檢體/SY_1103_1124.csv",sep=",")


