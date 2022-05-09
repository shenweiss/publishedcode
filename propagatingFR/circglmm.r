library(R.matlab)
library(bpnreg)
print("L1SOZ")
phase_data <- readMat("/data/downstate/wip/completed_analyses/Rinput_l1soz.mat")
phase_frame <- as.data.frame(phase_data)
colnames(phase_frame)[1] <- "pairnum"
colnames(phase_frame)[2] <- "inout"
colnames(phase_frame)[3] <- "sign"
colnames(phase_frame)[4] <- "montage"
colnames(phase_frame)[5] <- "angle"
fit <- bpnme(angle ~ inout + sign + montage + inout:sign + (1|pairnum),data =  phase_frame, its = 100)
l1soz_h1 <- BFc(fit, hypothesis = "inout > sign")
l1soz_h2 <- BFc(fit, hypothesis = "inout:sign > inout")
l1soz_h3 <- BFc(fit, hypothesis = "inout > montage")
l1soz_h4 <- BFc(fit, hypothesis = "sign > montage")
l1soz_h5 <- BFc(fit, hypothesis = "inout:sign > montage")

print("L2SOZ")
phase_data <- readMat("/data/downstate/wip/completed_analyses/Rinput_l2soz.mat")
phase_frame <- as.data.frame(phase_data)
colnames(phase_frame)[1] <- "pairnum"
colnames(phase_frame)[2] <- "inout"
colnames(phase_frame)[3] <- "sign"
colnames(phase_frame)[4] <- "montage"
colnames(phase_frame)[5] <- "angle"
fit <- bpnme(angle ~ inout + sign + montage + inout:sign + (1|pairnum),data =  phase_frame, its = 100)
l2soz_h1 <- BFc(fit, hypothesis = "inout > sign")
l2soz_h2 <- BFc(fit, hypothesis = "inout:sign > inout")
l2soz_h3 <- BFc(fit, hypothesis = "inout > montage")
l2soz_h4 <- BFc(fit, hypothesis = "sign > montage")
l2soz_h5 <- BFc(fit, hypothesis = "inout:sign > montage")

print("L3SOZ")
phase_data <- readMat("/data/downstate/wip/completed_analyses/Rinput_l3soz.mat")
phase_frame <- as.data.frame(phase_data)
colnames(phase_frame)[1] <- "pairnum"
colnames(phase_frame)[2] <- "inout"
colnames(phase_frame)[3] <- "sign"
colnames(phase_frame)[4] <- "montage"
colnames(phase_frame)[5] <- "angle"
fit <- bpnme(angle ~ inout + sign + montage + inout:sign + (1|pairnum),data =  phase_frame, its = 100)
l3soz_h1 <- BFc(fit, hypothesis = "inout > sign")
l3soz_h2 <- BFc(fit, hypothesis = "inout:sign > inout")
l3soz_h3 <- BFc(fit, hypothesis = "inout > montage")
l3soz_h4 <- BFc(fit, hypothesis = "sign > montage")
l3soz_h5 <- BFc(fit, hypothesis = "inout:sign > montage")

print("L4SOZ")
phase_data <- readMat("/data/downstate/wip/completed_analyses/Rinput_l4soz.mat")
phase_frame <- as.data.frame(phase_data)
colnames(phase_frame)[1] <- "pairnum"
colnames(phase_frame)[2] <- "inout"
colnames(phase_frame)[3] <- "sign"
colnames(phase_frame)[4] <- "montage"
colnames(phase_frame)[5] <- "angle"
fit <- bpnme(angle ~ inout + sign + montage + inout:sign + (1|pairnum),data =  phase_frame, its = 100)
l4soz_h1 <- BFc(fit, hypothesis = "inout > sign")
l4soz_h2 <- BFc(fit, hypothesis = "inout:sign > inout")
l4soz_h3 <- BFc(fit, hypothesis = "inout > montage")
l4soz_h4 <- BFc(fit, hypothesis = "sign > montage")
l4soz_h5 <- BFc(fit, hypothesis = "inout:sign > montage")

print("L5SOZ")
phase_data <- readMat("/data/downstate/wip/completed_analyses/Rinput_l5soz.mat")
phase_frame <- as.data.frame(phase_data)
colnames(phase_frame)[1] <- "pairnum"
colnames(phase_frame)[2] <- "inout"
colnames(phase_frame)[3] <- "sign"
colnames(phase_frame)[4] <- "montage"
colnames(phase_frame)[5] <- "angle"
fit <- bpnme(angle ~ inout + sign + montage + inout:sign + (1|pairnum),data =  phase_frame, its = 100)
l5soz_h1 <- BFc(fit, hypothesis = "inout > sign")
l5soz_h2 <- BFc(fit, hypothesis = "inout:sign > inout")
l5soz_h3 <- BFc(fit, hypothesis = "inout > montage")
l5soz_h4 <- BFc(fit, hypothesis = "sign > montage")
l5soz_h5 <- BFc(fit, hypothesis = "inout:sign > montage")

print("L1NSOZ")
phase_data <- readMat("/data/downstate/wip/completed_analyses/Rinput_l1nsoz.mat")
phase_frame <- as.data.frame(phase_data)
colnames(phase_frame)[1] <- "pairnum"
colnames(phase_frame)[2] <- "inout"
colnames(phase_frame)[3] <- "sign"
colnames(phase_frame)[4] <- "montage"
colnames(phase_frame)[5] <- "angle"
fit <- bpnme(angle ~ inout + sign + montage + inout:sign + (1|pairnum),data =  phase_frame, its = 100)
l1nsoz_h1 <- BFc(fit, hypothesis = "inout > sign")
l1nsoz_h2 <- BFc(fit, hypothesis = "inout:sign > inout")
l1nsoz_h3 <- BFc(fit, hypothesis = "inout > montage")
l1nsoz_h4 <- BFc(fit, hypothesis = "sign > montage")
l1nsoz_h5 <- BFc(fit, hypothesis = "inout:sign > montage")

print("L2NSOZ")
phase_data <- readMat("/data/downstate/wip/completed_analyses/Rinput_l2nsoz.mat")
phase_frame <- as.data.frame(phase_data)
colnames(phase_frame)[1] <- "pairnum"
colnames(phase_frame)[2] <- "inout"
colnames(phase_frame)[3] <- "sign"
colnames(phase_frame)[4] <- "montage"
colnames(phase_frame)[5] <- "angle"
fit <- bpnme(angle ~ inout + sign + montage + inout:sign + (1|pairnum),data =  phase_frame, its = 100)
l2nsoz_h1 <- BFc(fit, hypothesis = "inout > sign")
l2nsoz_h2 <- BFc(fit, hypothesis = "inout:sign > inout")
l2nsoz_h3 <- BFc(fit, hypothesis = "inout > montage")
l2nsoz_h4 <- BFc(fit, hypothesis = "sign > montage")
l2nsoz_h5 <- BFc(fit, hypothesis = "inout:sign > montage")

print("L3NSOZ")
phase_data <- readMat("/data/downstate/wip/completed_analyses/Rinput_l3nsoz.mat")
phase_frame <- as.data.frame(phase_data)
colnames(phase_frame)[1] <- "pairnum"
colnames(phase_frame)[2] <- "inout"
colnames(phase_frame)[3] <- "sign"
colnames(phase_frame)[4] <- "montage"
colnames(phase_frame)[5] <- "angle"
fit <- bpnme(angle ~ inout + sign + montage + inout:sign + (1|pairnum),data =  phase_frame, its = 100)
l3nsoz_h1 <- BFc(fit, hypothesis = "inout > sign")
l3nsoz_h2 <- BFc(fit, hypothesis = "inout:sign > inout")
l3nsoz_h3 <- BFc(fit, hypothesis = "inout > montage")
l3nsoz_h4 <- BFc(fit, hypothesis = "sign > montage")
l3nsoz_h5 <- BFc(fit, hypothesis = "inout:sign > montage")

print("L4NSOZ")
phase_data <- readMat("/data/downstate/wip/completed_analyses/Rinput_l4nsoz.mat")
phase_frame <- as.data.frame(phase_data)
colnames(phase_frame)[1] <- "pairnum"
colnames(phase_frame)[2] <- "inout"
colnames(phase_frame)[3] <- "sign"
colnames(phase_frame)[4] <- "montage"
colnames(phase_frame)[5] <- "angle"
fit <- bpnme(angle ~ inout + sign + montage + inout:sign + (1|pairnum),data =  phase_frame, its = 100)
l4nsoz_h1 <- BFc(fit, hypothesis = "inout > sign")
l4nsoz_h2 <- BFc(fit, hypothesis = "inout:sign > inout")
l4nsoz_h3 <- BFc(fit, hypothesis = "inout > montage")
l4nsoz_h4 <- BFc(fit, hypothesis = "sign > montage")
l4nsoz_h5 <- BFc(fit, hypothesis = "inout:sign > montage")

print("L5NSOZ")
phase_data <- readMat("/data/downstate/wip/completed_analyses/Rinput_l5nsoz.mat")
phase_frame <- as.data.frame(phase_data)
colnames(phase_frame)[1] <- "pairnum"
colnames(phase_frame)[2] <- "inout"
colnames(phase_frame)[3] <- "sign"
colnames(phase_frame)[4] <- "montage"
colnames(phase_frame)[5] <- "angle"
fit <- bpnme(angle ~ inout + sign + montage + inout:sign + (1|pairnum),data =  phase_frame, its = 100)
l5nsoz_h1 <- BFc(fit, hypothesis = "inout > sign")
l5nsoz_h2 <- BFc(fit, hypothesis = "inout:sign > inout")
l5nsoz_h3 <- BFc(fit, hypothesis = "inout > montage")
l5nsoz_h4 <- BFc(fit, hypothesis = "sign > montage")
l5nsoz_h5 <- BFc(fit, hypothesis = "inout:sign > montage")
print("SAVE DATA AS TABLE")