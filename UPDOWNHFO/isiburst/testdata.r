library('R.matlab')

#
# An R implementation of Gourevitch & Eggermont (2007) Rank Surprise Method for 
# identifying bursts in spike trains.
#
# Arguments:
# spike.train = vector of spike timings
# RS.thresh   = significance threshold for accepting a burst
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


load(file = "/data/downstate/Rcode/burstanalysis/Demas_analysis/demas.RData")
test<-c(21.4407, 21.48885, 21.57075, 21.59805, 21.6239, 21.6632, 21.7227, 21.7384, 21.7919, 21.85585, 21.8845, 21.9279, 21.99005, 22.0372, 22.1688, 65.62745, 65.76275, 65.80575, 65.8385, 65.88605, 65.9519, 65.9743, 66.03765, 66.0587, 66.08305, 66.0933, 66.105, 66.13165, 66.1577, 66.27425, 66.34135, 66.3545, 112.84965, 112.899, 112.94085, 113.01235, 113.071, 113.1409, 113.1825, 113.22205, 113.23955, 113.2629, 113.34015, 113.3636, 113.44135, 158.8576, 158.91525, 158.97, 159.1082, 159.169, 159.19695, 159.2173, 
159.27045, 159.29855, 159.32665, 159.385, 159.4144, 159.4415, 159.5075, 159.5375, 223.6862, 223.7773, 223.8311, 223.86435, 223.95365, 223.9668, 224.02955, 224.0691, 224.0833, 224.0905, 224.12805, 224.15055, 224.1739, 224.23275, 224.25465, 224.3381, 224.36925, 224.3709, 224.51015, 282.7372, 282.7536, 282.79375, 282.8324, 282.9185, 282.94765, 282.9608, 282.9976, 283.01705, 283.0433, 283.06945, 283.12035, 283.1506, 283.17445, 283.19045, 283.22565, 283.25065, 283.28175, 335.07915, 335.13445, 335.16355, 
335.2018, 335.32775, 335.35505, 335.35615, 335.4069, 335.42255, 335.42395, 335.44625, 335.46855, 335.4987, 335.5239, 335.54475, 335.5834, 335.63215, 335.7083, 335.8804, 401.387, 401.7055, 401.7442, 401.7711, 401.8023, 401.811, 401.8322, 401.8543, 401.88195, 401.89275, 401.9432, 401.9672, 401.9727, 402.0047, 402.0174, 402.0366, 402.05145, 402.0677, 402.12025, 452.97745, 453.02275, 453.06805, 453.22545, 453.26255, 453.2911, 453.3321, 453.3611, 453.37665, 453.4718, 453.76985, 509.6485, 509.70645, 509.77265, 
509.8046, 509.86175, 509.8811, 509.8921, 509.9435, 510.00095, 510.03725, 510.0607, 510.0671, 510.08575, 510.1059, 510.1187, 510.13975, 510.155, 510.236, 510.3297, 510.372, 562.07725, 562.0864, 562.13315, 562.1733, 562.26445, 562.33575, 562.38925, 562.4103, 562.43055, 562.4358, 562.4722, 562.51765, 562.5403, 562.58855, 562.6159, 562.67785, 562.78405, 612.13045, 612.1786, 612.3281, 612.3588, 612.3735, 612.4027, 612.417, 612.4396, 612.46095, 612.477, 612.5386, 612.56535, 612.5828, 612.6491, 612.67455, 
658.39915, 658.44325, 658.50915, 658.66745, 658.6909, 658.7003, 658.70765, 658.73625, 658.7384, 658.79675, 658.7993, 658.82355, 658.84285, 658.8594, 658.92105, 658.9558, 659.03665, 659.1446, 703.95845, 703.97215, 704.06765, 704.1738, 704.2157, 704.25075, 704.28215, 704.30535, 704.36055, 704.40395, 704.4553, 704.5061, 704.5353, 767.90225, 767.9519, 767.9943, 768.0571, 768.08995, 768.12075, 768.1252, 768.14205, 768.1564, 768.1792, 768.1836, 768.20155, 768.22195, 768.23405, 768.30195, 768.3237, 768.4386, 
768.4706, 768.6994, 816.71935, 816.77475, 816.8248, 816.8307, 817.02215, 817.06405, 817.08225, 817.11265, 817.13235, 817.1887, 817.22695, 817.2507, 817.2691, 817.3129, 817.3694, 817.4719, 864.16475, 864.17045, 864.21005, 864.2212, 864.2325, 864.2814, 864.42235, 864.49145, 864.5076, 864.5278, 864.5497, 864.58365, 864.6114, 864.6446, 864.6598, 864.70075, 864.7911, 904.1534, 904.2147, 904.28965, 904.40225, 904.48475, 904.52115, 904.5812, 904.62775, 904.7359, 945.77355, 945.78555, 945.82675, 945.88565, 
946.04265, 946.08985, 946.12815, 946.1735, 946.1951, 946.2282, 946.30795, 946.3392, 946.3643, 1010.91095, 1010.9521, 1010.9555, 1010.9855, 1010.9925, 1011.02045, 1011.05865, 1011.1037, 1011.1085, 1011.14545, 1011.1703, 1011.19295, 1011.2164, 1011.2342, 1011.25165, 1011.27995, 1011.3097, 1011.37615, 1011.40855, 1062.8079, 1062.8141, 1062.8621, 1062.8805, 1062.90155, 1062.94825, 1062.953, 1062.9888, 1063.00365, 1063.0315, 1063.05945, 1063.10385, 1063.12385, 1063.15925, 1063.20905, 1063.23295, 1063.26485, 
1063.3784, 1096.15025, 1096.2177, 1096.29515, 1096.4277, 1096.53205, 1096.62275, 1138.08615, 1138.1701, 1138.4915, 1138.51455, 1138.5238, 1138.5575, 1138.64285, 1138.74485, 1158.1392, 1158.20095, 1158.20545, 1158.2436, 1158.2656, 1158.3085, 1158.3576, 1158.4061, 1158.4564, 1158.51645, 1158.614, 1158.6867, 1187.7101, 1187.7612, 1187.8013, 1187.84605, 1187.8964, 1187.99755, 1188.0294, 1188.033, 1188.08365, 1188.08555, 1188.13395, 1188.14065, 1188.1705, 1188.19245, 1188.28125, 1188.3221, 1188.44915, 
1255.45685, 1255.7849, 1255.83905, 1255.8681, 1255.87115, 1255.90535, 1255.93185, 1255.9785, 1256.0306, 1256.0447, 1256.0912, 1256.0981, 1256.1088, 1256.13485, 1256.15955, 1256.18205, 1256.2061, 1256.28725, 1256.3204, 1306.4287, 1306.4726, 1306.51005, 1306.55605, 1306.56135, 1306.63875, 1306.6644, 1306.668, 1306.70475, 1306.79695, 1306.8225, 1306.84705, 1307.0248, 1307.07025, 1371.73015, 1371.79265, 1371.85235, 1371.89685, 1371.9439, 1372.0319, 1372.06675, 1372.0964, 1372.12, 1372.1783, 1372.1976, 
1372.215, 1372.24535, 1372.2577, 1372.2908, 1372.39675, 1413.40895, 1413.45355, 1413.5134, 1413.6106, 1413.75855, 1413.789, 1413.8273, 1413.87545, 1413.9414, 1453.75165, 1453.80665, 1453.8649, 1454.058, 1454.10925, 1454.1507, 1454.20465, 1454.25585, 1454.3126, 1497.8673, 1497.9206, 1498.05025, 1498.0906, 1498.2406, 1498.3058, 1498.34495, 1498.3885, 1545.2592, 1545.32135, 1545.4009, 1545.54575, 1545.63075, 1545.67435, 1545.70655, 1545.7415, 1545.80625, 1545.8759, 1604.88595, 1604.94305, 1604.98265, 
1605.0375, 1605.0964, 1605.1153, 1605.17365, 1605.21575, 1605.2249, 1605.23785, 1605.2587, 1605.2772, 1605.3164, 1605.348, 1605.38575, 1605.44485, 1605.50845, 1605.5887, 1682.81115, 1682.86915, 1682.9262, 1683.04665, 1683.062, 1683.10635, 1683.1783, 1683.21175, 1683.23025, 1683.26015, 1683.2909, 1683.3707, 1683.4126, 1776.536, 1776.6089, 1776.67605, 1776.8857, 1824.40715, 1885.34835, 2037.7968, 2037.87325, 2037.9208, 2037.98055, 2038.03425, 2038.0858, 2097.50735, 2247.0271, 2247.4056, 2247.42805, 
2247.4571, 2247.48545, 2247.5416, 2247.54855, 2247.5769, 2247.59, 2247.63715, 2247.651, 2247.67405, 2247.6984, 2247.73215, 2247.75675, 2247.8187, 2247.8333, 2247.9286, 2248.196, 2312.9516, 2313.0193, 2313.063, 2313.09525, 2313.14835, 2313.2002, 2313.25065, 2313.3032, 2370.22895, 2476.5393, 2476.6306, 2476.7062, 2476.76255, 2476.811, 2476.8533, 2476.90165, 2477.12845, 2477.13, 2477.17985, 2477.2073, 2477.23385, 2477.2708, 2614.95205, 2615.33845, 2615.35525, 2615.3809, 2615.408, 2615.41705, 2615.4468, 
2615.4929, 2615.5592, 2615.60085, 2615.61425, 2615.63835, 2615.64835, 2615.68345, 2615.72535, 2615.75955, 2615.78005, 2615.95965, 2616.02775, 2616.11325, 2680.8344, 2680.88115, 2680.8935, 2680.9055, 2680.9125, 2680.9636, 2681.01225, 2681.05585, 2681.09995, 2681.13785, 2681.1683, 2681.19875, 2681.24695, 2681.2948, 2681.3512, 2681.50105, 2681.6071, 2710.47425, 2710.56435, 2710.6502, 2718.11365, 2718.1817, 2718.27945, 2768.9312, 2768.95, 2769.0138, 2769.08005, 2769.1434, 2769.1933, 2769.24025, 2769.24305, 
2769.2909, 2769.3016, 2769.33055, 2769.3736, 2769.4088, 2769.4355, 2769.45215, 2769.47235, 2769.5283, 2769.69435, 2847.44165, 2847.4997, 2847.5353, 2847.5962, 2847.63015, 2847.64605, 2847.6938, 2847.7358, 2847.77315, 2847.8138, 2847.87, 2847.9283, 2847.9697, 2848.0345, 2848.09605, 2848.12465, 2848.20495, 2848.28135, 2848.43425, 2911.24895, 2911.3201, 2911.3717, 2911.5322, 2911.55605, 2911.5912, 2911.6581, 2911.6781, 2911.71715, 2911.76485, 2911.80315, 2911.90455, 2970.52175, 2970.5249, 2970.59275, 
2970.64345, 2970.68825, 2970.73285, 2970.7778, 2970.8187, 2970.8825, 2970.92945, 2971.00235, 2971.0783, 2971.1285, 3042.74825, 3042.8272, 3042.87465, 3042.92005, 3042.95735, 3043.03725, 3043.08195, 3043.14835, 3043.1599, 3043.17155, 3043.2034, 3043.2082, 3043.22485, 3043.25395, 3043.2788, 3043.3251, 3104.185, 3104.2441, 3104.29745, 3104.3781, 3104.4091, 3104.4488, 3104.47245, 3104.506, 3104.5117, 3104.53585, 3104.55275, 3104.56245, 3104.5853, 3104.6035, 3104.63405, 3104.64665, 3104.86515, 3186.06445, 
3186.1219, 3186.1892, 3186.2594, 3186.72495, 3252.25855, 3252.5244, 3252.5791, 3252.61605, 3252.66, 3252.7838, 3252.83865, 3252.89785, 3252.9504, 3252.982, 3253.0243, 3253.10015, 3314.3711, 3314.4289, 3314.48795, 3390.95525, 3391.36435, 3391.4287, 3391.43835, 3391.4876, 3391.5396, 3391.54085, 3391.6106, 3391.65565, 3391.7147, 3391.8038, 3391.8646, 3391.905, 3391.9615, 3439.17615, 3439.2596, 3499.6053, 3499.67485, 3499.74335, 3499.80635, 3500.2617)

st <- readMat("/data/downstate/wip/FromYuval/UPDOWN/Risiburst/RONOst.mat")

test_st<-as.spikeTrain(test)
test_ac<-acf.spikeTrain(test_st, lag.max = NULL,
       type = "correlation",
       plot = FALSE)
test_obj<-mkGLMdf(test_st,1)
test_isi<-isi(test_obj, lag = .001)
test4<-RS.method(test,4.6)
#B <- min(data.df$y) * 0.5  
# Estimate the rest parameters using a linear model
#model.0 <- lm(log(y - B) ~ x, data=data.df)  
#A <- exp(coef(model.0)[1]) 
#tau <- 1/(coef(model.0)[2]))
#start <- list(A,tau,B)
#model <- nls(y ~ A * exp(tau * x) + B , data = data.df, start = start)
#summary(model)

print("L1SOZ")
