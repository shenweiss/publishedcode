function [f2] = calc_node_strength(f)

f2=f;
% fast ripple > 350 Hz
nsoz_node_strength=[];
[a,b]=find(f.strength==0);
f.strength(a)=[];
f.soz_array(a)=[];
f.patient_array(a)=[];

for i=1:numel(f.lambda)
    [a,b]=find(f.patient_array==i);
    if isempty(a)
        nsoz_node_strength(i)=NaN;
    else
        temp_1=f.soz_array(a);
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
        
        nsoz_node_strength(i)=nansum(temp_4)-nansum(temp_3);
    end;
end;
f2.strength_diff=nsoz_node_strength';

% all fast ripple
f=f2;
nsoz_node_strength=[];
[a,b]=find(f.strength_frippleall==0);
f.strength_frippleall(a)=[];
f.soz_array(a)=[];
f.patient_array(a)=[];

for i=1:numel(f.lambda)
    [a,b]=find(f.patient_array==i);
    if isempty(a)
        nsoz_node_strength(i)=NaN;
    else
        temp_1=f.soz_array(a);
        temp_2=f.strength_frippleall(a);        
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
        
        nsoz_node_strength(i)=nansum(temp_4)-nansum(temp_3);
    end;
end;
f2.strength_diff_frippleall=nsoz_node_strength';

% spikes
f=f2;
nsoz_node_strength=[];
[a,b]=find(f.strength_spikes==0);
f.strength_spikes(a)=[];
f.soz_array(a)=[];
f.patient_array(a)=[];

for i=1:numel(f.lambda)
    [a,b]=find(f.patient_array==i);
    if isempty(a)
        nsoz_node_strength(i)=NaN;
    else
        temp_1=f.soz_array(a);
        temp_2=f.strength_spikes(a);        
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
        
        nsoz_node_strength(i)=nansum(temp_4)-nansum(temp_3);
    end;
end;
f2.strength_diff_spikes=nsoz_node_strength';

% RonS
f=f2;
nsoz_node_strength=[];
[a,b]=find(f.strength_rons==0);
f.strength_rons(a)=[];
f.soz_array(a)=[];
f.patient_array(a)=[];

for i=1:numel(f.lambda)
    [a,b]=find(f.patient_array==i);
    if isempty(a)
        nsoz_node_strength(i)=NaN;
    else
        temp_1=f.soz_array(a);
        temp_2=f.strength_rons(a);        
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
        
        nsoz_node_strength(i)=nansum(temp_4)-nansum(temp_3);
    end;
end;
f2.strength_diff_rons=nsoz_node_strength';

% RonO
f=f2;
nsoz_node_strength=[];
[a,b]=find(f.strength_rono==0);
f.strength_rono(a)=[];
f.soz_array(a)=[];
f.patient_array(a)=[];

for i=1:numel(f.lambda)
    [a,b]=find(f.patient_array==i);
    if isempty(a)
        nsoz_node_strength(i)=NaN;
    else
        temp_1=f.soz_array(a);
        temp_2=f.strength_rono(a);        
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
        
        nsoz_node_strength(i)=nansum(temp_4)-nansum(temp_3);
    end;
end;
f2.strength_diff_rono=nsoz_node_strength';