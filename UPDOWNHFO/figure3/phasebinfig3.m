% phase bin plot
clear
load('FRONOdataoutphaseMISTAKEv3.mat')
power_quantile=quantile(MDLdata.power,125);
[idx]=find(MDLdata.power<power_quantile(26));
MDLdata(idx,:)=[];
masterraster1=masterraster;
masterraster1(idx,:)=[];
masterraster1=masterraster1(:,22:64);
phasebin_spikes_SOZ=[];
phasebin_spikes_NSOZ=[];
trialcounts_SOZ=[];
trialcounts_NSOZ=[];
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
trialcounts_SOZ(i-1)=numel(sozidx);
parfor j=1:numel(nsozidx)
  spike_avg_nsoz=vertcat(spike_avg_nsoz,masterraster1(nsozidx(j),:));
end;
phasebin_spikes_NSOZ(i-1,:)=mean(spike_avg_nsoz);
trialcounts_NSOZ(i-1)=numel(nsozidx);
end;
figure
imagesc(phasebin_spikes_NSOZ)
colorbar
title('NSOZ')
figure
imagesc(phasebin_spikes_SOZ)
colorbar
title('SOZ')
figure
imagesc(trialcounts_SOZ')
title('trials SOZ')
colorbar
figure
imagesc(trialcounts_NSOZ')
title('trials NSOZ')
colorbar