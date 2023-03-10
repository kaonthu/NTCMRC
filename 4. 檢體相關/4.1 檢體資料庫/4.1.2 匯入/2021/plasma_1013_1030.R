
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

###########################################################

QC_miss_person <- c(8,11,12,14,15,17,19,20,22,25,26,28,29,44,53)
QC_miss_number <- c(2,1,1,1,2,1,1,1,2,1,1,1,1,1,1)
# 20211013  

out_20211013 <- f(20211013,53,"P","P10",435,"C04",37522,3487,16)
#此場次最後一人少了一管，下一管C number 要多加1 回去

#################################################################

QC_miss_person <- c(4,51,63,88,96)
QC_miss_number <- c(1,2,2,3,2)
# 20211016 

out_20211016 <- f(20211016,108,"P","P10",488,"C04",37787,3489,81)

#################################################################

QC_miss_person <- c(45,47,50,63,71,77,78)
QC_miss_number <- c(3,2,1,1,1,1,3)
# 20211023

out_20211023 <- f(20211023,86,"P","P10",596,"C04",38327,3495,21)

#################################################################

QC_miss_person <- NULL
QC_miss_number <- NULL

out_20211027 <- f(20211027,46,"P","P10",682,"C04",38757,3499,51)

#################################################################

QC_miss_person <- c(6,17,23,39)
QC_miss_number <- c(3,2,5,1)
# 20211030

out_20211030 <- f(20211030,60,"P","P10",728,"C04",38987,3501,81)



out_total <- rbind(out_20211013,out_20211016,out_20211023,out_20211027,out_20211030)

write.table(out_total,"C:/Users/labuser/Desktop/基隆長庚社區醫學科研究中心/CMRC社區資料庫/Li_Yu_Lee/2021_10月檢體/plasma_1013_1030.csv",sep=",")


