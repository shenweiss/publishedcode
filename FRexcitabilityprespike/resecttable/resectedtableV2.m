function [hfo_table] = resectedratetableV2(patient)
server='localhost';
username='admin';
password='';
dbname='deckard_new';
collection = "HFOs";
port=27017;
conn = mongo(server,port,dbname,'UserName',username,'Password',password);

hfo_table=[];
for m=1:numel(patient)
close(conn)
conn = mongo(server,port,dbname,'UserName',username,'Password',password);
test_query=['{"patient_id":"' patient{m} '"}'];
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
resected=[];
close(conn)
conn = mongoc(server,port,dbname,'UserName',username,'Password',password);

for i=1:numel(electrode)
       i
       test_query=['{"patient_id":"' patient{m} '","type":"' num2str(1) '","electrode":"' electrode{i} '" }'];
       temp = find(conn,collection,'Query',test_query,'limit',1);
       if ~isempty(temp)
           if ~isempty(temp.resected)
            if ischar(temp.resected)
                 resected(i)=str2num(temp.resected);
            else
                resected(i)=temp.resected;
            end;
           else
           resected(i)=0
           end;
       else
       resected(i)=0;
       end;
       test_query=['{"patient_id":"' patient{m} '","type":"' num2str(4) '","electrode":"' electrode{i} '" }'];
       dat1_t = count(conn,collection,Query=test_query);
       dat1_t = double(dat1_t);
       dat1(i)=dat1_t/60;
       test_query=['{"patient_id":"' patient{m} '","type":"' num2str(1) '","electrode":"' electrode{i} '" }'];
       dat2_t = count(conn,collection,Query=test_query);
       dat2_t = double(dat2_t);
       dat2(i)=dat2_t/60;
       test_query=['{"patient_id":"' patient{m} '","type":"' num2str(5) '","electrode":"' electrode{i} '" }'];
       dat3_t = count(conn,collection,Query=test_query);
       dat3_t = double(dat3_t);
       dat3(i)=dat3_t/60;
       test_query=['{"patient_id":"' patient{m} '","type":"' num2str(2) '","electrode":"' electrode{i} '" }'];
       dat4_t = count(conn,collection,Query=test_query);
       dat4_t = double(dat4_t);
       dat4(i)=dat4_t/60;
       % FR before spike
       test_query=['{"patient_id":"' patient{m} '","type":"' num2str(2) '","electrode":"' electrode{i} '" }'];
       RONS = find(conn,collection,'Query',test_query);
       rons_time=[];
       if ~isempty(RONS)
       parfor j=1:numel(RONS(:,1))
           rons_time(j)=getfield(RONS,{j},'start_t');
       end;
       end;
       test_query=['{"patient_id":"' patient{m} '","type":"' num2str(3) '","electrode":"' electrode{i} '" }'];
       SS = find(conn,collection,'Query',test_query);
       ss_time=[];
       if ~isempty(SS)
       parfor j=1:numel(SS(:,1))
            ss_time(j)=getfield(SS,{j},'start_t');
       end;
       end;
       test_query=['{"patient_id":"' patient{m} '","type":"' num2str(5) '","electrode":"' electrode{i} '" }'];
       FRONS = find(conn,collection,'Query',test_query);
       frons_time=[];
       if ~isempty(FRONS)
       parfor j=1:numel(FRONS(:,1))
           frons_time(j)=getfield(FRONS,{j},'start_t');
       end;
       end;
       allspike_t=horzcat(rons_time,ss_time,frons_time);
       allspike_t=sort(allspike_t,'ascend');
       test_query=['{"patient_id":"' patient{m} '","type":"' num2str(4) '","electrode":"' electrode{i} '" }'];
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
       dat5(i)=dat5_t/60;
       % R before spike
       test_query=['{"patient_id":"' patient{m} '","type":"' num2str(2) '","electrode":"' electrode{i} '" }'];
       RONS = find(conn,collection,'Query',test_query);
       rons_time=[];
       if ~isempty(RONS)
       parfor j=1:numel(RONS(:,1))
           rons_time(j)=getfield(RONS,{j},'start_t');
       end;
       end;
       test_query=['{"patient_id":"' patient{m} '","type":"' num2str(3) '","electrode":"' electrode{i} '" }'];
       SS = find(conn,collection,'Query',test_query);
       ss_time=[];
       if ~isempty(SS)
       parfor j=1:numel(SS(:,1))
            ss_time(j)=getfield(SS,{j},'start_t');
       end;
       end;
       test_query=['{"patient_id":"' patient{m} '","type":"' num2str(5) '","electrode":"' electrode{i} '" }'];
       FRONS = find(conn,collection,'Query',test_query);
       frons_time=[];
       if ~isempty(FRONS)
       parfor j=1:numel(FRONS(:,1))
           frons_time(j)=getfield(FRONS,{j},'start_t');
       end;
       end;
       allspike_t=horzcat(rons_time,ss_time,frons_time);
       allspike_t=sort(allspike_t,'ascend');
       test_query=['{"patient_id":"' patient{m} '","type":"' num2str(1) '","electrode":"' electrode{i} '" }'];
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
       dat6(i)=dat6_t/60;

       % FronS after HFO
       test_query=['{"patient_id":"' patient{m} '","type":"' num2str(5) '","electrode":"' electrode{i} '" }']; 
       HFO = find(conn,collection,'Query',test_query);
       start_t=[];
       if ~isempty(HFO)
       parfor j=1:numel(HFO(:,1))
           start_t(j)=getfield(HFO,{j},'start_t');
       end;
       end;
       test_query=['{"patient_id":"' patient{m} '","type":"' num2str(4) '","electrode":"' electrode{i} '" }'];
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
       dat7(i)=dat7_t/60;

       test_query=['{"patient_id":"' patient{m} '","type":"' num2str(1) '","electrode":"' electrode{i} '" }'];
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
       dat8(i)=dat8_t/60;
       
 %  RonS after HFO
       test_query=['{"patient_id":"' patient{m} '","type":"' num2str(2) '","electrode":"' electrode{i} '" }']; 
       HFO = find(conn,collection,'Query',test_query);
       start_t=[];
       if ~isempty(HFO)
       parfor j=1:numel(HFO(:,1))
           start_t(j)=getfield(HFO,{j},'start_t');
       end;
       end;
       test_query=['{"patient_id":"' patient{m} '","type":"' num2str(4) '","electrode":"' electrode{i} '" }'];
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
       dat9(i)=dat9_t/60;
       
       test_query=['{"patient_id":"' patient{m} '","type":"' num2str(1) '","electrode":"'  electrode{i} '" }'];
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
       dat10(i)=dat10_t/60;
       
end;
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
dat10=dat10';
resected=resected';
name_t=patient(m);
name={''};
name(1:numel(electrode))=name_t;
name=name';
table_t=table(name,electrode,dat1,dat2,dat3,dat4,dat5,dat6,dat7,dat8,dat9,dat10,resected);
hfo_table=vertcat(hfo_table,table_t);
end;