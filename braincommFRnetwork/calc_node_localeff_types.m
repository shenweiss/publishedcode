function [f2] = calc_node_localeff(f)

f2=f;

nsoz_node_leff=[];
[a,b]=find(f.e_l==0);
f.e_l(a)=[];
f.soz_array(a)=[];
f.patient_array(a)=[];

for i=1:numel(f.lambda)
    [a,b]=find(f.patient_array==i);
    if isempty(a)
        nsoz_node_leff(i)=NaN;
    else
        temp_1=f.soz_array(a);
        temp_2=f.e_l(a);        
        [c,d]=find(temp_1==0);
        temp_3=temp_2(c);
               
        [c,d]=find(temp_1==1);
        temp_4=temp_2(c);
        
        if isempty(temp_4)
            temp_4=0;
        end;
        
        if isempty(temp_3)
            temp_3=0;
        end;
        nsoz_node_leff(i)=nanmean(temp_3);
       
    end;
end;

f2.nsoz_node_leff=nsoz_node_leff';

f=f2;
nsoz_node_leff=[];
[a,b]=find(f.e_l_frippleall==0);
f.e_l_frippleall(a)=[];
f.soz_array(a)=[];
f.patient_array(a)=[];

for i=1:numel(f.lambda)
    [a,b]=find(f.patient_array==i);
    if isempty(a)
        nsoz_node_leff(i)=NaN;
    else
        temp_1=f.soz_array(a);
        temp_2=f.e_l_frippleall(a);        
        [c,d]=find(temp_1==0);
        temp_3=temp_2(c);
               
        [c,d]=find(temp_1==1);
        temp_4=temp_2(c);
        
        if isempty(temp_4)
            temp_4=0;
        end;
        
        if isempty(temp_3)
            temp_3=0;
        end;
        nsoz_node_leff(i)=nanmean(temp_3);
       
    end;
end;

f2.nsoz_node_leff_frippleall=nsoz_node_leff';

f=f2;
nsoz_node_leff=[];
[a,b]=find(f.e_l_spikes==0);
f.e_l_spikes(a)=[];
f.soz_array(a)=[];
f.patient_array(a)=[];

for i=1:numel(f.lambda)
    [a,b]=find(f.patient_array==i);
    if isempty(a)
        nsoz_node_leff(i)=NaN;
    else
        temp_1=f.soz_array(a);
        temp_2=f.e_l_spikes(a);        
        [c,d]=find(temp_1==0);
        temp_3=temp_2(c);
               
        [c,d]=find(temp_1==1);
        temp_4=temp_2(c);
        
        if isempty(temp_4)
            temp_4=0;
        end;
        
        if isempty(temp_3)
            temp_3=0;
        end;
        nsoz_node_leff(i)=nanmean(temp_3);
       
    end;
end;

f2.nsoz_node_leff_spikes=nsoz_node_leff';

f=f2;
nsoz_node_leff=[];
[a,b]=find(f.e_l_rons==0);
f.e_l_rons(a)=[];
f.soz_array(a)=[];
f.patient_array(a)=[];

for i=1:numel(f.lambda)
    [a,b]=find(f.patient_array==i);
    if isempty(a)
        nsoz_node_leff(i)=NaN;
    else
        temp_1=f.soz_array(a);
        temp_2=f.e_l_rons(a);        
        [c,d]=find(temp_1==0);
        temp_3=temp_2(c);
               
        [c,d]=find(temp_1==1);
        temp_4=temp_2(c);
        
        if isempty(temp_4)
            temp_4=0;
        end;
        
        if isempty(temp_3)
            temp_3=0;
        end;
        nsoz_node_leff(i)=nanmean(temp_3);
       
    end;
end;

f2.nsoz_node_leff_rons=nsoz_node_leff';

f=f2;
nsoz_node_leff=[];
[a,b]=find(f.e_l_rono==0);
f.e_l_rono(a)=[];
f.soz_array(a)=[];
f.patient_array(a)=[];

for i=1:numel(f.lambda)
    [a,b]=find(f.patient_array==i);
    if isempty(a)
        nsoz_node_leff(i)=NaN;
    else
        temp_1=f.soz_array(a);
        temp_2=f.e_l_rono(a);        
        [c,d]=find(temp_1==0);
        temp_3=temp_2(c);
               
        [c,d]=find(temp_1==1);
        temp_4=temp_2(c);
        
        if isempty(temp_4)
            temp_4=0;
        end;
        
        if isempty(temp_3)
            temp_3=0;
        end;
        nsoz_node_leff(i)=nanmean(temp_3);
       
    end;
end;

f2.nsoz_node_leff_rono=nsoz_node_leff';