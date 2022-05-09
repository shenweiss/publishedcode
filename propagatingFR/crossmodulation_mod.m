function crossmodulation_mod(events_in_np, events_in_p, events_out_np, events_out_p, figtitle);

% events out prop
data.label='chan'
data.fsample=2000;
time_base=[(1/2000):(1/2000):(2001/2000)];
data.time=time_base;
data.trial=cell(1,1);
nevents=numel(events_out_p(:,1));
for i=1:nevents
data.trial{1,i}=events_out_p(i,:) % the fieldtrip data format has been succesfully constructed
end;
temp=[];
cfg=[];
cfg.lpfilter='no';
cfg.hpfilter='no';
dataLFP=ft_preprocessing(cfg, data); %Fieldtrip preprocessingdbqui
for i=1:nevents
    dataLFP.cfg.trl(i,:)=[1 2001 0];% define trial structure
end;

% Calculating power from here
cfg=[];
cfg.method='tfr';
cfg.foi=[200:2:600];
cfg.foilim=[200 600]; % calculate power across all bands
cfg.toi=0.5002;
freq = ft_freqanalysis(cfg,dataLFP);
temp_freq=squeeze(freq.powspctrm);
for i=1:201
    temp_freq(i,:)=zscore(temp_freq(i,:));
end;
freq.powspctrm(1,:,:)=temp_freq;
figure
ft_singleplotTFR(cfg, freq);
title(figtitle)
subtitle('FRs out prop')
cfg=[];
freq_backup=freq;

type_1=[];
for i=1:numel(events_out_p(:,1))
    type_1{i,1}=events_out_p(i,:);
end;

% Modulating Signal Evoked Potential
evoked_mod=[];
for i=1:nevents
    evoked_mod=horzcat(evoked_mod,type_1{i}(:));
end;
evoked_mod=sum(evoked_mod');
time=[(1/2000):(1/2000):(2001/2000)];

% Calculate Statistics using boot strapping
s_array={''};
for i=1:nevents
 s=phaseran(type_1{i}(:),250);
 s_array{i}=s;
 i
end;
evoked_mod_s=[];
for i=1:250
 evoked_mod_s_temp=[];
  for j=1:nevents
   evoked_mod_s_temp=horzcat(evoked_mod_s_temp,s_array{j}(:,i));
  end;
 i
 evoked_mod_s(i,:)=sum(evoked_mod_s_temp');
end;
[surrogate_mean,surrogate_std]=normfit(evoked_mod_s);
norm_evoked_mod=(evoked_mod-surrogate_mean)./surrogate_std;
yyaxis right
plot(time,norm_evoked_mod,'LineWidth',2.5,'Color',[1 1 1])
subtitle('FRs out prop')

% events in prop
data.label='chan'
data.fsample=2000;
time_base=[(1/2000):(1/2000):(2001/2000)];
data.time=time_base;
data.trial=cell(1,1);
nevents=numel(events_in_p(:,1));
for i=1:nevents
data.trial{1,i}=events_in_p(i,:) % the fieldtrip data format has been succesfully constructed
end;
temp=[];
cfg=[];
cfg.lpfilter='no';
cfg.hpfilter='no';
dataLFP=ft_preprocessing(cfg, data); %Fieldtrip preprocessingdbqui
for i=1:nevents
    dataLFP.cfg.trl(i,:)=[1 2001 0];% define trial structure
end;

% Calculating power from here
cfg=[];
cfg.method='tfr';
cfg.foi=[200:2:600];
cfg.foilim=[200 600]; % calculate power across all bands
cfg.toi=0.5002;
figure
freq = ft_freqanalysis(cfg,dataLFP);
temp_freq=squeeze(freq.powspctrm);
for i=1:201
    temp_freq(i,:)=zscore(temp_freq(i,:));
end;
freq.powspctrm(1,:,:)=temp_freq;
ft_singleplotTFR(cfg, freq);
title(figtitle)
subtitle('FRs in prop')
cfg=[];
freq_backup=freq;

type_1=[];
for i=1:numel(events_in_p(:,1))
    type_1{i,1}=events_in_p(i,:);
end;

% Modulating Signal Evoked Potential
evoked_mod=[];
for i=1:nevents
    evoked_mod=horzcat(evoked_mod,type_1{i}(:));
end;
evoked_mod=sum(evoked_mod');
time=[(1/2000):(1/2000):(2001/2000)];

% Calculate Statistics using boot strapping
s_array={''};
for i=1:nevents
 s=phaseran(type_1{i}(:),250);
 s_array{i}=s;
 i
end;
evoked_mod_s=[];
for i=1:250
 evoked_mod_s_temp=[];
  for j=1:nevents
   evoked_mod_s_temp=horzcat(evoked_mod_s_temp,s_array{j}(:,i));
  end;
 i
 evoked_mod_s(i,:)=sum(evoked_mod_s_temp');
end;
[surrogate_mean,surrogate_std]=normfit(evoked_mod_s);
norm_evoked_mod=(evoked_mod-surrogate_mean)./surrogate_std;
yyaxis right
plot(time,norm_evoked_mod,'LineWidth',2.5,'Color',[1 1 1])
subtitle('FRs in prop')

% events out non-prop
data.label='chan'
data.fsample=2000;
time_base=[(1/2000):(1/2000):(2001/2000)];
data.time=time_base;
data.trial=cell(1,1);
nevents=numel(events_out_np(:,1));
for i=1:nevents
data.trial{1,i}=events_out_np(i,:) % the fieldtrip data format has been succesfully constructed
end;
temp=[];
cfg=[];
cfg.lpfilter='no';
cfg.hpfilter='no';
dataLFP=ft_preprocessing(cfg, data); %Fieldtrip preprocessingdbqui
for i=1:nevents
    dataLFP.cfg.trl(i,:)=[1 2001 0];% define trial structure
end;

% Calculating power from here
cfg=[];
cfg.method='tfr';
cfg.foi=[200:2:600];
cfg.foilim=[200 600]; % calculate power across all bands
cfg.toi=0.5002;
freq = ft_freqanalysis(cfg,dataLFP);
temp_freq=squeeze(freq.powspctrm);
for i=1:201
    temp_freq(i,:)=zscore(temp_freq(i,:));
end;
freq.powspctrm(1,:,:)=temp_freq;
figure
ft_singleplotTFR(cfg, freq);
title(figtitle)
subtitle('FRs out non-prop')
cfg=[];
freq_backup=freq;

type_1=[];
for i=1:numel(events_out_np(:,1))
    type_1{i,1}=events_out_np(i,:);
end;

% Modulating Signal Evoked Potential
evoked_mod=[];
for i=1:nevents
    evoked_mod=horzcat(evoked_mod,type_1{i}(:));
end;
evoked_mod=sum(evoked_mod');
time=[(1/2000):(1/2000):(2001/2000)];

% Calculate Statistics using boot strapping
s_array={''};
for i=1:nevents
 s=phaseran(type_1{i}(:),250);
 s_array{i}=s;
 i
end;
evoked_mod_s=[];
for i=1:250
 evoked_mod_s_temp=[];
  for j=1:nevents
   evoked_mod_s_temp=horzcat(evoked_mod_s_temp,s_array{j}(:,i));
  end;
 i
 evoked_mod_s(i,:)=sum(evoked_mod_s_temp');
end;
[surrogate_mean,surrogate_std]=normfit(evoked_mod_s);
norm_evoked_mod=(evoked_mod-surrogate_mean)./surrogate_std;
yyaxis right
plot(time,norm_evoked_mod,'LineWidth',2.5,'Color',[1 1 1])
xlim([0 1])


% events in non-prop
data.label='chan'
data.fsample=2000;
time_base=[(1/2000):(1/2000):(2001/2000)];
data.time=time_base;
data.trial=cell(1,1);
nevents=numel(events_in_np(:,1));
for i=1:nevents
data.trial{1,i}=events_in_np(i,:) % the fieldtrip data format has been succesfully constructed
end;
temp=[];
cfg=[];
cfg.lpfilter='no';
cfg.hpfilter='no';
dataLFP=ft_preprocessing(cfg, data); %Fieldtrip preprocessingdbqui
for i=1:nevents
    dataLFP.cfg.trl(i,:)=[1 2001 0];% define trial structure
end;

% Calculating power from here
cfg=[];
cfg.method='tfr';
cfg.foi=[200:2:600];
cfg.foilim=[200 600]; % calculate power across all bands
cfg.toi=0.5002;
figure
freq = ft_freqanalysis(cfg,dataLFP);
temp_freq=squeeze(freq.powspctrm);
for i=1:201
    temp_freq(i,:)=zscore(temp_freq(i,:));
end;
freq.powspctrm(1,:,:)=temp_freq;
ft_singleplotTFR(cfg, freq);
title(figtitle)
subtitle('FRs in non-prop')
cfg=[];
freq_backup=freq;

type_1=[];
for i=1:numel(events_in_np(:,1))
    type_1{i,1}=events_in_np(i,:);
end;

% Modulating Signal Evoked Potential
evoked_mod=[];
for i=1:nevents
    evoked_mod=horzcat(evoked_mod,type_1{i}(:));
end;
evoked_mod=sum(evoked_mod');
time=[(1/2000):(1/2000):(2001/2000)];

% Calculate Statistics using boot strapping
s_array={''};
for i=1:nevents
 s=phaseran(type_1{i}(:),250);
 s_array{i}=s;
 i
end;
evoked_mod_s=[];
for i=1:250
 evoked_mod_s_temp=[];
  for j=1:nevents
   evoked_mod_s_temp=horzcat(evoked_mod_s_temp,s_array{j}(:,i));
  end;
 i
 evoked_mod_s(i,:)=sum(evoked_mod_s_temp');
end;
[surrogate_mean,surrogate_std]=normfit(evoked_mod_s);
norm_evoked_mod=(evoked_mod-surrogate_mean)./surrogate_std;
yyaxis right
plot(time,norm_evoked_mod,'LineWidth',2.5,'Color',[1 1 1])
xlim([0 1])
disp('non-prop')
numel(events_in_np(:,1))
disp('prop')
numel(events_in_p(:,1))