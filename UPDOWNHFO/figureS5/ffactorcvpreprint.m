test_query=['{"patient_id":"423","electrode":"LEC" }']; 
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
test_query=['{"patient_id":"423","electrode":"LMH" }']; 
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
bins=[0:.1:15000];
[no,xo] = hist(lec_t,bins);
fflec423=var(no)/mean(no);
[no,xo] = hist(lmh_t,bins);
fflmh423=var(no)/mean(no);

[t, pd, ~, cvlec423] = isidist(raster_lec,100,60000,1)
[t, pd, ~, cvlmh423] = isidist(raster_lmh,100,60000,1)

test_query=['{"patient_id":"423","electrode":"REC" }']; 
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
test_query=['{"patient_id":"423","electrode":"RMH" }']; 
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
bins=[0:.1:15000];
[no,xo] = hist(lec_t,bins);
ffrec423=var(no)/mean(no);
[no,xo] = hist(lmh_t,bins);
ffrmh423=var(no)/mean(no);

[t, pd, ~, cvrec423] = isidist(raster_lec,100,60000,1)
[t, pd, ~, cvrmh423] = isidist(raster_lmh,100,60000,1)


test_query=['{"patient_id":"416","electrode":"LEC" }']; 
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
test_query=['{"patient_id":"416","electrode":"LAH" }']; 
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
bins=[0:.1:15000];
[no,xo] = hist(lec_t,bins);
fflec416=var(no)/mean(no);
[no,xo] = hist(lmh_t,bins);
fflmh416=var(no)/mean(no);

[t, pd, ~, cvlec416] = isidist(raster_lec,100,60000,1)
[t, pd, ~, cvlmh416] = isidist(raster_lmh,100,60000,1)

test_query=['{"patient_id":"416","electrode":"REC" }']; 
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
test_query=['{"patient_id":"416","electrode":"RAH" }']; 
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
bins=[0:.1:15000];
[no,xo] = hist(lec_t,bins);
ffrec416=var(no)/mean(no);
[no,xo] = hist(lmh_t,bins);
ffrmh416=var(no)/mean(no);

[t, pd, ~, cvrec416] = isidist(raster_lec,100,60000,1)
[t, pd, ~, cvrmh416] = isidist(raster_lmh,100,60000,1)

test_query=['{"patient_id":"406","electrode":"LPHG" }']; 
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
test_query=['{"patient_id":"406","electrode":"LAH" }']; 
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

bins=[0:.01:9000];
[no,xo] = hist(lphg_t_du,bins);
fflphgdu=var(no)/mean(no);
[no,xo] = hist(lphg_t_ud,bins);
fflphgud=var(no)/mean(no);
[no,xo] = hist(lah_t_du,bins);
fflah2du=var(no)/mean(no);
[no,xo] = hist(lah_t_ud,bins);
fflah2ud=var(no)/mean(no);

[t, pd, ~, cvlphgdu] = isidist(raster_lphg_du,100,60000,1)
figure
bar(t,pd,'red')
title('LPHG SOZ DU/DU')
[t, pd, ~, cvlphgud] = isidist(raster_lphg_ud,100,60000,1)
figure
bar(t,pd,'red')
title('LPHG UD/UD')
[t, pd, ~, cvlah2du] = isidist(raster_lah_du,100,60000,1)
figure
bar(t,pd,'red')
title('LPHG UD/DU')
[t, pd, ~, cvlah2ud] = isidist(raster_lah_ud,100,60000,1)
figure
bar(t,pd,'red')
title('LPHG DU/UD')

test_query=['{"patient_id":"406","electrode":"RPHG" }']; 
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
test_query=['{"patient_id":"406","electrode":"RAH" }']; 
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

bins=[0:.01:9000];
[no,xo] = hist(rphg_t_du,bins);
ffrphgdu=var(no)/mean(no);
[no,xo] = hist(rphg_t_ud,bins);
ffrphgud=var(no)/mean(no);
[no,xo] = hist(rah_t_du,bins);
ffrah2du=var(no)/mean(no);
[no,xo] = hist(rah_t_ud,bins);
ffrah2ud=var(no)/mean(no);

[t, pd, ~, cvrphgdu] = isidist(raster_rphg_du,100,60000,1)
figure
bar(t,pd)
title('rphg NSOZ DU/DU')
[t, pd, ~, cvrphgud] = isidist(raster_rphg_ud,100,60000,1)
figure
bar(t,pd)
title('rphg NSOZ UD/UD')
[t, pd, ~, cvrah2du] = isidist(raster_rah_du,100,60000,1)
figure
bar(t,pd)
title('rphg NSOZ UD/DU')
[t, pd, ~, cvrah2ud] = isidist(raster_rah_ud,100,60000,1)
figure
bar(t,pd)
title('rphg NSOZ DU/UD')

close all
p417ff_a=[ffrpardu ffrparud];
p417ff_b=[fflpardu fflparud];
p417ff=vertcat(p417ff_b,p417ff_a);
figure
bar(p417ff','grouped')
title('ff 417 hippocampus parietal down and up NSOZ SOZ')

p423ff_a=[fflmhdu fflmhud fflecdu fflecud];
p423ff_b=[ffrmhdu ffrmhud ffrecdu ffrecud];
p423ff=vertcat(p423ff_b,p423ff_a);
figure
bar(p423ff','grouped')
title('ff 423 hippocampus ec down and up NSOZ SOZ')

p406ff_a=[ffrah2du ffrah2ud ffrphgdu ffrphgud];
p406ff_b=[fflah2du fflah2ud fflphgdu fflphgud];
p406ff=vertcat(p406ff_a,p406ff_b);
figure
bar(p406ff','grouped')
title('ff 406 hippocampus lphg down and up NSOZ SOZ')

p417cv_a=[cvrpardu^2 cvrparud^2];
p417cv_b=[cvlpardu^2 cvlparud^2];
p417cv=vertcat(p417cv_b, p417cv_a);
figure
bar(p417cv','grouped')
title('cv2 417 hippocampus parietal down and up NSOZ SOZ')

p423cv_a=[cvlmhdu^2 cvlmhud^2 cvlecdu^2 cvlecud^2];
p423cv_b=[cvrmhdu^2 cvrmhud^2 cvrecdu^2 cvrecud^2];
p423cv=vertcat(p423cv_b,p423cv_a);
figure
bar(p423cv','grouped')
title('cv2 423 hippocampus ec down and up NSOZ SOZ')

p406cv_a=[cvrah2du^2 cvrah2ud^2 cvrphgdu^2 cvrphgud^2];
p406cv_b=[cvlah2du^2 cvlah2ud^2 cvlphgdu^2 cvlphgud^2];
p406cv=vertcat(p406cv_a,p406cv_b);
figure
bar(p406cv','grouped')
title('cv 406 hippocampus lphg down and up NSOZ SOZ')