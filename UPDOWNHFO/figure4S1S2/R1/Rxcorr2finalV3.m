server='localhost';
username='admin';
password='';
dbname='deckard_new';
collection = "yuvalHFOn";
port=27017;
conn = mongoc(server,port,dbname,'UserName',username,'Password',password);

test_query=['{"patient_id":"423","electrode":"LEC","type":"1" }']; 
HFO = find(conn,collection,'Query',test_query);
            start_t=[];
            slowangle_t=[];
            parfor j=1:numel(HFO(:,1))
                start_t(j)=getfield(HFO,{j},'start_t');
                slowangle_t(j)=getfield(HFO,{j},'slow_angle');
            end;
            maxUP=output_t_maxR.maxUP(37);
            tempangles=slowangle_t;
            tempangles_sub=[];
            for m=1:numel(tempangles)
                tempangles_sub(m)=subrad_sw(maxUP,tempangles(m));
            end;
            slowangle_t=tempangles_sub; 
            lec_t=start_t;
            lec_theta=slowangle_t;
test_query=['{"patient_id":"423","electrode":"LMH","type":"1" }']; 
HFO = find(conn,collection,'Query',test_query);
            start_t=[];
            slowangle_t=[];
            parfor j=1:numel(HFO(:,1))
                start_t(j)=getfield(HFO,{j},'start_t');
                slowangle_t(j)=getfield(HFO,{j},'slow_angle');
            end;
            maxUP=output_t_maxR.maxUP(38);
            tempangles=slowangle_t;
            tempangles_sub=[];
            for m=1:numel(tempangles)
                tempangles_sub(m)=subrad_sw(maxUP,tempangles(m));
            end;
            slowangle_t=tempangles_sub; 
            lmh_t=start_t;
            lmh_theta=slowangle_t;
[idx]=find(lec_theta>0);
lec_t_du=lec_t(idx);
[idx]=find(lec_theta<0);
lec_t_ud=lec_t(idx);
[idx]=find(lmh_theta>0);
lmh_t_du=lmh_t(idx);
[idx]=find(lmh_theta<0);
lmh_t_ud=lmh_t(idx);
raster_temp=zeros(1,15000000);
raster_lec=raster_temp;
for i=1:numel(lec_t)
    temp=round(lec_t(i),3);
    temp=temp*1000;
    temp=round(temp,0);
    raster_lec(temp)=1;
end;
raster_lmh=raster_temp;
for i=1:numel(lmh_t)
    temp=round(lmh_t(i),3);
    temp=temp*1000;
    temp=round(temp,0);
    raster_lmh(temp)=1;
end;
raster_lec_du=raster_temp;
for i=1:numel(lec_t_du)
    temp=round(lec_t_du(i),3);
    temp=temp*1000;
    temp=round(temp,0);
    raster_lec_du(temp)=1;
end;
raster_lec_ud=raster_temp;
for i=1:numel(lec_t_ud)
    temp=round(lec_t_ud(i),3);
    temp=temp*1000;
    temp=round(temp,0);
    raster_lec_ud(temp)=1;
end;
raster_lmh_du=raster_temp;
for i=1:numel(lmh_t_du)
    temp=round(lmh_t_du(i),3);
    temp=temp*1000;
    temp=round(temp,0);
    raster_lmh_du(temp)=1;
end;
raster_lmh_ud=raster_temp;
for i=1:numel(lmh_t_ud)
    temp=round(lmh_t_ud(i),3);
    temp=temp*1000;
    temp=round(temp,0);
    raster_lmh_ud(temp)=1;
end;
[c,lags] = xcorr(raster_lec,raster_lmh,'normalized');
figure
bar(lags(14999500:15000500),c(14999500:15000500),'red')
title('ecSOZ ALL')
midway = round(numel(c)/2);
val1 = max(c((midway-50):(midway+50)));
baselinevals = c((midway-1000):(midway+1000));
SEM = std(baselinevals)/sqrt(length(baselinevals));               % Standard Error
ts = tinv([0.025  0.975],length(baselinevals)-1);      % T-Score
CI = mean(baselinevals) + ts*SEM;   
val2 = mean(CI);
modindex_soz423=val1-val2;

ylim([0 .01])
[c,lags] = xcorr(raster_lec_du,raster_lmh_du,'normalized');
figure
bar(lags(14999500:15000500),c(14999500:15000500),'red')
title('ecSOZ DU/DU')
ylim([0 .01])
[c,lags] = xcorr(raster_lec_ud,raster_lmh_ud,'normalized');
figure
bar(lags(14999500:15000500),c(14999500:15000500),'red')
title('ecSOZ UD/UD')
ylim([0 .01])
[c,lags] = xcorr(raster_lec_ud,raster_lmh_du,'normalized');
figure
bar(lags(14999500:15000500),c(14999500:15000500),'red')
title('ecSOZ UD/DU')
ylim([0 .01])
[c,lags] = xcorr(raster_lec_du,raster_lmh_ud,'normalized');
figure
bar(lags(14999500:15000500),c(14999500:15000500),'red')
ylim([0 .01])
title('ecSOZ DU/UD')

test_query=['{"patient_id":"423","electrode":"REC" }']; 
HFO = find(conn,collection,'Query',test_query);
            start_t=[];
            slowangle_t=[];
            parfor j=1:numel(HFO(:,1))
                start_t(j)=getfield(HFO,{j},'start_t');
                slowangle_t(j)=getfield(HFO,{j},'slow_angle');
            end;
            maxUP=output_t_maxR.maxUP(40);
            tempangles=slowangle_t;
            tempangles_sub=[];
            for m=1:numel(tempangles)
                tempangles_sub(m)=subrad_sw(maxUP,tempangles(m));
            end;
            slowangle_t=tempangles_sub; 
            rec_t=start_t;
            rec_theta=slowangle_t;
test_query=['{"patient_id":"423","electrode":"RMH","type":"1" }']; 
HFO = find(conn,collection,'Query',test_query);
            start_t=[];
            slowangle_t=[];
            parfor j=1:numel(HFO(:,1))
                start_t(j)=getfield(HFO,{j},'start_t');
                slowangle_t(j)=getfield(HFO,{j},'slow_angle');
            end;
            maxUP=output_t_maxR.maxUP(41);
            tempangles=slowangle_t;
            tempangles_sub=[];
            for m=1:numel(tempangles)
                tempangles_sub(m)=subrad_sw(maxUP,tempangles(m));
            end;
            slowangle_t=tempangles_sub; 
            rmh_t=start_t;
            rmh_theta=slowangle_t;
[idx]=find(rec_theta>0);
rec_t_du=rec_t(idx);
[idx]=find(rec_theta<0);
rec_t_ud=rec_t(idx);
[idx]=find(rmh_theta>0);
rmh_t_du=rmh_t(idx);
[idx]=find(rmh_theta<0);
rmh_t_ud=rmh_t(idx);
raster_temp=zeros(1,15000000);
raster_rec=raster_temp;
for i=1:numel(rec_t)
    temp=round(rec_t(i),3);
    temp=temp*1000;
    temp=round(temp,0);
    raster_rec(temp)=1;
end;
raster_rmh=raster_temp;
for i=1:numel(rmh_t)
    temp=round(rmh_t(i),3);
    temp=temp*1000;
    temp=round(temp,0);
    raster_rmh(temp)=1;
end;
raster_rec_du=raster_temp;
for i=1:numel(rec_t_du)
    temp=round(rec_t_du(i),3);
    temp=temp*1000;
    temp=round(temp,0);
    raster_rec_du(temp)=1;
end;
raster_rec_ud=raster_temp;
for i=1:numel(rec_t_ud)
    temp=round(rec_t_ud(i),3);
    temp=temp*1000;
    temp=round(temp,0);
    raster_rec_ud(temp)=1;
end;
raster_rmh_du=raster_temp;
for i=1:numel(rmh_t_du)
    temp=round(rmh_t_du(i),3);
    temp=temp*1000;
    temp=round(temp,0);
    raster_rmh_du(temp)=1;
end;
raster_rmh_ud=raster_temp;
for i=1:numel(rmh_t_ud)
    temp=round(rmh_t_ud(i),3);
    temp=temp*1000;
    temp=round(temp,0);
    raster_rmh_ud(temp)=1;
end;
[c,lags] = xcorr(raster_rec,raster_rmh,'normalize');
figure
bar(lags(14999500:15000500),c(14999500:15000500))
ylim([0 .01])
title('ec NSOZ ALL')
midway = round(numel(c)/2);
val1 = max(c((midway-50):(midway+50)));
baselinevals = c((midway-1000):(midway+1000));
SEM = std(baselinevals)/sqrt(length(baselinevals));               % Standard Error
ts = tinv([0.025  0.975],length(baselinevals)-1);      % T-Score
CI = mean(baselinevals) + ts*SEM;   
val2 = mean(CI);
modindex_nsoz423=val1-val2;
[c,lags] = xcorr(raster_rec_du,raster_rmh_du,'normalize');
figure
bar(lags(14999500:15000500),c(14999500:15000500))
ylim([0 .01])
title('ec NSOZ DU/DU')
[c,lags] = xcorr(raster_rec_ud,raster_rmh_ud,'normalize');
figure
bar(lags(14999500:15000500),c(14999500:15000500))
title('ec NSOZ UD/UD')
ylim([0 .01])
[c,lags] = xcorr(raster_rec_ud,raster_rmh_du,'normalize');
figure
bar(lags(14999500:15000500),c(14999500:15000500))
title('ec NSOZ UD/DU')
ylim([0 .01])
[c,lags] = xcorr(raster_rec_du,raster_rmh_ud,'normalize');
figure
bar(lags(14999500:15000500),c(14999500:15000500))
ylim([0 .01])
title('ec NSOZ DU/UD')

test_query=['{"patient_id":"406","electrode":"LPHG","type":"1" }']; 
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
test_query=['{"patient_id":"406","electrode":"LAH","type":"1" }']; 
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
raster_temp=zeros(1,9000000);
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
bar(lags(8999500:9000500),c(8999500:9000500),'red')
title('LPHG SOZ ALL')
midway = round(numel(c)/2);
val1 = max(c((midway-50):(midway+50)));
baselinevals = c((midway-1000):(midway+1000));
SEM = std(baselinevals)/sqrt(length(baselinevals));               % Standard Error
ts = tinv([0.025  0.975],length(baselinevals)-1);      % T-Score
CI = mean(baselinevals) + ts*SEM;   
val2 = mean(CI);
modindex_soz406=val1-val2;
ylim([0 .031])
[c,lags] = xcorr(raster_lphg_du,raster_lah_du,'normalize');
figure
bar(lags(8999500:9000500),c(8999500:9000500),'red')
title('LPHG SOZ DU/DU')
ylim([0 .031])
[c,lags] = xcorr(raster_lphg_ud,raster_lah_ud,'normalize');
figure
bar(lags(8999500:9000500),c(8999500:9000500),'red')
title('LPHG UD/UD')
ylim([0 .031])
[c,lags] = xcorr(raster_lphg_ud,raster_lah_du,'normalize');
figure
bar(lags(8999500:9000500),c(8999500:9000500),'red')
ylim([0 .031])
title('LPHG UD/DU')
[c,lags] = xcorr(raster_lphg_du,raster_lah_ud,'normalize');
figure
bar(lags(8999500:9000500),c(8999500:9000500),'red')
ylim([0 .031])
title('LPHG DU/UD')


test_query=['{"patient_id":"406","electrode":"RPHG","type":"1" }']; 
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
test_query=['{"patient_id":"406","electrode":"RAH","type":"1" }']; 
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
raster_temp=zeros(1,9000000);
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
bar(lags(8999500:9000500),c(8999500:9000500))
title('rphg NSOZ ALL')
midway = round(numel(c)/2);
val1 = max(c((midway-50):(midway+50)));
baselinevals = c((midway-1000):(midway+1000));
SEM = std(baselinevals)/sqrt(length(baselinevals));               % Standard Error
ts = tinv([0.025  0.975],length(baselinevals)-1);      % T-Score
CI = mean(baselinevals) + ts*SEM;   
val2 = mean(CI);
modindex_nsoz406=val1-val2;
ylim([0 .031])
[c,lags] = xcorr(raster_rphg_du,raster_rah_du,'normalize');
figure
bar(lags(8999500:9000500),c(8999500:9000500))
title('rphg NSOZ DU/DU')
ylim([0 .031])
figure
[c,lags] = xcorr(raster_rphg_ud,raster_rah_ud,'normalize');
bar(lags(8999500:9000500),c(8999500:9000500))
title('rphg NSOZ UD/UD')
ylim([0 .031])
[c,lags] = xcorr(raster_rphg_ud,raster_rah_du,'normalize');
figure
bar(lags(8999500:9000500),c(8999500:9000500))
title('rphg NSOZ UD/DU')
ylim([0 .031])
[c,lags] = xcorr(raster_rphg_du,raster_rah_ud,'normalize');
figure
bar(lags(8999500:9000500),c(8999500:9000500))
title('rphg NSOZ DU/UD')
ylim([0 .025])
