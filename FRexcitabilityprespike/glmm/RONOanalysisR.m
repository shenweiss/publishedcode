function [masterraster,MDLdata]=RONOanalysisR(RONOchan,hfo_table)

%for figures
masterraster=[];
% y
bl =[];
hfo = [];
hfodiff =[];
% random effects
patient=[];
electrode=[];
unit=[];
% main effects
loc=[];
HFOlevel=[];
power=[];
frequency=[];
preSPIKE=[];
FzslowZ=[]; %abs
pcode=[];
start=[];

% hfodiff or hfo or baseline = loc + HFOlevel + power + preFR + FzslowZ:pcode + loc:HFOlevel +
% loc:power + loc:preFR + loc:FzslowZ:pcode + HFOlevel:power +
% HFOlevel:preFR + HFOlevel:FzslowZ:pcode + power:preFR +
% power:FzslowZ:pcode + preFR:FzslowZ:pcode + loc:HFOlevel:power +
% loc:HFOlevel:preFR + loc:HFOlevel:FzslowZ:pcode + HFOlevel:power:preFR +
% HFOlevel:power:FzslowZ:pcode + power:preFR:FzslowZ:pcode +
% loc:HFOlevel:power:preFR + HFOlevel:power:preFR:FZslowZ:pcode +
% loc:power:preFR:FzslowZ:pcode + loc:HFOlevel:preFR:FzslowZ:pcode +
% loc:HFOlevel:power:preFR:FzslowZ:pcode + (1/patient) + (1/electrode) +
% (1/unit)

%Algo
%iterate i through each unit in RONOchan i=unit
%code patient # and electrode # (~strcmp(electrodename(i)-electrodename(i-1)) then electrode_t=electrode_t+1) for that unit
% if ~strcmp(electrodename(i)-electrodename(i-1) or i=1
% obtain loc_t, obtain hfolevel_t
% download all FRonS R and FR
% calc index of FRonS that have < 300 ms R or FR
% interate through all HFOs
% code patient, electrode, and unit 
% obtain power pk, freq pk, code power and frequency
% check if HFO preceded by R or FR code preR and preFR
% obtain abs(FzslowZ) and determine pcode code these values
% determined smooth firing, calculate bl,hfo, and hfodiff
% vertically concat smooth firing in temporary structure
% at the conclusion of HFO loop vconcat temporary structure to tall raster

server='localhost';
username='admin';
password='';
dbname='deckard_new';
collection = "yuvalHFO";
port=27017;
conn = mongoc(server,port,dbname,'UserName',username,'Password',password);
counter=0;

for i=1:numel(RONOchan(:,1)) 
    unit_t=i
    collection = "yuvalHFO";
    
    if strcmp('398',RONOchan.A{i});
        patient_t=1;
    end;
    if strcmp('406',RONOchan.A{i});
        patient_t=2;
    end;
    if strcmp('416',RONOchan.A{i});
        patient_t=3;
    end;
    if strcmp('417',RONOchan.A{i});
        patient_t=4;
    end;
    if strcmp('423',RONOchan.A{i});
        patient_t=5;
    end;

    if i>1 
        if ~strcmp(RONOchan.B{i},RONOchan.B{i-1})
            electrode_t=electrode_t+1;
            [idx]=find(strcmp(RONOchan.A{i},hfo_table.patient)==1);
            [idx2]=find(strcmp(RONOchan.B{i},hfo_table.electrode)==1);
            [int]=intersect(idx,idx2);
            HFO_level_t=hfo_table.levels(int);
            HFOstats=1;
            test_query=['{"patient_id":"' RONOchan.A{i} '","type":"' num2str(1) '","electrode":"' RONOchan.B{i} '" }']; 
        else
            HFOstats=0;
        end;
     else
            electrode_t=1;
            HFOstats=1;
            [idx]=find(strcmp(RONOchan.A{i},hfo_table.patient)==1);
            [idx2]=find(strcmp(RONOchan.B{i},hfo_table.electrode)==1);
            [int]=intersect(idx,idx2);
            HFO_level_t=hfo_table.levels(int);
     end;
    if HFOstats==1
            disp('Downloading new HFOs')
            test_query=['{"patient_id":"' RONOchan.A{i} '","type":"' num2str(1) '","electrode":"' RONOchan.B{i} '" }']; 
            HFO = find(conn,collection,'Query',test_query);
            start_t=[];
            freq_t=[];
            power_t=[];
            FzslowZ_t=[];
            Fzslow_angle_t=[];
            loc_t=getfield(HFO,{1},'loc');
            if loc_t>4
                loc_t=5;
            end;          
            parfor j=1:numel(HFO(:,1))
                start_t(j)=getfield(HFO,{j},'start_t');
                freq_t(j)=getfield(HFO,{j},'freq_pk');
                power_t(j)=getfield(HFO,{j},'power_pk');
                if ~isempty(getfield(HFO,{j},'FzslowZ'))
                    FzslowZ_t(j)=getfield(HFO,{j},'FzslowZ');
                else 
                    FzslowZ_t(j)=NaN;
                end;
                if ~isempty(getfield(HFO,{j},'Fzslow_angle'))
                    Fzslow_angle_t(j)=getfield(HFO,{j},'Fzslow_angle');
                else
                    Fzslow_angle_t(j)=NaN;
                end;
            end;
           
           % FR before spike
           test_query=['{"patient_id":"' RONOchan.A{i} '","type":"' num2str(2) '","electrode":"' RONOchan.B{i} '" }'];
           RONS = find(conn,collection,'Query',test_query);
           rons_time=[];
           if ~isempty(RONS)
           parfor j=1:numel(RONS(:,1))
                rons_time(j)=getfield(RONS,{j},'start_t');
           end;
           end;
           test_query=['{"patient_id":"' RONOchan.A{i} '","type":"' num2str(3) '","electrode":"' RONOchan.B{i} '" }'];
           SS = find(conn,collection,'Query',test_query);
           ss_time=[];
           if ~isempty(SS)
           parfor j=1:numel(SS(:,1))
                ss_time(j)=getfield(SS,{j},'start_t');
           end;
           end;
           test_query=['{"patient_id":"' RONOchan.A{i} '","type":"' num2str(5) '","electrode":"' RONOchan.B{i} '" }'];
           FRONS = find(conn,collection,'Query',test_query);
           frons_time=[];
           if ~isempty(FRONS)
           parfor j=1:numel(FRONS(:,1))
                frons_time(j)=getfield(FRONS,{j},'start_t');
           end;
           end;
           allspike_t=horzcat(rons_time,ss_time,frons_time);
           allspike_t=sort(allspike_t,'ascend');
           spike_latency=[];
           if ~isempty(start_t)
               if ~isempty(allspike_t)
                   for k=1:numel(start_t)
                       temp=allspike_t-start_t(k);
                       idx=find(temp>0);
                       if ~isempty(idx)
                           spike_latency(k)=min(temp(idx));
                       else
                           spike_latency(k)=NaN;
                       end;
                   end;
               end;
           end;
           preSPIKE_idx=find(spike_latency<0.3);
    end;

collection = "yuvalUNIT";
tempstr=num2str(RONOchan.C{i});
test_query=['{"patient_id":"' RONOchan.A{i} '","channame":"' RONOchan.B{i} '","unitnum":' tempstr ' }'];
units = find(conn,collection,'query',test_query);
unit_ts=[];
slowphase=[];
deltaphase=[];
ieegslowphase=[];
ieegdeltaphase=[];
deltaZ=[];
parfor j=1:numel(units(:,1))
       unit_ts(j)=getfield(units,{j},'time');
       slowphase(j)=getfield(units,{j},'Fzslowphase');
       deltaphase(j)=getfield(units,{j},'Fzdeltaphase');
       ieegslowphase(j)=getfield(units,{j},'slowphase');
       ieegdeltaphase(j)=getfield(units,{j},'deltaphase');
       deltaZ(j)=getfield(units,{j},'deltaZ');
end;
dsraster_t=[];
for j=1:numel(HFO(:,1))
       counter=counter+1;
       HFO_start=start_t(j);
       unit_ts=round(unit_ts,3);
       HFO_begin=round(HFO_start,3)-1;
       HFO_end=round(HFO_start,3)+1;
       angle_begin=round(HFO_start,3)-0.03;
       angle_end=round(HFO_start,3)+0.03;
       raster=zeros(1,2000);
       dummyHFO=[HFO_begin:0.001:(HFO_end-0.001)];
       dummyAngle=[angle_begin:0.001:angle_end];
       [C,IA,IB] = intersect(unit_ts,dummyHFO);
       raster(IB)=1;
       k = gausswin(101);
       z1 = conv(raster,k);
       dsraster = downsample(z1,25);
       dsraster_t=vertcat(dsraster_t,dsraster);
       % calc y variables
       bl_t=mean(dsraster(10:38));
       hfo_t=max(dsraster(43:44));
       hfodiff_t=hfo_t-bl_t;
       % code model variables
       bl=vertcat(bl,bl_t);
       hfo=vertcat(hfo,hfo_t);
       hfodiff=vertcat(hfodiff,hfodiff_t);
       patient=vertcat(patient,patient_t);
       electrode=vertcat(electrode,electrode_t);
       unit=vertcat(unit,unit_t);
       loc=vertcat(loc,loc_t);
       HFOlevel=vertcat(HFOlevel,HFO_level_t);
       power=vertcat(power,power_t(j));
       frequency=vertcat(frequency,freq_t(j));
       if ismember(j,preSPIKE_idx)
           preSPIKE=vertcat(preSPIKE,1);
       else
           preSPIKE=vertcat(preSPIKE,0);
       end;
       start=vertcat(start,start_t(j));
end;
masterraster=vertcat(masterraster, dsraster_t);
collection = "yuvalHFO";
end;
MDLdata=table(bl,hfo,hfodiff,patient,electrode,unit,loc,HFOlevel,power,frequency,preSPIKE,start);
