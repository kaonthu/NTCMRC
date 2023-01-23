
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



###########################################################

who_U <- c(1,2,3,4,5,6,7,8,10,12,14,15,17,18,19,20,22,23,24,28,29,31,32,33,34,35,36,40,41,42,44,45,46,48,49,51,52,53)
number_U <- c(4,1,3,1,2,2,3,2,2,2,4,4,2,4,4,4,3,4,4,4,2,3,3,2,3,4,4,4,4,2,3,2,2,3,4,3,4,4)

last_ml <- c(9,12.5,12.5,12.5,8.5,7,4.5,12.5,12.5,7.5,9,6,12,10,9,10,11,8.5,6,8.5,12.5,
11,8,12.5,7.5,9.5,10.5,6.5,9,12.5,12.5,6.5,4,9,7.5,10,2.5,6.5)

# 20211013  

out_20211013 <- f(20211013,53,"P10",435,"C05",00839,1439,13)

#################################################################

who_U <- c(1,7,8,9,10,18,20,23,24,28,29,31,35,37,38,39,41,42,45,46,56,61,62,67,69,72,76,85,86,88,90,99,103,104,108)

number_U <- c(2,4,3,2,2,2,1,3,2,4,1,3,3,2,2,3,2,4,2,4,1,2,3,4,2,4,4,3,2,4,4,2,4,4,3)

last_ml <- c(9,8,6.5,6.5,2,9.5,5.5,4,10,10,10.5,7,5,6.5,4,8,12.5,3.5,10,5.5,12.5,12.5,12.5,7,8,4.5,4.5,5,9,4,10.5,4,11,12,5)

# 20211016 

out_20211016 <- f(20211016,108,"P10",488,"C05",01051,1442,20)

#################################################################

who_U <- c(1,3,5,11,13,16,18,22,34,37,38,40,48,53,54,57,63,66,79)

number_U <- c(3,2,2,3,4,3,2,2,3,3,2,4,4,4,4,4,4,4,3)

last_ml <- c(9,3,9.5,12.5,6.5,4.5,12.5,4,12.5,7,12.5,8,10,10,6.5,6,6,7,6.5)

# 20211023

out_20211023 <- f(20211023,86,"P10",596,"C05",01483,1445,9)

#################################################################

who_U <- c(1,2,3,4,5,6,8,9,10,11,13,15,17,18,20,21,23,24,27,28,31,32,33,38,39,40,41,45)

number_U <- c(4,4,4,4,4,4,4,4,3,3,4,4,3,3,4,4,4,4,4,4,3,3,3,3,3,4,4,3)

last_ml <- c(10,9,10,5,10,9,10.5,6,12.5,12.5,9,7.5,5.5,10,8,8.5,9,7,7,9,5.5,5,3.5,8,12.5,9.5,10,10.5)

out_20211027 <- f(20211027,46,"P10",682,"C05",01827,1446,33)

#################################################################

who_U <- c(3,4,6,9,10,13,17,18,21,22,23,25,28,32,34,36,37,40,41,45,47,51,54,57,59)

number_U <- c(4,4,3,4,1,4,3,2,4,4,3,4,4,3,3,4,4,4,4,2,2,2,3,4,2)

last_ml <- c(9,4.5,4.5,7,12.5,8.5,8,8.5,10.5,8.5,12.5,11,8.5,12.5,6,6,9,8.5,10,11.5,11,10,12,8.5,12.5)

# 20211030

out_20211030 <- f(20211030,60,"P10",728,"C05",02011,1449,27)

out_total <- rbind(out_20211013,out_20211016,out_20211023,out_20211027,out_20211030)

write.table(out_total,"C:/Users/labuser/Desktop/基隆長庚社區醫學科研究中心/CMRC社區資料庫/Li_Yu_Lee/2021_10月檢體/U尿液_1013_1030.csv",sep=",")

