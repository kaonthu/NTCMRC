
f=function(date,person,speciem,Pstart,P_number_start,Cstart,C_number_start,Box_start,Site_start)

{
S_number_a <- rep(date,person*1)
S_number_b <- rep(sprintf('%0.3d', 1:person),each = 1)
S_number <- paste(S_number_a,S_number_b,sep="")

P_number_a <- rep(Pstart,person*1)
P_number_b <- rep(sprintf('%0.4d', (P_number_start):(P_number_start+person-1)),each = 1)
P_number  <-  paste(P_number_a,P_number_b,sep="")

C_number_a <- rep(Cstart,person*1)
C_number_b <- sprintf('%0.5d', (C_number_start):(C_number_start+person*1-1))
C_number  <-  paste(C_number_a,C_number_b,sep="")


Site <- ((Site_start-1  + 0:(person*1-1)) %% 100) + 1

Box <- Box_start  + (Site_start + (-1):(person*1-2)) %/% 100

OUT <- data.frame(S_number_a,S_number,P_number,C_number,Box,Site," ")

#print(data.frame(QC_miss_person,QC_miss_number))


QC_start <- rep(1,person)

if( length(QC_miss_person) > 0)

{

delete <- NULL

for (i in 1:length(QC_miss_person)) {
QC_start[QC_miss_person[i]] <- QC_start[QC_miss_person[i]]-QC_miss_number[i]
delete <- c(delete,(1*QC_miss_person[i]-QC_miss_number[i]+1) : (1*QC_miss_person[i]))
}

OUT2 <- OUT[-delete,]

QC <- rep(0,person*1 - length(delete))
QC[cumsum(QC_start)] <- 1


QC_start <- rep(1,person)

delete <- NULL

for (i in 1:length(QC_miss_person)) {
QC_start[QC_miss_person[i]] <- QC_start[QC_miss_person[i]]-QC_miss_number[i]
delete <- c(delete,(1*QC_miss_person[i]-QC_miss_number[i]+1) : (1*QC_miss_person[i]))
}

OUT2 <- OUT[-delete,]

QC <- rep(0,person*1 - length(delete))
QC[cumsum(QC_start)] <- 1

OUT3 <- data.frame(OUT2,"NSY",QC)

}else {  

 QC <- rep(c(0),person)
 OUT3 <- data.frame(OUT,"NSY",QC)    }

print(OUT3[(dim(OUT3)[1]-10):dim(OUT3)[1],])
return(OUT3)

}

###########################################################

QC_miss_person <- NULL
QC_miss_number <- NULL

# 20211013  

out_20211013 <- f(20211013,53,"NSY","P10",435,"C04",28541,705,84)

#################################################################

QC_miss_person <- NULL
QC_miss_number <- NULL

# 20211016 

out_20211016 <- f(20211016,108,"NSY","P10",488,"C04",28594,706,37)

#################################################################

QC_miss_person <- NULL
QC_miss_number <- NULL
# 20211023

out_20211023 <- f(20211023,86,"NSY","P10",596,"C04",28702,707,45)

#################################################################

QC_miss_person <- NULL
QC_miss_number <- NULL
# 20211027

out_20211027 <- f(20211027,46,"NSY","P10",682,"C04",28788,708,31)

#################################################################

QC_miss_person <- NULL
QC_miss_number <- NULL
# 20211030

out_20211030 <- f(20211030,60,"NSY","P10",728,"C04",28834,708,77)



out_total <- rbind(out_20211013,out_20211016,out_20211023,out_20211027,out_20211030)

write.table(out_total,"C:/Users/labuser/Desktop/基隆長庚社區醫學科研究中心/CMRC社區資料庫/Li_Yu_Lee/NSY_SY_1013_1030.csv",sep=",")


