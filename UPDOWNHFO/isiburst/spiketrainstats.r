library('R.matlab')
library('STAR')
library('WriteXLS')
#
# An R implementation of Gourevitch & Eggermont (2007) Rank Surprise Method for 
# identifying bursts in spike trains.
#
# Arguments:
# spike.train = vector of spike timings
# RS.thresh   ='' significance threshold for accepting a burst
#
# Returns:
# A list of 2 column matrices of the start and end times of identified bursts for
# each value of RS.thresh provided. 
# A 2x2 matrix of -1 is returned whenever no bursts are found.
##

RS.method <- function(spike.train, RS.thresh){
  
  ISI <- diff(spike.train)
  N <- length(ISI)
  Results<-list()
  if (N>1) {
  # Burst size at which Gaussian approximation is used
  q.lim <- 30
  # Minimum number of spikes acceptable as a burst
  l.min <- 3
  # Maximum ISI identifying spikes as possible bursts for subsequent analysis
  limit <- quantile(ISI,0.75)
  
  # Convert ISI values to ranks
  order1 <- sort(ISI,index.return=T)$ix
  order2 <- sort(-ISI,index.return=T)$ix
  rk <- rep(0,N)
  rk2 <- rep(0,N)
  rk[order1] <- (1:N)
  rk2[order2] <- (1:N)
  R=(N+1-rk2+rk)/2  # ensures equal values given mean rank
  
  #Identify start and end points of spikes sequences below limit
  ISI.limit <- diff(ISI<limit)
  begin.int <- which(ISI.limit==1)+1
  end.int <- which(ISI.limit==-1)
  #Include first ISI if under limit
  if(ISI[1] < limit){
    begin.int <- c(1,begin.int)
  }
  #Include last ISI if spikes are below limit at end of spike train
  if(length(end.int) < length(begin.int)){
    end.int <- c(end.int,N)
  }
  #Number of spikes in each putative burst
  length.int <- end.int-begin.int+1
  
  # Create stores for final burst information
  burst.RS <-  numeric()
  burst.length <- numeric()
  burst.start <- numeric()
  
  # Create solutions to -1^k 
  alternate <- rep(c(1,-1),200)
  
  # Create solutions to log factorials
  log.fac <- cumsum(log(1:q.lim))
  
  for (index in 1:length(begin.int)){  # Repeat for all clusters of short ISIs
    n.j <- begin.int[index]
    p.j <- length.int[index];
    subseq.RS <- numeric()
    if (p.j >= (l.min-1)){		 # Proceed only if there are enough spikes
      for (i in 0:(p.j-(l.min-1))){  # Repeat for all possible first spikes
        q <- l.min-2
        while (q < p.j-i){       # Repeat for increasing burst lengths
          q <- q+1
          rr <- seq(n.j+i, n.j+i+q-1)
          u <- sum(R[rr])
          u <- floor(u)
          # Calculate RS probability exactly, if q is small
          # or approximately if q is large
          if (q < q.lim){
            k <- seq(0,(u-q)/N,1)
            length.k <- length(k)
            mat1 <- matrix(rep(k,q), q, length.k, byrow=T)*N
            mat2 <- matrix(rep(0:(q-1), length.k), q, length.k)
            p <- exp((colSums(log(u - mat1 - mat2)) - 
                        log.fac[c(1,k[-1])] - log.fac[q-k]) - 
                       q*log(N))%*%alternate[1:length.k]                 
          }else{
            p <- pnorm((u-q*(N+1)/2)/sqrt(q*(N^2-1)/12));
          }
          RS <- -log(p)
          subseq.RS <- rbind(subseq.RS, c(RS,i,q))
        }
      }
      # Extract the highest rank surprise bursts that are non-overlapping 
      subseq.RS <- matrix(subseq.RS,ncol=3)
      if (length(subseq.RS) > 0){  
        subseq.RS <- subseq.RS[order(subseq.RS[ ,1], decreasing=T), ]
        while (length(subseq.RS) > 0){
          subseq.RS <- matrix(subseq.RS, ncol=3)
          current.burst <- subseq.RS[1, ]
          burst.RS <- rbind(burst.RS,current.burst[1])
          burst.start <- rbind(burst.start, n.j+current.burst[2])
          burst.length <- rbind(burst.length, current.burst[3]+1)
          subseq.RS <- subseq.RS[-1, ]
          if (length(subseq.RS) > 0){ 
            subseq.RS <- matrix(subseq.RS, ncol=3)  
            keep <- which(subseq.RS[ ,2] + subseq.RS[ ,3] - 1 < 
                            current.burst[2] | subseq.RS[,2] >  
                            current.burst[2] + current.burst[3] -1)
            subseq.RS=subseq.RS[keep, ]
          }
        }
      }
    }
  }
  
 
  # Convert length into end position and positions into times
  for (x in 1:length(RS.thresh)){
  above.thresh<-which(burst.RS>=RS.thresh[x])
  N.burst<-length(above.thresh)
  if (N.burst<1) {
    result<-NA
  } else {
    bursts<-cbind(burst.start[above.thresh], burst.length[above.thresh])
   bursts.ord<-cbind(bursts[ order(bursts[,1]),1], bursts[ order(bursts[,1]),2])
  beg<-bursts.ord[,1]
  len<-bursts.ord[,2]
  end<-beg+len-1
  start.times<-spike.train[beg]
  end.times<-spike.train[end]
  IBI<-c(NA, start.times[-1]-end.times[-N.burst])
  durn<-end.times-start.times
  mean.isis<-durn/(len-1)
  result<-cbind(beg=beg, end=end, IBI=IBI, len=len, durn=durn, mean.isis=mean.isis, SI=rep(RS.thresh[x], N.burst))
  }
  Results[[x]]<-result
  }
  } else {
    Results<-rep(list(NA), length(RS.thresh))
  }
  
  
  return(Results)
  
}

Facdecay=c()
Ffrate=c()
Fisicv=c()
Fbpm=c()

st <- readMat("/data/downstate/wip/FromYuval/UPDOWN/Risiburst/RONOst.mat")
test <- st[1][1]
spikes <- test[[1]]
rm(st)
rm(test)
#174
for(i in 65:174){
print(i)
test3 <- spikes[i]
test4 <- y <- as.numeric(unlist(test3))
test_st<-as.spikeTrain(test4)
test_ac<-acf.spikeTrain(test_st, lag.max = 500,
       type = "covariance",
       plot = FALSE)
y <- test_ac[[1]]
x <- test_ac[[4]]
x <- x[-1]
y <- y[-1]
x <- x[-1]
y <- y[-1]
x[is.nan(x)] <- 0
y[is.nan(y)] <- 0
df <- data.frame(x,y)
B <- min(df$y) * 0.5  
# Estimate the rest parameters using a linear model
model.0 <- lm(log(y - B) ~ x, data=df)  
A <- exp(coef(model.0)[1]) 
tau <- (coef(model.0)[2])
start <- list(A=A,tau=tau,B=B)
model <- nls(y~(A*exp(tau*x)+B), data = df, start = start, control=nls.control(maxiter=1000, tol = 1e-05, minFactor = 1/1024, printEval = FALSE, warnOnly = TRUE))
test  <- summary(model)
test2 <- test[10]
test3 <- test2[[1]]
if (length((test3[tau]))>0) {
Facdecay[i] <- 1/(test3[tau][[1]])
} else {
Facdecay[i] <- NaN
}
test_obj<-mkGLMdf(test_st,.001)
test_isi<-isi(test_obj, lag = 1)
test <- as.numeric(test_isi)
Ffrate[i] <- 1/(mean(na.omit(test)))
Fisicv[i] <- sd(na.omit(test)) / mean(na.omit(test)) * 100
bursts<-RS.method(test4,4.6)
test<-bursts[[1]]
bursts<-dim(test)[1]
summary.spikeTrain(test_st)
timemax<-(test4[length(test4)]/60)
Fbpm[i] <- bursts/timemax
}
df <- data.frame(Facdecay,Ffrate,Fisicv,Fbpm)
save(df, file = "/data/downstate/wip/FromYuval/UPDOWN/Risiburst_temp65_174.RData")
print("to here")