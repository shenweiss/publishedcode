function [f2] = calc_localmeasures(f)

f2=f;
f_backup=f;
nonresected_whole_leff_mean=[];
nonresected_whole_leff_max=[];
[a,b]=find(f.e_l==0);
f.e_l(a)=[];
f.resected_array(a)=[];
f.patient_array(a)=[];

for i=1:numel(f.lambda)
    [a,b]=find(f.patient_array==i);
    if isempty(a)
        nonresected_whole_leff_mean(i)=NaN;
        nonresected_whole_leff_max(i)=NaN;
    else
        temp_1=f.resected_array(a);
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
        nonresected_whole_leff_mean(i)=nanmean(temp_3);
        nonresected_whole_leff_max(i)=max(temp_3);
    end;
end;

f=f_backup;
nonresected_ur_leff_mean=[];
nonresected_ur_leff_max=[];
[a,b]=find(f.e_l_nr==0);
f.e_l_nr(a)=[];
f.resected_array(a)=[];
f.patient_array(a)=[];
for i=1:numel(f.lambda)
    [a,b]=find(f.patient_array==i);
    if isempty(a)
        nonresected_ur_leff_mean(i)=NaN;
        nonresected_ur_leff_max(i)=NaN;
    else
        temp_1=f.resected_array(a);
        temp_2=f.e_l_nr(a);        
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
        nonresected_ur_leff_mean(i)=nanmean(temp_3);
        nonresected_ur_leff_max(i)=max(temp_3);
    end;
end;

% to here
f=f_backup;
nonresected_whole_leff_mean_uw=[];
nonresected_whole_leff_max_uw=[];
[a,b]=find(f.e_l_uw==0);
f.e_l_uw(a)=[];
f.resected_array(a)=[];
f.patient_array(a)=[];
for i=1:numel(f.lambda)
    [a,b]=find(f.patient_array==i);
    if isempty(a)
        nonresected_whole_leff_mean_uw(i)=NaN;
        nonresected_whole_leff_max_uw(i)=NaN;
    else
        temp_1=f.resected_array(a);
        temp_2=f.e_l_uw(a);        
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
        nonresected_whole_leff_mean_uw(i)=nanmean(temp_3);
        nonresected_whole_leff_max_uw(i)=max(temp_3);
    end;
end;

f=f_backup;
nonresected_ur_leff_mean_uw=[];
nonresected_ur_leff_max_uw=[];
[a,b]=find(f.e_l_uw_nr==0);
f.e_l_uw_nr(a)=[];
f.resected_array(a)=[];
f.patient_array(a)=[];
for i=1:numel(f.lambda)
    [a,b]=find(f.patient_array==i);
    if isempty(a)
        nonresected_ur_leff_mean_uw(i)=NaN;
        nonresected_ur_leff_max_uw(i)=NaN;
    else
        temp_1=f.resected_array(a);
        temp_2=f.e_l_uw_nr(a);        
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
        nonresected_ur_leff_mean_uw(i)=nanmean(temp_3);
        nonresected_ur_leff_max_uw(i)=max(temp_3);
    end;
end;

f=f_backup;
nonresected_whole_str_mean=[];
nonresected_whole_str_max=[];
[a,b]=find(f.strength==0);
f.strength(a)=[];
f.resected_array(a)=[];
f.patient_array(a)=[];

for i=1:numel(f.lambda)
    [a,b]=find(f.patient_array==i);
    if isempty(a)
        nonresected_whole_str_mean(i)=NaN;
        nonresected_whole_str_max(i)=NaN;
    else
        temp_1=f.resected_array(a);
        temp_2=f.strength(a);        
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
        nonresected_whole_str_mean(i)=nanmean(temp_3);
        nonresected_whole_str_max(i)=max(temp_3);
    end;
end;

f=f_backup;
nonresected_ur_str_mean=[];
nonresected_ur_str_max=[];
[a,b]=find(f.strength_nr==0);
f.strength_nr(a)=[];
f.resected_array(a)=[];
f.patient_array(a)=[];
for i=1:numel(f.lambda)
    [a,b]=find(f.patient_array==i);
    if isempty(a)
        nonresected_ur_str_mean(i)=NaN;
        nonresected_ur_str_max(i)=NaN;
    else
        temp_1=f.resected_array(a);
        temp_2=f.strength_nr(a);        
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
        nonresected_ur_str_mean(i)=nanmean(temp_3);
        nonresected_ur_str_max(i)=max(temp_3);
    end;
end;

f=f_backup;
nonresected_whole_cc_mean=[];
nonresected_whole_cc_max=[];
[a,b]=find(f.cC==0);
f.cC(a)=[];
f.resected_array(a)=[];
f.patient_array(a)=[];

for i=1:numel(f.lambda)
    [a,b]=find(f.patient_array==i);
    if isempty(a)
        nonresected_whole_cc_mean(i)=NaN;
        nonresected_whole_cc_max(i)=NaN;
    else
        temp_1=f.resected_array(a);
        temp_2=f.cC(a);        
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
        nonresected_whole_cc_mean(i)=nanmean(temp_3);
        nonresected_whole_cc_max(i)=max(temp_3);
    end;
end;

f=f_backup;
nonresected_ur_cc_mean=[];
nonresected_ur_cc_max=[];
[a,b]=find(f.cC_nr==0);
f.cC_nr(a)=[];
f.resected_array(a)=[];
f.patient_array(a)=[];
for i=1:numel(f.lambda)
    [a,b]=find(f.patient_array==i);
    if isempty(a)
        nonresected_ur_cc_mean(i)=NaN;
        nonresected_ur_cc_max(i)=NaN;
    else
        temp_1=f.resected_array(a);
        temp_2=f.cC_nr(a);        
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
        nonresected_ur_cc_mean(i)=nanmean(temp_3);
        nonresected_ur_cc_max(i)=max(temp_3);
    end;
end;

f=f_backup;
nonresected_whole_cc_mean_uw=[];
nonresected_whole_cc_max_uw=[];
[a,b]=find(f.cC_uw==0);
f.cC_uw(a)=[];
f.resected_array(a)=[];
f.patient_array(a)=[];

for i=1:numel(f.lambda)
    [a,b]=find(f.patient_array==i);
    if isempty(a)
        nonresected_whole_cc_mean_uw(i)=NaN;
        nonresected_whole_cc_max_uw(i)=NaN;
    else
        temp_1=f.resected_array(a);
        temp_2=f.cC_uw(a);        
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
        nonresected_whole_cc_mean_uw(i)=nanmean(temp_3);
        nonresected_whole_cc_max_uw(i)=max(temp_3);
    end;
end;

f=f_backup;
nonresected_whole_cent_mean=[];
nonresected_whole_cent_max=[];
[a,b]=find(f.Cnt==0);
f.Cnt(a)=[];
f.resected_array(a)=[];
f.patient_array(a)=[];

for i=1:numel(f.lambda)
    [a,b]=find(f.patient_array==i);
    if isempty(a)
        nonresected_whole_cent_mean(i)=NaN;
        nonresected_whole_cent_max(i)=NaN;
    else
        temp_1=f.resected_array(a);
        temp_2=f.Cnt(a);        
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
        nonresected_whole_cent_mean(i)=nanmean(temp_3);
        nonresected_whole_cent_max(i)=max(temp_3);
    end;
end;

f=f_backup;
nonresected_ur_cent_mean=[];
nonresected_ur_cent_max=[];
[a,b]=find(f.Cnt_nr==0);
f.Cnt_nr(a)=[];
f.resected_array(a)=[];
f.patient_array(a)=[];
for i=1:numel(f.lambda)
    [a,b]=find(f.patient_array==i);
    if isempty(a)
        nonresected_ur_cent_mean(i)=NaN;
        nonresected_ur_cent_max(i)=NaN;
    else
        temp_1=f.resected_array(a);
        temp_2=f.Cnt_nr(a);        
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
        nonresected_ur_cent_mean(i)=nanmean(temp_3);
        nonresected_ur_cent_max(i)=max(temp_3);
    end;
end;

f2.nonresected_whole_leff_mean=nonresected_whole_leff_mean;
f2.nonresected_whole_leff_max=nonresected_whole_leff_max;
f2.nonresected_ur_leff_mean=nonresected_ur_leff_mean;
f2.nonresected_ur_leff_max=nonresected_ur_leff_max;

f2.nonresected_whole_leff_mean_uw=nonresected_whole_leff_mean_uw;
f2.nonresected_whole_leff_max_uw=nonresected_whole_leff_max_uw;
f2.nonresected_ur_leff_mean_uw=nonresected_ur_leff_mean_uw;
f2.nonresected_ur_leff_max_uw=nonresected_ur_leff_max_uw;

f2.nonresected_whole_str_mean=nonresected_whole_str_mean;
f2.nonresected_whole_str_max=nonresected_whole_str_max;
f2.nonresected_ur_str_mean=nonresected_ur_str_mean;
f2.nonresected_ur_str_max=nonresected_ur_str_max;

f2.nonresected_whole_cc_mean=nonresected_whole_cc_mean;
f2.nonresected_whole_cc_max=nonresected_whole_cc_max;
f2.nonresected_ur_cc_mean=nonresected_ur_cc_mean;
f2.nonresected_ur_cc_max=nonresected_ur_cc_max;

f2.nonresected_whole_cc_mean_uw=nonresected_whole_cc_mean_uw;
f2.nonresected_whole_cc_max_uw=nonresected_whole_cc_max_uw;

f2.nonresected_whole_cent_mean=nonresected_whole_cent_mean;
f2.nonresected_whole_cent_max=nonresected_whole_cent_max;
f2.nonresected_ur_cent_mean=nonresected_ur_cent_mean;
f2.nonresected_ur_cent_max=nonresected_ur_cent_max;