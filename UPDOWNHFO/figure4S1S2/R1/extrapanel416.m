test_query=['{"patient_id":"416","electrode":"LEC" }']; 
HFO = find(conn,collection,'Query',test_query);
            start_t=[];
            slowangle_t=[];
            parfor j=1:numel(HFO(:,1))
                start_t(j)=getfield(HFO,{j},'start_t');
                slowangle_t(j)=getfield(HFO,{j},'slow_angle');
            end;
            maxUP=output_t_maxR.maxUP(9);
            tempangles=slowangle_t;
            tempangles_sub=[];
            for m=1:numel(tempangles)
                tempangles_sub(m)=subrad_sw(maxUP,tempangles(m));
            end;
            slowangle_t=tempangles_sub; 
            lphg_t=start_t;
            lphg_theta=slowangle_t;
test_query=['{"patient_id":"416","electrode":"LAH" }']; 
HFO = find(conn,collection,'Query',test_query);
            start_t=[];
            slowangle_t=[];
            parfor j=1:numel(HFO(:,1))
                start_t(j)=getfield(HFO,{j},'start_t');
                slowangle_t(j)=getfield(HFO,{j},'slow_angle');
            end;
            maxUP=output_t_maxR.maxUP(8);
            tempangles=slowangle_t;
            tempangles_sub=[];            
            for m=1:numel(tempangles)
                tempangles_sub(m)=subrad_sw(maxUP,tempangles(m));
            end;
            slowangle_t=tempangles_sub; 
            lah_t=start_t;
            lah_theta=slowangle_t;
[idx]=find(lphg_theta>0);
lphg_t_du=lphg_t(idx);
[idx]=find(lphg_theta<0);
lphg_t_ud=lphg_t(idx);
[idx]=find(lah_theta>0);
lah_t_du=lah_t(idx);
[idx]=find(lah_theta<0);
lah_t_ud=lah_t(idx);
raster_temp=zeros(1,15000000);
raster_lphg_du=raster_temp;
raster_lphg=raster_temp;
for i=1:numel(lphg_t)
    temp=round(lphg_t(i),3);
    temp=temp*1000;
    temp=round(temp,0);
    raster_lphg(temp)=1;
end;
raster_lah=raster_temp;
for i=1:numel(lah_t)
    temp=round(lah_t(i),3);
    temp=temp*1000;
    temp=round(temp,0);
    raster_lah(temp)=1;
end;
for i=1:numel(lphg_t_du)
    temp=round(lphg_t_du(i),3);
    temp=temp*1000;
    temp=round(temp,0);
    raster_lphg_du(temp)=1;
end;
raster_lphg_ud=raster_temp;
for i=1:numel(lphg_t_ud)
    temp=round(lphg_t_ud(i),3);
    temp=temp*1000;
    temp=round(temp,0);
    raster_lphg_ud(temp)=1;
end;
raster_lah_du=raster_temp;
for i=1:numel(lah_t_du)
    temp=round(lah_t_du(i),3);
    temp=temp*1000;
    temp=round(temp,0);
    raster_lah_du(temp)=1;
end;
raster_lah_ud=raster_temp;
for i=1:numel(lah_t_ud)
    temp=round(lah_t_ud(i),3);
    temp=temp*1000;
    temp=round(temp,0);
    raster_lah_ud(temp)=1;
end;
[c,lags] = xcorr(raster_lphg,raster_lah,'normalize');
figure
bar(lags(14999500:15000500),c(14999500:15000500),'green')
title('LEC SOZ ALL')
ylim([0 .025])
[c,lags] = xcorr(raster_lphg_du,raster_lah_du,'normalize');
midway = round(numel(c)/2);
val1 = max(c((midway-50):(midway+50)));
baselinevals = c((midway-1000):(midway+1000));
SEM = std(baselinevals)/sqrt(length(baselinevals));               % Standard Error
ts = tinv([0.025  0.975],length(baselinevals)-1);      % T-Score
CI = mean(baselinevals) + ts*SEM;   
val2 = mean(CI);
modindex_soza416=val1-val2;
figure
bar(lags(14999500:15000500),c(14999500:15000500),'green')
title('LEC SOZ DU/DU')
ylim([0 .025])
[c,lags] = xcorr(raster_lphg_ud,raster_lah_ud,'normalize');
figure
bar(lags(14999500:15000500),c(14999500:15000500),'green')
title('LEC UD/UD')
ylim([0 .025])
[c,lags] = xcorr(raster_lphg_ud,raster_lah_du,'normalize');
figure
bar(lags(14999500:15000500),c(14999500:15000500),'green')
ylim([0 .025])
title('LEC UD/DU')
[c,lags] = xcorr(raster_lphg_du,raster_lah_ud,'normalize');
figure
bar(lags(14999500:15000500),c(14999500:15000500),'green')
ylim([0 .025])
title('LEC DU/UD')


test_query=['{"patient_id":"416","electrode":"REC" }']; 
HFO = find(conn,collection,'Query',test_query);
            start_t=[];
            slowangle_t=[];
            parfor j=1:numel(HFO(:,1))
                start_t(j)=getfield(HFO,{j},'start_t');
                slowangle_t(j)=getfield(HFO,{j},'slow_angle');
            end;
            maxUP=output_t_maxR.maxUP(13);
            tempangles=slowangle_t;
            tempangles_sub=[];
            for m=1:numel(tempangles)
                tempangles_sub(m)=subrad_sw(maxUP,tempangles(m));
            end;
            slowangle_t=tempangles_sub; 
            rphg_t=start_t;
            rphg_theta=slowangle_t;
test_query=['{"patient_id":"416","electrode":"RAH" }']; 
HFO = find(conn,collection,'Query',test_query);
            start_t=[];
            slowangle_t=[];
            parfor j=1:numel(HFO(:,1))
                start_t(j)=getfield(HFO,{j},'start_t');
                slowangle_t(j)=getfield(HFO,{j},'slow_angle');
            end;
            maxUP=output_t_maxR.maxUP(12);
            tempangles=slowangle_t;
            tempangles_sub=[];            
            for m=1:numel(tempangles)
                tempangles_sub(m)=subrad_sw(maxUP,tempangles(m));
            end;
            slowangle_t=tempangles_sub; 
            rah_t=start_t;
            rah_theta=slowangle_t;
[idx]=find(rphg_theta>0);
rphg_t_du=rphg_t(idx);
[idx]=find(rphg_theta<0);
rphg_t_ud=rphg_t(idx);
[idx]=find(rah_theta>0);
rah_t_du=rah_t(idx);
[idx]=find(rah_theta<0);
rah_t_ud=rah_t(idx);
raster_temp=zeros(1,15000000);
raster_rphg=raster_temp;
for i=1:numel(rphg_t)
    temp=round(rphg_t(i),3);
    temp=temp*1000;
    temp=round(temp,0);
    raster_rphg(temp)=1;
end;
raster_rah=raster_temp;
for i=1:numel(rah_t)
    temp=round(rah_t(i),3);
    temp=temp*1000;
    temp=round(temp,0);
    raster_rah(temp)=1;
end;
raster_rphg_du=raster_temp;
for i=1:numel(rphg_t_du)
    temp=round(rphg_t_du(i),3);
    temp=temp*1000;
    temp=round(temp,0);
    raster_rphg_du(temp)=1;
end;
raster_rphg_ud=raster_temp;
for i=1:numel(rphg_t_ud)
    temp=round(rphg_t_ud(i),3);
    temp=temp*1000;
    temp=round(temp,0);
    raster_rphg_ud(temp)=1;
end;
raster_rah_du=raster_temp;
for i=1:numel(rah_t_du)
    temp=round(rah_t_du(i),3);
    temp=temp*1000;
    temp=round(temp,0);
    raster_rah_du(temp)=1;
end;
raster_rah_ud=raster_temp;
for i=1:numel(rah_t_ud)
    temp=round(rah_t_ud(i),3);
    temp=temp*1000;
    temp=round(temp,0);
    raster_rah_ud(temp)=1;
end;
[c,lags] = xcorr(raster_rphg,raster_rah,'normalize');
figure
bar(lags(14999500:15000500),c(14999500:15000500),'cyan')
title('rec SOZ ALL')
[c,lags] = xcorr(raster_lphg_du,raster_lah_du,'normalize');
midway = round(numel(c)/2);
val1 = max(c((midway-50):(midway+50)));
baselinevals = c((midway-1000):(midway+1000));
SEM = std(baselinevals)/sqrt(length(baselinevals));               % Standard Error
ts = tinv([0.025  0.975],length(baselinevals)-1);      % T-Score
CI = mean(baselinevals) + ts*SEM;   
val2 = mean(CI);
modindex_soza416=val1-val2;
ylim([0 .025])
[c,lags] = xcorr(raster_rphg_du,raster_rah_du,'normalize');
figure
bar(lags(14999500:15000500),c(14999500:15000500),'cyan')
title('rec SOZ DU/DU')
ylim([0 .025])
figure
[c,lags] = xcorr(raster_rphg_ud,raster_rah_ud,'normalize');
bar(lags(14999500:15000500),c(14999500:15000500),'cyan')
title('rec SOZ UD/UD')
ylim([0 .025])
[c,lags] = xcorr(raster_rphg_ud,raster_rah_du,'normalize');
figure
bar(lags(14999500:15000500),c(14999500:15000500),'cyan')
title('rec SOZ UD/DU')
ylim([0 .025])
[c,lags] = xcorr(raster_rphg_du,raster_rah_ud,'normalize');
figure
bar(lags(14999500:15000500),c(14999500:15000500),'cyan')
title('rec SOZ DU/UD')
ylim([0 .025])
