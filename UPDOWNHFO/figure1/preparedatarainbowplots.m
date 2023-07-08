load('spikes416.mat')
% REC channels 9-15 max 11
% RAH channels 16-28 max 16
load('EEG416concat.mat')
chanlist=eeg.chanlist;
eeg_data=eeg.eeg_data;
eeg_data_ds=[];
for i=1:(numel(eeg_data(:,1)))
    eeg_data_ds(i,:)=decimate(eeg_data(i,:),4,'fir');
end;
eeg_data=eeg_data_ds;
eeg_data_ds=[];

maxchan=numel(eeg_data(:,1));
eeg_data(maxchan,:)=[];
[output_bpFIR, delays] = filterEEG_ezpac70yuval(eeg_data, 500);
[output_hilbert] = zhilbert_ezpacyuval(eeg_data, output_bpFIR, 500);
fprintf('hilbert done \r');
numchan=numel(eeg_data(:,1));
[output_osc_epochs] = epochs_ezpacyuval(numchan, output_hilbert, 500);
fprintf('epochs test done \r');

t_epoch_delta = gather(output_osc_epochs.t_epoch_delta);
t_epoch_slow = gather(output_osc_epochs.t_epoch_slow);
clear output_osc_epochs
clear eeg_data;
clear output bpFIR;
hDelta=gather(output_hilbert.eeg.hDelta);
hSlow=gather(output_hilbert.eeg.hSlow);

zDelta=gather(output_hilbert.zDelta);
zSlow=gather(output_hilbert.zSlow);

