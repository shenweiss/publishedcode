function [output_t]=analysis1paconly(PATS)

server='localhost';
username='admin';
password='';
dbname='deckard_new';
port=27017;
conn = mongo(server,port,dbname,'UserName',username,'Password',password);

patient={''};
electrode={''};
unitnum=[];
soz=[];
loc=[];
maxUP=[];
UP_p=[];
UP_Z=[];
counter=0;
for Z=1:numel(PATS)
    close(conn);
    conn = mongo(server,port,dbname,'UserName',username,'Password',password);
    collection = "yuvalUNITn";
    % Find Unique Electrodes
    test_query=['{"patient_id":"' PATS{Z} '"}'];
    electrodes=distinct(conn,collection,"channame",'query',test_query)
         for j=1:numel(electrodes)
             close(conn)
             conn = mongo(server,port,dbname,'UserName',username,'Password',password);
             collection = "yuvalUNITn";
             j
             test_query=['{"patient_id":"' PATS{Z} '","channame":"' electrodes{j} '"}'];
             unitnums=distinct(conn,collection,'unitnum','query',test_query);
             for k=1:numel(unitnums)
                 close(conn)
                 conn = mongoc(server,port,dbname,'UserName',username,'Password',password);
                 k
                 collection = "yuvalUNITn";
                 counter=counter+1;
                 patient{counter}=PATS{Z};
                 electrode{counter}=electrodes{j};
                 unitnum(counter)=unitnums{k};
                 tempstr=num2str(unitnums{k});
                 collection = "yuvalUNITn";
                 test_query=['{"patient_id":"' PATS{Z} '","channame":"' electrodes{j} '","unitnum":' tempstr ' }'];
                 units = find(conn,collection,'query',test_query);
                 unit_ts=[];
                 slow=[];
                 slowphase=[];
                 soz_t=getfield(units,{1},'soz');
                 loc_t=getfield(units,{1},'loc')
                 parfor i=1:numel(units(:,1))
                   unit_ts(i)=getfield(units,{i},'time');
                   slow(i)=getfield(units,{i},'slow')
                   slowphase(i)=getfield(units,{i},'slowphase');
                 end;
                 soz(counter)=soz_t;
                 loc(counter)=loc_t;
                 [idx]=find(slow==1);
                 slowphase=slowphase(idx);
                 r_t = circ_mean(slowphase');
                 maxUP(counter) = r_t;
                 [p_t,Z_t] = circ_rtest(slowphase');
                 UP_p(counter)=p_t;
                 UP_z(counter)=Z_t;
             end;
         end;
end;

patient=patient';
electrode=electrode';
unitnum=unitnum';
soz=soz';
loc=loc';
maxUP=maxUP';
UP_p=UP_p';
UP_z=UP_z';

output_t=table(patient,electrode,unitnum,soz,loc,maxUP,UP_p,UP_z);