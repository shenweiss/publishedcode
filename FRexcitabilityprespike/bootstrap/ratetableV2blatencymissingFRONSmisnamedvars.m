function [hfo_table,latency] = ratetable()
server='localhost';
username='admin';
password='';
dbname='deckard_new';
collection = "yuvalHFO";
port=27017;
conn = mongo(server,port,dbname,'UserName',username,'Password',password);

RpreSlatsoz=[];
FRpreSlatsoz=[];
FRONSpostFRlatsoz=[];
FRONSpostRlatsoz=[];
RONSpostFRlatsoz=[];
RONSpostRlatsoz=[];

RpreSlatnsoz=[];
FRpreSlatnsoz=[];
FRONSpostFRlatnsoz=[];
FRONSpostRlatnsoz=[];
RONSpostFRlatnsoz=[];
RONSpostRlatnsoz=[];

RpreSlatnsoz_b=cell(500,1);
FRpreSlatnsoz_b=cell(500,1);
RpreSlatsoz_b=cell(500,1);
FRpreSlatsoz_b=cell(500,1);

%For each patient
%Calculate duration
%For each macroelectrode calculate
%1) fRonO rate
%2) RonO rate
%3) fRonS rate
%4) RonS rate
%5) preS fRonO rate
%6) preS RonO rate
%7) fRonS post fRonO rate
%8) fRonS post RonO rate
%9) RonS post fRonO rate
%10) RonS post RonO rate

%398
load('/data/downstate/wip/FromYuval/P398/EEG398concat.mat');
time_398=0;
full_index=[];
for i=1:11
      eeg_bp=eeg.eeg_data(1,(((i-1)*2000*60*10)+1):(i*2000*60*10));
      fzeeghg=ez_eegfilter(eeg_bp(1,:),80,600,2000);
      fzeegzhgamp=zscore(smooth(abs(hilbert(fzeeghg)),400));
      fzeegzhgamp=fzeegzhgamp';
      [idx]=find(fzeegzhgamp>.1);
      numel(idx)/2000;
      duration_tmp=((10*60*2000)-numel(idx))/2000;
      time_398=time_398+duration_tmp;
      index_t=[0.0005:0.0005:600]+((i-1)*600); % 
       if ~isempty(idx)
         index_t(idx)=[];
       end;
      full_index=horzcat(full_index,index_t);
end;
time_398=time_398/60;
test_query=['{"patient_id":"398"}'];
electrode=distinct(conn,collection,'electrode','query',test_query)
dat1=[];
dat2=[];
dat3=[];
dat4=[];
dat5=[];
dat6=[];
dat7=[];
dat8=[];
dat9=[];
dat10=[];
soz=[];
close(conn)
conn = mongoc(server,port,dbname,'UserName',username,'Password',password);
patient={''};
for i=1:numel(electrode)
       patient(i)={'398'};
end;

for i=1:numel(electrode)
       i
       test_query=['{"patient_id":"398","type":"' num2str(1) '","electrode":"' electrode{i} '" }'];
       temp = find(conn,collection,'Query',test_query,'limit',1);
       soz(i)=str2num(temp.soz);
       test_query=['{"patient_id":"398","type":"' num2str(4) '","electrode":"' electrode{i} '" }'];
       dat1_t = count(conn,collection,Query=test_query);
       dat1_t = double(dat1_t);
       dat1(i)=dat1_t/time_398;
       test_query=['{"patient_id":"398","type":"' num2str(1) '","electrode":"' electrode{i} '" }'];
       dat2_t = count(conn,collection,Query=test_query);
       dat2_t = double(dat2_t);
       dat2(i)=dat2_t/time_398;
       test_query=['{"patient_id":"398","type":"' num2str(5) '","electrode":"' electrode{i} '" }'];
       dat3_t = count(conn,collection,Query=test_query);
       dat3_t = double(dat3_t);
       dat3(i)=dat3_t/time_398;
       test_query=['{"patient_id":"398","type":"' num2str(2) '","electrode":"' electrode{i} '" }'];
       dat4_t = count(conn,collection,Query=test_query);
       dat4_t = double(dat4_t);
       dat4(i)=dat4_t/time_398;
       % FR before spike
       test_query=['{"patient_id":"398","type":"' num2str(2) '","electrode":"' electrode{i} '" }'];
       RONS = find(conn,collection,'Query',test_query);
       rons_time=[];
       if ~isempty(RONS)
       parfor j=1:numel(RONS(:,1))
           rons_time(j)=getfield(RONS,{j},'start_t');
       end;
       end;
       test_query=['{"patient_id":"398","type":"' num2str(3) '","electrode":"' electrode{i} '" }'];
       SS = find(conn,collection,'Query',test_query);
       ss_time=[];
       if ~isempty(SS)
       parfor j=1:numel(SS(:,1))
            ss_time(j)=getfield(SS,{j},'start_t');
       end;
       end;
       test_query=['{"patient_id":"398","type":"' num2str(5) '","electrode":"' electrode{i} '" }'];
       FRONS = find(conn,collection,'Query',test_query);
       frons_time=[];
       if ~isempty(FRONS)
       parfor j=1:numel(FRONS(:,1))
           frons_time(j)=getfield(FRONS,{j},'start_t');
       end;
       end;
       allspike_t=frons_time;
       allspike_t=sort(allspike_t,'ascend');
       test_query=['{"patient_id":"398","type":"' num2str(4) '","electrode":"' electrode{i} '" }'];
       FRONO = find(conn,collection,'Query',test_query);
       frono_time=[];
       if ~isempty(FRONO)
       parfor j=1:numel(FRONO(:,1))
           frono_time(j)=getfield(FRONO,{j},'start_t');
       end;
       end;
       spike_latency=[];
       if ~isempty(allspike_t)
           if ~isempty(frono_time)
               for k=1:numel(frono_time)
                   temp=allspike_t-frono_time(k);
                   idx=find(temp>0);
                   if ~isempty(idx)
                       spike_latency(k)=min(temp(idx));
                   else
                       spike_latency(k)=NaN;
                   end;
               end;
           end;
       end;
       dat5_t=numel(find(spike_latency<0.3));
       dat5(i)=dat5_t/time_398;
       if soz(i)==1
            FRpreSlatsoz=vertcat(FRpreSlatsoz,spike_latency');
       else 
            FRpreSlatnsoz=vertcat(FRpreSlatnsoz,spike_latency');
       end;     
       if ~isempty(allspike_t)
           if ~isempty(frono_time)
             for o=1:500
               permfr=rand(numel(frono_time),1);
               permfr=permfr*numel(full_index);
               permfr=ceil(permfr);
               permfr=full_index(permfr);
               for k=1:numel(permfr)
                   temp=allspike_t-permfr(k);
                   idx=find(temp>0);
                   if ~isempty(idx)
                       spike_latency(k)=min(temp(idx));
                   else
                       spike_latency(k)=NaN;
                   end;
               end;
            if soz(i)==1
            FRpreSlatsoz_b{o}=vertcat(FRpreSlatsoz_b{o},spike_latency');
            else 
            FRpreSlatnsoz_b{o}=vertcat(FRpreSlatnsoz_b{o},spike_latency');
            end; 
            end;  
           end;
       end;

       % R before spike
       test_query=['{"patient_id":"398","type":"' num2str(2) '","electrode":"' electrode{i} '" }'];
       RONS = find(conn,collection,'Query',test_query);
       rons_time=[];
       if ~isempty(RONS)
       parfor j=1:numel(RONS(:,1))
           rons_time(j)=getfield(RONS,{j},'start_t');
       end;
       end;
       test_query=['{"patient_id":"398","type":"' num2str(3) '","electrode":"' electrode{i} '" }'];
       SS = find(conn,collection,'Query',test_query);
       ss_time=[];
       if ~isempty(SS)
       parfor j=1:numel(SS(:,1))
            ss_time(j)=getfield(SS,{j},'start_t');
       end;
       end;
       test_query=['{"patient_id":"398","type":"' num2str(5) '","electrode":"' electrode{i} '" }'];
       FRONS = find(conn,collection,'Query',test_query);
       frons_time=[];
       if ~isempty(FRONS)
       parfor j=1:numel(FRONS(:,1))
           frons_time(j)=getfield(FRONS,{j},'start_t');
       end;
       end;
       allspike_t=rons_time;
       allspike_t=sort(allspike_t,'ascend');
       test_query=['{"patient_id":"398","type":"' num2str(4) '","electrode":"' electrode{i} '" }'];
       RONO = find(conn,collection,'Query',test_query);
       rono_time=[];
       if ~isempty(RONO)
       parfor j=1:numel(RONO(:,1))
           rono_time(j)=getfield(RONO,{j},'start_t');
       end;
       end;
       spike_latency=[];
       if ~isempty(allspike_t)
           if ~isempty(rono_time)
               for k=1:numel(rono_time)
                   temp=allspike_t-rono_time(k);
                   idx=find(temp>0);
                   if ~isempty(idx)
                       spike_latency(k)=min(temp(idx));
                   else
                       spike_latency(k)=NaN;
                   end;
               end;
           end;
       end;
       dat6_t=numel(find(spike_latency<0.3));
       dat6(i)=dat6_t/time_398;
       if soz(i)==1
           RpreSlatsoz=vertcat(RpreSlatsoz,spike_latency');
       else
           RpreSlatnsoz=vertcat(RpreSlatnsoz,spike_latency');
       end;
       if ~isempty(allspike_t)
           if ~isempty(rono_time)
             for o=1:500
               permr=rand(numel(rono_time),1);
               permr=(permr*numel(full_index));
               permr=ceil(permr);
               permr=full_index(permr);
               for k=1:numel(permr)
                   temp=allspike_t-permr(k);
                   idx=find(temp>0);
                   if ~isempty(idx)
                       spike_latency(k)=min(temp(idx));
                   else
                       spike_latency(k)=NaN;
                   end;
               end;
            if soz(i)==1
            RpreSlatsoz_b{o}=vertcat(RpreSlatsoz_b{o},spike_latency');
            else 
            RpreSlatnsoz_b{o}=vertcat(RpreSlatnsoz_b{o},spike_latency');
            end; 
            end;  
           end;
       end;

       % FronS after HFO
       test_query=['{"patient_id":"398","type":"' num2str(5) '","electrode":"' electrode{i} '" }']; 
       HFO = find(conn,collection,'Query',test_query);
       start_t=[];
       if ~isempty(HFO)
       parfor j=1:numel(HFO(:,1))
           start_t(j)=getfield(HFO,{j},'start_t');
       end;
       end;
       test_query=['{"patient_id":"398","type":"' num2str(4) '","electrode":"' electrode{i} '" }'];
       FR = find(conn,collection,'Query',test_query);
       frono_time=[];
       parfor j=1:numel(FR(:,1))
            frono_time(j)=getfield(FR,{j},'start_t');
       end;
       spike_latency=[];
       if ~isempty(start_t)
           if ~isempty(frono_time)
               for k=1:numel(start_t)
                   temp=start_t(k)-frono_time;
                   idx=find(temp>0);
                     if ~isempty(idx)
                        spike_latency(k)=min(temp(idx));
                     else
                        spike_latency(k)=NaN;
                     end;
               end;
           end;
       end;
       dat7_t=numel(find(spike_latency<0.3));
       dat7(i)=dat7_t/time_398;
       if soz(i)==1
           FRONSpostFRlatsoz=vertcat(FRONSpostFRlatsoz, spike_latency');
       else
           FRONSpostFRlatnsoz=vertcat(FRONSpostFRlatnsoz, spike_latency');
       end;

       test_query=['{"patient_id":"398","type":"' num2str(1) '","electrode":"' electrode{i} '" }'];
       R = find(conn,collection,'Query',test_query);
       rono_time=[];
       parfor j=1:numel(R(:,1))
            rono_time(j)=getfield(R,{j},'start_t');
       end;
       spike_latency=[];
           if ~isempty(start_t)
               if ~isempty(rono_time)
                   for k=1:numel(start_t)
                       temp=start_t(k)-rono_time;
                       idx=find(temp>0);
                       if ~isempty(idx)
                           spike_latency(k)=min(temp(idx));
                       else
                           spike_latency(k)=NaN;
                       end;
                   end;
               end;
       end;
       dat8_t=numel(find(spike_latency<0.3));
       dat8(i)=dat8_t/time_398;
       if soz(i)==1
           FRONSpostRlatsoz=vertcat(FRONSpostRlatsoz,spike_latency');
       else
           FRONSpostRlatnsoz=vertcat(FRONSpostRlatnsoz,spike_latency');
       end;
 %  RonS after HFO
       test_query=['{"patient_id":"398","type":"' num2str(2) '","electrode":"' electrode{i} '" }']; 
       HFO = find(conn,collection,'Query',test_query);
       start_t=[];
       if ~isempty(HFO)
       parfor j=1:numel(HFO(:,1))
           start_t(j)=getfield(HFO,{j},'start_t');
       end;
       end;
       test_query=['{"patient_id":"398","type":"' num2str(4) '","electrode":"' electrode{i} '" }'];
       FR = find(conn,collection,'Query',test_query);
       frono_time=[];
       parfor j=1:numel(FR(:,1))
            frono_time(j)=getfield(FR,{j},'start_t');
       end;
       spike_latency=[];
       if ~isempty(start_t)
           if ~isempty(frono_time)
               for k=1:numel(start_t)
                   temp=start_t(k)-frono_time;
                   idx=find(temp>0);
                     if ~isempty(idx)
                        spike_latency(k)=min(temp(idx));
                     else
                        spike_latency(k)=NaN;
                     end;
               end;
           end;
       end;
       dat9_t=numel(find(spike_latency<0.3));
       dat9(i)=dat9_t/time_398;
       if soz(i)==1
            RONSpostFRlatsoz=vertcat(RONSpostFRlatsoz, spike_latency');
       else
            RONSpostFRlatnsoz=vertcat(RONSpostFRlatnsoz, spike_latency');
       end;
       test_query=['{"patient_id":"398","type":"' num2str(1) '","electrode":"'  electrode{i} '" }'];
       R = find(conn,collection,'Query',test_query);
       rono_time=[];
       parfor j=1:numel(R(:,1))
            rono_time(j)=getfield(R,{j},'start_t');
       end;
       spike_latency=[];
           if ~isempty(start_t)
               if ~isempty(rono_time)
                   for k=1:numel(start_t)
                       temp=start_t(k)-rono_time;
                       idx=find(temp>0);
                       if ~isempty(idx)
                           spike_latency(k)=min(temp(idx));
                       else
                           spike_latency(k)=NaN;
                       end;
                   end;
               end;
       end;
       dat10_t=numel(find(spike_latency<0.3));
       dat10(i)=dat10_t/time_398;
       if soz(i)==1
          RONSpostRlatsoz=vertcat(RONSpostRlatsoz,spike_latency');
       else
          RONSpostRlatnsoz=vertcat(RONSpostRlatnsoz,spike_latency');
       end;
end;


patient=patient';
electrode=electrode';
dat1=dat1';
dat2=dat2';
dat3=dat3';
dat4=dat4';
dat5=dat5';
dat6=dat6';
dat7=dat7';
dat8=dat8';
dat9=dat9';
dat10=dat10'
soz=soz';
table398=table(patient,electrode,dat1,dat2,dat3,dat4,dat5,dat6,dat7,dat8,dat9,dat10,soz);
hfo_table=table398;
latency.RpreSlatsoz=RpreSlatsoz;
latency.FRpreSlatsoz=FRpreSlatsoz;
latency.FRONSpostFRlatsoz=FRONSpostFRlatsoz;
latency.FRONSpostRlatsoz=FRONSpostRlatsoz;
latency.RONSpostFRlatsoz=RONSpostFRlatsoz;
latency.RONSpostRlatsoz=RONSpostRlatsoz;
latency.RpreSlatnsoz=RpreSlatnsoz;
latency.FRpreSlatnsoz=FRpreSlatnsoz;
latency.FRONSpostFRlatnsoz=FRONSpostFRlatnsoz;
latency.FRONSpostRlatnsoz=FRONSpostRlatnsoz;
latency.RONSpostFRlatnsoz=RONSpostFRlatnsoz;
latency.RONSpostRlatnsoz=RONSpostRlatnsoz;

%406
close(conn)
conn = mongo(server,port,dbname,'UserName',username,'Password',password);
load('/data/downstate/wip/FromYuval/P406/EEG406concat.mat');
time_406=0;
lost=0;
full_index=[];
for i=1:15
      eeg_bp=eeg.eeg_data(1,(((i-1)*2000*60*10)+1):(i*2000*60*10));
      fzeeghg=ez_eegfilter(eeg_bp(1,:),80,600,2000);
      fzeegzhgamp=zscore(smooth(abs(hilbert(fzeeghg)),400));
      fzeegzhgamp=fzeegzhgamp';
      [idx]=find(fzeegzhgamp>.1);
      lost=lost+numel(idx)/2000;
      duration_tmp=((10*60*2000)-numel(idx))/2000;
      time_406=time_406+duration_tmp;
      index_t=[0.0005:0.0005:600]+((i-1)*600); % 
       if ~isempty(idx)
         index_t(idx)=[];
       end;
      full_index=horzcat(full_index,index_t);
end;
lost
time_406=time_406/60;
test_query=['{"patient_id":"406"}'];
electrode=distinct(conn,collection,'electrode','query',test_query)

dat1=[];
dat2=[];
dat3=[];
dat4=[];
dat5=[];
dat6=[];
dat7=[];
dat8=[];
dat9=[];
dat10=[];
soz=[];
close(conn)
conn = mongoc(server,port,dbname,'UserName',username,'Password',password);
patient={''};
for i=1:numel(electrode)
       patient(i)={'406'};
end;

for i=1:numel(electrode)
       i
       test_query=['{"patient_id":"406","type":"' num2str(1) '","electrode":"' electrode{i} '" }'];
       temp = find(conn,collection,'Query',test_query,'limit',1);
       soz(i)=str2num(temp.soz);
       test_query=['{"patient_id":"406","type":"' num2str(4) '","electrode":"' electrode{i} '" }'];
       dat1_t = count(conn,collection,Query=test_query);
       dat1_t = double(dat1_t);
       dat1(i)=dat1_t/time_406;
       test_query=['{"patient_id":"406","type":"' num2str(1) '","electrode":"' electrode{i} '" }'];
       dat2_t = count(conn,collection,Query=test_query);
       dat2_t = double(dat2_t);
       dat2(i)=dat2_t/time_406;
       test_query=['{"patient_id":"406","type":"' num2str(5) '","electrode":"' electrode{i} '" }'];
       dat3_t = count(conn,collection,Query=test_query);
       dat3_t = double(dat3_t);
       dat3(i)=dat3_t/time_406;
       test_query=['{"patient_id":"406","type":"' num2str(2) '","electrode":"' electrode{i} '" }'];
       dat4_t = count(conn,collection,Query=test_query);
       dat4_t = double(dat4_t);
       dat4(i)=dat4_t/time_406;
       % FR before spike
       test_query=['{"patient_id":"406","type":"' num2str(2) '","electrode":"' electrode{i} '" }'];
       RONS = find(conn,collection,'Query',test_query);
       rons_time=[];
       if ~isempty(RONS)
       parfor j=1:numel(RONS(:,1))
           rons_time(j)=getfield(RONS,{j},'start_t');
       end;
       end;
       test_query=['{"patient_id":"406","type":"' num2str(3) '","electrode":"' electrode{i} '" }'];
       SS = find(conn,collection,'Query',test_query);
       ss_time=[];
       if ~isempty(SS)
       parfor j=1:numel(SS(:,1))
            ss_time(j)=getfield(SS,{j},'start_t');
       end;
       end;
       test_query=['{"patient_id":"406","type":"' num2str(5) '","electrode":"' electrode{i} '" }'];
       FRONS = find(conn,collection,'Query',test_query);
       frons_time=[];
       if ~isempty(FRONS)
       parfor j=1:numel(FRONS(:,1))
           frons_time(j)=getfield(FRONS,{j},'start_t');
       end;
       end;
       allspike_t=frons_time;
       allspike_t=sort(allspike_t,'ascend');
       test_query=['{"patient_id":"406","type":"' num2str(4) '","electrode":"' electrode{i} '" }'];
       FRONO = find(conn,collection,'Query',test_query);
       frono_time=[];
       if ~isempty(FRONO)
       parfor j=1:numel(FRONO(:,1))
           frono_time(j)=getfield(FRONO,{j},'start_t');
       end;
       end;
       spike_latency=[];
       if ~isempty(allspike_t)
           if ~isempty(frono_time)
               for k=1:numel(frono_time)
                   temp=allspike_t-frono_time(k);
                   idx=find(temp>0);
                   if ~isempty(idx)
                       spike_latency(k)=min(temp(idx));
                   else
                       spike_latency(k)=NaN;
                   end;
               end;
           end;
       end;
       dat5_t=numel(find(spike_latency<0.3));
       dat5(i)=dat5_t/time_406;
       if soz(i)==1
            FRpreSlatsoz=vertcat(FRpreSlatsoz,spike_latency');
       else 
            FRpreSlatnsoz=vertcat(FRpreSlatnsoz,spike_latency');
       end;   
       if ~isempty(allspike_t)
           if ~isempty(frono_time)
             for o=1:500
               permfr=rand(numel(frono_time),1);
               permfr=permfr*numel(full_index);
               permfr=ceil(permfr);
               permfr=full_index(permfr);
               parfor k=1:numel(permfr)
                   temp=allspike_t-permfr(k);
                   idx=find(temp>0);
                   if ~isempty(idx)
                       spike_latency(k)=min(temp(idx));
                   else
                       spike_latency(k)=NaN;
                   end;
               end;
            if soz(i)==1
            FRpreSlatsoz_b{o}=vertcat(FRpreSlatsoz_b{o},spike_latency');
            else 
            FRpreSlatnsoz_b{o}=vertcat(FRpreSlatnsoz_b{o},spike_latency');
            end; 
            end;  
           end;
       end;
       % R before spike
       test_query=['{"patient_id":"406","type":"' num2str(2) '","electrode":"' electrode{i} '" }'];
       RONS = find(conn,collection,'Query',test_query);
       rons_time=[];
       if ~isempty(RONS)
       parfor j=1:numel(RONS(:,1))
           rons_time(j)=getfield(RONS,{j},'start_t');
       end;
       end;
       test_query=['{"patient_id":"406","type":"' num2str(3) '","electrode":"' electrode{i} '" }'];
       SS = find(conn,collection,'Query',test_query);
       ss_time=[];
       if ~isempty(SS)
       parfor j=1:numel(SS(:,1))
            ss_time(j)=getfield(SS,{j},'start_t');
       end;
       end;
       test_query=['{"patient_id":"406","type":"' num2str(5) '","electrode":"' electrode{i} '" }'];
       FRONS = find(conn,collection,'Query',test_query);
       frons_time=[];
       if ~isempty(FRONS)
       parfor j=1:numel(FRONS(:,1))
           frons_time(j)=getfield(FRONS,{j},'start_t');
       end;
       end;
       allspike_t=rons_time;
       allspike_t=sort(allspike_t,'ascend');
       test_query=['{"patient_id":"406","type":"' num2str(4) '","electrode":"' electrode{i} '" }'];
       RONO = find(conn,collection,'Query',test_query);
       rono_time=[];
       if ~isempty(RONO)
       parfor j=1:numel(RONO(:,1))
           rono_time(j)=getfield(RONO,{j},'start_t');
       end;
       end;
       spike_latency=[];
       if ~isempty(allspike_t)
           if ~isempty(rono_time)
               for k=1:numel(rono_time)
                   temp=allspike_t-rono_time(k);
                   idx=find(temp>0);
                   if ~isempty(idx)
                       spike_latency(k)=min(temp(idx));
                   else
                       spike_latency(k)=NaN;
                   end;
               end;
           end;
       end;
       dat6_t=numel(find(spike_latency<0.3));
       dat6(i)=dat6_t/time_406;
       if soz(i)==1
           RpreSlatsoz=vertcat(RpreSlatsoz,spike_latency');
       else
           RpreSlatnsoz=vertcat(RpreSlatnsoz,spike_latency');
       end;
       if ~isempty(allspike_t)
           if ~isempty(rono_time)
             for o=1:500
               permr=rand(numel(rono_time),1);
               permr=(permr*numel(full_index));
               permr=ceil(permr);
               permr=full_index(permr);
               parfor k=1:numel(permr)
                   temp=allspike_t-permr(k);
                   idx=find(temp>0);
                   if ~isempty(idx)
                       spike_latency(k)=min(temp(idx));
                   else
                       spike_latency(k)=NaN;
                   end;
               end;
            if soz(i)==1
            RpreSlatsoz_b{o}=vertcat(RpreSlatsoz_b{o},spike_latency');
            else 
            RpreSlatnsoz_b{o}=vertcat(RpreSlatnsoz_b{o},spike_latency');
            end; 
            end;  
           end;
       end;
       % FronS after HFO
       test_query=['{"patient_id":"406","type":"' num2str(5) '","electrode":"' electrode{i} '" }']; 
       HFO = find(conn,collection,'Query',test_query);
       start_t=[];
       if ~isempty(HFO)
       parfor j=1:numel(HFO(:,1))
           start_t(j)=getfield(HFO,{j},'start_t');
       end;
       end;
       test_query=['{"patient_id":"406","type":"' num2str(4) '","electrode":"' electrode{i} '" }'];
       FR = find(conn,collection,'Query',test_query);
       frono_time=[];
       parfor j=1:numel(FR(:,1))
            frono_time(j)=getfield(FR,{j},'start_t');
       end;
       spike_latency=[];
       if ~isempty(start_t)
           if ~isempty(frono_time)
               for k=1:numel(start_t)
                   temp=start_t(k)-frono_time;
                   idx=find(temp>0);
                     if ~isempty(idx)
                        spike_latency(k)=min(temp(idx));
                     else
                        spike_latency(k)=NaN;
                     end;
               end;
           end;
       end;
       dat7_t=numel(find(spike_latency<0.3));
       dat7(i)=dat7_t/time_406;
       if soz(i)==1
           FRONSpostFRlatsoz=vertcat(FRONSpostFRlatsoz, spike_latency');
       else
           FRONSpostFRlatnsoz=vertcat(FRONSpostFRlatnsoz, spike_latency');
       end;

       test_query=['{"patient_id":"406","type":"' num2str(1) '","electrode":"' electrode{i} '" }'];
       R = find(conn,collection,'Query',test_query);
       rono_time=[];
       parfor j=1:numel(R(:,1))
            rono_time(j)=getfield(R,{j},'start_t');
       end;
       spike_latency=[];
           if ~isempty(start_t)
               if ~isempty(rono_time)
                   for k=1:numel(start_t)
                       temp=start_t(k)-rono_time;
                       idx=find(temp>0);
                       if ~isempty(idx)
                           spike_latency(k)=min(temp(idx));
                       else
                           spike_latency(k)=NaN;
                       end;
                   end;
               end;
       end;
       dat8_t=numel(find(spike_latency<0.3));
       dat8(i)=dat8_t/time_406;
       if soz(i)==1
           FRONSpostRlatsoz=vertcat(FRONSpostRlatsoz,spike_latency');
       else
           FRONSpostRlatnsoz=vertcat(FRONSpostRlatnsoz,spike_latency');
       end;
 %  RonS after HFO
       test_query=['{"patient_id":"406","type":"' num2str(2) '","electrode":"' electrode{i} '" }']; 
       HFO = find(conn,collection,'Query',test_query);
       start_t=[];
       if ~isempty(HFO)
       parfor j=1:numel(HFO(:,1))
           start_t(j)=getfield(HFO,{j},'start_t');
       end;
       end;
       test_query=['{"patient_id":"406","type":"' num2str(4) '","electrode":"' electrode{i} '" }'];
       FR = find(conn,collection,'Query',test_query);
       frono_time=[];
       parfor j=1:numel(FR(:,1))
            frono_time(j)=getfield(FR,{j},'start_t');
       end;
       spike_latency=[];
       if ~isempty(start_t)
           if ~isempty(frono_time)
               for k=1:numel(start_t)
                   temp=start_t(k)-frono_time;
                   idx=find(temp>0);
                     if ~isempty(idx)
                        spike_latency(k)=min(temp(idx));
                     else
                        spike_latency(k)=NaN;
                     end;
               end;
           end;
       end;
       dat9_t=numel(find(spike_latency<0.3));
       dat9(i)=dat9_t/time_406;
       if soz(i)==1
            RONSpostFRlatsoz=vertcat(RONSpostFRlatsoz, spike_latency');
       else
            RONSpostFRlatnsoz=vertcat(RONSpostFRlatnsoz, spike_latency');
       end;
       test_query=['{"patient_id":"406","type":"' num2str(1) '","electrode":"'  electrode{i} '" }'];
       R = find(conn,collection,'Query',test_query);
       rono_time=[];
       parfor j=1:numel(R(:,1))
            rono_time(j)=getfield(R,{j},'start_t');
       end;
       spike_latency=[];
           if ~isempty(start_t)
               if ~isempty(rono_time)
                   for k=1:numel(start_t)
                       temp=start_t(k)-rono_time;
                       idx=find(temp>0);
                       if ~isempty(idx)
                           spike_latency(k)=min(temp(idx));
                       else
                           spike_latency(k)=NaN;
                       end;
                   end;
               end;
       end;
       dat10_t=numel(find(spike_latency<0.3));
       dat10(i)=dat10_t/time_406;
       if soz(i)==1
          RONSpostRlatsoz=vertcat(RONSpostRlatsoz,spike_latency');
       else
          RONSpostRlatnsoz=vertcat(RONSpostRlatnsoz,spike_latency');
       end;
end;

patient=patient';
electrode=electrode';
dat1=dat1';
dat2=dat2';
dat3=dat3';
dat4=dat4';
dat5=dat5';
dat6=dat6';
dat7=dat7';
dat8=dat8';
dat9=dat9';
dat10=dat10'
soz=soz';
table406=table(patient,electrode,dat1,dat2,dat3,dat4,dat5,dat6,dat7,dat8,dat9,dat10,soz);
hfo_table=table406;
latency.RpreSlatsoz=RpreSlatsoz;
latency.FRpreSlatsoz=FRpreSlatsoz;
latency.FRONSpostFRlatsoz=FRONSpostFRlatsoz;
latency.FRONSpostRlatsoz=FRONSpostRlatsoz;
latency.RONSpostFRlatsoz=RONSpostFRlatsoz;
latency.RONSpostRlatsoz=RONSpostRlatsoz;
latency.RpreSlatnsoz=RpreSlatnsoz;
latency.FRpreSlatnsoz=FRpreSlatnsoz;
latency.FRONSpostFRlatnsoz=FRONSpostFRlatnsoz;
latency.FRONSpostRlatnsoz=FRONSpostRlatnsoz;
latency.RONSpostFRlatnsoz=RONSpostFRlatnsoz;
latency.RONSpostRlatnsoz=RONSpostRlatnsoz;

close(conn)

%416
close(conn)
conn = mongo(server,port,dbname,'UserName',username,'Password',password);
load('/data/downstate/wip/FromYuval/P416/EEG416concat.mat');
time_416=0;
lost=0;
full_index=[];
for i=1:22
      eeg_bp=eeg.eeg_data(1,(((i-1)*2000*60*10)+1):(i*2000*60*10));
      fzeeghg=ez_eegfilter(eeg_bp(1,:),80,600,2000);
      fzeegzhgamp=zscore(smooth(abs(hilbert(fzeeghg)),400));
      fzeegzhgamp=fzeegzhgamp';
      [idx]=find(fzeegzhgamp>1.5);
      lost=numel(idx)/2000;
      duration_tmp=((10*60*2000)-numel(idx))/2000;
      time_416=time_416+duration_tmp;
      index_t=[0.0005:0.0005:600]+((i-1)*600); % 
       if ~isempty(idx)
         index_t(idx)=[];
       end;
      full_index=horzcat(full_index,index_t);
end;
time_416=time_416/60;
test_query=['{"patient_id":"416"}'];
electrode=distinct(conn,collection,'electrode','query',test_query)

dat1=[];
dat2=[];
dat3=[];
dat4=[];
dat5=[];
dat6=[];
dat7=[];
dat8=[];
dat9=[];
dat10=[];
soz=[];
close(conn)
conn = mongoc(server,port,dbname,'UserName',username,'Password',password);
patient={''};
for i=1:numel(electrode)
       patient(i)={'416'};
end;

for i=1:numel(electrode)
       i
       test_query=['{"patient_id":"416","type":"' num2str(1) '","electrode":"' electrode{i} '" }'];
       temp = find(conn,collection,'Query',test_query,'limit',1);
       soz(i)=str2num(temp.soz);
       test_query=['{"patient_id":"416","type":"' num2str(4) '","electrode":"' electrode{i} '" }'];
       dat1_t = count(conn,collection,Query=test_query);
       dat1_t = double(dat1_t);
       dat1(i)=dat1_t/time_416;
       test_query=['{"patient_id":"416","type":"' num2str(1) '","electrode":"' electrode{i} '" }'];
       dat2_t = count(conn,collection,Query=test_query);
       dat2_t = double(dat2_t);
       dat2(i)=dat2_t/time_416;
       test_query=['{"patient_id":"416","type":"' num2str(5) '","electrode":"' electrode{i} '" }'];
       dat3_t = count(conn,collection,Query=test_query);
       dat3_t = double(dat3_t);
       dat3(i)=dat3_t/time_416;
       test_query=['{"patient_id":"416","type":"' num2str(2) '","electrode":"' electrode{i} '" }'];
       dat4_t = count(conn,collection,Query=test_query);
       dat4_t = double(dat4_t);
       dat4(i)=dat4_t/time_416;
       % FR before spike
       test_query=['{"patient_id":"416","type":"' num2str(2) '","electrode":"' electrode{i} '" }'];
       RONS = find(conn,collection,'Query',test_query);
       rons_time=[];
       if ~isempty(RONS)
       parfor j=1:numel(RONS(:,1))
           rons_time(j)=getfield(RONS,{j},'start_t');
       end;
       end;
       test_query=['{"patient_id":"416","type":"' num2str(3) '","electrode":"' electrode{i} '" }'];
       SS = find(conn,collection,'Query',test_query);
       ss_time=[];
       if ~isempty(SS)
       parfor j=1:numel(SS(:,1))
            ss_time(j)=getfield(SS,{j},'start_t');
       end;
       end;
       test_query=['{"patient_id":"416","type":"' num2str(5) '","electrode":"' electrode{i} '" }'];
       FRONS = find(conn,collection,'Query',test_query);
       frons_time=[];
       if ~isempty(FRONS)
       parfor j=1:numel(FRONS(:,1))
           frons_time(j)=getfield(FRONS,{j},'start_t');
       end;
       end;
       allspike_t=frons_time;
       allspike_t=sort(allspike_t,'ascend');
       test_query=['{"patient_id":"416","type":"' num2str(4) '","electrode":"' electrode{i} '" }'];
       FRONO = find(conn,collection,'Query',test_query);
       frono_time=[];
       if ~isempty(FRONO)
       parfor j=1:numel(FRONO(:,1))
           frono_time(j)=getfield(FRONO,{j},'start_t');
       end;
       end;
       spike_latency=[];
       if ~isempty(allspike_t)
           if ~isempty(frono_time)
               for k=1:numel(frono_time)
                   temp=allspike_t-frono_time(k);
                   idx=find(temp>0);
                   if ~isempty(idx)
                       spike_latency(k)=min(temp(idx));
                   else
                       spike_latency(k)=NaN;
                   end;
               end;
           end;
       end;
       dat5_t=numel(find(spike_latency<0.3));
       dat5(i)=dat5_t/time_416;
       if soz(i)==1
            FRpreSlatsoz=vertcat(FRpreSlatsoz,spike_latency');
       else 
            FRpreSlatnsoz=vertcat(FRpreSlatnsoz,spike_latency');
       end;    
       if ~isempty(allspike_t)
           if ~isempty(frono_time)
             for o=1:500
               permfr=rand(numel(frono_time),1);
               permfr=permfr*numel(full_index);
               permfr=ceil(permfr);
               permfr=full_index(permfr);
               parfor k=1:numel(permfr)
                   temp=allspike_t-permfr(k);
                   idx=find(temp>0);
                   if ~isempty(idx)
                       spike_latency(k)=min(temp(idx));
                   else
                       spike_latency(k)=NaN;
                   end;
               end;
            if soz(i)==1
            FRpreSlatsoz_b{o}=vertcat(FRpreSlatsoz_b{o},spike_latency');
            else 
            FRpreSlatnsoz_b{o}=vertcat(FRpreSlatnsoz_b{o},spike_latency');
            end; 
            end;  
           end;
       end;
       % R before spike
       test_query=['{"patient_id":"416","type":"' num2str(2) '","electrode":"' electrode{i} '" }'];
       RONS = find(conn,collection,'Query',test_query);
       rons_time=[];
       if ~isempty(RONS)
       parfor j=1:numel(RONS(:,1))
           rons_time(j)=getfield(RONS,{j},'start_t');
       end;
       end;
       test_query=['{"patient_id":"416","type":"' num2str(3) '","electrode":"' electrode{i} '" }'];
       SS = find(conn,collection,'Query',test_query);
       ss_time=[];
       if ~isempty(SS)
       parfor j=1:numel(SS(:,1))
            ss_time(j)=getfield(SS,{j},'start_t');
       end;
       end;
       test_query=['{"patient_id":"416","type":"' num2str(5) '","electrode":"' electrode{i} '" }'];
       FRONS = find(conn,collection,'Query',test_query);
       frons_time=[];
       if ~isempty(FRONS)
       parfor j=1:numel(FRONS(:,1))
           frons_time(j)=getfield(FRONS,{j},'start_t');
       end;
       end;
       allspike_t=rons_time;
       allspike_t=sort(allspike_t,'ascend');
       test_query=['{"patient_id":"416","type":"' num2str(4) '","electrode":"' electrode{i} '" }'];
       RONO = find(conn,collection,'Query',test_query);
       rono_time=[];
       if ~isempty(RONO)
       parfor j=1:numel(RONO(:,1))
           rono_time(j)=getfield(RONO,{j},'start_t');
       end;
       end;
       spike_latency=[];
       if ~isempty(allspike_t)
           if ~isempty(rono_time)
               for k=1:numel(rono_time)
                   temp=allspike_t-rono_time(k);
                   idx=find(temp>0);
                   if ~isempty(idx)
                       spike_latency(k)=min(temp(idx));
                   else
                       spike_latency(k)=NaN;
                   end;
               end;
           end;
       end;
       dat6_t=numel(find(spike_latency<0.3));
       dat6(i)=dat6_t/time_416;
       if soz(i)==1
           RpreSlatsoz=vertcat(RpreSlatsoz,spike_latency');
       else
           RpreSlatnsoz=vertcat(RpreSlatnsoz,spike_latency');
       end;
       if ~isempty(allspike_t)
           if ~isempty(rono_time)
             for o=1:500
               permr=rand(numel(rono_time),1);
               permr=(permr*numel(full_index));
               permr=ceil(permr);
               permr=full_index(permr);
               parfor k=1:numel(permr)
                   temp=allspike_t-permr(k);
                   idx=find(temp>0);
                   if ~isempty(idx)
                       spike_latency(k)=min(temp(idx));
                   else
                       spike_latency(k)=NaN;
                   end;
               end;
            if soz(i)==1
            RpreSlatsoz_b{o}=vertcat(RpreSlatsoz_b{o},spike_latency');
            else 
            RpreSlatnsoz_b{o}=vertcat(RpreSlatnsoz_b{o},spike_latency');
            end; 
            end;  
           end;
       end;
       % FronS after HFO
       test_query=['{"patient_id":"416","type":"' num2str(5) '","electrode":"' electrode{i} '" }']; 
       HFO = find(conn,collection,'Query',test_query);
       start_t=[];
       if ~isempty(HFO)
       parfor j=1:numel(HFO(:,1))
           start_t(j)=getfield(HFO,{j},'start_t');
       end;
       end;
       test_query=['{"patient_id":"416","type":"' num2str(4) '","electrode":"' electrode{i} '" }'];
       FR = find(conn,collection,'Query',test_query);
       frono_time=[];
       parfor j=1:numel(FR(:,1))
            frono_time(j)=getfield(FR,{j},'start_t');
       end;
       spike_latency=[];
       if ~isempty(start_t)
           if ~isempty(frono_time)
               for k=1:numel(start_t)
                   temp=start_t(k)-frono_time;
                   idx=find(temp>0);
                     if ~isempty(idx)
                        spike_latency(k)=min(temp(idx));
                     else
                        spike_latency(k)=NaN;
                     end;
               end;
           end;
       end;
       dat7_t=numel(find(spike_latency<0.3));
       dat7(i)=dat7_t/time_416;
       if soz(i)==1
           FRONSpostFRlatsoz=vertcat(FRONSpostFRlatsoz, spike_latency');
       else
           FRONSpostFRlatnsoz=vertcat(FRONSpostFRlatnsoz, spike_latency');
       end;

       test_query=['{"patient_id":"416","type":"' num2str(1) '","electrode":"' electrode{i} '" }'];
       R = find(conn,collection,'Query',test_query);
       rono_time=[];
       parfor j=1:numel(R(:,1))
            rono_time(j)=getfield(R,{j},'start_t');
       end;
       spike_latency=[];
           if ~isempty(start_t)
               if ~isempty(rono_time)
                   for k=1:numel(start_t)
                       temp=start_t(k)-rono_time;
                       idx=find(temp>0);
                       if ~isempty(idx)
                           spike_latency(k)=min(temp(idx));
                       else
                           spike_latency(k)=NaN;
                       end;
                   end;
               end;
       end;
       dat8_t=numel(find(spike_latency<0.3));
       dat8(i)=dat8_t/time_416;
       if soz(i)==1
           FRONSpostRlatsoz=vertcat(FRONSpostRlatsoz,spike_latency');
       else
           FRONSpostRlatnsoz=vertcat(FRONSpostRlatnsoz,spike_latency');
       end;
 %  RonS after HFO
       test_query=['{"patient_id":"416","type":"' num2str(2) '","electrode":"' electrode{i} '" }']; 
       HFO = find(conn,collection,'Query',test_query);
       start_t=[];
       if ~isempty(HFO)
       parfor j=1:numel(HFO(:,1))
           start_t(j)=getfield(HFO,{j},'start_t');
       end;
       end;
       test_query=['{"patient_id":"416","type":"' num2str(4) '","electrode":"' electrode{i} '" }'];
       FR = find(conn,collection,'Query',test_query);
       frono_time=[];
       parfor j=1:numel(FR(:,1))
            frono_time(j)=getfield(FR,{j},'start_t');
       end;
       spike_latency=[];
       if ~isempty(start_t)
           if ~isempty(frono_time)
               for k=1:numel(start_t)
                   temp=start_t(k)-frono_time;
                   idx=find(temp>0);
                     if ~isempty(idx)
                        spike_latency(k)=min(temp(idx));
                     else
                        spike_latency(k)=NaN;
                     end;
               end;
           end;
       end;
       dat9_t=numel(find(spike_latency<0.3));
       dat9(i)=dat9_t/time_416;
       if soz(i)==1
            RONSpostFRlatsoz=vertcat(RONSpostFRlatsoz, spike_latency');
       else
            RONSpostFRlatnsoz=vertcat(RONSpostFRlatnsoz, spike_latency');
       end;
       test_query=['{"patient_id":"416","type":"' num2str(1) '","electrode":"'  electrode{i} '" }'];
       R = find(conn,collection,'Query',test_query);
       rono_time=[];
       parfor j=1:numel(R(:,1))
            rono_time(j)=getfield(R,{j},'start_t');
       end;
       spike_latency=[];
           if ~isempty(start_t)
               if ~isempty(rono_time)
                   for k=1:numel(start_t)
                       temp=start_t(k)-rono_time;
                       idx=find(temp>0);
                       if ~isempty(idx)
                           spike_latency(k)=min(temp(idx));
                       else
                           spike_latency(k)=NaN;
                       end;
                   end;
               end;
       end;
       dat10_t=numel(find(spike_latency<0.3));
       dat10(i)=dat10_t/time_416;
       if soz(i)==1
          RONSpostRlatsoz=vertcat(RONSpostRlatsoz,spike_latency');
       else
          RONSpostRlatnsoz=vertcat(RONSpostRlatnsoz,spike_latency');
       end;
end;


patient=patient';
electrode=electrode';
dat1=dat1';
dat2=dat2';
dat3=dat3';
dat4=dat4';
dat5=dat5';
dat6=dat6';
dat7=dat7';
dat8=dat8';
dat9=dat9';
dat10=dat10'
soz=soz';
table416=table(patient,electrode,dat1,dat2,dat3,dat4,dat5,dat6,dat7,dat8,dat9,dat10,soz);
hfo_table=table416;
latency.RpreSlatsoz=RpreSlatsoz;
latency.FRpreSlatsoz=FRpreSlatsoz;
latency.FRONSpostFRlatsoz=FRONSpostFRlatsoz;
latency.FRONSpostRlatsoz=FRONSpostRlatsoz;
latency.RONSpostFRlatsoz=RONSpostFRlatsoz;
latency.RONSpostRlatsoz=RONSpostRlatsoz;
latency.RpreSlatnsoz=RpreSlatnsoz;
latency.FRpreSlatnsoz=FRpreSlatnsoz;
latency.FRONSpostFRlatnsoz=FRONSpostFRlatnsoz;
latency.FRONSpostRlatnsoz=FRONSpostRlatnsoz;
latency.RONSpostFRlatnsoz=RONSpostFRlatnsoz;
latency.RONSpostRlatnsoz=RONSpostRlatnsoz;

close(conn)
conn = mongo(server,port,dbname,'UserName',username,'Password',password);
load('/data/downstate/wip/FromYuval/P417/EEG417concat.mat');
time_417=0;
full_index=[];
for i=1:23
      eeg_bp=eeg.eeg_data(1,(((i-1)*2000*60*10)+1):(i*2000*60*10));
      fzeeghg=ez_eegfilter(eeg_bp(1,:),80,600,2000);
      fzeegzhgamp=zscore(smooth(abs(hilbert(fzeeghg)),400));
      fzeegzhgamp=fzeegzhgamp';
      [idx]=find(fzeegzhgamp>0.5);
      duration_tmp=((10*60*2000)-numel(idx))/2000;
      time_417=time_417+duration_tmp;
      index_t=[0.0005:0.0005:600]+((i-1)*600); % 
       if ~isempty(idx)
         index_t(idx)=[];
       end;
      full_index=horzcat(full_index,index_t);
end;
time_417=time_417/60;
test_query=['{"patient_id":"417"}'];
electrode=distinct(conn,collection,'electrode','query',test_query)
dat1=[];
dat2=[];
dat3=[];
dat4=[];
dat5=[];
dat6=[];
dat7=[];
dat8=[];
dat9=[];
dat10=[];
soz=[];
close(conn)
conn = mongoc(server,port,dbname,'UserName',username,'Password',password);
patient={''};
for i=1:numel(electrode)
       patient(i)={'417'};
end;

for i=1:numel(electrode)
       i
       test_query=['{"patient_id":"417","type":"' num2str(1) '","electrode":"' electrode{i} '" }'];
       temp = find(conn,collection,'Query',test_query,'limit',1);
       soz(i)=str2num(temp.soz);
       test_query=['{"patient_id":"417","type":"' num2str(4) '","electrode":"' electrode{i} '" }'];
       dat1_t = count(conn,collection,Query=test_query);
       dat1_t = double(dat1_t);
       dat1(i)=dat1_t/time_417;
       test_query=['{"patient_id":"417","type":"' num2str(1) '","electrode":"' electrode{i} '" }'];
       dat2_t = count(conn,collection,Query=test_query);
       dat2_t = double(dat2_t);
       dat2(i)=dat2_t/time_417;
       test_query=['{"patient_id":"417","type":"' num2str(5) '","electrode":"' electrode{i} '" }'];
       dat3_t = count(conn,collection,Query=test_query);
       dat3_t = double(dat3_t);
       dat3(i)=dat3_t/time_417;
       test_query=['{"patient_id":"417","type":"' num2str(2) '","electrode":"' electrode{i} '" }'];
       dat4_t = count(conn,collection,Query=test_query);
       dat4_t = double(dat4_t);
       dat4(i)=dat4_t/time_417;
       % FR before spike
       test_query=['{"patient_id":"417","type":"' num2str(2) '","electrode":"' electrode{i} '" }'];
       RONS = find(conn,collection,'Query',test_query);
       rons_time=[];
       if ~isempty(RONS)
       parfor j=1:numel(RONS(:,1))
           rons_time(j)=getfield(RONS,{j},'start_t');
       end;
       end;
       test_query=['{"patient_id":"417","type":"' num2str(3) '","electrode":"' electrode{i} '" }'];
       SS = find(conn,collection,'Query',test_query);
       ss_time=[];
       if ~isempty(SS)
       parfor j=1:numel(SS(:,1))
            ss_time(j)=getfield(SS,{j},'start_t');
       end;
       end;
       test_query=['{"patient_id":"417","type":"' num2str(5) '","electrode":"' electrode{i} '" }'];
       FRONS = find(conn,collection,'Query',test_query);
       frons_time=[];
       if ~isempty(FRONS)
       parfor j=1:numel(FRONS(:,1))
           frons_time(j)=getfield(FRONS,{j},'start_t');
       end;
       end;
       allspike_t=frons_time;
       allspike_t=sort(allspike_t,'ascend');
       test_query=['{"patient_id":"417","type":"' num2str(4) '","electrode":"' electrode{i} '" }'];
       FRONO = find(conn,collection,'Query',test_query);
       frono_time=[];
       if ~isempty(FRONO)
       parfor j=1:numel(FRONO(:,1))
           frono_time(j)=getfield(FRONO,{j},'start_t');
       end;
       end;
       spike_latency=[];
       if ~isempty(allspike_t)
           if ~isempty(frono_time)
               for k=1:numel(frono_time)
                   temp=allspike_t-frono_time(k);
                   idx=find(temp>0);
                   if ~isempty(idx)
                       spike_latency(k)=min(temp(idx));
                   else
                       spike_latency(k)=NaN;
                   end;
               end;
           end;
       end;
       dat5_t=numel(find(spike_latency<0.3));
       dat5(i)=dat5_t/time_417;
       if soz(i)==1
            FRpreSlatsoz=vertcat(FRpreSlatsoz,spike_latency');
       else 
            FRpreSlatnsoz=vertcat(FRpreSlatnsoz,spike_latency');
       end;  
       if ~isempty(allspike_t)
           if ~isempty(frono_time)
             for o=1:500
               permfr=rand(numel(frono_time),1);
               permfr=permfr*numel(full_index);
               permfr=ceil(permfr);
               permfr=full_index(permfr);
               parfor k=1:numel(permfr)
                   temp=allspike_t-permfr(k);
                   idx=find(temp>0);
                   if ~isempty(idx)
                       spike_latency(k)=min(temp(idx));
                   else
                       spike_latency(k)=NaN;
                   end;
               end;
            if soz(i)==1
            FRpreSlatsoz_b{o}=vertcat(FRpreSlatsoz_b{o},spike_latency');
            else 
            FRpreSlatnsoz_b{o}=vertcat(FRpreSlatnsoz_b{o},spike_latency');
            end; 
            end;  
           end;
       end;
       % R before spike
       test_query=['{"patient_id":"417","type":"' num2str(2) '","electrode":"' electrode{i} '" }'];
       RONS = find(conn,collection,'Query',test_query);
       rons_time=[];
       if ~isempty(RONS)
       parfor j=1:numel(RONS(:,1))
           rons_time(j)=getfield(RONS,{j},'start_t');
       end;
       end;
       test_query=['{"patient_id":"417","type":"' num2str(3) '","electrode":"' electrode{i} '" }'];
       SS = find(conn,collection,'Query',test_query);
       ss_time=[];
       if ~isempty(SS)
       parfor j=1:numel(SS(:,1))
            ss_time(j)=getfield(SS,{j},'start_t');
       end;
       end;
       test_query=['{"patient_id":"417","type":"' num2str(5) '","electrode":"' electrode{i} '" }'];
       FRONS = find(conn,collection,'Query',test_query);
       frons_time=[];
       if ~isempty(FRONS)
       parfor j=1:numel(FRONS(:,1))
           frons_time(j)=getfield(FRONS,{j},'start_t');
       end;
       end;
       allspike_t=rons_time;
       allspike_t=sort(allspike_t,'ascend');
       test_query=['{"patient_id":"417","type":"' num2str(4) '","electrode":"' electrode{i} '" }'];
       RONO = find(conn,collection,'Query',test_query);
       rono_time=[];
       if ~isempty(RONO)
       parfor j=1:numel(RONO(:,1))
           rono_time(j)=getfield(RONO,{j},'start_t');
       end;
       end;
       spike_latency=[];
       if ~isempty(allspike_t)
           if ~isempty(rono_time)
               for k=1:numel(rono_time)
                   temp=allspike_t-rono_time(k);
                   idx=find(temp>0);
                   if ~isempty(idx)
                       spike_latency(k)=min(temp(idx));
                   else
                       spike_latency(k)=NaN;
                   end;
               end;
           end;
       end;
       dat6_t=numel(find(spike_latency<0.3));
       dat6(i)=dat6_t/time_417;
       if soz(i)==1
           RpreSlatsoz=vertcat(RpreSlatsoz,spike_latency');
       else
           RpreSlatnsoz=vertcat(RpreSlatnsoz,spike_latency');
       end;
       if ~isempty(allspike_t)
           if ~isempty(rono_time)
             for o=1:500
               permr=rand(numel(rono_time),1);
               permr=(permr*numel(full_index));
               permr=ceil(permr);
               permr=full_index(permr);
               parfor k=1:numel(permr)
                   temp=allspike_t-permr(k);
                   idx=find(temp>0);
                   if ~isempty(idx)
                       spike_latency(k)=min(temp(idx));
                   else
                       spike_latency(k)=NaN;
                   end;
               end;
            if soz(i)==1
            RpreSlatsoz_b{o}=vertcat(RpreSlatsoz_b{o},spike_latency');
            else 
            RpreSlatnsoz_b{o}=vertcat(RpreSlatnsoz_b{o},spike_latency');
            end; 
            end;  
           end;
       end;
       % FronS after HFO
       test_query=['{"patient_id":"417","type":"' num2str(5) '","electrode":"' electrode{i} '" }']; 
       HFO = find(conn,collection,'Query',test_query);
       start_t=[];
       if ~isempty(HFO)
       parfor j=1:numel(HFO(:,1))
           start_t(j)=getfield(HFO,{j},'start_t');
       end;
       end;
       test_query=['{"patient_id":"417","type":"' num2str(4) '","electrode":"' electrode{i} '" }'];
       FR = find(conn,collection,'Query',test_query);
       frono_time=[];
       parfor j=1:numel(FR(:,1))
            frono_time(j)=getfield(FR,{j},'start_t');
       end;
       spike_latency=[];
       if ~isempty(start_t)
           if ~isempty(frono_time)
               for k=1:numel(start_t)
                   temp=start_t(k)-frono_time;
                   idx=find(temp>0);
                     if ~isempty(idx)
                        spike_latency(k)=min(temp(idx));
                     else
                        spike_latency(k)=NaN;
                     end;
               end;
           end;
       end;
       dat7_t=numel(find(spike_latency<0.3));
       dat7(i)=dat7_t/time_417;
       if soz(i)==1
           FRONSpostFRlatsoz=vertcat(FRONSpostFRlatsoz, spike_latency');
       else
           FRONSpostFRlatnsoz=vertcat(FRONSpostFRlatnsoz, spike_latency');
       end;

       test_query=['{"patient_id":"417","type":"' num2str(1) '","electrode":"' electrode{i} '" }'];
       R = find(conn,collection,'Query',test_query);
       rono_time=[];
       parfor j=1:numel(R(:,1))
            rono_time(j)=getfield(R,{j},'start_t');
       end;
       spike_latency=[];
           if ~isempty(start_t)
               if ~isempty(rono_time)
                   parfor k=1:numel(start_t)
                       temp=start_t(k)-rono_time;
                       idx=find(temp>0);
                       if ~isempty(idx)
                           spike_latency(k)=min(temp(idx));
                       else
                           spike_latency(k)=NaN;
                       end;
                   end;
               end;
       end;
       dat8_t=numel(find(spike_latency<0.3));
       dat8(i)=dat8_t/time_417;
       if soz(i)==1
           FRONSpostRlatsoz=vertcat(FRONSpostRlatsoz,spike_latency');
       else
           FRONSpostRlatnsoz=vertcat(FRONSpostRlatnsoz,spike_latency');
       end;
 %  RonS after HFO
       test_query=['{"patient_id":"417","type":"' num2str(2) '","electrode":"' electrode{i} '" }']; 
       HFO = find(conn,collection,'Query',test_query);
       start_t=[];
       if ~isempty(HFO)
       parfor j=1:numel(HFO(:,1))
           start_t(j)=getfield(HFO,{j},'start_t');
       end;
       end;
       test_query=['{"patient_id":"417","type":"' num2str(4) '","electrode":"' electrode{i} '" }'];
       FR = find(conn,collection,'Query',test_query);
       frono_time=[];
       parfor j=1:numel(FR(:,1))
            frono_time(j)=getfield(FR,{j},'start_t');
       end;
       spike_latency=[];
       if ~isempty(start_t)
           if ~isempty(frono_time)
               for k=1:numel(start_t)
                   temp=start_t(k)-frono_time;
                   idx=find(temp>0);
                     if ~isempty(idx)
                        spike_latency(k)=min(temp(idx));
                     else
                        spike_latency(k)=NaN;
                     end;
               end;
           end;
       end;
       dat9_t=numel(find(spike_latency<0.3));
       dat9(i)=dat9_t/time_417;
       if soz(i)==1
            RONSpostFRlatsoz=vertcat(RONSpostFRlatsoz, spike_latency');
       else
            RONSpostFRlatnsoz=vertcat(RONSpostFRlatnsoz, spike_latency');
       end;
       test_query=['{"patient_id":"417","type":"' num2str(1) '","electrode":"'  electrode{i} '" }'];
       R = find(conn,collection,'Query',test_query);
       rono_time=[];
       parfor j=1:numel(R(:,1))
            rono_time(j)=getfield(R,{j},'start_t');
       end;
       spike_latency=[];
           if ~isempty(start_t)
               if ~isempty(rono_time)
                   for k=1:numel(start_t)
                       temp=start_t(k)-rono_time;
                       idx=find(temp>0);
                       if ~isempty(idx)
                           spike_latency(k)=min(temp(idx));
                       else
                           spike_latency(k)=NaN;
                       end;
                   end;
               end;
       end;
       dat10_t=numel(find(spike_latency<0.3));
       dat10(i)=dat10_t/time_417;
       if soz(i)==1
          RONSpostRlatsoz=vertcat(RONSpostRlatsoz,spike_latency');
       else
          RONSpostRlatnsoz=vertcat(RONSpostRlatnsoz,spike_latency');
       end;
end;


patient=patient';
electrode=electrode';
dat1=dat1';
dat2=dat2';
dat3=dat3';
dat4=dat4';
dat5=dat5';
dat6=dat6';
dat7=dat7';
dat8=dat8';
dat9=dat9';
dat10=dat10'
soz=soz';
table417=table(patient,electrode,dat1,dat2,dat3,dat4,dat5,dat6,dat7,dat8,dat9,dat10,soz);
hfo_table=table417;
latency.RpreSlatsoz=RpreSlatsoz;
latency.FRpreSlatsoz=FRpreSlatsoz;
latency.FRONSpostFRlatsoz=FRONSpostFRlatsoz;
latency.FRONSpostRlatsoz=FRONSpostRlatsoz;
latency.RONSpostFRlatsoz=RONSpostFRlatsoz;
latency.RONSpostRlatsoz=RONSpostRlatsoz;
latency.RpreSlatnsoz=RpreSlatnsoz;
latency.FRpreSlatnsoz=FRpreSlatnsoz;
latency.FRONSpostFRlatnsoz=FRONSpostFRlatnsoz;
latency.FRONSpostRlatnsoz=FRONSpostRlatnsoz;
latency.RONSpostFRlatnsoz=RONSpostFRlatnsoz;
latency.RONSpostRlatnsoz=RONSpostRlatnsoz;


%422
close(conn)
conn = mongo(server,port,dbname,'UserName',username,'Password',password);
load('/data/downstate/wip/FromYuval/P422/EEG422concat.mat');
time_422=0;
full_index=[];
for i=1:10
      eeg_bp=eeg.eeg_data(1,(((i-1)*2000*60*10)+1):(i*2000*60*10));
      fzeeghg=ez_eegfilter(eeg_bp(1,:),80,600,2000);
      fzeegzhgamp=zscore(smooth(abs(hilbert(fzeeghg)),400));
      fzeegzhgamp=fzeegzhgamp';
      [idx]=find(fzeegzhgamp>0.5);
      duration_tmp=((10*60*2000)-numel(idx))/2000;
      time_422=time_422+duration_tmp;
      index_t=[0.0005:0.0005:600]+((i-1)*600); % 
       if ~isempty(idx)
         index_t(idx)=[];
       end;
      full_index=horzcat(full_index,index_t);
end;
time_422=time_422/60;
test_query=['{"patient_id":"422"}'];
electrode=distinct(conn,collection,'electrode','query',test_query)
dat1=[];
dat2=[];
dat3=[];
dat4=[];
dat5=[];
dat6=[];
dat7=[];
dat8=[];
dat9=[];
dat10=[];
soz=[];
close(conn)
conn = mongoc(server,port,dbname,'UserName',username,'Password',password);
patient={''};
for i=1:numel(electrode)
       patient(i)={'422'};
end;

for i=1:numel(electrode)
       i
       test_query=['{"patient_id":"422","type":"' num2str(1) '","electrode":"' electrode{i} '" }'];
       temp = find(conn,collection,'Query',test_query,'limit',1);
       soz(i)=str2num(temp.soz);
       test_query=['{"patient_id":"422","type":"' num2str(4) '","electrode":"' electrode{i} '" }'];
       dat1_t = count(conn,collection,Query=test_query);
       dat1_t = double(dat1_t);
       dat1(i)=dat1_t/time_422;
       test_query=['{"patient_id":"422","type":"' num2str(1) '","electrode":"' electrode{i} '" }'];
       dat2_t = count(conn,collection,Query=test_query);
       dat2_t = double(dat2_t);
       dat2(i)=dat2_t/time_422;
       test_query=['{"patient_id":"422","type":"' num2str(5) '","electrode":"' electrode{i} '" }'];
       dat3_t = count(conn,collection,Query=test_query);
       dat3_t = double(dat3_t);
       dat3(i)=dat3_t/time_422;
       test_query=['{"patient_id":"422","type":"' num2str(2) '","electrode":"' electrode{i} '" }'];
       dat4_t = count(conn,collection,Query=test_query);
       dat4_t = double(dat4_t);
       dat4(i)=dat4_t/time_422;
       % FR before spike
       test_query=['{"patient_id":"422","type":"' num2str(2) '","electrode":"' electrode{i} '" }'];
       RONS = find(conn,collection,'Query',test_query);
       rons_time=[];
       if ~isempty(RONS)
       parfor j=1:numel(RONS(:,1))
           rons_time(j)=getfield(RONS,{j},'start_t');
       end;
       end;
       test_query=['{"patient_id":"422","type":"' num2str(3) '","electrode":"' electrode{i} '" }'];
       SS = find(conn,collection,'Query',test_query);
       ss_time=[];
       if ~isempty(SS)
       parfor j=1:numel(SS(:,1))
            ss_time(j)=getfield(SS,{j},'start_t');
       end;
       end;
       test_query=['{"patient_id":"422","type":"' num2str(5) '","electrode":"' electrode{i} '" }'];
       FRONS = find(conn,collection,'Query',test_query);
       frons_time=[];
       if ~isempty(FRONS)
       parfor j=1:numel(FRONS(:,1))
           frons_time(j)=getfield(FRONS,{j},'start_t');
       end;
       end;
       allspike_t=frons_time;
       allspike_t=sort(allspike_t,'ascend');
       test_query=['{"patient_id":"422","type":"' num2str(4) '","electrode":"' electrode{i} '" }'];
       FRONO = find(conn,collection,'Query',test_query);
       frono_time=[];
       if ~isempty(FRONO)
       parfor j=1:numel(FRONO(:,1))
           frono_time(j)=getfield(FRONO,{j},'start_t');
       end;
       end;
       spike_latency=[];
       if ~isempty(allspike_t)
           if ~isempty(frono_time)
               for k=1:numel(frono_time)
                   temp=allspike_t-frono_time(k);
                   idx=find(temp>0);
                   if ~isempty(idx)
                       spike_latency(k)=min(temp(idx));
                   else
                       spike_latency(k)=NaN;
                   end;
               end;
           end;
       end;
       dat5_t=numel(find(spike_latency<0.3));
       dat5(i)=dat5_t/time_422;
       if soz(i)==1
            FRpreSlatsoz=vertcat(FRpreSlatsoz,spike_latency');
       else 
            FRpreSlatnsoz=vertcat(FRpreSlatnsoz,spike_latency');
       end;    
       if ~isempty(allspike_t)
           if ~isempty(frono_time)
             for o=1:500
               permfr=rand(numel(frono_time),1);
               permfr=permfr*numel(full_index);
               permfr=ceil(permfr);
               permfr=full_index(permfr);
               parfor k=1:numel(permfr)
                   temp=allspike_t-permfr(k);
                   idx=find(temp>0);
                   if ~isempty(idx)
                       spike_latency(k)=min(temp(idx));
                   else
                       spike_latency(k)=NaN;
                   end;
               end;
            if soz(i)==1
            FRpreSlatsoz_b{o}=vertcat(FRpreSlatsoz_b{o},spike_latency');
            else 
            FRpreSlatnsoz_b{o}=vertcat(FRpreSlatnsoz_b{o},spike_latency');
            end; 
            end;  
           end;
       end;
       % R before spike
       test_query=['{"patient_id":"422","type":"' num2str(2) '","electrode":"' electrode{i} '" }'];
       RONS = find(conn,collection,'Query',test_query);
       rons_time=[];
       if ~isempty(RONS)
       parfor j=1:numel(RONS(:,1))
           rons_time(j)=getfield(RONS,{j},'start_t');
       end;
       end;
       test_query=['{"patient_id":"422","type":"' num2str(3) '","electrode":"' electrode{i} '" }'];
       SS = find(conn,collection,'Query',test_query);
       ss_time=[];
       if ~isempty(SS)
       parfor j=1:numel(SS(:,1))
            ss_time(j)=getfield(SS,{j},'start_t');
       end;
       end;
       test_query=['{"patient_id":"422","type":"' num2str(5) '","electrode":"' electrode{i} '" }'];
       FRONS = find(conn,collection,'Query',test_query);
       frons_time=[];
       if ~isempty(FRONS)
       parfor j=1:numel(FRONS(:,1))
           frons_time(j)=getfield(FRONS,{j},'start_t');
       end;
       end;
       allspike_t=rons_time;
       allspike_t=sort(allspike_t,'ascend');
       test_query=['{"patient_id":"422","type":"' num2str(4) '","electrode":"' electrode{i} '" }'];
       RONO = find(conn,collection,'Query',test_query);
       rono_time=[];
       if ~isempty(RONO)
       parfor j=1:numel(RONO(:,1))
           rono_time(j)=getfield(RONO,{j},'start_t');
       end;
       end;
       spike_latency=[];
       if ~isempty(allspike_t)
           if ~isempty(rono_time)
               for k=1:numel(rono_time)
                   temp=allspike_t-rono_time(k);
                   idx=find(temp>0);
                   if ~isempty(idx)
                       spike_latency(k)=min(temp(idx));
                   else
                       spike_latency(k)=NaN;
                   end;
               end;
           end;
       end;
       dat6_t=numel(find(spike_latency<0.3));
       dat6(i)=dat6_t/time_422;
       if soz(i)==1
           RpreSlatsoz=vertcat(RpreSlatsoz,spike_latency');
       else
           RpreSlatnsoz=vertcat(RpreSlatnsoz,spike_latency');
       end;
       if ~isempty(allspike_t)
           if ~isempty(rono_time)
             for o=1:500
               permr=rand(numel(rono_time),1);
               permr=(permr*numel(full_index));
               permr=ceil(permr);
               permr=full_index(permr);
               parfor k=1:numel(permr)
                   temp=allspike_t-permr(k);
                   idx=find(temp>0);
                   if ~isempty(idx)
                       spike_latency(k)=min(temp(idx));
                   else
                       spike_latency(k)=NaN;
                   end;
               end;
            if soz(i)==1
            RpreSlatsoz_b{o}=vertcat(RpreSlatsoz_b{o},spike_latency');
            else 
            RpreSlatnsoz_b{o}=vertcat(RpreSlatnsoz_b{o},spike_latency');
            end; 
            end;  
           end;
       end;
       % FronS after HFO
       test_query=['{"patient_id":"422","type":"' num2str(5) '","electrode":"' electrode{i} '" }']; 
       HFO = find(conn,collection,'Query',test_query);
       start_t=[];
       if ~isempty(HFO)
       parfor j=1:numel(HFO(:,1))
           start_t(j)=getfield(HFO,{j},'start_t');
       end;
       end;
       test_query=['{"patient_id":"422","type":"' num2str(4) '","electrode":"' electrode{i} '" }'];
       FR = find(conn,collection,'Query',test_query);
       frono_time=[];
       if ~isempty(FR)
       parfor j=1:numel(FR(:,1))
            frono_time(j)=getfield(FR,{j},'start_t');
       end;
       end;
       spike_latency=[];
       if ~isempty(start_t)
           if ~isempty(frono_time)
               for k=1:numel(start_t)
                   temp=start_t(k)-frono_time;
                   idx=find(temp>0);
                     if ~isempty(idx)
                        spike_latency(k)=min(temp(idx));
                     else
                        spike_latency(k)=NaN;
                     end;
               end;
           end;
       end;
       dat7_t=numel(find(spike_latency<0.3));
       dat7(i)=dat7_t/time_422;
       if soz(i)==1
           FRONSpostFRlatsoz=vertcat(FRONSpostFRlatsoz, spike_latency');
       else
           FRONSpostFRlatnsoz=vertcat(FRONSpostFRlatnsoz, spike_latency');
       end;

       test_query=['{"patient_id":"422","type":"' num2str(1) '","electrode":"' electrode{i} '" }'];
       R = find(conn,collection,'Query',test_query);
       rono_time=[];
       if ~isempty(R)
       parfor j=1:numel(R(:,1))
            rono_time(j)=getfield(R,{j},'start_t');
       end;
       end;
       spike_latency=[];
           if ~isempty(start_t)
               if ~isempty(rono_time)
                   for k=1:numel(start_t)
                       temp=start_t(k)-rono_time;
                       idx=find(temp>0);
                       if ~isempty(idx)
                           spike_latency(k)=min(temp(idx));
                       else
                           spike_latency(k)=NaN;
                       end;
                   end;
               end;
       end;
       dat8_t=numel(find(spike_latency<0.3));
       dat8(i)=dat8_t/time_422;
       if soz(i)==1
           FRONSpostRlatsoz=vertcat(FRONSpostRlatsoz,spike_latency');
       else
           FRONSpostRlatnsoz=vertcat(FRONSpostRlatnsoz,spike_latency');
       end;
 %  RonS after HFO
       test_query=['{"patient_id":"422","type":"' num2str(2) '","electrode":"' electrode{i} '" }']; 
       HFO = find(conn,collection,'Query',test_query);
       start_t=[];
       if ~isempty(HFO)
       parfor j=1:numel(HFO(:,1))
           start_t(j)=getfield(HFO,{j},'start_t');
       end;
       end;
       test_query=['{"patient_id":"422","type":"' num2str(4) '","electrode":"' electrode{i} '" }'];
       FR = find(conn,collection,'Query',test_query);
       frono_time=[];
       if ~isempty(FR)
       parfor j=1:numel(FR(:,1))
            frono_time(j)=getfield(FR,{j},'start_t');
       end;
       end;
       spike_latency=[];
       if ~isempty(start_t)
           if ~isempty(frono_time)
               for k=1:numel(start_t)
                   temp=start_t(k)-frono_time;
                   idx=find(temp>0);
                     if ~isempty(idx)
                        spike_latency(k)=min(temp(idx));
                     else
                        spike_latency(k)=NaN;
                     end;
               end;
           end;
       end;
       dat9_t=numel(find(spike_latency<0.3));
       dat9(i)=dat9_t/time_422;
       if soz(i)==1
            RONSpostFRlatsoz=vertcat(RONSpostFRlatsoz, spike_latency');
       else
            RONSpostFRlatnsoz=vertcat(RONSpostFRlatnsoz, spike_latency');
       end;
       test_query=['{"patient_id":"422","type":"' num2str(1) '","electrode":"'  electrode{i} '" }'];
       R = find(conn,collection,'Query',test_query);
       rono_time=[];
       if ~isempty(R)
       parfor j=1:numel(R(:,1))
            rono_time(j)=getfield(R,{j},'start_t');
       end;
       end;
       spike_latency=[];
           if ~isempty(start_t)
               if ~isempty(rono_time)
                   for k=1:numel(start_t)
                       temp=start_t(k)-rono_time;
                       idx=find(temp>0);
                       if ~isempty(idx)
                           spike_latency(k)=min(temp(idx));
                       else
                           spike_latency(k)=NaN;
                       end;
                   end;
               end;
       end;
       dat10_t=numel(find(spike_latency<0.3));
       dat10(i)=dat10_t/time_422;
       if soz(i)==1
          RONSpostRlatsoz=vertcat(RONSpostRlatsoz,spike_latency');
       else
          RONSpostRlatnsoz=vertcat(RONSpostRlatnsoz,spike_latency');
       end;
end;


patient=patient';
electrode=electrode';
dat1=dat1';
dat2=dat2';
dat3=dat3';
dat4=dat4';
dat5=dat5';
dat6=dat6';
dat7=dat7';
dat8=dat8';
dat9=dat9';
dat10=dat10'
soz=soz';
table422=table(patient,electrode,dat1,dat2,dat3,dat4,dat5,dat6,dat7,dat8,dat9,dat10,soz);
hfo_table=table422;
latency.RpreSlatsoz=RpreSlatsoz;
latency.FRpreSlatsoz=FRpreSlatsoz;
latency.FRONSpostFRlatsoz=FRONSpostFRlatsoz;
latency.FRONSpostRlatsoz=FRONSpostRlatsoz;
latency.RONSpostFRlatsoz=RONSpostFRlatsoz;
latency.RONSpostRlatsoz=RONSpostRlatsoz;
latency.RpreSlatnsoz=RpreSlatnsoz;
latency.FRpreSlatnsoz=FRpreSlatnsoz;
latency.FRONSpostFRlatnsoz=FRONSpostFRlatnsoz;
latency.FRONSpostRlatnsoz=FRONSpostRlatnsoz;
latency.RONSpostFRlatnsoz=RONSpostFRlatnsoz;
latency.RONSpostRlatnsoz=RONSpostRlatnsoz;

%423
close(conn)
conn = mongo(server,port,dbname,'UserName',username,'Password',password);
time_423=0;
load('/data/downstate/wip/FromYuval/P423/EEG423concat.mat');
test=eeg.eeg_data(1,:);
fzeeghg=ez_eegfilter(test(1,:),80,600,2000);
fzeegzhgamp=zscore(smooth(abs(hilbert(fzeeghg)),400));
fzeegzhgamp=fzeegzhgamp';
fzeegzhgamp=fzeegzhgamp-mean(fzeegzhgamp);
diffzhg=diff(fzeegzhgamp);
diffzhg=abs(diffzhg);
[idx]=find(diffzhg>.0025);
time_423=(numel(test)-numel(idx))/(2000*60);
time_423_sec=numel(test)/2000;    
full_index=[0.0005:0.0005:time_423_sec]; 
full_index(idx)=[];

test_query=['{"patient_id":"423"}'];
electrode=distinct(conn,collection,'electrode','query',test_query)
dat1=[];
dat2=[];
dat3=[];
dat4=[];
dat5=[];
dat6=[];
dat7=[];
dat8=[];
dat9=[];
dat10=[];
soz=[];
close(conn)
conn = mongoc(server,port,dbname,'UserName',username,'Password',password);
patient={''};
for i=1:numel(electrode)
       patient(i)={'423'};
end;

for i=1:numel(electrode)
       i
       test_query=['{"patient_id":"423","type":"' num2str(1) '","electrode":"' electrode{i} '" }'];
       temp = find(conn,collection,'Query',test_query,'limit',1);
       soz(i)=str2num(temp.soz);
       test_query=['{"patient_id":"423","type":"' num2str(4) '","electrode":"' electrode{i} '" }'];
       dat1_t = count(conn,collection,Query=test_query);
       dat1_t = double(dat1_t);
       dat1(i)=dat1_t/time_423;
       test_query=['{"patient_id":"423","type":"' num2str(1) '","electrode":"' electrode{i} '" }'];
       dat2_t = count(conn,collection,Query=test_query);
       dat2_t = double(dat2_t);
       dat2(i)=dat2_t/time_423;
       test_query=['{"patient_id":"423","type":"' num2str(5) '","electrode":"' electrode{i} '" }'];
       dat3_t = count(conn,collection,Query=test_query);
       dat3_t = double(dat3_t);
       dat3(i)=dat3_t/time_423;
       test_query=['{"patient_id":"423","type":"' num2str(2) '","electrode":"' electrode{i} '" }'];
       dat4_t = count(conn,collection,Query=test_query);
       dat4_t = double(dat4_t);
       dat4(i)=dat4_t/time_423;
       % FR before spike
       test_query=['{"patient_id":"423","type":"' num2str(2) '","electrode":"' electrode{i} '" }'];
       RONS = find(conn,collection,'Query',test_query);
       rons_time=[];
       if ~isempty(RONS)
       parfor j=1:numel(RONS(:,1))
           rons_time(j)=getfield(RONS,{j},'start_t');
       end;
       end;
       test_query=['{"patient_id":"423","type":"' num2str(3) '","electrode":"' electrode{i} '" }'];
       SS = find(conn,collection,'Query',test_query);
       ss_time=[];
       if ~isempty(SS)
       parfor j=1:numel(SS(:,1))
            ss_time(j)=getfield(SS,{j},'start_t');
       end;
       end;
       test_query=['{"patient_id":"423","type":"' num2str(5) '","electrode":"' electrode{i} '" }'];
       FRONS = find(conn,collection,'Query',test_query);
       frons_time=[];
       if ~isempty(FRONS)
       parfor j=1:numel(FRONS(:,1))
           frons_time(j)=getfield(FRONS,{j},'start_t');
       end;
       end;
       allspike_t=frons_time;
       allspike_t=sort(allspike_t,'ascend');
       test_query=['{"patient_id":"423","type":"' num2str(4) '","electrode":"' electrode{i} '" }'];
       FRONO = find(conn,collection,'Query',test_query);
       frono_time=[];
       if ~isempty(FRONO)
       parfor j=1:numel(FRONO(:,1))
           frono_time(j)=getfield(FRONO,{j},'start_t');
       end;
       end;
       spike_latency=[];
       if ~isempty(allspike_t)
           if ~isempty(frono_time)
               for k=1:numel(frono_time)
                   temp=allspike_t-frono_time(k);
                   idx=find(temp>0);
                   if ~isempty(idx)
                       spike_latency(k)=min(temp(idx));
                   else
                       spike_latency(k)=NaN;
                   end;
               end;
           end;
       end;
       dat5_t=numel(find(spike_latency<0.3));
       dat5(i)=dat5_t/time_423;
       if soz(i)==1
            FRpreSlatsoz=vertcat(FRpreSlatsoz,spike_latency');
       else 
            FRpreSlatnsoz=vertcat(FRpreSlatnsoz,spike_latency');
       end;    
       if ~isempty(allspike_t)
           if ~isempty(frono_time)
             for o=1:500
               permfr=rand(numel(frono_time),1);
               permfr=permfr*numel(full_index);
               permfr=ceil(permfr);
               permfr=full_index(permfr);
               parfor k=1:numel(permfr)
                   temp=allspike_t-permfr(k);
                   idx=find(temp>0);
                   if ~isempty(idx)
                       spike_latency(k)=min(temp(idx));
                   else
                       spike_latency(k)=NaN;
                   end;
               end;
            if soz(i)==1
            FRpreSlatsoz_b{o}=vertcat(FRpreSlatsoz_b{o},spike_latency');
            else 
            FRpreSlatnsoz_b{o}=vertcat(FRpreSlatnsoz_b{o},spike_latency');
            end; 
            end;  
           end;
       end;
       % R before spike
       test_query=['{"patient_id":"423","type":"' num2str(2) '","electrode":"' electrode{i} '" }'];
       RONS = find(conn,collection,'Query',test_query);
       rons_time=[];
       if ~isempty(RONS)
       parfor j=1:numel(RONS(:,1))
           rons_time(j)=getfield(RONS,{j},'start_t');
       end;
       end;
       test_query=['{"patient_id":"423","type":"' num2str(3) '","electrode":"' electrode{i} '" }'];
       SS = find(conn,collection,'Query',test_query);
       ss_time=[];
       if ~isempty(SS)
       parfor j=1:numel(SS(:,1))
            ss_time(j)=getfield(SS,{j},'start_t');
       end;
       end;
       test_query=['{"patient_id":"423","type":"' num2str(5) '","electrode":"' electrode{i} '" }'];
       FRONS = find(conn,collection,'Query',test_query);
       frons_time=[];
       if ~isempty(FRONS)
       parfor j=1:numel(FRONS(:,1))
           frons_time(j)=getfield(FRONS,{j},'start_t');
       end;
       end;
       allspike_t=rons_time;
       allspike_t=sort(allspike_t,'ascend');
       test_query=['{"patient_id":"423","type":"' num2str(4) '","electrode":"' electrode{i} '" }'];
       RONO = find(conn,collection,'Query',test_query);
       rono_time=[];
       if ~isempty(RONO)
       parfor j=1:numel(RONO(:,1))
           rono_time(j)=getfield(RONO,{j},'start_t');
       end;
       end;
       spike_latency=[];
       if ~isempty(allspike_t)
           if ~isempty(rono_time)
               for k=1:numel(rono_time)
                   temp=allspike_t-rono_time(k);
                   idx=find(temp>0);
                   if ~isempty(idx)
                       spike_latency(k)=min(temp(idx));
                   else
                       spike_latency(k)=NaN;
                   end;
               end;
           end;
       end;
       dat6_t=numel(find(spike_latency<0.3));
       dat6(i)=dat6_t/time_423;
       if soz(i)==1
           RpreSlatsoz=vertcat(RpreSlatsoz,spike_latency');
       else
           RpreSlatnsoz=vertcat(RpreSlatnsoz,spike_latency');
       end;
       if ~isempty(allspike_t)
           if ~isempty(rono_time)
             for o=1:500
               permr=rand(numel(rono_time),1);
               permr=(permr*numel(full_index));
               permr=ceil(permr);
               permr=full_index(permr);
               parfor k=1:numel(permr)
                   temp=allspike_t-permr(k);
                   idx=find(temp>0);
                   if ~isempty(idx)
                       spike_latency(k)=min(temp(idx));
                   else
                       spike_latency(k)=NaN;
                   end;
               end;
            if soz(i)==1
            RpreSlatsoz_b{o}=vertcat(RpreSlatsoz_b{o},spike_latency');
            else 
            RpreSlatnsoz_b{o}=vertcat(RpreSlatnsoz_b{o},spike_latency');
            end; 
            end;  
           end;
       end;
       % FronS after HFO
       test_query=['{"patient_id":"423","type":"' num2str(5) '","electrode":"' electrode{i} '" }']; 
       HFO = find(conn,collection,'Query',test_query);
       start_t=[];
       if ~isempty(HFO)
       parfor j=1:numel(HFO(:,1))
           start_t(j)=getfield(HFO,{j},'start_t');
       end;
       end;
       test_query=['{"patient_id":"423","type":"' num2str(4) '","electrode":"' electrode{i} '" }'];
       FR = find(conn,collection,'Query',test_query);
       frono_time=[];
       if ~isempty(FR)
       parfor j=1:numel(FR(:,1))
            frono_time(j)=getfield(FR,{j},'start_t');
       end;
       end;
       spike_latency=[];
       if ~isempty(start_t)
           if ~isempty(frono_time)
               for k=1:numel(start_t)
                   temp=start_t(k)-frono_time;
                   idx=find(temp>0);
                     if ~isempty(idx)
                        spike_latency(k)=min(temp(idx));
                     else
                        spike_latency(k)=NaN;
                     end;
               end;
           end;
       end;
       dat7_t=numel(find(spike_latency<0.3));
       dat7(i)=dat7_t/time_423;
       if soz(i)==1
           FRONSpostFRlatsoz=vertcat(FRONSpostFRlatsoz, spike_latency');
       else
           FRONSpostFRlatnsoz=vertcat(FRONSpostFRlatnsoz, spike_latency');
       end;

       test_query=['{"patient_id":"423","type":"' num2str(1) '","electrode":"' electrode{i} '" }'];
       R = find(conn,collection,'Query',test_query);
       rono_time=[];
       if ~isempty(R)
       parfor j=1:numel(R(:,1))
            rono_time(j)=getfield(R,{j},'start_t');
       end;
       end;
       spike_latency=[];
           if ~isempty(start_t)
               if ~isempty(rono_time)
                   for k=1:numel(start_t)
                       temp=start_t(k)-rono_time;
                       idx=find(temp>0);
                       if ~isempty(idx)
                           spike_latency(k)=min(temp(idx));
                       else
                           spike_latency(k)=NaN;
                       end;
                   end;
               end;
       end;
       dat8_t=numel(find(spike_latency<0.3));
       dat8(i)=dat8_t/time_423;
       if soz(i)==1
           FRONSpostRlatsoz=vertcat(FRONSpostRlatsoz,spike_latency');
       else
           FRONSpostRlatnsoz=vertcat(FRONSpostRlatnsoz,spike_latency');
       end;
 %  RonS after HFO
       test_query=['{"patient_id":"423","type":"' num2str(2) '","electrode":"' electrode{i} '" }']; 
       HFO = find(conn,collection,'Query',test_query);
       start_t=[];
       if ~isempty(HFO)
       parfor j=1:numel(HFO(:,1))
           start_t(j)=getfield(HFO,{j},'start_t');
       end;
       end;
       test_query=['{"patient_id":"423","type":"' num2str(4) '","electrode":"' electrode{i} '" }'];
       FR = find(conn,collection,'Query',test_query);
       frono_time=[];
       if ~isempty(FR)
       parfor j=1:numel(FR(:,1))
            frono_time(j)=getfield(FR,{j},'start_t');
       end;
       end;
       spike_latency=[];
       if ~isempty(start_t)
           if ~isempty(frono_time)
               for k=1:numel(start_t)
                   temp=start_t(k)-frono_time;
                   idx=find(temp>0);
                     if ~isempty(idx)
                        spike_latency(k)=min(temp(idx));
                     else
                        spike_latency(k)=NaN;
                     end;
               end;
           end;
       end;
       dat9_t=numel(find(spike_latency<0.3));
       dat9(i)=dat9_t/time_423;
       if soz(i)==1
            RONSpostFRlatsoz=vertcat(RONSpostFRlatsoz, spike_latency');
       else
            RONSpostFRlatnsoz=vertcat(RONSpostFRlatnsoz, spike_latency');
       end;
       test_query=['{"patient_id":"423","type":"' num2str(1) '","electrode":"'  electrode{i} '" }'];
       R = find(conn,collection,'Query',test_query);
       rono_time=[];
       if ~isempty(R)
       parfor j=1:numel(R(:,1))
            rono_time(j)=getfield(R,{j},'start_t');
       end;
       end;
       spike_latency=[];
           if ~isempty(start_t)
               if ~isempty(rono_time)
                   for k=1:numel(start_t)
                       temp=start_t(k)-rono_time;
                       idx=find(temp>0);
                       if ~isempty(idx)
                           spike_latency(k)=min(temp(idx));
                       else
                           spike_latency(k)=NaN;
                       end;
                   end;
               end;
       end;
       dat10_t=numel(find(spike_latency<0.3));
       dat10(i)=dat10_t/time_423;
       if soz(i)==1
          RONSpostRlatsoz=vertcat(RONSpostRlatsoz,spike_latency');
       else
          RONSpostRlatnsoz=vertcat(RONSpostRlatnsoz,spike_latency');
       end;
end;


patient=patient';
electrode=electrode';
dat1=dat1';
dat2=dat2';
dat3=dat3';
dat4=dat4';
dat5=dat5';
dat6=dat6';
dat7=dat7';
dat8=dat8';
dat9=dat9';
dat10=dat10'
soz=soz';
table423=table(patient,electrode,dat1,dat2,dat3,dat4,dat5,dat6,dat7,dat8,dat9,dat10,soz);
latency.RpreSlatsoz=RpreSlatsoz;
latency.FRpreSlatsoz=FRpreSlatsoz;
latency.FRONSpostFRlatsoz=FRONSpostFRlatsoz;
latency.FRONSpostRlatsoz=FRONSpostRlatsoz;
latency.RONSpostFRlatsoz=RONSpostFRlatsoz;
latency.RONSpostRlatsoz=RONSpostRlatsoz;
latency.RpreSlatnsoz=RpreSlatnsoz;
latency.FRpreSlatnsoz=FRpreSlatnsoz;
latency.FRONSpostFRlatnsoz=FRONSpostFRlatnsoz;
latency.FRONSpostRlatnsoz=FRONSpostRlatnsoz;
latency.RONSpostFRlatnsoz=RONSpostFRlatnsoz;
latency.RONSpostRlatnsoz=RONSpostRlatnsoz;

latency.RpreSlatnsoz_b=RpreSlatnsoz_b;
latency.FRpreSlatnsoz_b=FRpreSlatnsoz_b;
latency.RpreSlatsoz_b=RpreSlatsoz_b;
latency.FRpreSlatsoz_b=FRpreSlatsoz_b;
hfo_table=vertcat(table398,table406,table416,table417,table422,table423);