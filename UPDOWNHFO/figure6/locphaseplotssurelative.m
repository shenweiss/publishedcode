% phase bin plot
load('eRONOdataoutV1.mat')
for i=1:numel(masterraster(:,1))
    temp=masterraster(i,:);
    temp=temp./MDLdata.bl(i);
    idx=find(isnan(temp)==1);
    temp(idx)=0;
    idx=find(isinf(temp)==1);
    temp(idx)=7.5;
    masterraster(i,:)=temp;
end;
power_quantile=quantile(MDLdata.power,125);
[idx]=find(MDLdata.power<power_quantile(26));
MDLdata(idx,:)=[];
masterraster(idx,:)=[];
[idx]=find(MDLdata.loc==2);
MDLdata=MDLdata(idx,:);
masterraster=masterraster(idx,:);
masterraster1=masterraster;
masterraster1=masterraster1(:,22:64);
phasebin_spikes_SOZ=[];
phasebin_spikes_NSOZ=[];
phasebins=[-pi():(pi()/8):pi()];
cutoff=phasebins(1);
for i=2:17
   i 
[a,~]=find(MDLdata.slowangle<=phasebins(i));
[b,~]=find(MDLdata.slowangle>cutoff);
cutoff=phasebins(i);
c=intersect(a,b);
[d,~]=find(MDLdata.soz==1);
sozidx=intersect(c,d);
[f,~]=find(MDLdata.soz==0);
nsozidx=intersect(c,f);
spike_avg_soz=[];
spike_avg_nsoz=[];
parfor j=1:numel(sozidx)
spike_avg_soz=vertcat(spike_avg_soz,masterraster1(sozidx(j),:));
end;
phasebin_spikes_SOZ(i-1,:)=mean(spike_avg_soz);
parfor j=1:numel(nsozidx)
spike_avg_nsoz=vertcat(spike_avg_nsoz,masterraster1(nsozidx(j),:));
end;
phasebin_spikes_NSOZ(i-1,:)=mean(spike_avg_nsoz);
end;
figure
imagesc(phasebin_spikes_NSOZ)
colorbar
title('hipp NSOZ')
figure
imagesc(phasebin_spikes_SOZ)
colorbar
title('hipp SOZ')

clear
% phase bin plot
load('eRONOdataoutV1.mat')
for i=1:numel(masterraster(:,1))
    temp=masterraster(i,:);
    temp=temp-MDLdata.bl(i);
    masterraster(i,:)=temp;
end;
power_quantile=quantile(MDLdata.power,125);
[idx]=find(MDLdata.power<power_quantile(26));
MDLdata(idx,:)=[];
masterraster(idx,:)=[];
[idx]=find(MDLdata.loc==2);
MDLdata(idx,:)=[];
masterraster(idx,:)=[];
masterraster1=masterraster;
masterraster1=masterraster1(:,22:64);
phasebin_spikes_SOZ=[];
phasebin_spikes_NSOZ=[];
phasebins=[-pi():(pi()/8):pi()];
cutoff=phasebins(1);
soz_ci=[];
nsoz_ci=[];
for i=2:17
   i 
[a,~]=find(MDLdata.slowangle<=phasebins(i));
[b,~]=find(MDLdata.slowangle>cutoff);
cutoff=phasebins(i);
c=intersect(a,b);
[d,~]=find(MDLdata.soz==1);
sozidx=intersect(c,d);
[f,~]=find(MDLdata.soz==0);
nsozidx=intersect(c,f);
spike_avg_soz=[];
spike_avg_nsoz=[];
parfor j=1:numel(sozidx)
spike_avg_soz=vertcat(spike_avg_soz,masterraster1(sozidx(j),:));
if i==4
soz_ci=vertcat(soz_ci,masterraster1(sozidx(j),:));
end;
end;
phasebin_spikes_SOZ(i-1,:)=mean(spike_avg_soz);
parfor j=1:numel(nsozidx)
spike_avg_nsoz=vertcat(spike_avg_nsoz,masterraster1(nsozidx(j),:));
if i==4
nsoz_ci=vertcat(nsoz_ci,masterraster1(nsozidx(j),:))
end
end;
phasebin_spikes_NSOZ(i-1,:)=mean(spike_avg_nsoz);
end;
figure
imagesc(phasebin_spikes_NSOZ)
colorbar
title('non-hipp NSOZ')
figure
imagesc(phasebin_spikes_SOZ)
colorbar
title('non-hipp SOZ')

SEM = std(nsoz_ci(:,1:18))/sqrt(length(nsoz_ci(:,1:18)));               % Standard Error
ts = tinv([0.20  0.80],length(nsoz_ci(:,1:18))-1);      % T-Score
CI_1 = mean(nsoz_ci(:,1:18)) + SEM;              
CI_2 = mean(nsoz_ci(:,1:18)) - SEM;
time=[(2/84):(2/84):2];
time=time(22:64);
figure
plot(time(1:18),smooth(phasebin_spikes_NSOZ(3,1:18),5));
hold on
plot(time(1:18),smooth(CI_1,5),'red');
plot(time(1:18),smooth(CI_2,5),'red');
SEM = std(soz_ci(:,1:18))/sqrt(length(soz_ci(:,1:18)));               % Standard Error
ts = tinv([0.20  0.80],length(soz_ci(:,1:18))-1);      % T-Score
CI_1 = mean(soz_ci(:,1:18)) + SEM;              
CI_2 = mean(soz_ci(:,1:18)) - SEM;
plot(time(1:18),smooth(phasebin_spikes_SOZ(3,1:18),5));
plot(time(1:18),smooth(CI_1,5),'red');
plot(time(1:18),smooth(CI_2,5),'red');

[h,p,ci,stats] = ttest2(nsoz_ci(:,5),soz_ci(:,5))

SOZmin_t=[];
NSOZmin_t=[];
SOZmeanbl=[];
NSOZmeanbl=[];
time=[(2/84):(2/84):2];
time=time(22:64);
for i=1:24
    [~,idx_nsoz]=min(smooth(phasebin_spikes_NSOZ(i,20:41),3));
    [~,idx_soz]=min(smooth(phasebin_spikes_SOZ(i,20:41),3));
    NSOZmin_t(i)=time(idx_nsoz);
    SOZmin_t(i)=time(idx_soz);
    NSOZmeanbl(i)=mean(phasebin_spikes_NSOZ(i,1:41));
    SOZmeanbl(i)=mean(phasebin_spikes_SOZ(i,1:41));
end;
% test=horzcat(phasebins(2:end)',NSOZmin_t')
% figure
% scatter(test(:,1),test(:,2))
% figure
% polarscatter(test(:,1),test(:,2))
% rlim([0.6 1]);
% 
% test=horzcat(phasebins(2:end)',SOZmin_t')
% figure
% scatter(test(:,1),test(:,2))
% figure
% polarscatter(test(:,1),test(:,2))
% rlim([0.3 1]);
% 
% temp=phasebins(2:end);
% [idx]=temp<0
% temp(idx)=temp(idx)+(2*pi())
% temp=temp-(3*pi()/2)
spiralRdata=horzcat(phasebins(2:end)',NSOZmin_t',SOZmin_t');

% stats for mean bl
NSOZmeanbl=round((NSOZmeanbl.*1000),0)
SOZmeanbl=round((SOZmeanbl.*1000),0)
NSOZmeanbl=NSOZmeanbl-min(NSOZmeanbl);
SOZmeanbl=SOZmeanbl-min(SOZmeanbl);
% convert to angles
NSOZangles=[];
SOZangles=[];
for i=1:numel(NSOZmeanbl)
    temp=ones(1,NSOZmeanbl(i));
    temp=temp.*phasebins(1+i);
    NSOZangles=vertcat(NSOZangles,temp');
    temp=ones(1,SOZmeanbl(i));
    temp=temp.*phasebins(1+i);
    SOZangles=vertcat(SOZangles,temp');
end;

