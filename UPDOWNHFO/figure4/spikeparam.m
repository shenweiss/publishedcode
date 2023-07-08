function [unitparam]=spikeparam()
server='localhost';
username='admin';
password='';
dbname='deckard_new';
collection = "yuvalHFOn";
port=27017;
conn = mongo(server,port,dbname,'UserName',username,'Password',password);
collection = "yuvalUNITn";
patients=distinct(conn,collection,'patient_id');
counter=0;
for z=1:numel(patients)
    z
close(conn)
conn = mongo(server,port,dbname,'UserName',username,'Password',password);
test_query=['{"patient_id":"' patients{z} '" }'];
unitnums=distinct(conn,collection,'unitnum','Query',test_query);
mu=[];
if strcmp(patients{z},'398')
    load('398_spikes.mat')
end;
if strcmp(patients{z},'406')
    load('406_spikes.mat')
end;
if strcmp(patients{z},'416')
    load('416_spikes.mat')
end;
if strcmp(patients{z},'422')
    load('422_spikes.mat')
end
if strcmp(patients{z},'423')
    load('423_spikes.mat')
end;
for i=1:numel(unitnums)
    unit=unitnums(i);
    unit=unit{1};
    unit=num2str(unit);
    test_query=['{"patient_id":"' patients{z} '","unitnum":' unit ' }'];
    docs=find(conn,collection,'query',test_query,'limit',10);
    mu(i)=docs(1).type;
end;
close(conn);
conn = mongoc(server,port,dbname,'UserName',username,'Password',password);
for i=1:numel(unitnums)
    i
     if mu(i)==1
         counter=counter+1;
         unitparam(counter,1)=z;
         unitparam(counter,2)=i;
         [halfwidth,troughtopeak] = waveformcalcs(spike,i);
         unitparam(counter,3)=halfwidth;
         unitparam(counter,4)=troughtopeak;
         unit=i;
         unit=num2str(unit);
         test_query=['{"patient_id":"' patients{z} '","unitnum":' unit ' }'];
         docs=find(conn,collection,'query',test_query);
         parfor j=1:numel(docs)
            unit_ts(j)=getfield(docs,{j},'time');
         end;
         spiket=zeros(1,(2000*(unit_ts(numel(unit_ts)))));
         for j=1:numel(unit_ts)
             idx=round((unit_ts(j)*2000),0);
             spiket(idx)=1;
         end;    
         [f,Pxxn,tvect,Cxx] = psautospk(spiket,.0005);
         [idx]=find(tvect==0);
         Cxx_half=Cxx(idx+2:end);
         tvect_half=tvect(idx+2:end);
         % [~,AC_idx]=max(Cxx_half);
         % AC=tvect_half(AC_idx);
         tempvar=[tvect_half Cxx_half'];
         unitparam(counter,5)=mean(Cxx_half);
         unitparam(counter,6)=moment(tempvar,2);
     end;
   end;
end;