who_U <- c(1,2,3,4,5,6,7,8,10,12,14,15,17,18,19,20,22,23,24,28,29,31,32,33,34,35,36,40,41,42,44,45,46,48,49,51,52,53)
number_U <- c(4,1,3,1,2,2,3,2,2,2,4,4,2,4,4,4,3,4,4,4,2,3,3,2,3,4,4,4,4,2,3,2,2,3,4,3,4,4)
last_ml <- c(9,12.5,12.5,12.5,8.5,7,4.5,12.5,12.5,7.5,9,6,12,10,9,10,11,8.5,6,8.5,12.5,
11,8,12.5,7.5,9.5,10.5,6.5,9,12.5,12.5,6.5,4,9,7.5,10,2.5,6.5)

date <- 20211013
person<- 53
speciem <- "U"
Pstart <- "P10"
P_number_start <- 435
Cstart <- "C05"
C_number_start <- 00839
Box_start <- 1439
Site_start <- 13

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
QC_receive <- TEMP     # 53管每個人收到的管數

QC_miss_number <- 4-QC_receive

QC_start <- rep(4,person) #每個人預設有4管，經過input 每個人實際收到之後修正

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
 OUT3 <- data.frame(OUT2,Box,Site,QC)

}else {  
 QC <- rep(c(0,0,0,1),person)
 Site <- ((Site_start-1  + 0:( dim(OUT)[1]-1)) %% 36) + 1
 Box <- Box_start  + (Site_start + (-1):(dim(OUT3)[1]-2)) %/% 36
 OUT3 <- data.frame(OUT,Box,Site,QC)
 }

 OUT3


data.frame(OUT2[,c("S_number_a","S_number","P_number")],Box,Site,OUT2[,c("C_number","ML","Speciem")],QC)







