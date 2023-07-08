% phase bin plot
load('xcorrraster406sulphglah.mat')
power_quantile=quantile(MDLdata.power,125);
[idx]=find(MDLdata.power<power_quantile(26));
MDLdata(idx,:)=[];
masterraster(idx,:)=[];
power_quantile=quantile(MDLdata_pair.power,125);
[idx]=find(MDLdata_pair.power<power_quantile(26));
MDLdata_pair(idx,:)=[];
masterraster_pair(idx,:)=[];

masterraster1=masterraster;
masterraster1=masterraster1(:,22:64);

masterraster1_pair=masterraster_pair;
masterraster1_pair=masterraster1_pair(:,22:64);

% source
phasebin_spikes=[];
phasebins=[-pi():(pi()/2.5):pi()];
cutoff=phasebins(1);
counts_bin=[];
for i=2:5
[a,~]=find(MDLdata.slowangle<=phasebins(i));
[b,~]=find(MDLdata.slowangle>cutoff);
cutoff=phasebins(i);
c=intersect(a,b);

spike_avg=[];
counts_bin(i)=numel(c);
parfor j=1:numel(c)
spike_avg=vertcat(spike_avg,masterraster1(c(j),:));
end;
phasebin_spikes(i-1,:)=mean(spike_avg);
end;
figure
imagesc(phasebin_spikes)
colorbar
title('source')

% sink
phasebin_spikes=[];
phasebins=[-pi():(pi()/2.5):pi()];
cutoff=phasebins(1);
counts_bin=[];
for i=2:5
[a,~]=find(MDLdata_pair.slowangle<=phasebins(i));
[b,~]=find(MDLdata_pair.slowangle>cutoff);
cutoff=phasebins(i);
c=intersect(a,b);

spike_avg=[];
counts_bin(i)=numel(c);
parfor j=1:numel(c)
spike_avg=vertcat(spike_avg,masterraster1_pair(c(j),:));
end;
phasebin_spikes(i-1,:)=mean(spike_avg);
end;
figure
imagesc(phasebin_spikes)
colorbar
title('sink')

