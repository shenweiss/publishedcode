function tjuIO018plots(alledges,FRpropertiesVr0306)

reversed=0;

ao_np_aperiodic=[];
ao_p_aperiodic=[];
ai_np_aperiodic=[];
ai_p_aperiodic=[];
ao_np_peak=[];
ao_p_peak=[];
ai_np_peak=[];
ai_p_peak=[];
ao_np_gauss=[];
ao_p_gauss=[];
ai_np_gauss=[];
ai_p_gauss=[];
ao_np_rsqr=[];
ao_p_rsqr=[];
ai_np_rsqr=[];
ai_p_rsqr=[];

abo_np_aperiodic=[];
abo_p_aperiodic=[];
abi_np_aperiodic=[];
abi_p_aperiodic=[];
abo_np_peak=[];
abo_p_peak=[];
abi_np_peak=[];
abi_p_peak=[];
abo_np_gauss=[];
abo_p_gauss=[];
abi_np_gauss=[];
abi_p_gauss=[];
abo_np_rsqr=[];
abo_p_rsqr=[];
abi_np_rsqr=[];
abi_p_rsqr=[];

[idx,~]=find(alledges.patientvector==22);
edgesIO018=alledges(idx,:);

mod = py.importlib.import_module('part2foof');
load('IO018Js_allmp1.mat')
block1chanlist=chanlist;
block1eeg=tall(eeg_data);
load('IO018Js_allmp2.mat')
block2chanlist=chanlist;
block2eeg=tall(eeg_data);
load('IO018Js_allmp4.mat')
block3chanlist=chanlist;
block3eeg=tall(eeg_data);
load('IO018Js_allmp5.mat')
block4chanlist=chanlist;
block4eeg=tall(eeg_data);

j=2;
    temp=edgesIO018.chnameVector(j);
    if edgesIO018.mean_delay(j)>0
        ch1=temp{1}{1}{1};
        ch2=temp{1}{2}{1};
    else
        ch1=temp{1}{2}{1};
        ch2=temp{1}{1}{1};
    end

[idx,~]=find(FRpropertiesVr0306.FR_patient==22);
[idx2,~]=find(ismember(FRpropertiesVr0306.FR_electrode_1,ch1)==1);
[idx3,~]=find(ismember(FRpropertiesVr0306.FR_electrode_2,ch2)==1);
int1=intersect(idx2,idx3);
int2=intersect(int1,idx);

if isempty(int2)
    reversed=reversed+1;
    if edgesIO018.mean_delay(j)>0
        ch1=temp{1}{2}{1};
        ch2=temp{1}{1}{1};
    else
        ch1=temp{1}{1}{1};
        ch2=temp{1}{2}{1};
    end

[idx,~]=find(FRpropertiesVr0306.FR_patient==22);
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

events_in=[];
events_in_g350=[];
events_in_l350=[];
events_in_np=[];
events_in_p=[];
events_out=[];
events_out_g350=[];
events_out_l350=[];
events_out_np=[];
events_out_p=[];

b_events_in=[];
b_events_in_np=[];
b_events_in_p=[];
b_events_out=[];
b_events_out_np=[];
b_events_out_p=[];


%block 1
[idx,~]=find(vtable.FR_inout==0);
[idx2,~]=find(vtable.FR_block==1);
[int1]=intersect(idx,idx2);
events_out_1t=vtable.FR_start_t(int1);
[idx3,~]=find(vtable.FR_sign==0);
[int2]=intersect(int1,idx3);
events_out_np_1t=vtable.FR_start_t(int2);
[idx4,~]=find(vtable.FR_sign==1);
[int3]=intersect(int1,idx4);
events_out_p_1t=vtable.FR_start_t(int3);
[idx5,~]=find(vtable.FR_freqs>350);
[int4]=intersect(idx5,int1);
events_out_g350_1t=vtable.FR_start_t(int4);
[idx6,~]=find(vtable.FR_freqs<350);
[int5]=intersect(idx6,int1);
events_out_l350_1t=vtable.FR_start_t(int5);

[~,outchan]=find(ismember(block1chanlist,ch1));
[~,inchan]=find(ismember(block1chanlist,ch2));

eeg=gather(block1eeg);
for i=1:numel(events_out_1t)
    pts=round(events_out_1t(i)*2000);
    if ((pts+1500) < 1200001)
        if ((pts-500) > 0)
            dataout=eeg(outchan,((pts-500):(pts+1500)));
            datain=eeg(inchan,((pts-500):(pts+1500)));
            events_out=vertcat(events_out,dataout);
            events_in=vertcat(events_in, datain);
        end;
    end;
    if ((pts-2500) > 0)
           dataout=eeg(outchan,((pts-2500):(pts-500)));
           datain=eeg(inchan,((pts-2500):(pts-500)));
           b_events_out=vertcat(b_events_out,dataout);
           b_events_in=vertcat(b_events_in,datain);
    end;
end;

for i=1:numel(events_out_g350_1t)
    pts=round(events_out_g350_1t(i)*2000);
    if ((pts+1500) < 1200001)
        if ((pts-500) > 0)
            dataout=eeg(outchan,((pts-500):(pts+1500)));
            datain=eeg(inchan,((pts-500):(pts+1500)));
            events_out_g350=vertcat(events_out_g350,dataout);
            events_in_g350=vertcat(events_in_g350, datain);
        end;
    end;
end;

for i=1:numel(events_out_l350_1t)
    pts=round(events_out_l350_1t(i)*2000);
    dataout=eeg(outchan,((pts-500):(pts+1500)));
    datain=eeg(inchan,((pts-500):(pts+1500)));
    events_out_l350=vertcat(events_out_l350,dataout);
    events_in_l350=vertcat(events_in_l350, datain);
end;

for i=1:numel(events_out_p_1t)
    pts=round(events_out_p_1t(i)*2000);
    if ((pts+1500) < 1200001)
        if ((pts-500) > 0)
            dataout=eeg(outchan,((pts-500):(pts+1500)));
            dataout_t=eeg((outchan+1),((pts-500):(pts+1500)));
            dataout=dataout-dataout_t;
            datain=eeg(inchan,((pts-500):(pts+1500)));
            datain_t=eeg((inchan+1),((pts-500):(pts+1500)));
            datain=datain-datain_t;
            events_out_p=vertcat(events_out_p,dataout);
            events_in_p=vertcat(events_in_p, datain);
        end;
    end;
    if ((pts-2500) > 0)
           dataout=eeg(outchan,((pts-2500):(pts-500)));
           datain=eeg(inchan,((pts-2500):(pts-500)));
           b_events_out_p=vertcat(b_events_out_p,dataout);
           b_events_in_p=vertcat(b_events_in_p,datain);
    end;
end;

for i=1:numel(events_out_np_1t)
    pts=round(events_out_np_1t(i)*2000);
    if ((pts+1500) < 1200001)
        if ((pts-500) > 0)
            dataout=eeg(outchan,((pts-500):(pts+1500)));
            dataout_t=eeg((outchan+1),((pts-500):(pts+1500)));
            dataout=dataout-dataout_t;
            datain=eeg(inchan,((pts-500):(pts+1500)));
            datain_t=eeg((inchan+1),((pts-500):(pts+1500)));
            datain=datain-datain_t;
            events_out_np=vertcat(events_out_np,dataout);
            events_in_np=vertcat(events_in_np, datain);
        end;
    end;
    if ((pts-2500) > 0)
           dataout=eeg(outchan,((pts-2500):(pts-500)));
           datain=eeg(inchan,((pts-2500):(pts-500)));
           b_events_out_np=vertcat(b_events_out_np,dataout);
           b_events_in_np=vertcat(b_events_in_np,datain);
    end;
end;

%block 2
[idx,~]=find(vtable.FR_inout==0);
[idx2,~]=find(vtable.FR_block==2);
[int1]=intersect(idx,idx2);
events_out_1t=vtable.FR_start_t(int1);
[idx3,~]=find(vtable.FR_sign==0);
[int2]=intersect(int1,idx3);
events_out_np_1t=vtable.FR_start_t(int2);
[idx4,~]=find(vtable.FR_sign==1);
[int3]=intersect(int1,idx4);
events_out_p_1t=vtable.FR_start_t(int3);
[idx5,~]=find(vtable.FR_freqs>350);
[int4]=intersect(idx5,int1);
events_out_g350_1t=vtable.FR_start_t(int4);
[idx6,~]=find(vtable.FR_freqs<350);
[int5]=intersect(idx6,int1);
events_out_l350_1t=vtable.FR_start_t(int5);

[~,outchan]=find(ismember(block2chanlist,ch1));
[~,inchan]=find(ismember(block2chanlist,ch2));

eeg=gather(block2eeg);
for i=1:numel(events_out_1t)
    pts=(round(events_out_1t(i)*2000)-(600*2000));
    if ((pts+1500) < 1200001)
        if ((pts-500) > 0)
            dataout=eeg(outchan,((pts-500):(pts+1500)));
            datain=eeg(inchan,((pts-500):(pts+1500)));
            events_out=vertcat(events_out,dataout);
            events_in=vertcat(events_in, datain);
        end;
    end;
    if ((pts-2500) > 0)
           dataout=eeg(outchan,((pts-2500):(pts-500)));
           datain=eeg(inchan,((pts-2500):(pts-500)));
           b_events_out=vertcat(b_events_out,dataout);
           b_events_in=vertcat(b_events_in,datain);
    end;
end;

for i=1:numel(events_out_g350_1t)
    pts=(round(events_out_g350_1t(i)*2000)-(600*2000));
    if ((pts+1500) < 1200001)
        if ((pts-500) > 0)
            dataout=eeg(outchan,((pts-500):(pts+1500)));
            datain=eeg(inchan,((pts-500):(pts+1500)));
            events_out_g350=vertcat(events_out_g350,dataout);
            events_in_g350=vertcat(events_in_g350, datain);
        end;
    end;
end;

for i=1:numel(events_out_l350_1t)
    pts=(round(events_out_l350_1t(i)*2000)-(600*2000));
    if ((pts+1500) < 1200001)
        if ((pts-500) > 0)
            dataout=eeg(outchan,((pts-500):(pts+1500)));
            datain=eeg(inchan,((pts-500):(pts+1500)));
            events_out_l350=vertcat(events_out_l350,dataout);
            events_in_l350=vertcat(events_in_l350, datain);
        end;
    end;
end;

for i=1:numel(events_out_p_1t)
    pts=(round(events_out_p_1t(i)*2000)-(600*2000));
    if ((pts+1500) < 1200001)
        if ((pts-500) > 0)
            dataout=eeg(outchan,((pts-500):(pts+1500)));
            dataout_t=eeg((outchan+1),((pts-500):(pts+1500)));
            dataout=dataout-dataout_t;
            datain=eeg(inchan,((pts-500):(pts+1500)));
            datain_t=eeg((inchan+1),((pts-500):(pts+1500)));
            datain=datain-datain_t;
            events_out_p=vertcat(events_out_p,dataout);
            events_in_p=vertcat(events_in_p, datain);
        end;
    end;
    if ((pts-2500) > 0)
           dataout=eeg(outchan,((pts-2500):(pts-500)));
           datain=eeg(inchan,((pts-2500):(pts-500)));
           b_events_out_p=vertcat(b_events_out_p,dataout);
           b_events_in_p=vertcat(b_events_in_p,datain);
    end;
end;

for i=1:numel(events_out_np_1t)
    pts=(round(events_out_np_1t(i)*2000)-(600*2000));
    if ((pts+1500) < 1200001)
        if ((pts-500) > 0)
            dataout=eeg(outchan,((pts-500):(pts+1500)));
            dataout_t=eeg((outchan+1),((pts-500):(pts+1500)));
            dataout=dataout-dataout_t;
            datain=eeg(inchan,((pts-500):(pts+1500)));
            datain_t=eeg((inchan+1),((pts-500):(pts+1500)));
            datain=datain-datain_t;
            events_out_np=vertcat(events_out_np,dataout);
            events_in_np=vertcat(events_in_np, datain);
        end;
    end;
    if ((pts-2500) > 0)
           dataout=eeg(outchan,((pts-2500):(pts-500)));
           datain=eeg(inchan,((pts-2500):(pts-500)));
           b_events_out_np=vertcat(b_events_out_np,dataout);
           b_events_in_np=vertcat(b_events_in_np,datain);
    end;
end;

%block 3
[idx,~]=find(vtable.FR_inout==0);
[idx2,~]=find(vtable.FR_block==4);
[int1]=intersect(idx,idx2);
events_out_1t=vtable.FR_start_t(int1);
[idx3,~]=find(vtable.FR_sign==0);
[int2]=intersect(int1,idx3);
events_out_np_1t=vtable.FR_start_t(int2);
[idx4,~]=find(vtable.FR_sign==1);
[int3]=intersect(int1,idx4);
events_out_p_1t=vtable.FR_start_t(int3);
[idx5,~]=find(vtable.FR_freqs>350);
[int4]=intersect(idx5,int1);
events_out_g350_1t=vtable.FR_start_t(int4);
[idx6,~]=find(vtable.FR_freqs<350);
[int5]=intersect(idx6,int1);
events_out_l350_1t=vtable.FR_start_t(int5);

[~,outchan]=find(ismember(block3chanlist,ch1));
[~,inchan]=find(ismember(block3chanlist,ch2));

eeg=gather(block3eeg);
for i=1:numel(events_out_1t)
    pts=(round(events_out_1t(i)*2000)-(1200*2000));
    if ((pts+1500) < 1200001)
        if ((pts-500) > 0)
            dataout=eeg(outchan,((pts-500):(pts+1500)));
            datain=eeg(inchan,((pts-500):(pts+1500)));
            events_out=vertcat(events_out,dataout);
            events_in=vertcat(events_in, datain);
        end;
    end;
    if ((pts-2500) > 0)
           dataout=eeg(outchan,((pts-2500):(pts-500)));
           datain=eeg(inchan,((pts-2500):(pts-500)));
           b_events_out=vertcat(b_events_out,dataout);
           b_events_in=vertcat(b_events_in,datain);
    end;
end;

for i=1:numel(events_out_g350_1t)
    pts=(round(events_out_g350_1t(i)*2000)-(1200*2000));
    if ((pts+1500) < 1200001)
        if ((pts-500) > 0)
            dataout=eeg(outchan,((pts-500):(pts+1500)));
            datain=eeg(inchan,((pts-500):(pts+1500)));
            events_out_g350=vertcat(events_out_g350,dataout);
            events_in_g350=vertcat(events_in_g350, datain);
        end;
    end;
end;

for i=1:numel(events_out_l350_1t)
    pts=(round(events_out_l350_1t(i)*2000)-(1200*2000));
    if ((pts+1500) < 1200001)
        if ((pts-500) > 0)
            dataout=eeg(outchan,((pts-500):(pts+1500)));
            datain=eeg(inchan,((pts-500):(pts+1500)));
            events_out_l350=vertcat(events_out_l350,dataout);
            events_in_l350=vertcat(events_in_l350, datain);
        end;
    end;
end;

for i=1:numel(events_out_p_1t)
    pts=(round(events_out_p_1t(i)*2000)-(1200*2000));
    if ((pts+1500) < 1200001)
        if ((pts-500) > 0)
            dataout=eeg(outchan,((pts-500):(pts+1500)));
            dataout_t=eeg((outchan+1),((pts-500):(pts+1500)));
            dataout=dataout-dataout_t;
            datain=eeg(inchan,((pts-500):(pts+1500)));
            datain_t=eeg((inchan+1),((pts-500):(pts+1500)));
            datain=datain-datain_t;
            events_out_p=vertcat(events_out_p,dataout);
            events_in_p=vertcat(events_in_p, datain);
        end;
    end;
    if ((pts-2500) > 0)
           dataout=eeg(outchan,((pts-2500):(pts-500)));
           datain=eeg(inchan,((pts-2500):(pts-500)));
           b_events_out_p=vertcat(b_events_out_p,dataout);
           b_events_in_p=vertcat(b_events_in_p,datain);
    end;
end;

for i=1:numel(events_out_np_1t)
    pts=(round(events_out_np_1t(i)*2000)-(1200*2000));
    if ((pts+1500) < 1200001)
        if ((pts-500) > 0)
            dataout=eeg(outchan,((pts-500):(pts+1500)));
            dataout_t=eeg((outchan+1),((pts-500):(pts+1500)));
            dataout=dataout-dataout_t;
            datain=eeg(inchan,((pts-500):(pts+1500)));
            datain_t=eeg((inchan+1),((pts-500):(pts+1500)));
            datain=datain-datain_t;
            events_out_np=vertcat(events_out_np,dataout);
            events_in_np=vertcat(events_in_np, datain);
        end;
    end;
    if ((pts-2500) > 0)
           dataout=eeg(outchan,((pts-2500):(pts-500)));
           datain=eeg(inchan,((pts-2500):(pts-500)));
           b_events_out_np=vertcat(b_events_out_np,dataout);
           b_events_in_np=vertcat(b_events_in_np,datain);
    end;
end;

%block 4
[idx,~]=find(vtable.FR_inout==0);
[idx2,~]=find(vtable.FR_block==5);
[int1]=intersect(idx,idx2);
events_out_1t=vtable.FR_start_t(int1);
[idx3,~]=find(vtable.FR_sign==0);
[int2]=intersect(int1,idx3);
events_out_np_1t=vtable.FR_start_t(int2);
[idx4,~]=find(vtable.FR_sign==1);
[int3]=intersect(int1,idx4);
events_out_p_1t=vtable.FR_start_t(int3);
[idx5,~]=find(vtable.FR_freqs>350);
[int4]=intersect(idx5,int1);
events_out_g350_1t=vtable.FR_start_t(int4);
[idx6,~]=find(vtable.FR_freqs<350);
[int5]=intersect(idx6,int1);
events_out_l350_1t=vtable.FR_start_t(int5);

[~,outchan]=find(ismember(block4chanlist,ch1));
[~,inchan]=find(ismember(block4chanlist,ch2));

eeg=gather(block4eeg);
for i=1:numel(events_out_1t)
    pts=(round(events_out_1t(i)*2000)-(1800*2000));
    if ((pts+1500) < 1200001)
        if ((pts-500) > 0)
            dataout=eeg(outchan,((pts-500):(pts+1500)));
            datain=eeg(inchan,((pts-500):(pts+1500)));
            events_out=vertcat(events_out,dataout);
            events_in=vertcat(events_in, datain);
        end;
    end;
    if ((pts-2500) > 0)
           dataout=eeg(outchan,((pts-2500):(pts-500)));
           datain=eeg(inchan,((pts-2500):(pts-500)));
           b_events_out=vertcat(b_events_out,dataout);
           b_events_in=vertcat(b_events_in,datain);
    end;
end;

for i=1:numel(events_out_g350_1t)
    pts=(round(events_out_g350_1t(i)*2000)-(1800*2000));
    if ((pts+1500) < 1200001)
        if ((pts-500) > 0)
            dataout=eeg(outchan,((pts-500):(pts+1500)));
            datain=eeg(inchan,((pts-500):(pts+1500)));
            events_out_g350=vertcat(events_out_g350,dataout);
            events_in_g350=vertcat(events_in_g350, datain);
        end;
    end;
end;

for i=1:numel(events_out_l350_1t)
    pts=(round(events_out_l350_1t(i)*2000)-(1800*2000));
    if ((pts+1500) < 1200001)
        if ((pts-500) > 0)
            dataout=eeg(outchan,((pts-500):(pts+1500)));
            datain=eeg(inchan,((pts-500):(pts+1500)));
            events_out_l350=vertcat(events_out_l350,dataout);
            events_in_l350=vertcat(events_in_l350, datain);
        end;
    end;
end;

for i=1:numel(events_out_p_1t)
    pts=(round(events_out_p_1t(i)*2000)-(1800*2000));
    if ((pts+1500) < 1200001)
        if ((pts-500) > 0)
            dataout=eeg(outchan,((pts-500):(pts+1500)));
            dataout_t=eeg((outchan+1),((pts-500):(pts+1500)));
            dataout=dataout-dataout_t;
            datain=eeg(inchan,((pts-500):(pts+1500)));
            datain_t=eeg((inchan+1),((pts-500):(pts+1500)));
            datain=datain-datain_t;
            events_out_p=vertcat(events_out_p,dataout);
            events_in_p=vertcat(events_in_p, datain);
        end;
    end;
    if ((pts-2500) > 0)
           dataout=eeg(outchan,((pts-2500):(pts-500)));
           datain=eeg(inchan,((pts-2500):(pts-500)));
           b_events_out_p=vertcat(b_events_out_p,dataout);
           b_events_in_p=vertcat(b_events_in_p,datain);
    end;
end;

for i=1:numel(events_out_np_1t)
    pts=(round(events_out_np_1t(i)*2000)-(1800*2000));
    if ((pts+1500) < 1200001)
        if ((pts-500) > 0)
            dataout=eeg(outchan,((pts-500):(pts+1500)));
            dataout_t=eeg((outchan+1),((pts-500):(pts+1500)));
            dataout=dataout-dataout_t;
            datain=eeg(inchan,((pts-500):(pts+1500)));
            datain_t=eeg((inchan+1),((pts-500):(pts+1500)));
            datain=datain-datain_t;
            events_out_np=vertcat(events_out_np,dataout);
            events_in_np=vertcat(events_in_np, datain);
        end;
    end;
    if ((pts-2500) > 0)
           dataout=eeg(outchan,((pts-2500):(pts-500)));
           datain=eeg(inchan,((pts-2500):(pts-500)));
           b_events_out_np=vertcat(b_events_out_np,dataout);
           b_events_in_np=vertcat(b_events_in_np,datain);
    end;
end;
figtitle='IO018';
crossmodulation_mod(events_in_np, events_in_p, events_out_np, events_out_p, figtitle);
save('IO018foofexample.mat','events_in_np', 'events_in_p', 'events_out_np', 'events_out_p')
