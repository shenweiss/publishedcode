%%
slow=[];
[idx]=find(MDLdata.soz==0);
ieegslowangsoz=ieegslowang(idx);
for i=1:numel(ieegslowangsoz)
    temp=ieegslowangsoz{i};
    slow=horzcat(slow,temp);
end;
[idx]=find(slow==0);
slow(idx)=[];
[idx]=find(slow<0);
slow(idx)=slow(idx)+(2*pi());
slow=unique(slow);
figure
[t, r_nsoz] = rose(slow, 72); % 100 is desired number of bins. Set as needed
r_nsoz = r_nsoz./numel(slow); % normalize
polar(t, r_nsoz) % polar plot

%%
slow=[];
[idx]=find(MDLdata.soz==1);
ieegslowangsoz=ieegslowang(idx);
for i=1:numel(ieegslowangsoz)
    temp=ieegslowangsoz{i};
    slow=horzcat(slow,temp);
end;
[idx]=find(slow==0);
slow(idx)=[];
[idx]=find(slow<0);
slow(idx)=slow(idx)+(2*pi());
slow=unique(slow);
figure
[t, r_soz] = rose(slow, 72); % 100 is desired number of bins. Set as needed
r_soz = r_soz./numel(slow); % normalize
polar(t, r_soz) % polar plot

idx=[2:4:288];
bins=[0:5:355];
r_nsoz=r_nsoz(idx);
r_soz=r_soz(idx);
figure_3a2=horzcat(r_nsoz',r_soz',bins');

% % ripple phasor probability plot
% load('FRONOdataoutphaseMISTAKEv3.mat')
adjslow=MDLdata.slowangle;
[idx]=find(MDLdata.soz==0);
adjslownsoz=adjslow(idx);
[idx]=find(MDLdata.soz==1);
adjslowsoz=adjslow(idx);
adjslownsoz=unique(adjslownsoz);
adjslowsoz=unique(adjslowsoz);
[t, r] = rose(adjslownsoz, 72); % 100 is desired number of bins. Set as needed
r_adjslownsoz = r./numel(adjslownsoz); % normalize
figure
polar(t, r_adjslownsoz) % polar plot
idx=[2:4:288];
nsozrose=r_adjslownsoz(idx);
[t, r] = rose(adjslowsoz, 72); % 100 is desired number of bins. Set as needed
r_adjslowsoz = r./numel(adjslowsoz); % normalize
figure
polar(t, r_adjslowsoz) % polar plot
sozrose=r_adjslowsoz(idx);
bins=[0:5:355];
figure2a=horzcat(nsozrose',sozrose',bins');

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
title('NSOZ')
figure
imagesc(phasebin_spikes_SOZ)
colorbar
title('SOZ')