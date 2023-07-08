library(R.matlab)
library(ggplot2) 
library(circular)

df <- readMat("C:/Yuval_UPDOWN_2023/R/esuspiralRdatarad.mat")
df <- as.data.frame(df)
colnames(df)[1] <- "phasebin"
colnames(df)[2] <- "NSOZ"
colnames(df)[3] <- "SOZ"

x <- c(as.numeric(unlist(df[2])))
dim(x) <- c(length(x), 1)
x <- cbind(x, rep(1,24))
y <- as.numeric(unlist(df[1]))

lm.circular(y=y, x=x, init=c(1,1), type='c-l', verbose=TRUE, tol=500)

x <- c(as.numeric(unlist(df[3])))
dim(x) <- c(length(x), 1)
x <- cbind(x, rep(1,24))
y <- as.numeric(unlist(df[1]))

lm.circular(y=y, x=x, init=c(1,1), type='c-l', verbose=TRUE, tol=500)

x <- runif(n=24, min=0.3, max=1)
dim(x) <- c(length(x), 1)
x <- cbind(x, rep(1,24))
y <- as.numeric(unlist(df[1]))

lm.circular(y=y, x=x, init=c(1,1), type='c-l', verbose=TRUE, tol=1000)

df <- readMat("C:/Yuval_UPDOWN_2023/R/esuspiralRdata_deg.mat")
df <- as.data.frame(df)
colnames(df)[1] <- "phasebin"
colnames(df)[2] <- "NSOZ"
colnames(df)[3] <- "SOZ"

dev.new()
p <- ggplot(data=df,aes(x=phasebin,y=NSOZ)) +
geom_point(colour="green") +
coord_polar() +
theme_light() +
scale_x_continuous(limits = c(0,360),breaks = seq(0, 360, by = 45),
minor_breaks = seq(0, 360, by = 15)) +
scale_y_continuous(limits = c(0.45, 1))
p
ggsave("C:/Yuval_UPDOWN_2023/R/nsozesumin.eps")

dev.new()
p <- ggplot(data=df,aes(x=phasebin,y=SOZ)) +
geom_point(colour="purple") +
coord_polar() +
theme_light() +
scale_x_continuous(limits = c(0,360),breaks = seq(0, 360, by = 45),
minor_breaks = seq(0, 360, by = 15)) +
scale_y_continuous(limits = c(0.45, 1))
p
ggsave("C:/Yuval_UPDOWN_2023/R/sozesumin.eps")

df <- readMat("C:/Yuval_UPDOWN_2023/R/meanblfiringesu.mat")
df <- as.data.frame(df)
colnames(df)[1] <- "phasebin"
colnames(df)[2] <- "NSOZ"
colnames(df)[3] <- "SOZ"

dev.new()
p <- ggplot(data=df,aes(x=phasebin,y=NSOZ)) +
geom_bar(stat="identity", colour="black", fill="blue") +
coord_polar() +
theme_light() 
p
ggsave("C:/Yuval_UPDOWN_2023/R/nsozmeanblpolar.eps")

dev.new()
p <- ggplot(data=df,aes(x=phasebin,y=SOZ)) +
geom_bar(stat="identity", colour="black", fill="red") +
coord_polar() +
theme_light() 
p
ggsave("C:/Yuval_UPDOWN_2023/R/sozmeanblpolar.eps")

dev.new()
p <- ggplot(data=df,aes(x=phasebin,y=SOZ)) +
geom_bar(stat="identity", colour="black", fill="red") +
coord_polar() +
theme_light() +
scale_x_continuous(limits = c(0,360),breaks = seq(0, 360, by = 45),
minor_breaks = seq(0, 360, by = 15))
p
ggsave("C:/Yuval_UPDOWN_2023/R/template.eps")

df <- readMat("C:/Yuval_UPDOWN_2023/R/meanblfiringisu.mat")
df <- as.data.frame(df)
colnames(df)[1] <- "phasebin"
colnames(df)[2] <- "NSOZ"
colnames(df)[3] <- "SOZ"

dev.new()
p <- ggplot(data=df,aes(x=phasebin,y=NSOZ)) +
geom_bar(stat="identity", colour="black", fill="blue") +
coord_polar() +
theme_light() 
p
ggsave("C:/Yuval_UPDOWN_2023/R/insozmeanblpolar.eps")

dev.new()
p <- ggplot(data=df,aes(x=phasebin,y=SOZ)) +
geom_bar(stat="identity", colour="black", fill="red") +
coord_polar() +
theme_light() 
p
ggsave("C:/Yuval_UPDOWN_2023/R/isozmeanblpolar.eps")

dev.new()
p <- ggplot(data=df,aes(x=phasebin,y=SOZ)) +
geom_bar(stat="identity", colour="black", fill="red") +
coord_polar() +
theme_light() +
scale_x_continuous(limits = c(0,360),breaks = seq(0, 360, by = 45),
minor_breaks = seq(0, 360, by = 15))
p
ggsave("C:/Yuval_UPDOWN_2023/R/template.eps")

