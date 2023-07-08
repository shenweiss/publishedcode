%398
server='localhost';
username='admin';
password='';
dbname='deckard_new';
collection = "yuvalHFOn";
port=27017;
conn = mongo(server,port,dbname,'UserName',username,'Password',password);
collection = "yuvalUNITn";
test_query=['{"patient_id":"398" }'];
unitnums=distinct(conn,collection,'unitnum','Query',test_query);
mu=[];
for i=1:numel(unitnums)
    unit=unitnums(i);
    unit=unit{1};
    unit=num2str(unit);
    test_query=['{"patient_id":"398","unitnum":' unit ' }'];
    docs=find(conn,collection,'query',test_query,'limit',10);
    mu(i)=docs(1).type;
end;
counter=0;
unitparam=[];
close(conn);
conn = mongoc(server,port,dbname,'UserName',username,'Password',password);
for i=1:numel(unitnums)
     if mu(i)==1
         counter=counter+1;
         unitparam(counter,1)=i;
         [halfwidth,troughtopeak] = waveformcalcs(spike,i);
         unitparam(counter,2)=halfwidth;
         unitparam(counter,3)=troughtopeak;
         unit=i;
         unit=num2str(unit);
         test_query=['{"patient_id":"398","unitnum":' unit ' }'];
         docs=find(conn,collection,'query',test_query);
         parfor j=1:numel(docs)
            unit_ts(j)=getfield(docs,{j},'time');
         end;
         fprintf('to here');
     end;
end;