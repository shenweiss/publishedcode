server='localhost';
username='admin';
password='';
dbname='deckard_new';
port=27017;
conn = mongo(server,port,dbname,'UserName',username,'Password',password);
collection = "HFOs";

X=[];

[a,b]=unique(processed.DistanceVector);
processed=processed(b,:);
[a,b]=find(processed.fripple_sign_p_matrix<0.005); %0.0045
processed=processed(a,:);
soz=cell2mat(processed.SOZstatusVector);
[a,b]=find(soz(:,1)==1);
[c,d]=find(soz(:,2)==1);
e=intersect(a,c);
sozedges=processed(e,:);
[a,b]=find(soz(:,1)==1);
[c,d]=find(soz(:,2)==0);
e=intersect(a,c);
soznsozedges=processed(e,:);
[a,b]=find(soz(:,1)==0);
[c,d]=find(soz(:,2)==1);
e=intersect(a,c);
nsozsozedges=processed(e,:);
[a,b]=find(soz(:,1)==0);
[c,d]=find(soz(:,2)==0);
e=intersect(a,c);
nsozedges=processed(e,:);

% correct organization of SOZ:NSOZ and NSOZ:SOZ edges 
transition_soznsoz=[];
delete_nsozsoz=[];
for i=1:numel(nsozsozedges.mean_delay)
    if nsozsozedges.mean_delay(i)<0
        nsozsozedges.mean_delay(i)=-nsozsozedges.mean_delay(i);
        nsozsozedges.fripple_sign_z_matrix(i)=-nsozsozedges.fripple_sign_z_matrix(i);
        transition_soznsoz=vertcat(transition_soznsoz, nsozsozedges(i,:));
        delete_nsozsoz=[delete_nsozsoz i];
    end;
end;
transition_nsozsoz=[];
delete_soznsoz=[];
for i=1:numel(soznsozedges.mean_delay)
    if soznsozedges.mean_delay(i)<0
        soznsozedges.mean_delay(i)=-soznsozedges.mean_delay(i);
        soznsozedges.fripple_sign_z_matrix(i)=-soznsozedges.fripple_sign_z_matrix(i);
        transition_nsozsoz=vertcat(transition_nsozsoz, soznsozedges(i,:));
        delete_soznsoz=[delete_soznsoz i];
    end;
end;

nsozsozedges(delete_nsozsoz,:)=[];
soznsozedges(delete_soznsoz,:)=[];

nsozsozedges=vertcat(nsozsozedges,transition_nsozsoz);
soznsozedges=vertcat(soznsozedges, transition_soznsoz);

totalsozedges=zeros(numel(ALLPATIENTS),1);
resectedsozedges=zeros(numel(ALLPATIENTS),1);
for i=1:numel(sozedges.patientvector);
    totalsozedges(sozedges.patientvector(i))=totalsozedges(sozedges.patientvector(i))+1;
    chname=sozedges.chnameVector(i);
    chname=chname{1}{1}{1};
    if sozedges.fripple_sign_z_matrix(i)<0
        chname=sozedges.chnameVector(i);
        chname=chname{1}{2}{1};
    end;
    test_query=['{"patient_id":"' ALLPATIENTS{sozedges.patientvector(i)} '","electrode":"' chname '" }'];
    docs = find(conn,collection,'query',test_query,'limit',100);
    resected=str2num(docs(1).resected);
    if resected==1
        resectedsozedges(sozedges.patientvector(i))=resectedsozedges(sozedges.patientvector(i))+1;
    end;
end;

temp=totalsozedges(14);
totalsozedes(14)=totalsozedges(21);
totalsozedges(21)=temp;

temp=resectedsozedges(14);
resectedsozedes(14)=resectedsozedges(21);
resectedsozedges(21)=temp;

subtotal_t=totalsozedges-resectedsozedges;
X(1,1,:)=subtotal_t;

subtotal_t=resectedsozedges;
X(1,2,:)=subtotal_t

totalsoznsozedges=zeros(numel(ALLPATIENTS),1);
resectedsoznsozedges=zeros(numel(ALLPATIENTS),1);
for i=1:numel(soznsozedges.patientvector);
    totalsoznsozedges(soznsozedges.patientvector(i))=totalsoznsozedges(soznsozedges.patientvector(i))+1;
    chname=soznsozedges.chnameVector(i);
    chname=chname{1}{1}{1};
    test_query=['{"patient_id":"' ALLPATIENTS{soznsozedges.patientvector(i)} '","electrode":"' chname '" }'];
    docs = find(conn,collection,'query',test_query,'limit',100);
    resected=str2num(docs(1).resected);
    if resected==1
        resectedsoznsozedges(soznsozedges.patientvector(i))=resectedsoznsozedges(soznsozedges.patientvector(i))+1;
    end;
end;


temp=totalsoznsozedges(14);
totalsoznsozedes(14)=totalsoznsozedges(21);
totalsoznsozedges(21)=temp;

temp=resectedsoznsozedges(14);
resectedsoznsozedes(14)=resectedsoznsozedges(21);
resectedsoznsozedges(21)=temp;

subtotal_t=totalsoznsozedges-resectedsoznsozedges;
X(2,1,:)=subtotal_t;

subtotal_t=resectedsoznsozedges;
X(2,2,:)=subtotal_t;

totalnsozsozedges=zeros(numel(ALLPATIENTS),1);
resectednsozsozedges=zeros(numel(ALLPATIENTS),1);
for i=1:numel(nsozsozedges.patientvector);
    totalnsozsozedges(soznsozedges.patientvector(i))=totalnsozsozedges(nsozsozedges.patientvector(i))+1;
    chname=nsozsozedges.chnameVector(i);
    chname=chname{1}{1}{1};
    test_query=['{"patient_id":"' ALLPATIENTS{nsozsozedges.patientvector(i)} '","electrode":"' chname '" }'];
    docs = find(conn,collection,'query',test_query,'limit',100);
    resected=str2num(docs(1).resected);
    if resected==1
        resectednsozsozedges(nsozsozedges.patientvector(i))=resectednsozsozedges(nsozsozedges.patientvector(i))+1;
    end;
end;

temp=totalnsozsozedges(14);
totalnsozsozedes(14)=totalnsozsozedges(21);
totalnsozsozedges(21)=temp;

temp=resectednsozsozedges(14);
resectednsozsozedes(14)=resectednsozsozedges(21);
resectednsozsozedges(21)=temp;

subtotal_t=totalnsozsozedges-resectednsozsozedges;
X(3,1,:)=subtotal_t;

subtotal_t=resectednsozsozedges;
X(3,2,:)=subtotal_t;

subtotal_t=resectednsozsozedges;
groupdata_t=ones(23,1)*3;
stackdata_t=ones(23,1)*2;
X2=permute(X,[3 1 2])
plotBarStackGroups(X2);

totalnsozedges=zeros(numel(ALLPATIENTS),1);
resectednsozedges=zeros(numel(ALLPATIENTS),1);
for i=1:numel(nsozedges.patientvector);
    totalnsozedges(nsozedges.patientvector(i))=totalnsozedges(nsozedges.patientvector(i))+1;
    chname=nsozedges.chnameVector(i);
    chname=chname{1}{1}{1};
    if nsozedges.fripple_sign_z_matrix(i)<0
        chname=nsozedges.chnameVector(i);
        chname=chname{1}{2}{1};
    end;
    test_query=['{"patient_id":"' ALLPATIENTS{nsozedges.patientvector(i)} '","electrode":"' chname '" }'];
    docs = find(conn,collection,'query',test_query,'limit',100);
    resected=str2num(docs(1).resected);
    if resected==1
        resectedsozedges(nsozedges.patientvector(i))=resectedsozedges(nsozedges.patientvector(i))+1;
    end;
end;

CODED_label=ALLPATIENTS;
temp=CODED_label(14);
CODED_label(14)=CODED_label(21);
CODED_label(21)=temp;
set(gca, 'XTickLabel',CODED_label, 'XTick',1:numel(CODED_label))
