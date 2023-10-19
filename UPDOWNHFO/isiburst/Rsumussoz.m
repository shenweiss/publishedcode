server='localhost';
username='admin';
password='';
dbname='deckard_new';
collection = "yuvalHFOn";
port=27017;
conn = mongoc(server,port,dbname,'UserName',username,'Password',password);
counter=0;

soz=[];
sumu=[];
for i=1:numel(RONOchan(:,1)) 
collection = "yuvalUNITn";
tempstr=num2str(RONOchan.C{i});
test_query=['{"patient_id":"' RONOchan.A{i} '","channame":"' RONOchan.B{i} '","unitnum":' tempstr ' }'];
units = find(conn,collection,'query',test_query,'limit',1);
soz(i)=getfield(units,'soz');
sumu(i)=getfield(units,'type')
end;