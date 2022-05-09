function [tableIO006] = IO006foofind(alledges,FRpropertiesVr0306)

reversed=0;
tableIO006=[];

[idx,~]=find(alledges.patientvector==17);
edgesIO006=alledges(idx,:);

mod = py.importlib.import_module('foofind');
load('IO006J_sleep_11.mat')
block1chanlist=chanlist;
block1eeg=tall(eeg_data);
load('IO006J_sleep_12.mat')
block2chanlist=chanlist;
block2eeg=tall(eeg_data);
load('IO006J_sleep_13.mat')
block3chanlist=chanlist;
block3eeg=tall(eeg_data);
load('IO006J_sleep_14.mat')
block4chanlist=chanlist;
block4eeg=tall(eeg_data);
load('IO006J_sleep_15.mat')
block5chanlist=chanlist;
block5eeg=tall(eeg_data);
load('IO006J_sleep_16.mat')
block6chanlist=chanlist;
block6eeg=tall(eeg_data);

for j=1:numel(edgesIO006.patientvector)
    events_out=[];
    j
    temp=edgesIO006.chnameVector(j);
    if edgesIO006.mean_delay(j)>0
        ch1=temp{1}{1}{1};
        ch2=temp{1}{2}{1};
    else
        ch1=temp{1}{2}{1};
        ch2=temp{1}{1}{1};
    end

[idx,~]=find(FRpropertiesVr0306.FR_patient==17);
[idx2,~]=find(ismember(FRpropertiesVr0306.FR_electrode_1,ch1)==1);
[idx3,~]=find(ismember(FRpropertiesVr0306.FR_electrode_2,ch2)==1);
int1=intersect(idx2,idx3);
int2=intersect(int1,idx);

if isempty(int2)
    reversed=reversed+1;
    if edgesIO006.mean_delay(j)>0
        ch1=temp{1}{2}{1};
        ch2=temp{1}{1}{1};
    else
        ch1=temp{1}{1}{1};
        ch2=temp{1}{2}{1};
    end

[idx,~]=find(FRpropertiesVr0306.FR_patient==17);
[idx2,~]=find(ismember(FRpropertiesVr0306.FR_electrode_1,ch1)==1);
[idx3,~]=find(ismember(FRpropertiesVr0306.FR_electrode_2,ch2)==1);
int1=intersect(idx2,idx3);
int2=intersect(int1,idx);
end;

vtable=FRpropertiesVr0306(int2,:);
new_block=[];
for i=1:numel(vtable.FR_block)
    temp=vtable.FR_block(i);
    new_block(i)=str2num(temp{1});
end;
vtable.FR_block=new_block';

[idx,~]=find(vtable.FR_inout==0);
vtable=vtable(idx,:);

events=[];

%block 1
[idx,~]=find(vtable.FR_block==1);
events_t=vtable.FR_start_t(idx);

[~,outchan]=find(ismember(block1chanlist,ch1));
[~,inchan]=find(ismember(block1chanlist,ch2));

eeg=gather(block1eeg);
for i=1:numel(events_t)
    pts=round(events_t(i)*2000);
    if ((pts+1500) < 1200001)
        if ((pts-500) > 0)
            dataout=eeg(outchan,((pts-500):(pts+1500)));
            events_out=vertcat(events_out,dataout);
        else
            dataout=eeg(outchan,(1:2001));
            events_out=vertcat(events_out,dataout);
        end;
    else
        dataout=eeg(outchan,((1200000-2000):1200000));
        events_out=vertcat(events_out,dataout);
    end;   
end;

%block 2
[idx,~]=find(vtable.FR_block==2);
events_t=vtable.FR_start_t(idx);

[~,outchan]=find(ismember(block2chanlist,ch1));
[~,inchan]=find(ismember(block2chanlist,ch2));

eeg=gather(block2eeg);
for i=1:numel(events_t)
    pts=(round(events_t(i)*2000)-(600*2000));
    if ((pts+1500) < 1200001)
        if ((pts-500) > 0)
            dataout=eeg(outchan,((pts-500):(pts+1500)));
            events_out=vertcat(events_out,dataout);
        else
            dataout=eeg(outchan,(1:2001));
            events_out=vertcat(events_out,dataout);
        end;
    else
        dataout=eeg(outchan,((1200000-2000):1200000));
        events_out=vertcat(events_out,dataout);
    end;   
end;

%block 3
[idx,~]=find(vtable.FR_block==3);
events_t=vtable.FR_start_t(idx);

[~,outchan]=find(ismember(block3chanlist,ch1));
[~,inchan]=find(ismember(block3chanlist,ch2));

eeg=gather(block3eeg);
for i=1:numel(events_t)
    pts=(round(events_t(i)*2000)-(1200*2000));
    if ((pts+1500) < 1200001)
        if ((pts-500) > 0)
            dataout=eeg(outchan,((pts-500):(pts+1500)));
            events_out=vertcat(events_out,dataout);
        else
            dataout=eeg(outchan,(1:2001));
            events_out=vertcat(events_out,dataout);
        end;
    else
        dataout=eeg(outchan,((1200000-2000):1200000));
        events_out=vertcat(events_out,dataout);
    end;   
end;

%block 4
[idx,~]=find(vtable.FR_block==4);
events_t=vtable.FR_start_t(idx);

[~,outchan]=find(ismember(block4chanlist,ch1));
[~,inchan]=find(ismember(block4chanlist,ch2));

eeg=gather(block4eeg);
for i=1:numel(events_t)
    pts=(round(events_t(i)*2000)-(1800*2000));
    if ((pts+1500) < 1200001)
        if ((pts-500) > 0)
            dataout=eeg(outchan,((pts-500):(pts+1500)));
            events_out=vertcat(events_out,dataout);
        else
            dataout=eeg(outchan,(1:2001));
            events_out=vertcat(events_out,dataout);
        end;
    else
        dataout=eeg(outchan,((1200000-2000):1200000));
        events_out=vertcat(events_out,dataout);
    end;   
end;

[idx,~]=find(vtable.FR_block==5);
events_t=vtable.FR_start_t(idx);

[~,outchan]=find(ismember(block5chanlist,ch1));
[~,inchan]=find(ismember(block5chanlist,ch2));

eeg=gather(block5eeg);
for i=1:numel(events_t)
    pts=(round(events_t(i)*2000)-(2400*2000));
    if ((pts+1500) < 1200001)
        if ((pts-500) > 0)
            dataout=eeg(outchan,((pts-500):(pts+1500)));
            events_out=vertcat(events_out,dataout);
        else
            dataout=eeg(outchan,(1:2001));
            events_out=vertcat(events_out,dataout);
        end;
    else
        dataout=eeg(outchan,((1200000-2000):1200000));
        events_out=vertcat(events_out,dataout);
    end;   
end;

[idx,~]=find(vtable.FR_block==6);
events_t=vtable.FR_start_t(idx);

[~,outchan]=find(ismember(block6chanlist,ch1));
[~,inchan]=find(ismember(block6chanlist,ch2));

eeg=gather(block6eeg);
for i=1:numel(events_t)
    pts=(round(events_t(i)*2000)-(3000*2000));
    if ((pts+1500) < 1200001)
        if ((pts-500) > 0)
            dataout=eeg(outchan,((pts-500):(pts+1500)));
            events_out=vertcat(events_out,dataout);
        else
            dataout=eeg(outchan,(1:2001));
            events_out=vertcat(events_out,dataout);
        end;
    else
        dataout=eeg(outchan,((1200000-2000):1200000));
        events_out=vertcat(events_out,dataout);
    end;   
end;
test=mod.foofind(events_out)
offset=double(test)';
vtable=addvars(vtable,offset);
tableIO006=vertcat(tableIO006,vtable);
end;

