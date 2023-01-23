date <- 20211016
person<- 108
speciem <- "P"
Pstart <- "P10"
P_number_start <- 488
Cstart <- "C04"
C_number_start <- 37786
Box_start <- 3489
Site_start <- 80

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

Box <- Box_start + (Site_start + (-1):(person*5-2)) %/% 100

cbind(Site,Box)


