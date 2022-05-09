server='localhost';
username='admin';
password='';
dbname='deckard_new';
port=27017;
conn = mongo(server,port,dbname,'UserName',username,'Password',password);
collection = "Electrodes";
test_query=['{"patient_id":"IO002"}'];
doc = find(conn,collection,'query',test_query,'limit',5000);
% LW14 LBA40 
load('IO002J_sleep_11.mat')
% chan 190
eeg_temp=eeg_data(190,:);
load('IO002J_sleep_12.mat')
eeg_temp2=eeg_data(190,:);
load('IO002J_sleep_15.mat')
eeg_temp3=eeg_data(190,:);
eeg_temp=[eeg_temp eeg_temp2 eeg_temp3];
f0 = (2*(60/2000));
df = .1;
N = 30; % must be even for this trick
h = remez(N,[0 f0-df/2 f0+df/2 1],[1 1 0 0]);
h = 2*h - ((0:N)==(N/2));
eeg_notch = filtfilt(h,1,eeg_temp);
[psd, freqs]=pwelch(eeg_notch,40000,[],[],2000);
psd=psd(1:1312);
freqs=freqs(1:1312);
maxpsd=max(psd(18:1312));
psd=psd/maxpsd;
IO02psd=psd;

server='localhost';
username='admin';
password='';
dbname='deckard_new';
port=27017;
conn = mongo(server,port,dbname,'UserName',username,'Password',password);
collection = "Electrodes";
test_query=['{"patient_id":"4145"}'];
doc = find(conn,collection,'query',test_query,'limit',5000);
% LPF16 Left superior frontal gyrus
% ch 16
load('TJU4145_11.mat')
eeg_temp=eeg_data(16,:);
load('TJU4145_12.mat')
eeg_temp2=eeg_data(16,:);
load('TJU4145_13.mat')
eeg_temp3=eeg_data(16,:);
load('TJU4145_14.mat')
eeg_temp4=eeg_data(16,:);
load('TJU4145_15.mat')
eeg_temp5=eeg_data(16,:);
load('TJU4145_16.mat')
eeg_temp6=eeg_data(16,:);
eeg_temp=[eeg_temp eeg_temp2 eeg_temp3 eeg_temp4 eeg_temp5 eeg_temp6];
f0 = (2*(60/2000));
df = .1;
N = 30; % must be even for this trick
h = remez(N,[0 f0-df/2 f0+df/2 1],[1 1 0 0]);
h = 2*h - ((0:N)==(N/2));
eeg_notch = filtfilt(h,1,eeg_temp);
[psd, freqs]=pwelch(eeg_notch,40000,[],[],2000);
psd=psd(1:1312);
freqs=freqs(1:1312);
maxpsd=max(psd(18:1312));
psd=psd/maxpsd;
tju4145psd=psd;

server='localhost';
username='admin';
password='';
dbname='deckard_new';
port=27017;
conn = mongo(server,port,dbname,'UserName',username,'Password',password);
collection = "Electrodes";
test_query=['{"patient_id":"IO006"}'];
doc = find(conn,collection,'query',test_query,'limit',5000);
% LRC9 left middle central gyrus
% chan130
load('IO006J_sleep_11.mat')
eeg_temp=eeg_data(130,:);
load('IO006J_sleep_12.mat')
eeg_temp2=eeg_data(130,:);
load('IO006J_sleep_13.mat')
eeg_temp3=eeg_data(130,:);
load('IO006J_sleep_14.mat')
eeg_temp4=eeg_data(130,:);
load('IO006J_sleep_15.mat')
eeg_temp5=eeg_data(130,:);
load('IO006J_sleep_16.mat')
eeg_temp6=eeg_data(130,:);
eeg_temp=[eeg_temp eeg_temp2 eeg_temp3 eeg_temp4 eeg_temp5 eeg_temp6];
f0 = (2*(60/2000));
df = .1;
N = 30; % must be even for this trick
h = remez(N,[0 f0-df/2 f0+df/2 1],[1 1 0 0]);
h = 2*h - ((0:N)==(N/2));
eeg_notch = filtfilt(h,1,eeg_temp);
[psd, freqs]=pwelch(eeg_notch,40000,[],[],2000);
psd=psd(1:1312);
freqs=freqs(1:1312);
maxpsd=max(psd(18:1312));
psd=psd/maxpsd;
IO006psd=psd;

server='localhost';
username='admin';
password='';
dbname='deckard_new';
port=27017;
conn = mongo(server,port,dbname,'UserName',username,'Password',password);
collection = "Electrodes";
test_query=['{"patient_id":"IO018"}'];
doc = find(conn,collection,'query',test_query,'limit',5000);
% LF8 Middle frontal gyrus
% channel 8
load('IO018Js_allmp1.mat')
eeg_temp=eeg_data(130,:);
load('IO018Js_allmp2.mat')
eeg_temp2=eeg_data(130,:);
load('IO018Js_allmp4.mat')
eeg_temp3=eeg_data(130,:);
load('IO018Js_allmp5.mat')
eeg_temp4=eeg_data(130,:);
eeg_temp=[eeg_temp eeg_temp2 eeg_temp3 eeg_temp4];
f0 = (2*(60/2000));
df = .1;
N = 30; % must be even for this trick
h = remez(N,[0 f0-df/2 f0+df/2 1],[1 1 0 0]);
h = 2*h - ((0:N)==(N/2));
eeg_notch = filtfilt(h,1,eeg_temp);
[psd, freqs]=pwelch(eeg_notch,40000,[],[],2000);
psd=psd(1:1312);
freqs=freqs(1:1312);
maxpsd=max(psd(18:1312));
psd=psd/maxpsd;
IO018psd=psd;

server='localhost';
username='admin';
password='';
dbname='deckard_new';
port=27017;
conn = mongo(server,port,dbname,'UserName',username,'Password',password);
collection = "Electrodes";
test_query=['{"patient_id":"481"}'];
doc = find(conn,collection,'query',test_query,'limit',5000);
% LOF7 middle frontal gyrus
% chan81
load('4811.mat')
eeg_temp=eeg_data(81,:);
load('4812.mat')
eeg_temp2=eeg_data(81,:);
load('4813.mat')
eeg_temp3=eeg_data(81,:);
load('4814.mat')
eeg_temp4=eeg_data(81,:);
load('4815.mat')
eeg_temp5=eeg_data(81,:);
load('4816.mat')
eeg_temp6=eeg_data(81,:);
eeg_temp=[eeg_temp eeg_temp2 eeg_temp3 eeg_temp4 eeg_temp5 eeg_temp6];
f0 = (2*(60/2000));
df = .1;
N = 30; % must be even for this trick
h = remez(N,[0 f0-df/2 f0+df/2 1],[1 1 0 0]);
h = 2*h - ((0:N)==(N/2));
eeg_notch = filtfilt(h,1,eeg_temp);
[psd, freqs]=pwelch(eeg_notch,40000,[],[],2000);
psd=psd(1:1312);
freqs=freqs(1:1312);
maxpsd=max(psd(18:1312));
psd=psd/maxpsd;
ucla481psd=psd;

% LGb7 Left Middle frontal Gyrus % LK15 left superior frontal gyrus 
% channel 164 %128
load('TJU4110_11.mat')
eeg_temp=eeg_data(128,:);
load('TJU4110_12.mat')
eeg_temp2=eeg_data(128,:);
load('TJU4110_16.mat')
eeg_temp3=eeg_data(128,:);
eeg_temp=[eeg_temp eeg_temp2 eeg_temp3];
f0 = (2*(60/2000));
df = .1;
N = 30; % must be even for this trick
h = remez(N,[0 f0-df/2 f0+df/2 1],[1 1 0 0]);
h = 2*h - ((0:N)==(N/2));
eeg_notch = filtfilt(h,1,eeg_temp);
[psd, freqs]=pwelch(eeg_notch,40000,[],[],2000);
psd=psd(1:1312);
freqs=freqs(1:1312);
maxpsd=max(psd(18:1312));
psd=psd/maxpsd;
tju4110psd=psd;

server='localhost';
username='admin';
password='';
dbname='deckard_new';
port=27017;
conn = mongo(server,port,dbname,'UserName',username,'Password',password);
collection = "Electrodes";
test_query=['{"patient_id":"IO022"}'];
doc = find(conn,collection,'query',test_query,'limit',5000);
% RFa9 middle frontal gyrus
%ch 66
load('IO022J_s2_block2.mat')
eeg_temp=eeg_data(66,:);
load('IO022J_s2_block3.mat')
eeg_temp2=eeg_data(66,:);
load('IO022J_s2_block5.mat')
eeg_temp3=eeg_data(66,:);
eeg_temp=[eeg_temp eeg_temp2 eeg_temp3];
f0 = (2*(60/2000));
df = .1;
N = 30; % must be even for this trick
h = remez(N,[0 f0-df/2 f0+df/2 1],[1 1 0 0]);
h = 2*h - ((0:N)==(N/2));
eeg_notch = filtfilt(h,1,eeg_temp);
[psd, freqs]=pwelch(eeg_notch,40000,[],[],2000);
psd=psd(1:1312);
freqs=freqs(1:1312);
maxpsd=max(psd(18:1312));
psd=psd/maxpsd;
IO022psd=psd;


server='localhost';
username='admin';
password='';
dbname='deckard_new';
port=27017;
conn = mongo(server,port,dbname,'UserName',username,'Password',password);
collection = "Electrodes";
test_query=['{"patient_id":"IO015"}'];
doc = find(conn,collection,'query',test_query,'limit',5000);
% LK15 superior frontal gyrus
% ch154
load('IO015J_s1_block1.mat')
eeg_temp=eeg_data(154,:);
load('IO015J_s1_block2.mat')
eeg_temp2=eeg_data(154,:);
load('IO015J_s1_block3.mat')
eeg_temp3=eeg_data(154,:);
load('IO015J_s1_block4.mat')
eeg_temp4=eeg_data(154,:);
eeg_temp=[eeg_temp eeg_temp2 eeg_temp3 eeg_temp4];
f0 = (2*(60/2000));
df = .1;
N = 30; % must be even for this trick
h = remez(N,[0 f0-df/2 f0+df/2 1],[1 1 0 0]);
h = 2*h - ((0:N)==(N/2));
eeg_notch = filtfilt(h,1,eeg_temp);
[psd, freqs]=pwelch(eeg_notch,40000,[],[],2000);
psd=psd(1:1312);
freqs=freqs(1:1312);
maxpsd=max(psd(18:1312));
psd=psd/maxpsd;
IO015psd=psd;


server='localhost';
username='admin';
password='';
dbname='deckard_new';
port=27017;
conn = mongo(server,port,dbname,'UserName',username,'Password',password);
collection = "Electrodes";
test_query=['{"patient_id":"IO005"}'];
doc = find(conn,collection,'query',test_query,'limit',5000);
% RI15 middle frontal gyrus %Rmh13 precentral gyrus
% ch 176 % ch 160
load('IO005J_s11.mat')
eeg_temp=eeg_data(176,:);
load('IO005J_s12.mat')
eeg_temp2=eeg_data(176,:);
load('IO005J_s13.mat')
eeg_temp3=eeg_data(176,:);
load('IO005J_s14.mat')
eeg_temp4=eeg_data(176,:);
load('IO005J_s16.mat')
eeg_temp5=eeg_data(176,:);
eeg_temp=[eeg_temp eeg_temp2 eeg_temp3 eeg_temp4 eeg_temp5];
f0 = (2*(60/2000));
df = .1;
N = 30; % must be even for this trick
h = remez(N,[0 f0-df/2 f0+df/2 1],[1 1 0 0]);
h = 2*h - ((0:N)==(N/2));
eeg_notch = filtfilt(h,1,eeg_temp);
[psd, freqs]=pwelch(eeg_notch,40000,[],[],2000);
psd=psd(1:1312);
freqs=freqs(1:1312);
maxpsd=max(psd(18:1312));
psd=psd/maxpsd;
IO005psd=psd;

server='localhost';
username='admin';
password='';
dbname='deckard_new';
port=27017;
conn = mongo(server,port,dbname,'UserName',username,'Password',password);
collection = "Electrodes";
test_query=['{"patient_id":"474"}'];
doc = find(conn,collection,'query',test_query,'limit',5000);
% LAC7 inferior frontal gyrus 
% ch79
load('4741.mat')
eeg_temp=eeg_data(79,:);
load('4742.mat')
eeg_temp2=eeg_data(79,:);
load('4745.mat')
eeg_temp3=eeg_data(79,:);
eeg_temp=[eeg_temp eeg_temp2 eeg_temp3];
f0 = (2*(60/2000));
df = .1;
N = 30; % must be even for this trick
h = remez(N,[0 f0-df/2 f0+df/2 1],[1 1 0 0]);
h = 2*h - ((0:N)==(N/2));
eeg_notch = filtfilt(h,1,eeg_temp);
[psd, freqs]=pwelch(eeg_notch,40000,[],[],2000);
psd=psd(1:1312);
freqs=freqs(1:1312);
maxpsd=max(psd(18:1312));
psd=psd/maxpsd;
ucla474psd=psd;

server='localhost';
username='admin';
password='';
dbname='deckard_new';
port=27017;
conn = mongo(server,port,dbname,'UserName',username,'Password',password);
collection = "Electrodes";
test_query=['{"patient_id":"IO019"}'];
doc = find(conn,collection,'query',test_query,'limit',5000);
% 3SC6 inferior parietal lobule BA40
load('IO019J_s1mp1.mat')
eeg_temp=eeg_data(79,:);
load('IO019J_s1mp2.mat')
eeg_temp2=eeg_data(79,:);
eeg_temp=[eeg_temp eeg_temp2];
f0 = (2*(60/2000));
df = .1;
N = 30; % must be even for this trick
h = remez(N,[0 f0-df/2 f0+df/2 1],[1 1 0 0]);
h = 2*h - ((0:N)==(N/2));
eeg_notch = filtfilt(h,1,eeg_temp);
[psd, freqs]=pwelch(eeg_notch,40000,[],[],2000);
psd=psd(1:1312);
freqs=freqs(1:1312);
maxpsd=max(psd(18:1312));
psd=psd/maxpsd;
IO019psd=psd;

server='localhost';
username='admin';
password='';
dbname='deckard_new';
port=27017;
conn = mongo(server,port,dbname,'UserName',username,'Password',password);
collection = "Electrodes";
test_query=['{"patient_id":"4163"}'];
doc = find(conn,collection,'query',test_query,'limit',5000);
% Lu9 left middle frontal gyrus
% ch 183
load('TJU41632.mat')
eeg_temp=eeg_data(183,:);
load('TJU41635.mat')
eeg_temp2=eeg_data(183,:);
eeg_temp=[eeg_temp eeg_temp2];
f0 = (2*(60/2000));
df = .1;
N = 30; % must be even for this trick
h = remez(N,[0 f0-df/2 f0+df/2 1],[1 1 0 0]);
h = 2*h - ((0:N)==(N/2));
eeg_notch = filtfilt(h,1,eeg_temp);
[psd, freqs]=pwelch(eeg_notch,40000,[],[],2000);
psd=psd(1:1312);
freqs=freqs(1:1312);
maxpsd=max(psd(18:1312));
psd=psd/maxpsd;
tju4163psd=psd;

psdarray=horzcat(ucla481psd,ucla474psd,tju4163psd,tju4145psd,tju4110psd,IO02psd,IO022psd,IO019psd,IO018psd,IO015psd,IO006psd,IO005psd);
meanpsd=mean(psdarray');
stdpsd=std(psdarray');

xarray=[];
yarray=[];
errorpos=[];
errorneg=[];
counter=0;
for i=18:20:1312
 counter=counter+1;
 xarray(counter)=freqs(i);
 yarray(counter)=meanpsd(i);
 errorpos(counter)=((stdpsd(i))/sqrt(12));
 errorneg(counter)=((stdpsd(i))/sqrt(12));
end;

errorbar(xarray,yarray,errorpos,errorneg,'black')
