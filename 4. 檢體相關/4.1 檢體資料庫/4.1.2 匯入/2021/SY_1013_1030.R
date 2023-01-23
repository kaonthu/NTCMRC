
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

QC_miss_person <- c(2,4,6,7,8,10,12,14,17,18,20,22,23,25,26,27,28,29,33,35,39,41,42,44,46,47,49,52)
QC_miss_number <- c(3,2,2,2,1,3,3,2,3,1,4,3,2,2,3,2,4,3,4,5,3,1,3,2,3,2,3,1)
# 20211013  

out_20211013 <- f(20211013,53,"SY","P10",435,"C04",84309,3831,11)

#################################################################

QC_miss_person <- c(10,23,25,28,29,31,32,41,43,48,49,51,52,56,61,62,69,72,74,76,87,88,91,95,96,97,99,101,104)
QC_miss_number <- c(1,1,2,2,1,2,1,2,3,1,1,2,2,1,1,6,1,3,2,1,1,2,2,3,6,2,2,3,2)
# 20211016 

out_20211016 <- f(20211016,108,"SY","P10",488,"C04",84839,3836,41)

#################################################################

QC_miss_person <- c(4,5,20,21,22,25,29,30,31,35,37,38,39,41,43,44,45,47,48,49,50,52,54,55,56,58,69,71,72,74,77,78,81)
QC_miss_number <- c(1,2,3,3,1,1,4,2,1,2,1,2,1,4,1,1,4,1,1,2,2,1,3,1,1,1,2,2,1,3,2,2,1)
# 20211023

out_20211023 <- f(20211023,86,"SY","P10",596,"C04",85919,3847,21)

#################################################################

QC_miss_person <- c(3,11,14,22,24,25,27,28,29,30,31,32,33,34,35,36,37,38,39,40,45)
QC_miss_number <- c(1,2,1,1,3,1,1,2,2,3,1,2,1,2,1,2,1,4,1,2,3)

out_20211027 <- f(20211027,46,"SY","P10",682,"C04",86779,3855,81)

#################################################################

QC_miss_person <- c(7,11,14,17,19,21,23,24,26,27,28,29,31,32,33,34,35,36,40,43,53,54,55,57,60)
QC_miss_number <- c(2,1,2,2,1,2,2,1,1,1,1,2,1,2,4,1,1,2,2,1,4,1,2,1,2)
# 20211030

out_20211030 <- f(20211030,60,"SY","P10",728,"C04",87239,3860,41)



out_total <- rbind(out_20211013,out_20211016,out_20211023,out_20211027,out_20211030)

write.table(out_total,"C:/Users/labuser/Desktop/基隆長庚社區醫學科研究中心/CMRC社區資料庫/Li_Yu_Lee/SY_1013_1030.csv",sep=",")


