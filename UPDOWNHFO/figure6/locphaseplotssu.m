% phase bin plot
load('eRONOdataoutV1.mat')
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
counts_soz_hipp=[];
counts_nsoz_hipp=[];
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
counts_soz_hipp(i)=numel(sozidx);
counts_nsoz_hipp(i)=numel(nsozidx);
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
counts_soz_eh=[];
counts_nsoz_eh=[];
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
counts_soz_eh(i)=numel(sozidx);
counts_nsoz_eh(i)=numel(nsozidx);
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
title('non-hipp NSOZ')
figure
imagesc(phasebin_spikes_SOZ)
colorbar
title('non-hipp SOZ')


SOZmin_t=[];
NSOZmin_t=[];
SOZmeanbl=[];
NSOZmeanbl=[];
time=[(2/84):(2/84):2];
time=time(15:41);
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

