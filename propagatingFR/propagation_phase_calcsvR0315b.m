clear
plotgraphs=1;
load('R3master200nospikesVr0306.mat')
[idx,~]=find(R3v2master200nospikesVr0306.patientvector==39);
idx2=[];
for i=1:numel(R3v2master200nospikesVr0306.chnameVector)
    temp2=R3v2master200nospikesVr0306.chnameVector(i);
    temp2=temp2{1};
    if strcmp(temp2{1},'POL LA8')
        idx2=[idx2 i];
    end;
    if strcmp(temp2{2},'POL LA8')
        idx2=[idx2 i];
    end;
    if strcmp(temp2{1},'POL SMA1')
        idx2=[idx2 i];
    end;
    if strcmp(temp2{2},'POL SMA1')
        idx2=[idx2 i];
    end;
end;
idx3=intersect(idx,idx2);
R3v2master200nospikesVr0306(idx3,:)=[];

[idx,~]=find(FRpropertiesVr0306.FR_patient==39);
[idx2,~]=find(ismember(FRpropertiesVr0306.FR_electrode_1,'POL LA8')==1);
[idx3,~]=find(ismember(FRpropertiesVr0306.FR_electrode_1,'POL LSMA1')==1);
[idx4,~]=find(ismember(FRpropertiesVr0306.FR_electrode_2,'POL LA8')==1);
[idx5,~]=find(ismember(FRpropertiesVr0306.FR_electrode_2,'POL LSMA1')==1);

int1=intersect(idx,idx2);
int2=intersect(idx,idx3);
int3=intersect(idx,idx4);
int4=intersect(idx,idx5);

deleteindices=vertcat(int1,int2,int3,int4);
FRpropertiesVr0306(deleteindices,:)=[];
[a,b]=unique(R3v2master200nospikesVr0306.DistanceVector);
R3v2master200nospikesVr0306=R3v2master200nospikesVr0306(b,:);
[a,b]=find(R3v2master200nospikesVr0306.fripple_sign_p_matrix<0.005); %0.0045
R3v2master200nospikesVr0306=R3v2master200nospikesVr0306(a,:);
soz=cell2mat(R3v2master200nospikesVr0306.SOZstatusVector);
[a,b]=find(soz(:,1)==1);
[c,d]=find(soz(:,2)==1);
e=intersect(a,c);
sozedges=R3v2master200nospikesVr0306(e,:);
[a,b]=find(soz(:,1)==1);
[c,d]=find(soz(:,2)==0);
e=intersect(a,c);
soznsozedges=R3v2master200nospikesVr0306(e,:);
[a,b]=find(soz(:,1)==0);
[c,d]=find(soz(:,2)==1);
e=intersect(a,c);
nsozsozedges=R3v2master200nospikesVr0306(e,:);
[a,b]=find(soz(:,1)==0);
[c,d]=find(soz(:,2)==0);
e=intersect(a,c);
nsozedges=R3v2master200nospikesVr0306(e,:);

velocity=zeros(3,1);
velocity_R2=zeros(3,1);
velocity_p=zeros(3,1);
slow_delay_p=ones(4,1);
slow_dist_p=ones(4,1);
slow_x_p=ones(4,1);
slow_y_p=ones(4,1);
slow_z_p=ones(4,1);
slow_delay_R2=zeros(4,1);
slow_dist_R2=zeros(4,1);
slow_x_R2=zeros(4,1);
slow_y_R2=zeros(4,1);
slow_z_R2=zeros(4,1);

% nsoz edges slow
% calculate propagation velocity

% find slope outliers
%p = normcdf(-abs(zscore(abs(nsozedges.mean_delay)./(nsozedges.DistanceVector))));
%[outlier,~]=find(p<0.05);
% p = normcdf(zscore(nsozedges.std_delay))
% [outlier2,~]=find(p>0.95);
% outlier=vertcat(outlier,outlier2);

% remove bad data confirmed with visual inspection
badnsozpatientdata=[3 9 16 18 35];
[idx,~]=find(ismember(nsozedges.patientvector,badnsozpatientdata)==1)
outliers_patients=nsozedges.patientvector(idx);
outliers_channels=nsozedges.chnameVector(idx);
outliers_t=table(outliers_patients,outliers_channels);
outliers_table=outliers_t;
nsozedges(idx,:)=[];

% 
figure
scatter(nsozedges.DistanceVector,abs(nsozedges.mean_delay));
hold on
errorbar(nsozedges.DistanceVector,abs(nsozedges.mean_delay),nsozedges.std_delay,'.');
[yfit,velocity_R2(1,1),velocity_p(1,1)] = shenregression(nsozedges.DistanceVector,abs(nsozedges.mean_delay));
hold on
plot(nsozedges.DistanceVector,yfit);
velocity(1,1)=((yfit(2)-yfit(1))/(nsozedges.DistanceVector(2)-nsozedges.DistanceVector(1)))
title('nsoz FR propagation (p<0.005)')
subtitle('NSOZ pair distance vs. abs(FR propagation delay)')
txt1 = ['nsoz r2=' num2str(round(velocity_R2(1,1),4))];
annotation('textbox', [.5,.5,0,0], 'string', txt1);
txt1 = ['nsoz p=' num2str(round(velocity_p(1,1),4))];
annotation('textbox', [.5,.625,0,0], 'string', txt1);
txt1 = ['nsoz v =' num2str(round((velocity(1,1)*1000),4))];
annotation('textbox', [.5,.75,0,0], 'string', txt1);
xlim([0 100]);
ylim([0 0.2]);
% separate x values in left and right hemisphere
right_pairs=[];
left_pairs=[];
for i=1:numel(nsozedges.xcoordVector)
    temp=nsozedges.xcoordVector{i};
    temp=temp(1);
    if temp<0
        right_pairs=[right_pairs i];
    else
        left_pairs=[left_pairs i];
    end;
end;

% calculate angle diff
phaseshift=[];
tempangles=cell2mat(nsozedges.Slow_A_array);
for i=1:numel(tempangles(:,1))
phaseshift(i)=subrad(tempangles(i,2)',tempangles(i,1)');
end;
tempangles=horzcat(tempangles,phaseshift');
phaseshift=phaseshift';
phaseshift_x=phaseshift;
[idx,~]=find(isnan(phaseshift)==1);
phaseshift(idx,:)=[];
mean_delay=nsozedges.mean_delay;
mean_delay(idx,:)=[];
ydistance=nsozedges.yDistanceVector;
xdistance=nsozedges.xDistanceVector;
zdistance=nsozedges.zDistanceVector;
xdistance(left_pairs)=-xdistance(left_pairs); % Adjust for MNI coordinate designation
ydistance(idx,:)=[];
xdistance(idx,:)=[];
zdistance(idx,:)=[];
[yfit,slow_delay_R2(1,1),slow_delay_p(1,1)] = shenregression_nonzero(phaseshift,mean_delay);
[yfit2,slow_dist_R2(1,1),slow_dist_p(1,1)] = shenregression_nonzero(phaseshift,ydistance);
[yfit3,slow_y_R2(1,1),slow_y_p(1,1)] = shenregression_nonzero(nsozedges.yDistanceVector,nsozedges.mean_delay);
[yfit4,slow_x_R2(1,1),slow_x_p(1,1)] = shenregression_nonzero(nsozedges.xDistanceVector,nsozedges.mean_delay);
[yfit5,slow_z_R2(1,1),slow_z_p(1,1)] = shenregression_nonzero(nsozedges.zDistanceVector,nsozedges.mean_delay);
if plotgraphs==1
figure
scatter(phaseshift,mean_delay,9,'green','o')
hold on
plot(phaseshift,yfit,'green');
yyaxis right
scatter(phaseshift,ydistance,9,'magenta','square');
hold on
plot(phaseshift,yfit2,'magenta');
title('slow nsoz edges phase shift vs. delay (p<0.005)')
subtitle('slow nsoz edges phase shift vs. yDistance (magenta)')
txt1 = ['slow_delay r2=' num2str(round(slow_delay_R2(1,1),4))];
txt2 = ['slow_dist r2=' num2str(round(slow_dist_R2(1,1),4))];
txt1=txt1(1:18);
txt2=txt2(1:18);
text=vertcat(txt1,txt2);
annotation('textbox', [.5,.5,0,0], 'string', text)
txt1 = ['slow_delay p=' num2str(round(slow_delay_p(1,1),4))];
txt2 = ['slow_dist p=' num2str(round(slow_dist_p(1,1),4))];
txt1=txt1(1:17);
txt2=txt2(1:17);
text=vertcat(txt1,txt2);
annotation('textbox', [.5,.75,0,0], 'string', text)
xticks([-pi -pi/2 0 pi/2 pi])
xticklabels({'-\pi','-\pi/2','0','\pi/2','\pi'})
figure
scatter(nsozedges.yDistanceVector,nsozedges.mean_delay,9,'black','o');
hold on
scatter(nsozedges.xDistanceVector,nsozedges.mean_delay,3,'blue','o');
scatter(nsozedges.zDistanceVector,nsozedges.mean_delay,9,'red','o');
plot(nsozedges.yDistanceVector,yfit3,'black');
plot(nsozedges.xDistanceVector,yfit4,'blue');
plot(nsozedges.zDistanceVector,yfit5,'red');
title('slow nsoz edges x,y,z Distance vs. mean delay')
txt1 = ['x blue r2=' num2str(round(slow_x_R2(1,1),4))];
txt2 = ['y black r2=' num2str(round(slow_y_R2(1,1),4))];
txt3 = ['z red r2=' num2str(round(slow_z_R2(1,1),4))];
txt1=txt1(1:15);
txt2=txt2(1:15);
txt3=txt3(1:15);
text=vertcat(txt1,txt2,txt3);
annotation('textbox', [.5,.5,0,0], 'string', text)
txt1 = ['x p=' num2str(round(slow_x_p(1,1),4))];
txt2 = ['y p=' num2str(round(slow_y_p(1,1),4))];
txt3 = ['z p=' num2str(round(slow_z_p(1,1),4))];
txt1=txt1(1:5);
txt2=txt2(1:5);
txt3=txt3(1:5);
text=vertcat(txt1,txt2,txt3);
annotation('textbox', [.5,.75,0,0], 'string', text)
figure
scatter(phaseshift,xdistance,9,'blue','square');
hold on
scatter(phaseshift,zdistance,9,'red','square');
title('slow nsoz edges phase shift vs. x (right) and z Distance (blue, red)')
end;

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

% remove bad data confirmed with visual inspection

outlier_patients_1=soznsozedges.patientvector(7);
outlier_channels_1=soznsozedges.chnameVector(7);
outlier_patients_2=nsozsozedges.patientvector(4);
outlier_channels_2=nsozsozedges.chnameVector(4);
outliers_patients=vertcat(outlier_patients_1, outlier_patients_2);
outliers_channels=vertcat(outlier_channels_1, outlier_channels_2);
outliers_t=table(outliers_patients,outliers_channels);
outliers_table=vertcat(outliers_table, outliers_t);
soznsozedges(7,:)=[];
nsozsozedges(4,:)=[];

figure
xlim([0 100])
ylim([0 0.2])
nsozsoz_distance=vertcat(soznsozedges.DistanceVector, nsozsozedges.DistanceVector);
nsozsoz_meandelay=vertcat(soznsozedges.mean_delay, nsozsozedges.mean_delay);
nsozsoz_stddelay=vertcat(soznsozedges.std_delay, nsozsozedges.std_delay);

% separate x values in left and right hemisphere
right_pairs=[];
left_pairs=[];
temp_table=vertcat(soznsozedges,nsozsozedges);
for i=1:numel(temp_table.xcoordVector)
    temp=sozedges.xcoordVector{i};
    temp=temp(1);
    if temp<0
        right_pairs=[right_pairs i];
    else
        left_pairs=[left_pairs i];
    end;
end;

scatter(soznsozedges.DistanceVector, abs(soznsozedges.mean_delay),'yellow')
hold on
scatter(nsozsozedges.DistanceVector, abs(nsozsozedges.mean_delay),'cyan')
errorbar(nsozsozedges.DistanceVector,abs(nsozsozedges.mean_delay),nsozsozedges.std_delay,'.');
errorbar(soznsozedges.DistanceVector,abs(soznsozedges.mean_delay),soznsozedges.std_delay,'.','Color','r');
[yfit,velocity_R2(2,1),velocity_p(2,1)] = shenregression(temp_table.DistanceVector,abs(temp_table.mean_delay));
hold on
plot(temp_table.DistanceVector,yfit);
velocity(2,1)=((yfit(2)-yfit(1)))/(temp_table.DistanceVector(2)-temp_table.DistanceVector(1));
title('nsoz:soz FR propagation (p<0.005)')
subtitle('NSOZ:soz pair distance vs. abs(FR propagation delay)')
txt1 = ['nsoz:soz r2=' num2str(round(velocity_R2(2,1),4))];
annotation('textbox', [.5,.5,0,0], 'string', txt1)
txt1 = ['nsoz:soz v=' num2str(round((velocity(2,1)*1000),4))];
annotation('textbox', [.5 .62,0,0], 'string', txt1)
txt1 = ['nsoz:soz p=' num2str(round(velocity_p(2,1),4))];
annotation('textbox', [.5,.75,0,0], 'string', txt1)

phaseshift_soznsoz=[];
tempangles=cell2mat(soznsozedges.Slow_A_array);
for i=1:numel(tempangles(:,1))
phaseshift_soznsoz(i)=subrad(tempangles(i,1)',tempangles(i,2)'); % reversed for convention
end;
phaseshift_soznsoz=phaseshift_soznsoz';
[idx,~]=find(isnan(phaseshift_soznsoz)==1);
phaseshift_soznsoz(idx,:)=[];
mean_delay_soznsoz=-soznsozedges.mean_delay; %reversed for convention
mean_delay_soznsoz(idx,:)=[];
ydistance_soznsoz=-soznsozedges.yDistanceVector; %reversed for convention
ydistance_soznsoz(idx,:)=[];
phaseshift=[];
tempangles=cell2mat(nsozsozedges.Slow_A_array);
for i=1:numel(tempangles(:,1))
phaseshift(i)=subrad(tempangles(i,2)',tempangles(i,1)');
end;
tempangles=horzcat(tempangles,phaseshift');
phaseshift=phaseshift';
[idx,~]=find(isnan(phaseshift)==1);
phaseshift(idx,:)=[];
mean_delay=nsozsozedges.mean_delay;
mean_delay(idx,:)=[];
ydistance=nsozsozedges.yDistanceVector;
ydistance(idx,:)=[];
phaseshift=vertcat(phaseshift_soznsoz, phaseshift);
mean_delay=vertcat(mean_delay_soznsoz, mean_delay);
% for phase calculations remove outlier
ydistance=vertcat(ydistance_soznsoz,ydistance);
[idx,~]=find(phaseshift<=0);
modphaseshift=phaseshift(idx);
modmean_delay=mean_delay(idx);
modydistance=ydistance(idx);
[yfit,slow_delay_R2(3,1),slow_delay_p(3,1)] = shenregression_nonzero(modphaseshift,modmean_delay);
[yfit2,slow_dist_R2(3,1),slow_dist_p(3,1)] = shenregression_nonzero(phaseshift,ydistance);
if plotgraphs==1
figure
scatter(phaseshift,mean_delay,9,'green','o')
hold on
plot(modphaseshift,yfit,'green');
yyaxis right
scatter(phaseshift,ydistance,9,'magenta','square');
hold on
plot(phaseshift,yfit2,'magenta');
title('slow nsoz:soz edges phase shift vs. delay (p<0.005)')
subtitle('slow nsoz:soz edges phase shift vs. yDistance (magenta)')
txt1 = ['slow_delay r2=' num2str(round(slow_delay_R2(3,1),4))];
txt2 = ['slow_dist r2=' num2str(round(slow_dist_R2(3,1),4))];
txt1=txt1(1:18);
txt2=txt2(1:18);
text=vertcat(txt1,txt2);
annotation('textbox', [.5,.5,0,0], 'string', text)
txt1 = ['slow_delay p=' num2str(round(slow_delay_p(3,1),4))];
txt2 = ['slow_dist p=' num2str(round(slow_dist_p(3,1),4))];
txt1=txt1(1:17);
txt2=txt2(1:17);
text=vertcat(txt1,txt2);
annotation('textbox', [.5,.75,0,0], 'string', text)
xlim([-pi pi]);
xticks([-pi -pi/2 0 pi/2 pi]);
xticklabels({'-\pi','-\pi/2','0','\pi/2','\pi'});
% figure
figure
ydist_allnsozsoznodes=vertcat(soznsozedges.yDistanceVector, nsozsozedges.yDistanceVector);
xdist_allnsozsoznodes=vertcat(soznsozedges.xDistanceVector, nsozsozedges.xDistanceVector);
zdist_allnsozsoznodes=vertcat(soznsozedges.zDistanceVector, nsozsozedges.zDistanceVector);
invsoznsozdelay=-soznsozedges.mean_delay;
delay_allnsozsoznodes=vertcat(invsoznsozdelay,nsozsozedges.mean_delay);
xdist_allnsozsoznodes(left_pairs)=-xdist_allnsozsoznodes(left_pairs);

%
[yfit3,slow_y_R2(3,1),slow_y_p(3,1)] = shenregression_nonzero(ydist_allnsozsoznodes,delay_allnsozsoznodes);
[yfit4,slow_x_R2(3,1),slow_x_p(3,1)] = shenregression_nonzero(xdist_allnsozsoznodes,delay_allnsozsoznodes);
[yfit5,slow_z_R2(3,1),slow_z_p(3,1)] = shenregression_nonzero(zdist_allnsozsoznodes,delay_allnsozsoznodes);
scatter(ydist_allnsozsoznodes,delay_allnsozsoznodes,9,'black','o');
hold on
plot(ydist_allnsozsoznodes,yfit3,'black');
scatter(xdist_allnsozsoznodes,delay_allnsozsoznodes,9,'blue','o');
scatter(zdist_allnsozsoznodes,delay_allnsozsoznodes,9,'red','o');
plot(xdist_allnsozsoznodes,yfit4,'blue');
plot(zdist_allnsozsoznodes,yfit5,'red')
title('slow nsoz:soz edges yDistance vs. mean delay')
txt1 = ['x blue r2=' num2str(round(slow_x_R2(3,1),4))];
txt2 = ['y black r2=' num2str(round(slow_y_R2(3,1),4))];
txt3 = ['z red r2=' num2str(round(slow_z_R2(3,1),4))];
txt1=txt1(1:14);
txt2=txt2(1:14);
txt3=txt3(1:14);
text=vertcat(txt1,txt2,txt3);
annotation('textbox', [.5,.5,0,0], 'string', text)
txt1 = ['x p=' num2str(round(slow_x_p(3,1),4))];
txt2 = ['y p=' num2str(round(slow_y_p(3,1),4))];
txt3 = ['z p=' num2str(round(slow_z_p(3,1),4))];
txt1=txt1(1:9);
txt2=txt2(1:9);
txt3=txt3(1:9);
text=vertcat(txt1,txt2,txt3);
annotation('textbox', [.5,.75,0,0], 'string', text)
end;

% soz edges slow
% calculate propagation velocity

% find slope outliers

figure
scatter(sozedges.DistanceVector,abs(sozedges.mean_delay),'red');
hold on
xlim([0 100])
ylim([0 0.2])
errorbar(sozedges.DistanceVector,abs(sozedges.mean_delay),sozedges.std_delay,'.');
[yfit,velocity_R2(3,1),velocity_p(3,1)] = shenregression(sozedges.DistanceVector,abs(sozedges.mean_delay));
hold on
plot(sozedges.DistanceVector,yfit);
velocity(3,1)=((yfit(2)-yfit(1))/(sozedges.DistanceVector(2)-sozedges.DistanceVector(1)));
title('soz FR propagation (p<0.005)')
subtitle('NSOZ pair distance vs. abs(FR propagation delay)')
txt1 = ['soz r2=' num2str(round(velocity_R2(3,1),4))];
annotation('textbox', [.5,.5,0,0], 'string', txt1)
txt1 = ['soz v=' num2str(round((velocity(3,1)*1000),4))]
annotation('textbox', [.5,.62,0,0], 'string', txt1)
txt1 = ['soz p=' num2str(round(velocity_p(3,1),4))];
annotation('textbox', [.5,.75,0,0], 'string', txt1)

% separate x values in left and right hemisphere
right_pairs=[];
left_pairs=[];
for i=1:numel(sozedges.xcoordVector)
    temp=sozedges.xcoordVector{i};
    temp=temp(1);
    if temp<0
        right_pairs=[right_pairs i];
    else
        left_pairs=[left_pairs i];
    end;
end;

phaseshift=[];
tempangles=cell2mat(sozedges.Slow_A_array);
for i=1:numel(tempangles(:,1))
phaseshift(i)=subrad(tempangles(i,2)',tempangles(i,1)');
end;
tempangles=horzcat(tempangles,phaseshift');
phaseshift=phaseshift';
[idx,~]=find(isnan(phaseshift)==1);
phaseshift(idx,:)=[];
mean_delay=sozedges.mean_delay;
mean_delay(idx,:)=[];
ydistance=sozedges.yDistanceVector;
ydistance(idx,:)=[];
xdistance=sozedges.xDistanceVector;
xdistance(left_pairs)=-xdistance(left_pairs);
xdistance(idx,:)=[];
zdistance=sozedges.zDistanceVector;
zdistance(idx)=[];
[yfit,slow_delay_R2(4,1),slow_delay_p(4,1)] = shenregression_nonzero(phaseshift,mean_delay);
[yfit2,slow_dist_R2(4,1),slow_dist_p(4,1)] = shenregression_nonzero(phaseshift,ydistance);
[yfit3,slow_y_R2(4,1),slow_y_p(4,1)] = shenregression_nonzero(sozedges.yDistanceVector,sozedges.mean_delay);
[yfit4,slow_x_R2(4,1),slow_x_p(4,1)] = shenregression_nonzero(sozedges.xDistanceVector,sozedges.mean_delay);
[yfit5,slow_z_R2(4,1),slow_z_p(4,1)] = shenregression_nonzero(sozedges.zDistanceVector,sozedges.mean_delay);
if plotgraphs==1
figure
scatter(phaseshift,mean_delay,9,'green','o')
hold on
plot(phaseshift,yfit,'green');
yyaxis right
scatter(phaseshift,ydistance,9,'magenta','square');
hold on
plot(phaseshift,yfit2,'magenta');
title('slow soz edges phase shift vs. delay (p<0.005)')
subtitle('slow soz edges phase shift vs. yDistance (magenta)')
txt1 = ['slow_delay r2=' num2str(round(slow_delay_R2(4,1),4))];
txt2 = ['slow_dist r2=' num2str(round(slow_dist_R2(4,1),4))];
txt1=txt1(1:19);
txt2=txt2(1:19);
text=vertcat(txt1,txt2);
annotation('textbox', [.5,.5,0,0], 'string', text)
txt1 = ['slow_delay p=' num2str(round(slow_delay_p(4,1),4))];
txt2 = ['slow_dist p=' num2str(round(slow_dist_p(4,1),4))];
txt1=txt1(1:17);
txt2=txt2(1:17);
text=vertcat(txt1,txt2);
annotation('textbox', [.5,.75,0,0], 'string', text)
xlim([-pi pi])
xticks([-pi -pi/2 0 pi/2 pi])
xticklabels({'-\pi','-\pi/2','0','\pi/2','\pi'})
figure
scatter(sozedges.yDistanceVector,sozedges.mean_delay,9,'black','o');
hold on
plot(sozedges.yDistanceVector,yfit3,'black');
scatter(sozedges.xDistanceVector,sozedges.mean_delay,9,'blue','o');
scatter(sozedges.zDistanceVector,sozedges.mean_delay,9,'red','o');
plot(sozedges.xDistanceVector,yfit4,'blue');
plot(sozedges.zDistanceVector,yfit5,'red')
title('slow soz edges x,y,z Distance vs. mean delay')
txt1 = ['x blue r2=' num2str(round(slow_x_R2(4,1),4))];
txt2 = ['y black r2=' num2str(round(slow_y_R2(4,1),4))];
txt3 = ['z red r2=' num2str(round(slow_z_R2(4,1),4))];
txt1=txt1(1:15);
txt2=txt2(1:15);
txt3=txt3(1:15);
text=vertcat(txt1,txt2,txt3);
annotation('textbox', [.5,.5,0,0], 'string', text)
txt1 = ['x p=' num2str(round(slow_x_p(4,1),4))];
txt2 = ['y p=' num2str(round(slow_y_p(4,1),4))];
txt3 = ['z p=' num2str(round(slow_z_p(4,1),4))];
txt1=[txt1 '0000'];
txt2=txt2(1:9);
txt3=txt3(1:9);
text=vertcat(txt1,txt2,txt3);
annotation('textbox', [.5,.75,0,0], 'string', text)
figure
scatter(phaseshift,xdistance,9,'blue','square');
hold on
scatter(phaseshift,zdistance,9,'red','square');
title('slow soz edges phase shift vs. x (right) and z Distance (blue, red)')
end;

% Delta analysis
delta_delay_p=ones(4,1);
delta_dist_p=ones(4,1);
delta_delay_R2=zeros(4,1);
delta_dist_R2=zeros(4,1);

% nsoz edges delta
% calculate angle diff
phaseshift=[];
tempangles=cell2mat(nsozedges.Delta_A_array);
for i=1:numel(tempangles(:,1))
phaseshift(i)=subrad(tempangles(i,2)',tempangles(i,1)');
end;
tempangles=horzcat(tempangles,phaseshift');
phaseshift=phaseshift';
[idx,~]=find(isnan(phaseshift)==1);
phaseshift(idx,:)=[];
mean_delay=nsozedges.mean_delay;
mean_delay(idx,:)=[];
ydistance=nsozedges.yDistanceVector;
ydistance(idx,:)=[];
[yfit,delta_delay_R2(1,1),delta_delay_p(1,1)] = shenregression_nonzero(phaseshift,mean_delay);
[yfit2,delta_dist_R2(1,1),delta_dist_p(1,1)] = shenregression_nonzero(phaseshift,ydistance);
if plotgraphs==1
figure
scatter(phaseshift,mean_delay,9,'green','o')
hold on
plot(phaseshift,yfit,'green');
yyaxis right
scatter(phaseshift,ydistance,9,'magenta','square');
hold on
plot(phaseshift,yfit2,'magenta');
title('delta nsoz edges phase shift vs. delay (p<0.005)')
subtitle('delta nsoz edges phase shift vs. yDistance (magenta)')
txt1 = ['delta_delay r2=' num2str(round(delta_delay_R2(1,1),4))];
txt2 = ['delta_dist r2=' num2str(round(delta_dist_R2(1,1),4))];
txt1=txt1(1:19);
txt2=txt2(1:19);
text=vertcat(txt1,txt2);
annotation('textbox', [.5,.5,0,0], 'string', text)
txt1 = ['delta_delay p=' num2str(round(delta_delay_p(1,1),4))];
txt2 = ['delta_dist p=' num2str(round(delta_dist_p(1,1),4))];
txt1=txt1(1:18);
txt2=txt2(1:18);
text=vertcat(txt1,txt2);
annotation('textbox', [.5,.75,0,0], 'string', text)
xticks([-pi -pi/2 0 pi/2 pi])
xticklabels({'-\pi','-\pi/2','0','\pi/2','\pi'})
end;

% nsoz:soz edges delta including soz:nsoz edges that are reversed 
phaseshift_soznsoz=[];
tempangles=cell2mat(soznsozedges.Delta_A_array);
for i=1:numel(tempangles(:,1))
phaseshift_soznsoz(i)=subrad(tempangles(i,1)',tempangles(i,2)'); % reversed for convention
end;
phaseshift_soznsoz=phaseshift_soznsoz';
[idx,~]=find(isnan(phaseshift_soznsoz)==1);
phaseshift_soznsoz(idx,:)=[];
mean_delay_soznsoz=-soznsozedges.mean_delay; %reversed for convention
mean_delay_soznsoz(idx,:)=[];
ydistance_soznsoz=-soznsozedges.yDistanceVector; %reversed for convention
ydistance_soznsoz(idx,:)=[];
phaseshift=[];
tempangles=cell2mat(nsozsozedges.Delta_A_array);
for i=1:numel(tempangles(:,1))
phaseshift(i)=subrad(tempangles(i,2)',tempangles(i,1)');
end;
tempangles=horzcat(tempangles,phaseshift');
phaseshift=phaseshift';
[idx,~]=find(isnan(phaseshift)==1);
phaseshift(idx,:)=[];
mean_delay=nsozsozedges.mean_delay;
mean_delay(idx,:)=[];
ydistance=nsozsozedges.yDistanceVector;
ydistance(idx,:)=[];
phaseshift=vertcat(phaseshift_soznsoz, phaseshift);
mean_delay=vertcat(mean_delay_soznsoz, mean_delay);
ydistance=vertcat(ydistance_soznsoz,ydistance);
[idx,~]=find(phaseshift<=0);
modphaseshift=phaseshift(idx);
modmean_delay=mean_delay(idx);
modydistance=ydistance(idx);
[yfit,delta_delay_R2(3,1),delta_delay_p(3,1)] = shenregression_nonzero(phaseshift,mean_delay);
[yfit2,delta_dist_R2(3,1),delta_dist_p(3,1)] = shenregression_nonzero(phaseshift,ydistance);
if plotgraphs==1
figure
scatter(phaseshift,mean_delay,9,'green','o')
hold on
plot(phaseshift,yfit,'green');
yyaxis right
scatter(phaseshift,ydistance,9,'magenta','square');
hold on
plot(phaseshift,yfit2,'magenta');
title('delta nsoz:soz edges phase shift vs. delay (p<0.005)')
subtitle('delta nsoz:soz edges phase shift vs. yDistance (magenta)')
txt1 = ['delta_delay r2=' num2str(round(delta_delay_R2(3,1),4))];
txt2 = ['delta_dist r2=' num2str(round(delta_dist_R2(3,1),4))];
txt1=txt1(1:18);
txt2=txt2(1:18);
text=vertcat(txt1,txt2);
annotation('textbox', [.5,.5,0,0], 'string', text)
txt1 = ['delta_delay p=' num2str(round(delta_delay_p(3,1),4))];
txt2 = ['delta_dist p=' num2str(round(delta_dist_p(3,1),4))];
txt1=txt1(1:18);
txt2=txt2(1:18);
text=vertcat(txt1,txt2);
annotation('textbox', [.5,.75,0,0], 'string', text)
xticks([-pi -pi/2 0 pi/2 pi])
xticklabels({'-\pi','-\pi/2','0','\pi/2','\pi'})
end;

% soz edges delta
% separate x values in left and right hemisphere
right_pairs=[];
left_pairs=[];
for i=1:numel(sozedges.xcoordVector)
    temp=sozedges.xcoordVector{i};
    temp=temp(1);
    if temp<0
        right_pairs=[right_pairs i];
    else
        left_pairs=[left_pairs i];
    end;
end;

phaseshift=[];
tempangles=cell2mat(sozedges.Delta_A_array);
for i=1:numel(tempangles(:,1))
phaseshift(i)=subrad(tempangles(i,2)',tempangles(i,1)');
end;
tempangles=horzcat(tempangles,phaseshift');
phaseshift=phaseshift';
[idx,~]=find(isnan(phaseshift)==1);
phaseshift(idx,:)=[];
mean_delay=sozedges.mean_delay;
mean_delay(idx,:)=[];
ydistance=sozedges.yDistanceVector;
ydistance(idx,:)=[];
xdistance=sozedges.xDistanceVector;
xdistance(left_pairs)=-xdistance(left_pairs);
xdistance(idx,:)=[];
zdistance=sozedges.zDistanceVector;
zdistance(idx)=[];
[yfit,delta_delay_R2(4,1),delta_delay_p(4,1)] = shenregression_nonzero(phaseshift,mean_delay);
[yfit2,delta_dist_R2(4,1),delta_dist_p(4,1)] = shenregression_nonzero(phaseshift,ydistance);
if plotgraphs==1
figure
scatter(phaseshift,mean_delay,9,'green','o')
hold on
plot(phaseshift,yfit,'green');
yyaxis right
scatter(phaseshift,ydistance,9,'magenta','square');
hold on
plot(phaseshift,yfit2,'magenta');
title('delta soz edges phase shift vs. delay (p<0.005)')
subtitle('delta soz edges phase shift vs. yDistance (magenta)')
txt1 = ['delta_delay r2=' num2str(round(delta_delay_R2(4,1),4))];
txt2 = ['delta_dist r2=' num2str(round(delta_dist_R2(4,1),4))];
txt1=txt1(1:20);
text=vertcat(txt1,txt2);
annotation('textbox', [.5,.5,0,0], 'string', text)
txt1 = ['delta_delay p=' num2str(round(delta_delay_p(4,1),4))];
txt2 = ['delta_dist p=' num2str(round(delta_dist_p(4,1),4))];
txt1=txt1(1:19);
text=vertcat(txt1,txt2);
annotation('textbox', [.5,.75,0,0], 'string', text)
xticks([-pi -pi/2 0 pi/2 pi])
xticklabels({'-\pi','-\pi/2','0','\pi/2','\pi'})
figure
scatter(phaseshift,xdistance,9,'blue','square');
hold on
scatter(phaseshift,zdistance,9,'red','square');
title('delta soz edges phase shift vs. x and z Distance (blue, red)')

end;

del_idx=[];
% Remove outliers from R3mastertable
temp=R3v2master200nospikesVr0306.chnameVector;
for j=1:numel(temp)
   temp2(j)=temp{j,1}{1};
   temp3(j)=temp{j,1}{2};
end;
temp2=temp2';
temp3=temp3';
for i=1:numel(outliers_table(:,1))
   chans=outliers_table.outliers_channels(i);
   ch1=chans{1,1}{1};
   ch2=chans{1,1}{2};
   patient=outliers_table.outliers_patients(i);
   [idx,~]=find(R3v2master200nospikesVr0306.patientvector==patient);
   [idx2,~]=find(ismember(temp2,ch1)==1);
   [idx3,~]=find(ismember(temp3,ch1)==1);
   [idx4,~]=find(ismember(temp2,ch2)==1);
   [idx5,~]=find(ismember(temp3,ch2)==1);
   int1=intersect(idx,idx2);
   int2=intersect(idx,idx3);
   int3=intersect(idx,idx4);
   int4=intersect(idx,idx5);
   del_idx=vertcat(del_idx, int1, int2, int3, int4);
end;
del_idx=unique(del_idx);
R3v2master200nospikesVr0306(del_idx,:)=[];

% Vector plot quiver3 caculate X,Y,Z,U,V,W

x=[];
y=[];
z=[];
u=[];
v=[];
w=[];
soz=[];
for i=1:numel(R3v2master200nospikesVr0306.xcoordVector)
   if R3v2master200nospikesVr0306.SOZstatusVector{i,1}(1)==1
       if R3v2master200nospikesVr0306.SOZstatusVector{i,1}(2)==1
           soz(i)=1;
       else
           soz(i)=2;
       end;
   else 
       if R3v2master200nospikesVr0306.SOZstatusVector{i,1}(2)==0
           soz(i)=4;
       else
           soz(i)=3;
       end;
   end;
   x(i)=R3v2master200nospikesVr0306.xcoordVector{i,1}(1);
   y(i)=R3v2master200nospikesVr0306.ycoordVector{i,1}(1);
   z(i)=R3v2master200nospikesVr0306.zcoordVector{i,1}(1);
   u(i)=R3v2master200nospikesVr0306.xcoordVector{i,1}(2)-R3v2master200nospikesVr0306.xcoordVector{i,1}(1);
   v(i)=R3v2master200nospikesVr0306.ycoordVector{i,1}(2)-R3v2master200nospikesVr0306.ycoordVector{i,1}(1);
   w(i)=R3v2master200nospikesVr0306.zcoordVector{i,1}(2)-R3v2master200nospikesVr0306.zcoordVector{i,1}(1);
end;

figure
a=70; % horizontal radius
b=88.5; % vertical radius
x0=0; % x0,y0 ellipse centre coordinates
y0=0;
t=-pi:0.01:pi;
x1=x0+a*cos(t);
y1=-16.5+b*sin(t);
z1=0*t;
plot3(x1,y1,z1,'k')
hold on
a=70;
b=65;
x0=0; % x0,y0 ellipse centre coordinates
y0=0;
t=-pi:0.01:pi;
x1=x0+a*cos(t);
y1=0*t;
z1=10+b*sin(t);
plot3(x1,y1,z1,'k')
a=88.5;
b=65;
x0=0; % x0,y0 ellipse centre coordinates
y0=0;
t=-pi:0.01:pi;
x1=0*t;
y1=-16.5+a*cos(t);
z1=10+b*sin(t);
plot3(x1,y1,z1,'k')
for i=1:numel(x)
if soz(i)==1
quiver3(x(i),y(i),z(i),u(i),v(i),w(i),'red')
end;
if soz(i)==2
quiver3(x(i),y(i),z(i),u(i),v(i),w(i),'yellow')
end;
if soz(i)==3
quiver3(x(i),y(i),z(i),u(i),v(i),w(i),'cyan')
end;
if soz(i)==4
quiver3(x(i),y(i),z(i),u(i),v(i),w(i),'blue')
end;
end;

del_idx=[];
% Remove outliers from FRproperties
for i=1:numel(outliers_table(:,1))
   chans=outliers_table.outliers_channels(i);
   ch1=chans{1,1}{1};
   ch2=chans{1,1}{2};
   patient=outliers_table.outliers_patients(i);
   [idx,~]=find(FRpropertiesVr0306.FR_patient==patient);
   [idx2,~]=find(ismember(FRpropertiesVr0306.FR_electrode_1,ch1)==1);
   [idx3,~]=find(ismember(FRpropertiesVr0306.FR_electrode_1,ch2)==1);
   [idx4,~]=find(ismember(FRpropertiesVr0306.FR_electrode_2,ch1)==1);
   [idx5,~]=find(ismember(FRpropertiesVr0306.FR_electrode_2,ch2)==1);
   int1=intersect(idx,idx2);
   int2=intersect(idx,idx3);
   int3=intersect(idx,idx4);
   int4=intersect(idx,idx5);
   del_idx=vertcat(del_idx, int1, int2, int3, int4);
end;

del_idx_unique=unique(del_idx);
FRpropertiesVr0306(del_idx_unique,:)=[];

% supplemental figures
server='localhost';
username='admin';
password='';
dbname='deckard_new';
port=27017;
conn = mongo(server,port,dbname,'UserName',username,'Password',password);
collection = "HFOs";

mean_soz_fr=[];
stderr_soz_fr=[];
mean_nsoz_fr=[];
stderr_nsoz_fr=[];
for i=1:numel(R3ALLpatientscoded)
    i
    test_query=['{"patient_id":"' R3ALLpatientscoded{i} '"}'];
    electrodes = distinct(conn,collection,"electrode",'Query',test_query);
    collection = "Electrodes";
    electrodes_2 = distinct(conn,collection,"electrode",'Query',test_query);
    total_electrodes=[electrodes electrodes_2];
    unique_electrodes=unique(total_electrodes);
    soz_array=[];

      % find electrodes that are in the SOZ (re-evaluate to see if this needs
      % to be per patient
      for j=1:numel(unique_electrodes)
      test_query=['{"patient_id":"' R3ALLpatientscoded{i} '","electrode":"' unique_electrodes{j} '"}'];
      collection = "HFOs";
      soz = distinct(conn,collection,"soz",'Query',test_query);
      soz=cell2mat(soz);
      if ~isempty(soz)
      soz=str2double(soz);
      end;
      if ~isempty(soz)
      soz=soz(1);
      else
      collection = "Electrodes";
      soz = distinct(conn,collection,"soz",'Query',test_query);      
      soz=cell2mat(soz);
      if ~isempty(soz)
      soz=str2double(soz);
      end;
      soz=soz(1);
      end;
      if soz == 0
          collection = "Electrodes";
          soz = distinct(conn,collection,"soz",'Query',test_query);
          soz=cell2mat(soz);
          if ~isempty(soz)
          soz=str2double(soz);
          end;
          soz=soz(1);
      end;
      if soz == 0
          soz_array=[soz_array 0];
      else
          soz_array=[soz_array 1];
      end;
      end; 
      
      soz_count=[];
      nsoz_count=[];
      for j=1:numel(unique_electrodes)
        collection = "HFOs";
        test_query=['{"patient_id":"' R3ALLpatientscoded{i} '","electrode":"' unique_electrodes{j} '","type":"' num2str(4) '","freq_pk": {$gt:200} }'];
        n = count(conn,collection,'Query',test_query);
        if soz_array(j)==1
            soz_count=[soz_count n];
        else
            nsoz_count=[nsoz_count n];
        end;
      end;

    mean_soz_fr=[mean_soz_fr mean(soz_count)];
    stderr_soz_fr=[stderr_soz_fr std(soz_count)/sqrt(numel(unique_electrodes))];
    mean_nsoz_fr=[mean_nsoz_fr, mean(nsoz_count)];
    stderr_nsoz_fr=[stderr_nsoz_fr std(nsoz_count)/sqrt(numel(unique_electrodes))];

    total_fr(i)=n;
    n = numel(find(sozedges.patientvector==i));
    total_soz_edges(i)=n;
    n1 = numel(find(nsozsozedges.patientvector==i));
    n2 = numel(find(soznsozedges.patientvector==i));
    total_nsozsoz_edges(i)=n1+n2;
    n = numel(find(nsozedges.patientvector==i));
    total_nsoz_edges(i)=n;
end;

edge_count=vertcat(total_soz_edges, total_nsozsoz_edges, total_nsoz_edges);
total_fr=vertcat(mean_soz_fr,mean_nsoz_fr);
error_fr=vertcat(stderr_soz_fr,stderr_nsoz_fr);
figure
x=[1:46];
bar(x,total_fr);
hold on
x=vertcat(x-.15,x+.15)
er = errorbar(x,total_fr,error_fr,error_fr,'black');
xticks([[1:46]])
set(gca,'xticklabel',R3ALLpatientscoded)
title('number of FR per channel in SOZ and NSOZ')
hold off

figure
x=[1:46];
bar(x,edge_count)
xticks([[1:46]])
set(gca,'xticklabel',R3ALLpatientscoded)
title('number of FR propagating edges')

%stats
X1=mean_soz_fr;
Y1=total_soz_edges;
X2=mean_nsoz_fr;
Y2=(total_nsozsoz_edges+total_nsoz_edges);
disp('SOZ:SOZ')
mdl=fitlm(X1,Y1);
disp('NSOZ')
mdl=fitlm(X2,Y2);

figure
nsoz_locations=[];
counter=0;
for i=1:numel(nsozedges.locations)
    counter=counter+1;
    nsoz_locations(counter)=nsozedges.locations{i}(1);
    counter=counter+1;
    nsoz_locations(counter)=nsozedges.locations{i}(2);
end;
[nsozhist,xo]=hist(nsoz_locations,[1:9])
nsozsoz_locations=[];
counter=0;
for i=1:numel(nsozsozedges.locations)
    counter=counter+1;
    nsozsoz_locations(counter)=nsozsozedges.locations{i}(1);
    counter=counter+1;
    nsozsoz_locations(counter)=nsozsozedges.locations{i}(2);
end;
[nsozsozhist,xo]=hist(nsozsoz_locations,[1:9])
soznsoz_locations=[];
counter=0;
for i=1:numel(soznsozedges.locations)
    counter=counter+1;
    soznsoz_locations(counter)=soznsozedges.locations{i}(1);
    counter=counter+1;
    soznsoz_locations(counter)=soznsozedges.locations{i}(2);
end;
[soznsozhist,xo]=hist(soznsoz_locations,[1:9])
nsozsozhist=nsozsozhist+soznsozhist;
soz_locations=[];
counter=0;
for i=1:numel(sozedges.locations)
    counter=counter+1;
    soz_locations(counter)=sozedges.locations{i}(1);
    counter=counter+1;
    soz_locations(counter)=sozedges.locations{i}(2);
end;
[sozhist,xo]=hist(soz_locations,[1:9])
loc_edge_count=vertcat(sozhist,nsozsozhist,nsozhist);
bar(loc_edge_count')
title('edges by location')

clear  temp_table tempedges outliers_t outliers_table 

% Example raster plots for figure 1A
[idx,~]=find(FRpropertiesVr0306.FR_patient==4);
temp_properties=FRpropertiesVr0306(idx,:);
[idx,~]=find(ismember(temp_properties.FR_electrode_1,'POL LPF33')==1);
[idx2,~]=find(ismember(temp_properties.FR_electrode_2,'POL LPF31')==1);
[idx3]=intersect(idx,idx2);
temp_properties=temp_properties(idx3,:);
figure
hold on
x_plot=[];
y_plot=[];
for i=1:numel(temp_properties.FR_inout)
   if temp_properties.FR_inout(i)==0
        if temp_properties.FR_sign(i)==0
            x_plot(1:2)=[temp_properties.FR_start_t(i) temp_properties.FR_start_t(i)];
            y_plot(1:2)=[.25 -.25];
            plot(x_plot,y_plot,'black')
        else
            x_plot(1:2)=[temp_properties.FR_start_t(i) temp_properties.FR_start_t(i)];
            y_plot(1:2)=[.25 -.25];
            plot(x_plot,y_plot,'red')
        end;
   else
       if temp_properties.FR_sign(i)==0
            x_plot(1:2)=[temp_properties.FR_start_t(i) temp_properties.FR_start_t(i)];
            y_plot(1:2)=[-.25 -.75];
            plot(x_plot,y_plot,'black')
        else
            x_plot(1:2)=[temp_properties.FR_start_t(i) temp_properties.FR_start_t(i)];
            y_plot(1:2)=[-.25 -.75];
            plot(x_plot,y_plot,'red')
        end;
   end;
end;
title('4145 LPF33:LPF31')

% Example raster plots for figure 1B
[idx,~]=find(FRpropertiesVr0306.FR_patient==5);
temp_properties=FRpropertiesVr0306(idx,:);
[idx,~]=find(ismember(temp_properties.FR_electrode_1,'POL LL4')==1);
[idx2,~]=find(ismember(temp_properties.FR_electrode_2,'POL LP6')==1);
[idx3]=intersect(idx,idx2);
temp_properties=temp_properties(idx3,:);
figure
hold on
x_plot=[];
y_plot=[];
for i=1:numel(temp_properties.FR_inout)
   if temp_properties.FR_inout(i)==0
        if temp_properties.FR_sign(i)==0
            x_plot(1:2)=[temp_properties.FR_start_t(i) temp_properties.FR_start_t(i)];
            y_plot(1:2)=[.25 -.25];
            plot(x_plot,y_plot,'black')
        else
            x_plot(1:2)=[temp_properties.FR_start_t(i) temp_properties.FR_start_t(i)];
            y_plot(1:2)=[.25 -.25];
            plot(x_plot,y_plot,'red')
        end;
   else
       if temp_properties.FR_sign(i)==0
            x_plot(1:2)=[temp_properties.FR_start_t(i) temp_properties.FR_start_t(i)];
            y_plot(1:2)=[-.25 -.75];
            plot(x_plot,y_plot,'black')
        else
            x_plot(1:2)=[temp_properties.FR_start_t(i) temp_properties.FR_start_t(i)];
            y_plot(1:2)=[-.25 -.75];
            plot(x_plot,y_plot,'red')
        end;
   end;
end;
title('4163 LL4:LP6')

% Example raster plots for figure 1B
[idx,~]=find(FRpropertiesVr0306.FR_patient==45);
temp_properties=FRpropertiesVr0306(idx,:);
[idx,~]=find(ismember(temp_properties.FR_electrode_1,'POL Rc1')==1);
[idx2,~]=find(ismember(temp_properties.FR_electrode_2,'POL Rc3')==1);
[idx3]=intersect(idx,idx2);
temp_properties=temp_properties(idx3,:);
figure
hold on
x_plot=[];
y_plot=[];
for i=1:numel(temp_properties.FR_inout)
   if temp_properties.FR_inout(i)==0
        if temp_properties.FR_sign(i)==0
            x_plot(1:2)=[temp_properties.FR_start_t(i) temp_properties.FR_start_t(i)];
            y_plot(1:2)=[.25 -.25];
            plot(x_plot,y_plot,'black')
        else
            x_plot(1:2)=[temp_properties.FR_start_t(i) temp_properties.FR_start_t(i)];
            y_plot(1:2)=[.25 -.25];
            plot(x_plot,y_plot,'red')
        end;
   else
       if temp_properties.FR_sign(i)==0
            x_plot(1:2)=[temp_properties.FR_start_t(i) temp_properties.FR_start_t(i)];
            y_plot(1:2)=[-.25 -.75];
            plot(x_plot,y_plot,'black')
        else
            x_plot(1:2)=[temp_properties.FR_start_t(i) temp_properties.FR_start_t(i)];
            y_plot(1:2)=[-.25 -.75];
            plot(x_plot,y_plot,'red')
        end;
   end;
end;
title('IO002 RC1:RC3')

% Example raster plots for figure 1B
[idx,~]=find(FRpropertiesVr0306.FR_patient==22);
temp_properties=FRpropertiesVr0306(idx,:);
[idx,~]=find(ismember(temp_properties.FR_electrode_1,'POL RMS2')==1);
[idx2,~]=find(ismember(temp_properties.FR_electrode_2,'POL RS5')==1);
[idx3]=intersect(idx,idx2);
temp_properties=temp_properties(idx3,:);
figure
hold on
x_plot=[];
y_plot=[];
for i=1:numel(temp_properties.FR_inout)
   if temp_properties.FR_inout(i)==0
        if temp_properties.FR_sign(i)==0
            x_plot(1:2)=[temp_properties.FR_start_t(i) temp_properties.FR_start_t(i)];
            y_plot(1:2)=[.25 -.25];
            plot(x_plot,y_plot,'black')
        else
            x_plot(1:2)=[temp_properties.FR_start_t(i) temp_properties.FR_start_t(i)];
            y_plot(1:2)=[.25 -.25];
            plot(x_plot,y_plot,'red')
        end;
   else
       if temp_properties.FR_sign(i)==0
            x_plot(1:2)=[temp_properties.FR_start_t(i) temp_properties.FR_start_t(i)];
            y_plot(1:2)=[-.25 -.75];
            plot(x_plot,y_plot,'black')
        else
            x_plot(1:2)=[temp_properties.FR_start_t(i) temp_properties.FR_start_t(i)];
            y_plot(1:2)=[-.25 -.75];
            plot(x_plot,y_plot,'red')
        end;
   end;
end;
title('IO018 RMS2:RS5')

% Example raster plots for figure 1B
[idx,~]=find(FRpropertiesVr0306.FR_patient==38);
temp_properties=FRpropertiesVr0306(idx,:);
[idx,~]=find(ismember(temp_properties.FR_electrode_1,'POL LSMA10')==1);
[idx2,~]=find(ismember(temp_properties.FR_electrode_2,'POL LSMA8')==1);
[idx3]=intersect(idx,idx2);
temp_properties=temp_properties(idx3,:);
figure
hold on
x_plot=[];
y_plot=[];
for i=1:numel(temp_properties.FR_inout)
   if temp_properties.FR_inout(i)==0
        if temp_properties.FR_sign(i)==0
            x_plot(1:2)=[temp_properties.FR_start_t(i) temp_properties.FR_start_t(i)];
            y_plot(1:2)=[.25 -.25];
            plot(x_plot,y_plot,'black')
        else
            x_plot(1:2)=[temp_properties.FR_start_t(i) temp_properties.FR_start_t(i)];
            y_plot(1:2)=[.25 -.25];
            plot(x_plot,y_plot,'red')
        end;
   else
       if temp_properties.FR_sign(i)==0
            x_plot(1:2)=[temp_properties.FR_start_t(i) temp_properties.FR_start_t(i)];
            y_plot(1:2)=[-.25 -.75];
            plot(x_plot,y_plot,'black')
        else
            x_plot(1:2)=[temp_properties.FR_start_t(i) temp_properties.FR_start_t(i)];
            y_plot(1:2)=[-.25 -.75];
            plot(x_plot,y_plot,'red')
        end;
   end;
end;
title('IO022 LSMA10:LSMA8')

% Example raster plots for figure 1B
[idx,~]=find(FRpropertiesVr0306.FR_patient==5);
temp_properties=FRpropertiesVr0306(idx,:);
[idx,~]=find(ismember(temp_properties.FR_electrode_1,'POL LK6')==1);
[idx2,~]=find(ismember(temp_properties.FR_electrode_2,'POL LK15')==1);
[idx3]=intersect(idx,idx2);
temp_properties=temp_properties(idx3,:);
figure
hold on
x_plot=[];
y_plot=[];
for i=1:numel(temp_properties.FR_inout)
   if temp_properties.FR_inout(i)==0
        if temp_properties.FR_sign(i)==0
            x_plot(1:2)=[temp_properties.FR_start_t(i) temp_properties.FR_start_t(i)];
            y_plot(1:2)=[.25 -.25];
            plot(x_plot,y_plot,'black')
        else
            x_plot(1:2)=[temp_properties.FR_start_t(i) temp_properties.FR_start_t(i)];
            y_plot(1:2)=[.25 -.25];
            plot(x_plot,y_plot,'red')
        end;
   else
       if temp_properties.FR_sign(i)==0
            x_plot(1:2)=[temp_properties.FR_start_t(i) temp_properties.FR_start_t(i)];
            y_plot(1:2)=[-.25 -.75];
            plot(x_plot,y_plot,'black')
        else
            x_plot(1:2)=[temp_properties.FR_start_t(i) temp_properties.FR_start_t(i)];
            y_plot(1:2)=[-.25 -.75];
            plot(x_plot,y_plot,'red')
        end;
   end;
end;
title('4163 LK6:LK15')

% Example raster plots for figure 1B
[idx,~]=find(FRpropertiesVr0306.FR_patient==45);
temp_properties=FRpropertiesVr0306(idx,:);
[idx,~]=find(ismember(temp_properties.FR_electrode_1,'POL Ru3')==1);
[idx2,~]=find(ismember(temp_properties.FR_electrode_2,'POL Rd4')==1);
[idx3]=intersect(idx,idx2);
temp_properties=temp_properties(idx3,:);
figure
hold on
x_plot=[];
y_plot=[];
for i=1:numel(temp_properties.FR_inout)
   if temp_properties.FR_inout(i)==0
        if temp_properties.FR_sign(i)==0
            x_plot(1:2)=[temp_properties.FR_start_t(i) temp_properties.FR_start_t(i)];
            y_plot(1:2)=[.25 -.25];
            plot(x_plot,y_plot,'black')
        else
            x_plot(1:2)=[temp_properties.FR_start_t(i) temp_properties.FR_start_t(i)];
            y_plot(1:2)=[.25 -.25];
            plot(x_plot,y_plot,'red')
        end;
   else
       if temp_properties.FR_sign(i)==0
            x_plot(1:2)=[temp_properties.FR_start_t(i) temp_properties.FR_start_t(i)];
            y_plot(1:2)=[-.25 -.75];
            plot(x_plot,y_plot,'black')
        else
            x_plot(1:2)=[temp_properties.FR_start_t(i) temp_properties.FR_start_t(i)];
            y_plot(1:2)=[-.25 -.75];
            plot(x_plot,y_plot,'red')
        end;
   end;
end;
title('IO002 Ru3:Rd4')

% Example raster plots for figure 1B
[idx,~]=find(FRpropertiesVr0306.FR_patient==38);
temp_properties=FRpropertiesVr0306(idx,:);
[idx,~]=find(ismember(temp_properties.FR_electrode_1,'POL LSMA2')==1);
[idx2,~]=find(ismember(temp_properties.FR_electrode_2,'POL LM3')==1);
[idx3]=intersect(idx,idx2);
temp_properties=temp_properties(idx3,:);
figure
hold on
x_plot=[];
y_plot=[];
for i=1:numel(temp_properties.FR_inout)
   if temp_properties.FR_inout(i)==0
        if temp_properties.FR_sign(i)==0
            x_plot(1:2)=[temp_properties.FR_start_t(i) temp_properties.FR_start_t(i)];
            y_plot(1:2)=[.25 -.25];
            plot(x_plot,y_plot,'black')
        else
            x_plot(1:2)=[temp_properties.FR_start_t(i) temp_properties.FR_start_t(i)];
            y_plot(1:2)=[.25 -.25];
            plot(x_plot,y_plot,'red')
        end;
   else
       if temp_properties.FR_sign(i)==0
            x_plot(1:2)=[temp_properties.FR_start_t(i) temp_properties.FR_start_t(i)];
            y_plot(1:2)=[-.25 -.75];
            plot(x_plot,y_plot,'black')
        else
            x_plot(1:2)=[temp_properties.FR_start_t(i) temp_properties.FR_start_t(i)];
            y_plot(1:2)=[-.25 -.75];
            plot(x_plot,y_plot,'red')
        end;
   end;
end;
title('IO022 LSMA2:LM3')

% Example raster plots for figure 1B
[idx,~]=find(FRpropertiesVr0306.FR_patient==15);
temp_properties=FRpropertiesVr0306(idx,:);
[idx,~]=find(ismember(temp_properties.FR_electrode_1,'POL RA1')==1);
[idx2,~]=find(ismember(temp_properties.FR_electrode_2,'POL REC1')==1);
[idx3]=intersect(idx,idx2);
temp_properties=temp_properties(idx3,:);
figure
hold on
x_plot=[];
y_plot=[];
for i=1:numel(temp_properties.FR_inout)
   if temp_properties.FR_inout(i)==0
        if temp_properties.FR_sign(i)==0
            x_plot(1:2)=[temp_properties.FR_start_t(i) temp_properties.FR_start_t(i)];
            y_plot(1:2)=[.25 -.25];
            plot(x_plot,y_plot,'black')
        else
            x_plot(1:2)=[temp_properties.FR_start_t(i) temp_properties.FR_start_t(i)];
            y_plot(1:2)=[.25 -.25];
            plot(x_plot,y_plot,'red')
        end;
   else
       if temp_properties.FR_sign(i)==0
            x_plot(1:2)=[temp_properties.FR_start_t(i) temp_properties.FR_start_t(i)];
            y_plot(1:2)=[-.25 -.75];
            plot(x_plot,y_plot,'black')
        else
            x_plot(1:2)=[temp_properties.FR_start_t(i) temp_properties.FR_start_t(i)];
            y_plot(1:2)=[-.25 -.75];
            plot(x_plot,y_plot,'red')
        end;
   end;
end;
title('481 RA1:REC1')

% Example raster plots for figure 1B
[idx,~]=find(FRpropertiesVr0306.FR_patient==35);
temp_properties=FRpropertiesVr0306(idx,:);
[idx,~]=find(ismember(temp_properties.FR_electrode_1,'P`OL LPHG7-Ref')==1);
[idx2,~]=find(ismember(temp_properties.FR_electrode_2,'POL LSTG2-Ref')==1);
[idx3]=intersect(idx,idx2);
temp_properties=temp_properties(idx3,:);
figure
hold on
x_plot=[];
y_plot=[];
for i=1:numel(temp_properties.FR_inout)
   if temp_properties.FR_inout(i)==0
        if temp_properties.FR_sign(i)==0
            x_plot(1:2)=[temp_properties.FR_start_t(i) temp_properties.FR_start_t(i)];
            y_plot(1:2)=[.25 -.25];
            plot(x_plot,y_plot,'black')
        else
            x_plot(1:2)=[temp_properties.FR_start_t(i) temp_properties.FR_start_t(i)];
            y_plot(1:2)=[.25 -.25];
            plot(x_plot,y_plot,'red')
        end;
   else
       if temp_properties.FR_sign(i)==0
            x_plot(1:2)=[temp_properties.FR_start_t(i) temp_properties.FR_start_t(i)];
            y_plot(1:2)=[-.25 -.75];
            plot(x_plot,y_plot,'black')
        else
            x_plot(1:2)=[temp_properties.FR_start_t(i) temp_properties.FR_start_t(i)];
            y_plot(1:2)=[-.25 -.75];
            plot(x_plot,y_plot,'red')
        end;
   end;
end;
title('474 LPH7:LSTG')

% Example raster plots for figure 1B
[idx,~]=find(FRpropertiesVr0306.FR_patient==34);
temp_properties=FRpropertiesVr0306(idx,:);
[idx,~]=find(ismember(temp_properties.FR_electrode_1,'POL Rb3')==1);
[idx2,~]=find(ismember(temp_properties.FR_electrode_2,'POL Rk14')==1);
[idx3]=intersect(idx,idx2);
temp_properties=temp_properties(idx3,:);
figure
hold on
x_plot=[];
y_plot=[];
for i=1:numel(temp_properties.FR_inout)
   if temp_properties.FR_inout(i)==0
        if temp_properties.FR_sign(i)==0
            x_plot(1:2)=[temp_properties.FR_start_t(i) temp_properties.FR_start_t(i)];
            y_plot(1:2)=[.25 -.25];
            plot(x_plot,y_plot,'black')
        else
            x_plot(1:2)=[temp_properties.FR_start_t(i) temp_properties.FR_start_t(i)];
            y_plot(1:2)=[.25 -.25];
            plot(x_plot,y_plot,'red')
        end;
   else
       if temp_properties.FR_sign(i)==0
            x_plot(1:2)=[temp_properties.FR_start_t(i) temp_properties.FR_start_t(i)];
            y_plot(1:2)=[-.25 -.75];
            plot(x_plot,y_plot,'black')
        else
            x_plot(1:2)=[temp_properties.FR_start_t(i) temp_properties.FR_start_t(i)];
            y_plot(1:2)=[-.25 -.75];
            plot(x_plot,y_plot,'red')
        end;
   end;
end;
title('IO005 RB3:RK14')

% Example raster plots for figure 1B
[idx,~]=find(FRpropertiesVr0306.FR_patient==39);
temp_properties=FRpropertiesVr0306(idx,:);
[idx,~]=find(ismember(temp_properties.FR_electrode_1,'POL 1MC8')==1);
[idx2,~]=find(ismember(temp_properties.FR_electrode_2,'POL SMC4')==1);
[idx3]=intersect(idx,idx2);
temp_properties=temp_properties(idx3,:);
figure
hold on
x_plot=[];
y_plot=[];
for i=1:numel(temp_properties.FR_inout)
   if temp_properties.FR_inout(i)==0
        if temp_properties.FR_sign(i)==0
            x_plot(1:2)=[temp_properties.FR_start_t(i) temp_properties.FR_start_t(i)];
            y_plot(1:2)=[.25 -.25];
            plot(x_plot,y_plot,'black')
        else
            x_plot(1:2)=[temp_properties.FR_start_t(i) temp_properties.FR_start_t(i)];
            y_plot(1:2)=[.25 -.25];
            plot(x_plot,y_plot,'red')
        end;
   else
       if temp_properties.FR_sign(i)==0
            x_plot(1:2)=[temp_properties.FR_start_t(i) temp_properties.FR_start_t(i)];
            y_plot(1:2)=[-.25 -.75];
            plot(x_plot,y_plot,'black')
        else
            x_plot(1:2)=[temp_properties.FR_start_t(i) temp_properties.FR_start_t(i)];
            y_plot(1:2)=[-.25 -.75];
            plot(x_plot,y_plot,'red')
        end;
   end;
end;
title('IO019 1MC8:SMC4')

% Remove diagonal and extract montage data
montage_1=[];
montage_2=[];
parfor i=1:numel(FRpropertiesVr0306.FR_montage)
    montage_1(i)=str2num(FRpropertiesVr0306.FR_montage{i,1}{1}{1});
    montage_2(i)=str2num(FRpropertiesVr0306.FR_montage{i,1}{2}{1});
end;
FRpropertiesVr0306=removevars(FRpropertiesVr0306,'FR_montage');
FRpropertiesVr0306=addvars(FRpropertiesVr0306,montage_1','NewVariableNames','montage_1');
FRpropertiesVr0306=addvars(FRpropertiesVr0306,montage_2','NewVariableNames','montage_2');

temp1=FRpropertiesVr0306.FR_patient;
temp2=FRpropertiesVr0306.FR_freqs;
temp3=FRpropertiesVr0306.FR_duration;
temp4=FRpropertiesVr0306.FR_power;
temp5=FRpropertiesVr0306.FR_delay;
temp6=FRpropertiesVr0306.montage_1;
temp7=FRpropertiesVr0306.montage_2;
uniqueA=horzcat(temp1,temp2,temp3,temp4,temp5,temp6,temp7);
[C,ia,ic]=unique(uniqueA,'rows');
ia=sort(ia,'ascend');
FRpropertiesVr0306=FRpropertiesVr0306(ia,:);

% build R output datafile
temp1=FRpropertiesVr0306.FR_pairnum;
temp2=FRpropertiesVr0306.FR_inout;
temp3=FRpropertiesVr0306.FR_sign;
temp4=FRpropertiesVr0306.FR_elec1_SOZ;
temp5=FRpropertiesVr0306.FR_elec2_SOZ;
temp6=FRpropertiesVr0306.FR_elec1_loc;
temp7=FRpropertiesVr0306.montage_1;
temp8=FRpropertiesVr0306.montage_2;
temp9=FRpropertiesVr0306.FR_delta_angle;
[idx,~]=find(isnan(temp9)==1);
temp1(idx)=[];
temp2(idx)=[];
temp3(idx)=[];
temp4(idx)=[];
temp5(idx)=[];
temp6(idx)=[];
temp7(idx)=[];
temp8(idx)=[];
temp9(idx)=[];

temp10=[]; %master montage
for i=1:numel(temp2)
    if temp2(i)==0
     temp10(i)=temp7(i);
    else
     temp10(i)=temp8(i);
    end;
end;
temp10=temp10';

% NSOZ loc 1
[idx,~]=find(temp6==1);
[idx2,~]=find(temp4==0);
int1=intersect(idx,idx2);
Rinput_l1nsoz=horzcat(temp1(int1),temp2(int1),temp3(int1),temp10(int1),temp9(int1));
save('Rinput_l1nsoz.mat','Rinput_l1nsoz')
% NSOZ loc 2 
[idx,~]=find(temp6==2);
[idx2,~]=find(temp4==0);
int1=intersect(idx,idx2);
Rinput_l2nsoz=horzcat(temp1(int1),temp2(int1),temp3(int1),temp10(int1),temp9(int1));
save('Rinput_l2nsoz.mat','Rinput_l2nsoz')
% NSOZ loc 3
[idx,~]=find(temp6==3);
[idx2,~]=find(temp4==0);
int1=intersect(idx,idx2);
Rinput_l3nsoz=horzcat(temp1(int1),temp2(int1),temp3(int1),temp10(int1),temp9(int1));
save('Rinput_l3nsoz.mat','Rinput_l3nsoz')
% NSOZ loc 4
[idx,~]=find(temp6==4);
[idx2,~]=find(temp4==0);
int1=intersect(idx,idx2);
Rinput_l4nsoz=horzcat(temp1(int1),temp2(int1),temp3(int1),temp10(int1),temp9(int1));
save('Rinput_l4nsoz.mat','Rinput_l4nsoz')
% NSOZ loc >=5
[idx,~]=find(temp6>4);
[idx2,~]=find(temp4==0);
int1=intersect(idx,idx2);
Rinput_l5nsoz=horzcat(temp1(int1),temp2(int1),temp3(int1),temp10(int1),temp9(int1));
save('Rinput_l5nsoz.mat','Rinput_l5nsoz')

% SOZ loc 1
[idx,~]=find(temp6==1);
[idx2,~]=find(temp4==1);
int1=intersect(idx,idx2);
Rinput_l1soz=horzcat(temp1(int1),temp2(int1),temp3(int1),temp10(int1),temp9(int1));
save('Rinput_l1soz.mat','Rinput_l1soz')
% SOZ loc 2
[idx,~]=find(temp6==2);
[idx2,~]=find(temp4==1);
int1=intersect(idx,idx2);
Rinput_l2soz=horzcat(temp1(int1),temp2(int1),temp3(int1),temp10(int1),temp9(int1));
save('Rinput_l2soz.mat','Rinput_l2soz')
% SOZ loc 3
[idx,~]=find(temp6==3);
[idx2,~]=find(temp4==1);
int1=intersect(idx,idx2);
Rinput_l3soz=horzcat(temp1(int1),temp2(int1),temp3(int1),temp10(int1),temp9(int1));
save('Rinput_l3soz.mat','Rinput_l3soz')
% SOZ loc 4
[idx,~]=find(temp6==4);
[idx2,~]=find(temp4==1);
int1=intersect(idx,idx2);
Rinput_l4soz=horzcat(temp1(int1),temp2(int1),temp3(int1),temp10(int1),temp9(int1));
save('Rinput_l4soz.mat','Rinput_l4soz')
% SOZ loc >=5
[idx,~]=find(temp6>4);
[idx2,~]=find(temp4==1);
int1=intersect(idx,idx2);
Rinput_l5soz=horzcat(temp1(int1),temp2(int1),temp3(int1),temp10(int1),temp9(int1));
save('Rinput_l5soz.mat','Rinput_l5soz')

clear temp1 temp2 temp3 temp4 temp5 temp6 temp7 temp8 temp9 temp10 Rinput_l1nsoz Rinput_l2nsoz Rinput_l3nsoz Rinput_l4nsoz Rinput_l5nsoz Rinput_l1soz Rinput_l2soz Rinput_l3soz Rinput_l4soz Rinput_l5soz
% 
% glme = fitglme(FRpropertiesVr0306,'FR_freqs ~ 1 + FR_inout + FR_inout:FR_delay + montage_1:montage_2 + FR_sign:FR_inout +  FR_elec1_SOZ:FR_elec2_SOZ:FR_inout:FR_sign + FR_inout:FR_delay:FR_elec1_SOZ:FR_elec2_SOZ + FR_inout:FR_distance:FR_elec1_SOZ:FR_elec2_SOZ + FR_inout:FR_delay:FR_elec1_SOZ:FR_elec2_SOZ:montage_1:montage_2 + FR_inout:FR_sign:FR_delay + FR_inout:FR_sign:FR_delay:FR_elec1_SOZ:FR_elec2_SOZ + FR_inout:FR_sign:FR_distance:FR_elec1_SOZ:FR_elec2_SOZ + FR_inout:FR_sign:FR_delay:FR_elec1_SOZ:FR_elec2_SOZ:montage_1:montage_2 + (1|FR_pairnum)', ...
% 'Distribution','Gaussian','Link','log','FitMethod','Laplace', ...
% 'DummyVarCoding','effects');
% fprintf('FRonO prop freq corr');
% disp(glme)
% glme = fitglme(FRpropertiesVr0306,'FR_duration ~ 1 + FR_inout + FR_inout:FR_delay + montage_1:montage_2 + FR_sign:FR_inout +  FR_elec1_SOZ:FR_elec2_SOZ:FR_inout:FR_sign + FR_inout:FR_delay:FR_elec1_SOZ:FR_elec2_SOZ + FR_inout:FR_distance:FR_elec1_SOZ:FR_elec2_SOZ + FR_inout:FR_distance:FR_elec1_SOZ:FR_elec2_SOZ:montage_1:montage_2 + FR_inout:FR_sign:FR_delay + FR_inout:FR_sign:FR_delay:FR_elec1_SOZ:FR_elec2_SOZ + FR_inout:FR_sign:FR_distance:FR_elec1_SOZ:FR_elec2_SOZ + FR_inout:FR_sign:FR_distance:FR_elec1_SOZ:FR_elec2_SOZ:montage_1:montage_2 + (1|FR_pairnum)', ...
% 'Distribution','Gaussian','Link','log','FitMethod','Laplace', ...
% 'DummyVarCoding','effects');
% fprintf('FRonO prop duration corr');
% disp(glme)
% glme = fitglme(FRpropertiesVr0306,'FR_power ~ 1 + FR_inout + montage_1:montage_2 + FR_inout:FR_sign:FR_delay:montage_1:montage_2 + FR_inout:FR_delay + FR_sign:FR_inout +  FR_elec1_SOZ:FR_elec2_SOZ:FR_inout:FR_sign + FR_elec1_SOZ:FR_elec2_SOZ:FR_inout:FR_sign:montage_1:montage_2 + FR_inout:FR_delay:FR_elec1_SOZ:FR_elec2_SOZ + FR_inout:FR_distance:FR_elec1_SOZ:FR_elec2_SOZ + FR_inout:FR_sign:FR_delay + FR_inout:FR_sign:FR_delay:FR_elec1_SOZ:FR_elec2_SOZ + FR_inout:FR_sign:FR_distance:FR_elec1_SOZ:FR_elec2_SOZ + (1|FR_pairnum)', ...
% 'Distribution','Gaussian','Link','log','FitMethod','Laplace', ...
% 'DummyVarCoding','effects');
% fprintf('FRonO prop power corr');
% disp(glme)

% Plots for FR frequency
% SOZ
[idx,~]=find(FRpropertiesVr0306.FR_elec1_SOZ==1);
[idx2,~]=find(FRpropertiesVr0306.FR_elec2_SOZ==1);
[int]=intersect(idx,idx2);
SOZproperties=FRpropertiesVr0306(int,:);
[idx_in,~]=find(SOZproperties.FR_inout==0);
[idx_out,~]=find(SOZproperties.FR_inout==1);
[idx_sign0,~]=find(SOZproperties.FR_sign==0);
[idx_sign1,~]=find(SOZproperties.FR_sign==1);
[int_insign0]=intersect(idx_in,idx_sign0);
[int_insign1]=intersect(idx_in,idx_sign1);
[int_outsign0]=intersect(idx_out,idx_sign0);
[int_outsign1]=intersect(idx_out,idx_sign1);
insign0properties=SOZproperties(int_insign0,:);
insign1properties=SOZproperties(int_insign1,:);
outsign0properties=SOZproperties(int_outsign0,:);
outsign1properties=SOZproperties(int_outsign1,:);

figure
scatter(abs(insign0properties.FR_delay),insign0properties.FR_freqs,9,'.','MarkerEdgeColor',[0 0 1])
hold on
scatter(abs(outsign0properties.FR_delay),outsign0properties.FR_freqs,9,'.','MarkerEdgeColor',[1 0 0])
scatter(abs(insign1properties.FR_delay),insign1properties.FR_freqs,9,'.','MarkerEdgeColor',[.9922 .7216 0.0745])
scatter(abs(outsign1properties.FR_delay),outsign1properties.FR_freqs,9,'.','MarkerEdgeColor',[0 1 1])
title('frono frequency change with propagation in SOZ:SOZ')
subtitle('blue: non-prop out, red:non-prop in, yellow: prop out, cyan: prop in')
xlabel('propagation delay')
ylabel('FR frequency HZ')

figure
hold on
% in sign 0 really means out
[delay_t,~]= unique(abs(insign0properties.FR_delay))
insign0_mean=[];
insign0_stderr=[];
for i=1:numel(delay_t)
   [idx,~]=find(abs(insign0properties.FR_delay)==delay_t(i))
   insign0_mean(i)=nanmean(insign0properties.FR_freqs(idx));
   insign0_stderr(i)=nanstd(insign0properties.FR_freqs(idx))/(sqrt(numel(idx)))
end;
scatter(log10(delay_t),insign0_mean,20,'.','MarkerEdgeColor',[0 0 1])
errorbar(log10(delay_t),insign0_mean,insign0_stderr,'.','MarkerEdgeColor',[0 0 1],'LineStyle','none', 'Color',[0 0 1],'linewidth', .5)
% out sign 0 
outsign0_mean=[];
outsign0_stderr=[];
for i=1:numel(delay_t)
   [idx,~]=find(abs(outsign0properties.FR_delay)==delay_t(i))
   outsign0_mean(i)=nanmean(outsign0properties.FR_freqs(idx));
   outsign0_stderr(i)=nanstd(outsign0properties.FR_freqs(idx))/(sqrt(numel(idx)))
end;
scatter(log10(delay_t),outsign0_mean,20,'.','MarkerEdgeColor',[1 0 0])
errorbar(log10(delay_t),outsign0_mean,outsign0_stderr,'.','MarkerEdgeColor',[1 0 0],'LineStyle','none', 'Color',[1 0 0],'linewidth', .5)
% in sign 1 
insign1_mean=[];
insign1_stderr=[];
for i=1:numel(delay_t)
   [idx,~]=find(abs(insign1properties.FR_delay)==delay_t(i))
   insign1_mean(i)=nanmean(insign1properties.FR_freqs(idx));
   insign1_stderr(i)=nanstd(insign1properties.FR_freqs(idx))/(sqrt(numel(idx)))
end;
scatter(log10(delay_t),insign1_mean,20,'.','MarkerEdgeColor',[.9922 .7216 0.0745])
errorbar(log10(delay_t),insign1_mean,insign0_stderr,'.','MarkerEdgeColor',[.9922 .7216 0.0745],'LineStyle','none', 'Color',[.9922 .7216 0.0745],'linewidth', .5)
% out sign 1 
outsign1_mean=[];
outsign1_stderr=[];
for i=1:numel(delay_t)
   [idx,~]=find(abs(outsign1properties.FR_delay)==delay_t(i))
   outsign1_mean(i)=nanmean(outsign1properties.FR_freqs(idx));
   outsign1_stderr(i)=nanstd(outsign1properties.FR_freqs(idx))/(sqrt(numel(idx)))
end;
scatter(log10(delay_t),outsign1_mean,20,'.','MarkerEdgeColor',[0 1 1])
errorbar(log10(delay_t),outsign1_mean,insign0_stderr,'.','MarkerEdgeColor',[0 1 1],'LineStyle','none', 'Color',[0 1 1],'linewidth', .5)
title('frono frequency change with propagation in SOZ:SOZ')
subtitle('blue: non-prop out, red:non-prop in, yellow: prop out, cyan: prop in')
xlabel('log10(propagation delay)')
ylabel('FR frequency HZ')

figure
scatter(abs(insign0properties.FR_delay),insign0properties.FR_duration,9,'.','MarkerEdgeColor',[0 0 1])
hold on
scatter(abs(outsign0properties.FR_delay),outsign0properties.FR_duration,9,'.','MarkerEdgeColor',[1 0 0])
scatter(abs(insign1properties.FR_delay),insign1properties.FR_duration,9,'.','MarkerEdgeColor',[.9922 .7216 0.0745])
scatter(abs(outsign1properties.FR_delay),outsign1properties.FR_duration,9,'.','MarkerEdgeColor',[0 1 1])
title('frono duration change with propagation in SOZ:SOZ')
subtitle('blue: non-prop out, red:non-prop in, yellow: prop out, cyan: prop in')
xlabel('propagation delay')
ylabel('FR duration seconds')

figure
hold on
% in sign 0 really means out
[distance_t,~]= unique(abs(insign0properties.FR_distance))
insign0_mean=[];
insign0_stderr=[];
for i=1:numel(distance_t)
   [idx,~]=find(abs(insign0properties.FR_distance)==distance_t(i))
   insign0_mean(i)=nanmean(insign0properties.FR_duration(idx));
   insign0_stderr(i)=nanstd(insign0properties.FR_duration(idx))/(sqrt(numel(idx)))
end;
scatter(log10(distance_t),insign0_mean,20,'.','MarkerEdgeColor',[0 0 1])
errorbar(log10(distance_t),insign0_mean,insign0_stderr,'.','MarkerEdgeColor',[0 0 1],'LineStyle','none', 'Color',[0 0 1],'linewidth', .5)
% out sign 0 
outsign0_mean=[];
outsign0_stderr=[];
for i=1:numel(distance_t)
   [idx,~]=find(abs(outsign0properties.FR_distance)==distance_t(i))
   outsign0_mean(i)=nanmean(outsign0properties.FR_duration(idx));
   outsign0_stderr(i)=nanstd(outsign0properties.FR_duration(idx))/(sqrt(numel(idx)))
end;
scatter(log10(distance_t),outsign0_mean,20,'.','MarkerEdgeColor',[1 0 0])
errorbar(log10(distance_t),outsign0_mean,outsign0_stderr,'.','MarkerEdgeColor',[1 0 0],'LineStyle','none', 'Color',[1 0 0],'linewidth', .5)
% in sign 1 
insign1_mean=[];
insign1_stderr=[];
for i=1:numel(distance_t)
   [idx,~]=find(abs(insign1properties.FR_distance)==distance_t(i))
   insign1_mean(i)=nanmean(insign1properties.FR_duration(idx));
   insign1_stderr(i)=nanstd(insign1properties.FR_duration(idx))/(sqrt(numel(idx)))
end;
scatter(log10(distance_t),insign1_mean,20,'.','MarkerEdgeColor',[.9922 .7216 0.0745])
errorbar(log10(distance_t),insign1_mean,insign0_stderr,'.','MarkerEdgeColor',[.9922 .7216 0.0745],'LineStyle','none', 'Color',[.9922 .7216 0.0745],'linewidth', .5)
% out sign 1 
outsign1_mean=[];
outsign1_stderr=[];
for i=1:numel(distance_t)
   [idx,~]=find(abs(outsign1properties.FR_distance)==distance_t(i))
   outsign1_mean(i)=nanmean(outsign1properties.FR_duration(idx));
   outsign1_stderr(i)=nanstd(outsign1properties.FR_duration(idx))/(sqrt(numel(idx)))
end;
scatter(log10(distance_t),outsign1_mean,20,'.','MarkerEdgeColor',[0 1 1])
errorbar(log10(distance_t),outsign1_mean,insign0_stderr,'.','MarkerEdgeColor',[0 1 1],'LineStyle','none', 'Color',[0 1 1],'linewidth', .5)
title('frono duration change with propagation in SOZ:SOZ')
subtitle('blue: non-prop out, red:non-prop in, yellow: prop out, cyan: prop in')
xlabel('log10(propagation distance)')
ylabel('FR duration seconds')

figure
scatter(abs(insign0properties.FR_delay),insign0properties.FR_power,9,'.','MarkerEdgeColor',[0 0 1])
hold on
scatter(abs(outsign0properties.FR_delay),outsign0properties.FR_power,9,'.','MarkerEdgeColor',[1 0 0])
scatter(abs(insign1properties.FR_delay),insign1properties.FR_power,9,'.','MarkerEdgeColor',[.9922 .7216 0.0745])
scatter(abs(outsign1properties.FR_delay),outsign1properties.FR_power,9,'.','MarkerEdgeColor',[0 1 1])
title('frono power change with propagation in SOZ:SOZ')
subtitle('blue: non-prop out, red:non-prop in, yellow: prop out, cyan: prop in')
xlabel('propagation delay')
ylabel('FR power AU')
ylim([0 5e6])

figure
hold on
% in sign 0 really means out
[delay_t,~]= unique(abs(insign0properties.FR_delay))
insign0_mean=[];
insign0_stderr=[];
for i=1:numel(delay_t)
   [idx,~]=find(abs(insign0properties.FR_delay)==delay_t(i))
   insign0_mean(i)=nanmean(insign0properties.FR_power(idx));
   insign0_stderr(i)=nanstd(insign0properties.FR_power(idx))/(sqrt(numel(idx)))
end;
scatter(log10(delay_t),insign0_mean,20,'.','MarkerEdgeColor',[0 0 1])
errorbar(log10(delay_t),insign0_mean,insign0_stderr,'.','MarkerEdgeColor',[0 0 1],'LineStyle','none', 'Color',[0 0 1],'linewidth', .5)
% out sign 0 
outsign0_mean=[];
outsign0_stderr=[];
for i=1:numel(delay_t)
   [idx,~]=find(abs(outsign0properties.FR_delay)==delay_t(i))
   outsign0_mean(i)=nanmean(outsign0properties.FR_power(idx));
   outsign0_stderr(i)=nanstd(outsign0properties.FR_power(idx))/(sqrt(numel(idx)))
end;
scatter(log10(delay_t),outsign0_mean,20,'.','MarkerEdgeColor',[1 0 0])
errorbar(log10(delay_t),outsign0_mean,outsign0_stderr,'.','MarkerEdgeColor',[1 0 0],'LineStyle','none', 'Color',[1 0 0],'linewidth', .5)
% in sign 1 
insign1_mean=[];
insign1_stderr=[];
for i=1:numel(delay_t)
   [idx,~]=find(abs(insign1properties.FR_delay)==delay_t(i))
   insign1_mean(i)=nanmean(insign1properties.FR_power(idx));
   insign1_stderr(i)=nanstd(insign1properties.FR_power(idx))/(sqrt(numel(idx)))
end;
scatter(log10(delay_t),insign1_mean,20,'.','MarkerEdgeColor',[.9922 .7216 0.0745])
errorbar(log10(delay_t),insign1_mean,insign0_stderr,'.','MarkerEdgeColor',[.9922 .7216 0.0745],'LineStyle','none', 'Color',[.9922 .7216 0.0745],'linewidth', .5)
% out sign 1 
outsign1_mean=[];
outsign1_stderr=[];
for i=1:numel(delay_t)
   [idx,~]=find(abs(outsign1properties.FR_delay)==delay_t(i))
   outsign1_mean(i)=nanmean(outsign1properties.FR_power(idx));
   outsign1_stderr(i)=nanstd(outsign1properties.FR_power(idx))/(sqrt(numel(idx)))
end;
scatter(log10(delay_t),outsign1_mean,20,'.','MarkerEdgeColor',[0 1 1])
errorbar(log10(delay_t),outsign1_mean,insign0_stderr,'.','MarkerEdgeColor',[0 1 1],'LineStyle','none', 'Color',[0 1 1],'linewidth', .5)
title('frono power change with propagation in SOZ:SOZ')
subtitle('blue: non-prop out, red:non-prop in, yellow: prop out, cyan: prop in')
xlabel('log10(propagation delay)')
ylabel('FR power AU')

% SOZ/NSOZ
[idx,~]=find(FRpropertiesVr0306.FR_elec1_SOZ==1);
[idx2,~]=find(FRpropertiesVr0306.FR_elec2_SOZ==0);
[int]=intersect(idx,idx2);
[idx,~]=find(FRpropertiesVr0306.FR_elec1_SOZ==0);
[idx2,~]=find(FRpropertiesVr0306.FR_elec2_SOZ==1);
[int2]=intersect(idx,idx2);
int=unique(vertcat(int,int2));
SOZproperties=FRpropertiesVr0306(int,:);
[idx_in,~]=find(SOZproperties.FR_inout==0);
[idx_out,~]=find(SOZproperties.FR_inout==1);
[idx_sign0,~]=find(SOZproperties.FR_sign==0);
[idx_sign1,~]=find(SOZproperties.FR_sign==1);
[int_insign0]=intersect(idx_in,idx_sign0);
[int_insign1]=intersect(idx_in,idx_sign1);
[int_outsign0]=intersect(idx_out,idx_sign0);
[int_outsign1]=intersect(idx_out,idx_sign1);
insign0properties=SOZproperties(int_insign0,:);
insign1properties=SOZproperties(int_insign1,:);
outsign0properties=SOZproperties(int_outsign0,:);
outsign1properties=SOZproperties(int_outsign1,:);

figure
scatter(abs(insign0properties.FR_delay),insign0properties.FR_freqs,9,'.','MarkerEdgeColor',[0 0 1])
hold on
scatter(abs(outsign0properties.FR_delay),outsign0properties.FR_freqs,9,'.','MarkerEdgeColor',[1 0 0])
scatter(abs(insign1properties.FR_delay),insign1properties.FR_freqs,9,'.','MarkerEdgeColor',[.9922 .7216 0.0745])
scatter(abs(outsign1properties.FR_delay),outsign1properties.FR_freqs,9,'.','MarkerEdgeColor',[0 1 1])
title('frono frequency change with propagation in NSOZ:SOZ')
subtitle('blue: non-prop out, red:non-prop in, yellow: prop out, cyan: prop in')
xlabel('propagation delay')
ylabel('FR frequency HZ')

figure
hold on
% in sign 0 really means out
[delay_t,~]= unique(abs(insign0properties.FR_delay))
insign0_mean=[];
insign0_stderr=[];
for i=1:numel(delay_t)
   [idx,~]=find(abs(insign0properties.FR_delay)==delay_t(i))
   insign0_mean(i)=nanmean(insign0properties.FR_freqs(idx));
   insign0_stderr(i)=nanstd(insign0properties.FR_freqs(idx))/(sqrt(numel(idx)))
end;
scatter(log10(delay_t),insign0_mean,20,'.','MarkerEdgeColor',[0 0 1])
errorbar(log10(delay_t),insign0_mean,insign0_stderr,'.','MarkerEdgeColor',[0 0 1],'LineStyle','none', 'Color',[0 0 1],'linewidth', .5)
% out sign 0 
outsign0_mean=[];
outsign0_stderr=[];
for i=1:numel(delay_t)
   [idx,~]=find(abs(outsign0properties.FR_delay)==delay_t(i))
   outsign0_mean(i)=nanmean(outsign0properties.FR_freqs(idx));
   outsign0_stderr(i)=nanstd(outsign0properties.FR_freqs(idx))/(sqrt(numel(idx)))
end;
scatter(log10(delay_t),outsign0_mean,20,'.','MarkerEdgeColor',[1 0 0])
errorbar(log10(delay_t),outsign0_mean,outsign0_stderr,'.','MarkerEdgeColor',[1 0 0],'LineStyle','none', 'Color',[1 0 0],'linewidth', .5)
% in sign 1 
insign1_mean=[];
insign1_stderr=[];
for i=1:numel(delay_t)
   [idx,~]=find(abs(insign1properties.FR_delay)==delay_t(i))
   insign1_mean(i)=nanmean(insign1properties.FR_freqs(idx));
   insign1_stderr(i)=nanstd(insign1properties.FR_freqs(idx))/(sqrt(numel(idx)))
end;
scatter(log10(delay_t),insign1_mean,20,'.','MarkerEdgeColor',[.9922 .7216 0.0745])
errorbar(log10(delay_t),insign1_mean,insign0_stderr,'.','MarkerEdgeColor',[.9922 .7216 0.0745],'LineStyle','none', 'Color',[.9922 .7216 0.0745],'linewidth', .5)
% out sign 1 
outsign1_mean=[];
outsign1_stderr=[];
for i=1:numel(delay_t)
   [idx,~]=find(abs(outsign1properties.FR_delay)==delay_t(i))
   outsign1_mean(i)=nanmean(outsign1properties.FR_freqs(idx));
   outsign1_stderr(i)=nanstd(outsign1properties.FR_freqs(idx))/(sqrt(numel(idx)))
end;
scatter(log10(delay_t),outsign1_mean,20,'.','MarkerEdgeColor',[0 1 1])
errorbar(log10(delay_t),outsign1_mean,insign0_stderr,'.','MarkerEdgeColor',[0 1 1],'LineStyle','none', 'Color',[0 1 1],'linewidth', .5)
title('frono frequency change with propagation in NSOZ:SOZ')
subtitle('blue: non-prop out, red:non-prop in, yellow: prop out, cyan: prop in')
xlabel('log10(propagation delay)')
ylabel('FR frequency HZ')
ylim([200 500])

figure
scatter(abs(insign0properties.FR_delay),insign0properties.FR_duration,9,'.','MarkerEdgeColor',[0 0 1])
hold on
scatter(abs(outsign0properties.FR_delay),outsign0properties.FR_duration,9,'.','MarkerEdgeColor',[1 0 0])
scatter(abs(insign1properties.FR_delay),insign1properties.FR_duration,9,'.','MarkerEdgeColor',[.9922 .7216 0.0745])
scatter(abs(outsign1properties.FR_delay),outsign1properties.FR_duration,9,'.','MarkerEdgeColor',[0 1 1])
title('frono duration change with propagation in NSOZ:SOZ')
subtitle('blue: non-prop out, red:non-prop in, yellow: prop out, cyan: prop in')
xlabel('propagation delay')
ylabel('FR duration seconds')

figure
hold on
% in sign 0 really means out
[distance_t,~]= unique(abs(insign0properties.FR_distance))
insign0_mean=[];
insign0_stderr=[];
for i=1:numel(distance_t)
   [idx,~]=find(abs(insign0properties.FR_distance)==distance_t(i))
   insign0_mean(i)=nanmean(insign0properties.FR_duration(idx));
   insign0_stderr(i)=nanstd(insign0properties.FR_duration(idx))/(sqrt(numel(idx)))
end;
scatter(log10(distance_t),insign0_mean,20,'.','MarkerEdgeColor',[0 0 1])
errorbar(log10(distance_t),insign0_mean,insign0_stderr,'.','MarkerEdgeColor',[0 0 1],'LineStyle','none', 'Color',[0 0 1],'linewidth', .5)
% out sign 0 
outsign0_mean=[];
outsign0_stderr=[];
for i=1:numel(distance_t)
   [idx,~]=find(abs(outsign0properties.FR_distance)==distance_t(i))
   outsign0_mean(i)=nanmean(outsign0properties.FR_duration(idx));
   outsign0_stderr(i)=nanstd(outsign0properties.FR_duration(idx))/(sqrt(numel(idx)))
end;
scatter(log10(distance_t),outsign0_mean,20,'.','MarkerEdgeColor',[1 0 0])
errorbar(log10(distance_t),outsign0_mean,outsign0_stderr,'.','MarkerEdgeColor',[1 0 0],'LineStyle','none', 'Color',[1 0 0],'linewidth', .5)
% in sign 1 
insign1_mean=[];
insign1_stderr=[];
for i=1:numel(distance_t)
   [idx,~]=find(abs(insign1properties.FR_distance)==distance_t(i))
   insign1_mean(i)=nanmean(insign1properties.FR_duration(idx));
   insign1_stderr(i)=nanstd(insign1properties.FR_duration(idx))/(sqrt(numel(idx)))
end;
scatter(log10(distance_t),insign1_mean,20,'.','MarkerEdgeColor',[.9922 .7216 0.0745])
errorbar(log10(distance_t),insign1_mean,insign0_stderr,'.','MarkerEdgeColor',[.9922 .7216 0.0745],'LineStyle','none', 'Color',[.9922 .7216 0.0745],'linewidth', .5)
% out sign 1 
outsign1_mean=[];
outsign1_stderr=[];
for i=1:numel(distance_t)
   [idx,~]=find(abs(outsign1properties.FR_distance)==distance_t(i))
   outsign1_mean(i)=nanmean(outsign1properties.FR_duration(idx));
   outsign1_stderr(i)=nanstd(outsign1properties.FR_duration(idx))/(sqrt(numel(idx)))
end;
scatter(log10(distance_t),outsign1_mean,20,'.','MarkerEdgeColor',[0 1 1])
errorbar(log10(distance_t),outsign1_mean,insign0_stderr,'.','MarkerEdgeColor',[0 1 1],'LineStyle','none', 'Color',[0 1 1],'linewidth', .5)
title('frono duration change with propagation in SOZ:NSOZ')
subtitle('blue: non-prop out, red:non-prop in, yellow: prop out, cyan: prop in')
xlabel('log10(propagation distance)')
ylabel('FR duration seconds')


figure
scatter(abs(insign0properties.FR_delay),insign0properties.FR_power,9,'.','MarkerEdgeColor',[0 0 1])
hold on
scatter(abs(outsign0properties.FR_delay),outsign0properties.FR_power,9,'.','MarkerEdgeColor',[1 0 0])
scatter(abs(insign1properties.FR_delay),insign1properties.FR_power,9,'.','MarkerEdgeColor',[.9922 .7216 0.0745])
scatter(abs(outsign1properties.FR_delay),outsign1properties.FR_power,9,'.','MarkerEdgeColor',[0 1 1])
title('frono power change with propagation in NSOZ:SOZ')
subtitle('blue: non-prop out, red:non-prop in, yellow: prop out, cyan: prop in')
xlabel('propagation delay')
ylabel('FR power AU')
ylim([0 5e6])

figure
hold on
% in sign 0 really means out
[delay_t,~]= unique(abs(insign0properties.FR_delay))
insign0_mean=[];
insign0_stderr=[];
for i=1:numel(delay_t)
   [idx,~]=find(abs(insign0properties.FR_delay)==delay_t(i))
   insign0_mean(i)=nanmean(insign0properties.FR_power(idx));
   insign0_stderr(i)=nanstd(insign0properties.FR_power(idx))/(sqrt(numel(idx)))
end;
scatter(log10(delay_t),insign0_mean,20,'.','MarkerEdgeColor',[0 0 1])
errorbar(log10(delay_t),insign0_mean,insign0_stderr,'.','MarkerEdgeColor',[0 0 1],'LineStyle','none', 'Color',[0 0 1],'linewidth', .5)
% out sign 0 
outsign0_mean=[];
outsign0_stderr=[];
for i=1:numel(delay_t)
   [idx,~]=find(abs(outsign0properties.FR_delay)==delay_t(i))
   outsign0_mean(i)=nanmean(outsign0properties.FR_power(idx));
   outsign0_stderr(i)=nanstd(outsign0properties.FR_power(idx))/(sqrt(numel(idx)))
end;
scatter(log10(delay_t),outsign0_mean,20,'.','MarkerEdgeColor',[1 0 0])
errorbar(log10(delay_t),outsign0_mean,outsign0_stderr,'.','MarkerEdgeColor',[1 0 0],'LineStyle','none', 'Color',[1 0 0],'linewidth', .5)
% in sign 1 
insign1_mean=[];
insign1_stderr=[];
for i=1:numel(delay_t)
   [idx,~]=find(abs(insign1properties.FR_delay)==delay_t(i))
   insign1_mean(i)=nanmean(insign1properties.FR_power(idx));
   insign1_stderr(i)=nanstd(insign1properties.FR_power(idx))/(sqrt(numel(idx)))
end;
scatter(log10(delay_t),insign1_mean,20,'.','MarkerEdgeColor',[.9922 .7216 0.0745])
errorbar(log10(delay_t),insign1_mean,insign0_stderr,'.','MarkerEdgeColor',[.9922 .7216 0.0745],'LineStyle','none', 'Color',[.9922 .7216 0.0745],'linewidth', .5)
% out sign 1 
outsign1_mean=[];
outsign1_stderr=[];
for i=1:numel(delay_t)
   [idx,~]=find(abs(outsign1properties.FR_delay)==delay_t(i))
   outsign1_mean(i)=nanmean(outsign1properties.FR_power(idx));
   outsign1_stderr(i)=nanstd(outsign1properties.FR_power(idx))/(sqrt(numel(idx)))
end;
scatter(log10(delay_t),outsign1_mean,20,'.','MarkerEdgeColor',[0 1 1])
errorbar(log10(delay_t),outsign1_mean,insign0_stderr,'.','MarkerEdgeColor',[0 1 1],'LineStyle','none', 'Color',[0 1 1],'linewidth', .5)
title('frono power change with propagation in NSOZ:SOZ')
subtitle('blue: non-prop out, red:non-prop in, yellow: prop out, cyan: prop in')
xlabel('log10(propagation delay)')
ylabel('FR power AU')

% NSOZ
[idx,~]=find(FRpropertiesVr0306.FR_elec1_SOZ==0);
[idx2,~]=find(FRpropertiesVr0306.FR_elec2_SOZ==0);
[int]=intersect(idx,idx2);
SOZproperties=FRpropertiesVr0306(int,:);
[idx_in,~]=find(SOZproperties.FR_inout==0);
[idx_out,~]=find(SOZproperties.FR_inout==1);
[idx_sign0,~]=find(SOZproperties.FR_sign==0);
[idx_sign1,~]=find(SOZproperties.FR_sign==1);
[int_insign0]=intersect(idx_in,idx_sign0);
[int_insign1]=intersect(idx_in,idx_sign1);
[int_outsign0]=intersect(idx_out,idx_sign0);
[int_outsign1]=intersect(idx_out,idx_sign1);
insign0properties=SOZproperties(int_insign0,:);
insign1properties=SOZproperties(int_insign1,:);
outsign0properties=SOZproperties(int_outsign0,:);
outsign1properties=SOZproperties(int_outsign1,:);

figure
scatter(abs(insign0properties.FR_delay),insign0properties.FR_freqs,9,'.','MarkerEdgeColor',[0 0 1])
hold on
scatter(abs(outsign0properties.FR_delay),outsign0properties.FR_freqs,9,'.','MarkerEdgeColor',[1 0 0])
scatter(abs(insign1properties.FR_delay),insign1properties.FR_freqs,9,'.','MarkerEdgeColor',[.9922 .7216 0.0745])
scatter(abs(outsign1properties.FR_delay),outsign1properties.FR_freqs,9,'.','MarkerEdgeColor',[0 1 1])
title('frono frequency change with propagation in NSOZ')
subtitle('blue: non-prop out, red:non-prop in, yellow: prop out, cyan: prop in')
xlabel('propagation delay')
ylabel('FR frequency HZ')

figure
hold on
% in sign 0 really means out
[delay_t,~]= unique(abs(insign0properties.FR_delay))
insign0_mean=[];
insign0_stderr=[];
for i=1:numel(delay_t)
   [idx,~]=find(abs(insign0properties.FR_delay)==delay_t(i))
   insign0_mean(i)=nanmean(insign0properties.FR_freqs(idx));
   insign0_stderr(i)=nanstd(insign0properties.FR_freqs(idx))/(sqrt(numel(idx)))
end;
scatter(log10(delay_t),insign0_mean,20,'.','MarkerEdgeColor',[0 0 1])
errorbar(log10(delay_t),insign0_mean,insign0_stderr,'.','MarkerEdgeColor',[0 0 1],'LineStyle','none', 'Color',[0 0 1],'linewidth', .5)
% out sign 0 
outsign0_mean=[];
outsign0_stderr=[];
for i=1:numel(delay_t)
   [idx,~]=find(abs(outsign0properties.FR_delay)==delay_t(i))
   outsign0_mean(i)=nanmean(outsign0properties.FR_freqs(idx));
   outsign0_stderr(i)=nanstd(outsign0properties.FR_freqs(idx))/(sqrt(numel(idx)))
end;
scatter(log10(delay_t),outsign0_mean,20,'.','MarkerEdgeColor',[1 0 0])
errorbar(log10(delay_t),outsign0_mean,outsign0_stderr,'.','MarkerEdgeColor',[1 0 0],'LineStyle','none', 'Color',[1 0 0],'linewidth', .5)
% in sign 1 
insign1_mean=[];
insign1_stderr=[];
for i=1:numel(delay_t)
   [idx,~]=find(abs(insign1properties.FR_delay)==delay_t(i))
   insign1_mean(i)=nanmean(insign1properties.FR_freqs(idx));
   insign1_stderr(i)=nanstd(insign1properties.FR_freqs(idx))/(sqrt(numel(idx)))
end;
scatter(log10(delay_t),insign1_mean,20,'.','MarkerEdgeColor',[.9922 .7216 0.0745])
errorbar(log10(delay_t),insign1_mean,insign0_stderr,'.','MarkerEdgeColor',[.9922 .7216 0.0745],'LineStyle','none', 'Color',[.9922 .7216 0.0745],'linewidth', .5)
% out sign 1 
outsign1_mean=[];
outsign1_stderr=[];
for i=1:numel(delay_t)
   [idx,~]=find(abs(outsign1properties.FR_delay)==delay_t(i))
   outsign1_mean(i)=nanmean(outsign1properties.FR_freqs(idx));
   outsign1_stderr(i)=nanstd(outsign1properties.FR_freqs(idx))/(sqrt(numel(idx)))
end;
scatter(log10(delay_t),outsign1_mean,20,'.','MarkerEdgeColor',[0 1 1])
errorbar(log10(delay_t),outsign1_mean,insign0_stderr,'.','MarkerEdgeColor',[0 1 1],'LineStyle','none', 'Color',[0 1 1],'linewidth', .5)
title('frono frequency change with propagation in NSOZ')
subtitle('blue: non-prop out, red:non-prop in, yellow: prop out, cyan: prop in')
xlabel('log10(propagation delay)')
ylabel('FR frequency HZ')
ylim([200 500])
figure
scatter(abs(insign0properties.FR_delay),insign0properties.FR_duration,9,'.','MarkerEdgeColor',[0 0 1])
hold on
scatter(abs(outsign0properties.FR_delay),outsign0properties.FR_duration,9,'.','MarkerEdgeColor',[1 0 0])
scatter(abs(insign1properties.FR_delay),insign1properties.FR_duration,9,'.','MarkerEdgeColor',[.9922 .7216 0.0745])
scatter(abs(outsign1properties.FR_delay),outsign1properties.FR_duration,9,'.','MarkerEdgeColor',[0 1 1])
title('frono duration change with propagation in NSOZ')
subtitle('blue: non-prop out, red:non-prop in, yellow: prop out, cyan: prop in')
xlabel('propagation delay')
ylabel('FR duration seconds')

figure
hold on
% in sign 0 really means out
[distance_t,~]= unique(abs(insign0properties.FR_distance))
insign0_mean=[];
insign0_stderr=[];
for i=1:numel(distance_t)
   [idx,~]=find(abs(insign0properties.FR_distance)==distance_t(i))
   insign0_mean(i)=nanmean(insign0properties.FR_duration(idx));
   insign0_stderr(i)=nanstd(insign0properties.FR_duration(idx))/(sqrt(numel(idx)))
end;
scatter(log10(distance_t),insign0_mean,20,'.','MarkerEdgeColor',[0 0 1])
errorbar(log10(distance_t),insign0_mean,insign0_stderr,'.','MarkerEdgeColor',[0 0 1],'LineStyle','none', 'Color',[0 0 1],'linewidth', .5)
% out sign 0 
outsign0_mean=[];
outsign0_stderr=[];
for i=1:numel(distance_t)
   [idx,~]=find(abs(outsign0properties.FR_distance)==distance_t(i))
   outsign0_mean(i)=nanmean(outsign0properties.FR_duration(idx));
   outsign0_stderr(i)=nanstd(outsign0properties.FR_duration(idx))/(sqrt(numel(idx)))
end;
scatter(log10(distance_t),outsign0_mean,20,'.','MarkerEdgeColor',[1 0 0])
errorbar(log10(distance_t),outsign0_mean,outsign0_stderr,'.','MarkerEdgeColor',[1 0 0],'LineStyle','none', 'Color',[1 0 0],'linewidth', .5)
% in sign 1 
insign1_mean=[];
insign1_stderr=[];
for i=1:numel(distance_t)
   [idx,~]=find(abs(insign1properties.FR_distance)==distance_t(i))
   insign1_mean(i)=nanmean(insign1properties.FR_duration(idx));
   insign1_stderr(i)=nanstd(insign1properties.FR_duration(idx))/(sqrt(numel(idx)))
end;
scatter(log10(distance_t),insign1_mean,20,'.','MarkerEdgeColor',[.9922 .7216 0.0745])
errorbar(log10(distance_t),insign1_mean,insign0_stderr,'.','MarkerEdgeColor',[.9922 .7216 0.0745],'LineStyle','none', 'Color',[.9922 .7216 0.0745],'linewidth', .5)
% out sign 1 
outsign1_mean=[];
outsign1_stderr=[];
for i=1:numel(distance_t)
   [idx,~]=find(abs(outsign1properties.FR_distance)==distance_t(i))
   outsign1_mean(i)=nanmean(outsign1properties.FR_duration(idx));
   outsign1_stderr(i)=nanstd(outsign1properties.FR_duration(idx))/(sqrt(numel(idx)))
end;
scatter(log10(distance_t),outsign1_mean,20,'.','MarkerEdgeColor',[0 1 1])
errorbar(log10(distance_t),outsign1_mean,insign0_stderr,'.','MarkerEdgeColor',[0 1 1],'LineStyle','none', 'Color',[0 1 1],'linewidth', .5)
title('frono duration change with propagation in NSOZ')
subtitle('blue: non-prop out, red:non-prop in, yellow: prop out, cyan: prop in')
xlabel('log10(propagation distance)')
ylabel('FR duration seconds')


figure
scatter(abs(insign0properties.FR_delay),insign0properties.FR_power,9,'.','MarkerEdgeColor',[0 0 1])
hold on
scatter(abs(outsign0properties.FR_delay),outsign0properties.FR_power,9,'.','MarkerEdgeColor',[1 0 0])
scatter(abs(insign1properties.FR_delay),insign1properties.FR_power,9,'.','MarkerEdgeColor',[.9922 .7216 0.0745])
scatter(abs(outsign1properties.FR_delay),outsign1properties.FR_power,9,'.','MarkerEdgeColor',[0 1 1])
title('frono power change with propagation in NSOZ')
subtitle('blue: non-prop out, red:non-prop in, yellow: prop out, cyan: prop in')
xlabel('propagation delay')
ylabel('FR power AU')
ylim([0 5e6])

figure
hold on
% in sign 0 really means out
[delay_t,~]= unique(abs(insign0properties.FR_delay))
insign0_mean=[];
insign0_stderr=[];
for i=1:numel(delay_t)
   [idx,~]=find(abs(insign0properties.FR_delay)==delay_t(i))
   insign0_mean(i)=nanmean(insign0properties.FR_power(idx));
   insign0_stderr(i)=nanstd(insign0properties.FR_power(idx))/(sqrt(numel(idx)))
end;
scatter(log10(delay_t),insign0_mean,20,'.','MarkerEdgeColor',[0 0 1])
errorbar(log10(delay_t),insign0_mean,insign0_stderr,'.','MarkerEdgeColor',[0 0 1],'LineStyle','none', 'Color',[0 0 1],'linewidth', .5)
% out sign 0 
outsign0_mean=[];
outsign0_stderr=[];
for i=1:numel(delay_t)
   [idx,~]=find(abs(outsign0properties.FR_delay)==delay_t(i))
   outsign0_mean(i)=nanmean(outsign0properties.FR_power(idx));
   outsign0_stderr(i)=nanstd(outsign0properties.FR_power(idx))/(sqrt(numel(idx)))
end;
scatter(log10(delay_t),outsign0_mean,20,'.','MarkerEdgeColor',[1 0 0])
errorbar(log10(delay_t),outsign0_mean,outsign0_stderr,'.','MarkerEdgeColor',[1 0 0],'LineStyle','none', 'Color',[1 0 0],'linewidth', .5)
% in sign 1 
insign1_mean=[];
insign1_stderr=[];
for i=1:numel(delay_t)
   [idx,~]=find(abs(insign1properties.FR_delay)==delay_t(i))
   insign1_mean(i)=nanmean(insign1properties.FR_power(idx));
   insign1_stderr(i)=nanstd(insign1properties.FR_power(idx))/(sqrt(numel(idx)))
end;
scatter(log10(delay_t),insign1_mean,20,'.','MarkerEdgeColor',[.9922 .7216 0.0745])
errorbar(log10(delay_t),insign1_mean,insign0_stderr,'.','MarkerEdgeColor',[.9922 .7216 0.0745],'LineStyle','none', 'Color',[.9922 .7216 0.0745],'linewidth', .5)
% out sign 1 
outsign1_mean=[];
outsign1_stderr=[];
for i=1:numel(delay_t)
   [idx,~]=find(abs(outsign1properties.FR_delay)==delay_t(i))
   outsign1_mean(i)=nanmean(outsign1properties.FR_power(idx));
   outsign1_stderr(i)=nanstd(outsign1properties.FR_power(idx))/(sqrt(numel(idx)))
end;
scatter(log10(delay_t),outsign1_mean,20,'.','MarkerEdgeColor',[0 1 1])
errorbar(log10(delay_t),outsign1_mean,insign0_stderr,'.','MarkerEdgeColor',[0 1 1],'LineStyle','none', 'Color',[0 1 1],'linewidth', .5)
title('frono power change with propagation in NSOZ')
subtitle('blue: non-prop out, red:non-prop in, yellow: prop out, cyan: prop in')
xlabel('log10(propagation delay)')
ylabel('FR power AU')

clear insign0properties outsign0properties insign1preperties outsign1properties SOZproperties

% Box plot of FR properties
% Power
figure
power=FRpropertiesVr0306.FR_power;
[idx,~]=find(FRpropertiesVr0306.FR_elec1_SOZ==1);
[idx2,~]=find(FRpropertiesVr0306.FR_elec2_SOZ==1);
[int]=intersect(idx,idx2);
[idx,~]=find(FRpropertiesVr0306.FR_inout==0);
[idx2,~]=find(FRpropertiesVr0306.FR_sign==0);
[int2]=intersect(idx,idx2);
int3=intersect(int,int2);
power_cellarray{1,1}=power(int3);
[idx,~]=find(FRpropertiesVr0306.FR_inout==1);
[idx2,~]=find(FRpropertiesVr0306.FR_sign==0);
[int2]=intersect(idx,idx2);
int3=intersect(int,int2);
power_cellarray{1,2}=power(int3);
[idx,~]=find(FRpropertiesVr0306.FR_inout==0);
[idx2,~]=find(FRpropertiesVr0306.FR_sign==1);
[int2]=intersect(idx,idx2);
int3=intersect(int,int2);
power_cellarray{1,3}=power(int3);
[idx,~]=find(FRpropertiesVr0306.FR_inout==1);
[idx2,~]=find(FRpropertiesVr0306.FR_sign==1);
[int2]=intersect(idx,idx2);
int3=intersect(int,int2);
power_cellarray{1,4}=power(int3);
cellarray_colors=[0 0 1; 1 0 0; 1 1 0; 0 1 1;];
xlabel({'out np' 'in np' 'out p' 'in p'});
daboxplot(power_cellarray,'legend',{'out np','in np','in p','out p'},'colors',cellarray_colors,'outliers',0);
title('FR power SOZ')

figure
[idx,~]=find(FRpropertiesVr0306.FR_elec1_SOZ==1);
[idx2,~]=find(FRpropertiesVr0306.FR_elec2_SOZ==0);
[int]=intersect(idx,idx2);
[idx,~]=find(FRpropertiesVr0306.FR_elec1_SOZ==0);
[idx2,~]=find(FRpropertiesVr0306.FR_elec2_SOZ==1);
[int2]=intersect(idx,idx2);
int=unique(vertcat(int,int2));
[idx,~]=find(FRpropertiesVr0306.FR_inout==0);
[idx2,~]=find(FRpropertiesVr0306.FR_sign==0);
[int2]=intersect(idx,idx2);
int3=intersect(int,int2);
power_cellarray{1,1}=power(int3);
[idx,~]=find(FRpropertiesVr0306.FR_inout==1);
[idx2,~]=find(FRpropertiesVr0306.FR_sign==0);
[int2]=intersect(idx,idx2);
int3=intersect(int,int2);
power_cellarray{1,2}=power(int3);
[idx,~]=find(FRpropertiesVr0306.FR_inout==0);
[idx2,~]=find(FRpropertiesVr0306.FR_sign==1);
[int2]=intersect(idx,idx2);
int3=intersect(int,int2);
power_cellarray{1,3}=power(int3);
[idx,~]=find(FRpropertiesVr0306.FR_inout==1);
[idx2,~]=find(FRpropertiesVr0306.FR_sign==1);
[int2]=intersect(idx,idx2);
int3=intersect(int,int2);
power_cellarray{1,4}=power(int3);
cellarray_colors=[0 0 1; 1 0 0; 1 1 0; 0 1 1;];
xlabel({'out np' 'in np' 'out p' 'in p'});
daboxplot(power_cellarray,'legend',{'out np','in np','out p','in p'},'colors',cellarray_colors,'outliers',0);
title('FR power NSOZ:SOZ')

figure
[idx,~]=find(FRpropertiesVr0306.FR_elec1_SOZ==0);
[idx2,~]=find(FRpropertiesVr0306.FR_elec2_SOZ==0);
[int]=intersect(idx,idx2);
[idx,~]=find(FRpropertiesVr0306.FR_inout==0);
[idx2,~]=find(FRpropertiesVr0306.FR_sign==0);
[int2]=intersect(idx,idx2);
int3=intersect(int,int2);
power_cellarray{1,1}=power(int3);
[idx,~]=find(FRpropertiesVr0306.FR_inout==1);
[idx2,~]=find(FRpropertiesVr0306.FR_sign==0);
[int2]=intersect(idx,idx2);
int3=intersect(int,int2);
power_cellarray{1,2}=power(int3);
[idx,~]=find(FRpropertiesVr0306.FR_inout==0);
[idx2,~]=find(FRpropertiesVr0306.FR_sign==1);
[int2]=intersect(idx,idx2);
int3=intersect(int,int2);
power_cellarray{1,3}=power(int3);
[idx,~]=find(FRpropertiesVr0306.FR_inout==1);
[idx2,~]=find(FRpropertiesVr0306.FR_sign==1);
[int2]=intersect(idx,idx2);
int3=intersect(int,int2);
power_cellarray{1,4}=power(int3);
cellarray_colors=[0 0 1; 1 0 0; 1 1 0; 0 1 1;];
xlabel({'out np' 'in np' 'out p' 'in p'});
daboxplot(power_cellarray,'legend',{'out np','in np','out p','in p'},'colors',cellarray_colors,'outliers',0);
title('FR power NSOZ')

% Box plot of FR properties
% Duration
figure
duration=FRpropertiesVr0306.FR_duration;
[idx,~]=find(FRpropertiesVr0306.FR_elec1_SOZ==1);
[idx2,~]=find(FRpropertiesVr0306.FR_elec2_SOZ==1);
[int]=intersect(idx,idx2);
[idx,~]=find(FRpropertiesVr0306.FR_inout==0);
[idx2,~]=find(FRpropertiesVr0306.FR_sign==0);
[int2]=intersect(idx,idx2);
int3=intersect(int,int2);
duration_cellarray{1,1}=duration(int3);
[idx,~]=find(FRpropertiesVr0306.FR_inout==1);
[idx2,~]=find(FRpropertiesVr0306.FR_sign==0);
[int2]=intersect(idx,idx2);
int3=intersect(int,int2);
duration_cellarray{1,2}=duration(int3);
[idx,~]=find(FRpropertiesVr0306.FR_inout==0);
[idx2,~]=find(FRpropertiesVr0306.FR_sign==1);
[int2]=intersect(idx,idx2);
int3=intersect(int,int2);
duration_cellarray{1,3}=duration(int3);
[idx,~]=find(FRpropertiesVr0306.FR_inout==1);
[idx2,~]=find(FRpropertiesVr0306.FR_sign==1);
[int2]=intersect(idx,idx2);
int3=intersect(int,int2);
duration_cellarray{1,4}=duration(int3);
cellarray_colors=[0 0 1; 1 0 0; 1 1 0; 0 1 1;];
xlabel({'out np' 'in np' 'out p' 'in p'});
daboxplot(duration_cellarray,'legend',{'out np','in np','in p','out p'},'colors',cellarray_colors,'outliers',0);
title('FR duration SOZ')

figure
[idx,~]=find(FRpropertiesVr0306.FR_elec1_SOZ==1);
[idx2,~]=find(FRpropertiesVr0306.FR_elec2_SOZ==0);
[int]=intersect(idx,idx2);
[idx,~]=find(FRpropertiesVr0306.FR_elec1_SOZ==0);
[idx2,~]=find(FRpropertiesVr0306.FR_elec2_SOZ==1);
[int2]=intersect(idx,idx2);
int=unique(vertcat(int,int2));
[idx,~]=find(FRpropertiesVr0306.FR_inout==0);
[idx2,~]=find(FRpropertiesVr0306.FR_sign==0);
[int2]=intersect(idx,idx2);
int3=intersect(int,int2);
duration_cellarray{1,1}=duration(int3);
[idx,~]=find(FRpropertiesVr0306.FR_inout==1);
[idx2,~]=find(FRpropertiesVr0306.FR_sign==0);
[int2]=intersect(idx,idx2);
int3=intersect(int,int2);
duration_cellarray{1,2}=duration(int3);
[idx,~]=find(FRpropertiesVr0306.FR_inout==0);
[idx2,~]=find(FRpropertiesVr0306.FR_sign==1);
[int2]=intersect(idx,idx2);
int3=intersect(int,int2);
duration_cellarray{1,3}=duration(int3);
[idx,~]=find(FRpropertiesVr0306.FR_inout==1);
[idx2,~]=find(FRpropertiesVr0306.FR_sign==1);
[int2]=intersect(idx,idx2);
int3=intersect(int,int2);
duration_cellarray{1,4}=duration(int3);
cellarray_colors=[0 0 1; 1 0 0; 1 1 0; 0 1 1;];
xlabel({'out np' 'in np' 'out p' 'in p'});
daboxplot(duration_cellarray,'legend',{'out np','in np','out p','in p'},'colors',cellarray_colors,'outliers',0);
title('FR duration NSOZ:SOZ')

figure
[idx,~]=find(FRpropertiesVr0306.FR_elec1_SOZ==0);
[idx2,~]=find(FRpropertiesVr0306.FR_elec2_SOZ==0);
[int]=intersect(idx,idx2);
[idx,~]=find(FRpropertiesVr0306.FR_inout==0);
[idx2,~]=find(FRpropertiesVr0306.FR_sign==0);
[int2]=intersect(idx,idx2);
int3=intersect(int,int2);
duration_cellarray{1,1}=duration(int3);
[idx,~]=find(FRpropertiesVr0306.FR_inout==1);
[idx2,~]=find(FRpropertiesVr0306.FR_sign==0);
[int2]=intersect(idx,idx2);
int3=intersect(int,int2);
duration_cellarray{1,2}=duration(int3);
[idx,~]=find(FRpropertiesVr0306.FR_inout==0);
[idx2,~]=find(FRpropertiesVr0306.FR_sign==1);
[int2]=intersect(idx,idx2);
int3=intersect(int,int2);
duration_cellarray{1,3}=duration(int3);
[idx,~]=find(FRpropertiesVr0306.FR_inout==1);
[idx2,~]=find(FRpropertiesVr0306.FR_sign==1);
[int2]=intersect(idx,idx2);
int3=intersect(int,int2);
duration_cellarray{1,4}=duration(int3);
cellarray_colors=[0 0 1; 1 0 0; 1 1 0; 0 1 1;];
xlabel({'out np' 'in np' 'out p' 'in p'});
daboxplot(duration_cellarray,'legend',{'out np','in np','out p','in p'},'colors',cellarray_colors,'outliers',0);
title('FR duration NSOZ')

% Aggregate FR power distance plot
SOZproperties=FRpropertiesVr0306;
[idx_in,~]=find(SOZproperties.FR_inout==0);
[idx_out,~]=find(SOZproperties.FR_inout==1);
[idx_sign0,~]=find(SOZproperties.FR_sign==0);
[idx_sign1,~]=find(SOZproperties.FR_sign==1);
[int_insign0]=intersect(idx_in,idx_sign0);
[int_insign1]=intersect(idx_in,idx_sign1);
[int_outsign0]=intersect(idx_out,idx_sign0);
[int_outsign1]=intersect(idx_out,idx_sign1);
insign0properties=SOZproperties(int_insign0,:);
insign1properties=SOZproperties(int_insign1,:);
outsign0properties=SOZproperties(int_outsign0,:);
outsign1properties=SOZproperties(int_outsign1,:);
figure
hold on
% in sign 0 really means out
[delay_t,~]= unique(abs(insign0properties.FR_delay))
insign0_mean=[];
insign0_stderr=[];
for i=1:numel(delay_t)
   [idx,~]=find(abs(insign0properties.FR_delay)==delay_t(i))
   insign0_mean(i)=nanmean(insign0properties.FR_power(idx));
   insign0_stderr(i)=nanstd(insign0properties.FR_power(idx))/(sqrt(numel(idx)))
end;
scatter(log10(delay_t),insign0_mean,20,'.','MarkerEdgeColor',[0 0 1])
errorbar(log10(delay_t),insign0_mean,insign0_stderr,'.','MarkerEdgeColor',[0 0 1],'LineStyle','none', 'Color',[0 0 1],'linewidth', .5)
% out sign 0 
outsign0_mean=[];
outsign0_stderr=[];
for i=1:numel(delay_t)
   [idx,~]=find(abs(outsign0properties.FR_delay)==delay_t(i))
   outsign0_mean(i)=nanmean(outsign0properties.FR_power(idx));
   outsign0_stderr(i)=nanstd(outsign0properties.FR_power(idx))/(sqrt(numel(idx)))
end;
scatter(log10(delay_t),outsign0_mean,20,'.','MarkerEdgeColor',[1 0 0])
errorbar(log10(delay_t),outsign0_mean,outsign0_stderr,'.','MarkerEdgeColor',[1 0 0],'LineStyle','none', 'Color',[1 0 0],'linewidth', .5)
% in sign 1 
insign1_mean=[];
insign1_stderr=[];
for i=1:numel(delay_t)
   [idx,~]=find(abs(insign1properties.FR_delay)==delay_t(i))
   insign1_mean(i)=nanmean(insign1properties.FR_power(idx));
   insign1_stderr(i)=nanstd(insign1properties.FR_power(idx))/(sqrt(numel(idx)))
end;
scatter(log10(delay_t),insign1_mean,20,'.','MarkerEdgeColor',[.9922 .7216 0.0745])
errorbar(log10(delay_t),insign1_mean,insign0_stderr,'.','MarkerEdgeColor',[.9922 .7216 0.0745],'LineStyle','none', 'Color',[.9922 .7216 0.0745],'linewidth', .5)
% out sign 1 
outsign1_mean=[];
outsign1_stderr=[];
for i=1:numel(delay_t)
   [idx,~]=find(abs(outsign1properties.FR_delay)==delay_t(i))
   outsign1_mean(i)=nanmean(outsign1properties.FR_power(idx));
   outsign1_stderr(i)=nanstd(outsign1properties.FR_power(idx))/(sqrt(numel(idx)))
end;
scatter(log10(delay_t),outsign1_mean,20,'.','MarkerEdgeColor',[0 1 1])
errorbar(log10(delay_t),outsign1_mean,insign0_stderr,'.','MarkerEdgeColor',[0 1 1],'LineStyle','none', 'Color',[0 1 1],'linewidth', .5)
title('frono power change with propagation in all regions')
subtitle('blue: non-prop out, red:non-prop in, yellow: prop out, cyan: prop in')
xlabel('log10(propagation delay)')
ylabel('FR power AU')

% two way circular ANOVA
delta_temp=FRpropertiesVr0306.FR_delta_angle;
locs=FRpropertiesVr0306.FR_elec1_loc;  
soz=FRpropertiesVr0306.FR_elec1_SOZ;
[idx,~]=find(isnan(delta_temp)==1);
delta_temp(idx)=[];
locs(idx)=[];
soz(idx)=[];
[hk_p hk_table] = circ_hktest(delta_temp, locs, soz, 1);
clear soz

% collect data for 2D circular ANOVA no locs but SOZ
[idx,~]=find(FRpropertiesVr0306.FR_elec1_SOZ==0);
[idx2,~]=find(FRpropertiesVr0306.FR_elec1_SOZ==1);
locs=FRpropertiesVr0306.FR_elec1_loc;            
slow_temp=FRpropertiesVr0306.FR_slow_angle;
delta_temp=FRpropertiesVr0306.FR_delta_angle;
inout=FRpropertiesVr0306.FR_inout;
sign=FRpropertiesVr0306.FR_sign;
slow_nsoz=slow_temp(idx);
delta_nsoz=delta_temp(idx);
slow_locs_nsoz=locs(idx);
delta_locs_nsoz=locs(idx);
slow_inout_nsoz=inout(idx);
delta_inout_nsoz=inout(idx);
slow_sign_nsoz=sign(idx);
delta_sign_nsoz=sign(idx);

slow_soz=slow_temp(idx2);
delta_soz=delta_temp(idx2);
slow_locs_soz=locs(idx2);
delta_locs_soz=locs(idx2);
slow_inout_soz=inout(idx2);
delta_inout_soz=inout(idx2);
slow_sign_soz=sign(idx2);
delta_sign_soz=sign(idx2);

[idx_nan,~] = find(isnan(slow_nsoz));
slow_nsoz(idx_nan,:)=[];
slow_locs_nsoz(idx_nan,:)=[];
slow_inout_nsoz(idx_nan,:)=[];
slow_sign_nsoz(idx_nan,:)=[];
[idx_nan,~] = find(isnan(delta_nsoz));
delta_nsoz(idx_nan,:)=[];
delta_locs_nsoz(idx_nan,:)=[];
delta_inout_nsoz(idx_nan,:)=[];
delta_sign_nsoz(idx_nan,:)=[];
[idx_nan,~] = find(isnan(slow_soz));
slow_soz(idx_nan,:)=[];
slow_locs_soz(idx_nan,:)=[];
slow_inout_soz(idx_nan,:)=[];
slow_sign_soz(idx_nan,:)=[];
[idx_nan,~] = find(isnan(delta_soz));
delta_soz(idx_nan,:)=[];
delta_locs_soz(idx_nan,:)=[];
delta_inout_soz(idx_nan,:)=[];
delta_sign_soz(idx_nan,:)=[];

% plot circular data
[idx,~]=find(slow_inout_nsoz==0);
[idx2,~]=find(slow_sign_nsoz==0);
int=intersect(idx,idx2);
slow_nsoz_in_sign0=slow_nsoz(int);
[idx,~]=find(slow_inout_nsoz==1);
[idx2,~]=find(slow_sign_nsoz==0);
int=intersect(idx,idx2);
slow_nsoz_out_sign0=slow_nsoz(int);
[idx,~]=find(slow_inout_nsoz==0);
[idx2,~]=find(slow_sign_nsoz==1);
int=intersect(idx,idx2);
slow_nsoz_in_sign1=slow_nsoz(int);
[idx,~]=find(slow_inout_nsoz==1);
[idx2,~]=find(slow_sign_nsoz==1);
int=intersect(idx,idx2);
slow_nsoz_out_sign1=slow_nsoz(int);
[idx,~]=find(slow_inout_soz==0);
[idx2,~]=find(slow_sign_soz==0);
int=intersect(idx,idx2);
slow_soz_in_sign0=slow_soz(int);
slow_soz_in_sign0_loc=slow_locs_soz(int);
[idx,~]=find(slow_inout_soz==1);
[idx2,~]=find(slow_sign_soz==0);
int=intersect(idx,idx2);
slow_soz_out_sign0=slow_soz(int);
slow_soz_out_sign0_loc=slow_locs_soz(int);
[idx,~]=find(slow_inout_soz==0);
[idx2,~]=find(slow_sign_soz==1);
int=intersect(idx,idx2);
slow_soz_in_sign1=slow_soz(int);
slow_soz_in_sign1_loc=slow_locs_soz(int);
[idx,~]=find(slow_inout_soz==1);
[idx2,~]=find(slow_sign_soz==1);
int=intersect(idx,idx2);
slow_soz_out_sign1=slow_soz(int);
slow_soz_out_sign1_loc=slow_locs_soz(int);

%Loc stats for different slow phasor groups
slow_soz_nonprop=vertcat(slow_soz_in_sign0,slow_soz_out_sign0);
slow_soz_nonprop_inout=vertcat(zeros(numel(slow_soz_in_sign0),1),ones(numel(slow_soz_out_sign0),1));
slow_soz_nonprop_loc=vertcat(slow_soz_in_sign0_loc,slow_soz_out_sign0_loc);

slow_soz_prop=vertcat(slow_soz_in_sign1,slow_soz_out_sign1);
slow_soz_prop_inout=vertcat(zeros(numel(slow_soz_in_sign1),1),ones(numel(slow_soz_out_sign1),1));
slow_soz_prop_loc=vertcat(slow_soz_in_sign1_loc,slow_soz_out_sign1_loc);

% slow loc figures
figure
polar(0,200,'-k')
hold on
[idx,~]=find(slow_soz_in_sign0_loc>4);
loc5=slow_soz_in_sign0(idx);
[t, r] = rose(loc5, 60); 
polar(t, r,'black')
title('slow limbic SOZ non-prop out')
figure
polar(0,50,'-k')
hold on
[idx,~]=find(slow_soz_in_sign0_loc==1);
loc1=slow_soz_in_sign0(idx);
[t, r] = rose(loc1, 60); 
polar(t, r,'cyan')
[idx,~]=find(slow_soz_in_sign0_loc==3);
loc3=slow_soz_in_sign0(idx);
[t, r] = rose(loc3, 60); 
polar(t, r,'red')
[idx,~]=find(slow_soz_in_sign0_loc==2);
loc2=slow_soz_in_sign0(idx);
[t, r] = rose(loc2, 60); 
polar(t, r,'blue')
[idx,~]=find(slow_soz_in_sign0_loc==4);
loc4=slow_soz_in_sign0(idx);
[t, r] = rose(loc4, 60); 
polar(t, r,'green')
title('slow Other SOZ non-prop out')

figure
polar(0,200,'-k')
hold on
[idx,~]=find(slow_soz_out_sign0_loc>4);
loc5=slow_soz_out_sign0(idx);
[t, r] = rose(loc5, 60); 
polar(t, r,'black')
title('slow limbic SOZ non-prop in')
figure
polar(0,80,'-k')
hold on
[idx,~]=find(slow_soz_out_sign0_loc==1);
loc1=slow_soz_out_sign0(idx);
[t, r] = rose(loc1, 60); 
polar(t, r,'cyan')
[idx,~]=find(slow_soz_out_sign0_loc==3);
loc3=slow_soz_out_sign0(idx);
[t, r] = rose(loc3, 60); 
polar(t, r,'red')
[idx,~]=find(slow_soz_out_sign0_loc==2);
loc2=slow_soz_out_sign0(idx);
[t, r] = rose(loc2, 60); 
polar(t, r,'blue')
[idx,~]=find(slow_soz_out_sign0_loc==4);
loc4=slow_soz_out_sign0(idx);
[t, r] = rose(loc4, 60); 
polar(t, r,'green')
title('slow Other SOZ non-prop in')

% slow loc figures
figure
polar(0,100,'-k')
hold on
[idx,~]=find(slow_soz_in_sign1_loc>4);
loc5=slow_soz_in_sign0(idx);
[t, r] = rose(loc5, 60); 
polar(t, r,'black')
title('slow limbic SOZ prop out')
figure
polar(0,15,'-k')
hold on
[idx,~]=find(slow_soz_in_sign1_loc==1);
loc1=slow_soz_in_sign0(idx);
[t, r] = rose(loc1, 60); 
polar(t, r,'cyan')
[idx,~]=find(slow_soz_in_sign1_loc==3);
loc3=slow_soz_in_sign0(idx);
[t, r] = rose(loc3, 60); 
polar(t, r,'red')
[idx,~]=find(slow_soz_in_sign1_loc==2);
loc2=slow_soz_in_sign0(idx);
[t, r] = rose(loc2, 60); 
polar(t, r,'blue')
[idx,~]=find(slow_soz_in_sign1_loc==4);
loc4=slow_soz_in_sign0(idx);
[t, r] = rose(loc4, 60); 
polar(t, r,'green')
title('slow Other SOZ prop out')

figure
polar(0,100,'-k')
hold on
[idx,~]=find(slow_soz_out_sign1_loc>4);
loc5=slow_soz_out_sign0(idx);
[t, r] = rose(loc5, 60); 
polar(t, r,'black')
title('slow limbic SOZ prop in')
figure
polar(0,15,'-k')
hold on
[idx,~]=find(slow_soz_out_sign1_loc==1);
loc1=slow_soz_out_sign0(idx);
[t, r] = rose(loc1, 60); 
polar(t, r,'cyan')
[idx,~]=find(slow_soz_out_sign1_loc==3);
loc3=slow_soz_out_sign0(idx);
[t, r] = rose(loc3, 60); 
polar(t, r,'red')
[idx,~]=find(slow_soz_out_sign1_loc==2);
loc2=slow_soz_out_sign0(idx);
[t, r] = rose(loc2, 60); 
polar(t, r,'blue')
[idx,~]=find(slow_soz_out_sign1_loc==4);
loc4=slow_soz_out_sign0(idx);
[t, r] = rose(loc4, 60); 
polar(t, r,'green')
title('slow Other SOZ prop in')

% plot circular data
[idx,~]=find(delta_inout_nsoz==0);
[idx2,~]=find(delta_sign_nsoz==0);
int=intersect(idx,idx2);
delta_nsoz_in_sign0=delta_nsoz(int);
[idx,~]=find(delta_inout_nsoz==1);
[idx2,~]=find(delta_sign_nsoz==0);
int=intersect(idx,idx2);
delta_nsoz_out_sign0=delta_nsoz(int);
[idx,~]=find(delta_inout_nsoz==0);
[idx2,~]=find(delta_sign_nsoz==1);
int=intersect(idx,idx2);
delta_nsoz_in_sign1=delta_nsoz(int);
[idx,~]=find(delta_inout_nsoz==1);
[idx2,~]=find(delta_sign_nsoz==1);
int=intersect(idx,idx2);
delta_nsoz_out_sign1=delta_nsoz(int);
[idx,~]=find(delta_inout_soz==0);
[idx2,~]=find(delta_sign_soz==0);
int=intersect(idx,idx2);
delta_soz_in_sign0=delta_soz(int);
delta_soz_in_sign0_loc=delta_locs_soz(int);
[idx,~]=find(delta_inout_soz==1);
[idx2,~]=find(delta_sign_soz==0);
int=intersect(idx,idx2);
delta_soz_out_sign0=delta_soz(int);
delta_soz_out_sign0_loc=delta_locs_soz(int);
[idx,~]=find(delta_inout_soz==0);
[idx2,~]=find(delta_sign_soz==1);
int=intersect(idx,idx2);
delta_soz_in_sign1=delta_soz(int);
delta_soz_in_sign1_loc=delta_locs_soz(int);
[idx,~]=find(delta_inout_soz==1);
[idx2,~]=find(delta_sign_soz==1);
int=intersect(idx,idx2);
delta_soz_out_sign1=delta_soz(int);
delta_soz_out_sign1_loc=delta_locs_soz(int);

[idx,~]=find(delta_inout_nsoz==0);
[idx2,~]=find(delta_sign_nsoz==0);
int=intersect(idx,idx2);
delta_nsoz_in_sign0_loc=delta_locs_nsoz(int);
[idx,~]=find(delta_inout_nsoz==1);
[idx2,~]=find(delta_sign_nsoz==0);
int=intersect(idx,idx2);
delta_nsoz_out_sign0_loc=delta_locs_nsoz(int);
[idx,~]=find(delta_inout_nsoz==0);
[idx2,~]=find(delta_sign_nsoz==1);
int=intersect(idx,idx2);
delta_nsoz_in_sign1_loc=delta_locs_nsoz(int);
[idx,~]=find(delta_inout_nsoz==1);
[idx2,~]=find(delta_sign_nsoz==1);
int=intersect(idx,idx2);
delta_nsoz_out_sign1_loc=delta_locs_nsoz(int);

mean_soz_insign0_rad=[];
mean_soz_insign0_Z=[];

% delta rayleigh tests and mean, std
% delta soz loc figures
figure
polar(0,500,'-k')
hold on
[idx,~]=find(delta_soz_in_sign0_loc>4);
loc5=delta_soz_in_sign0(idx);
[mean_soz_insign0_rad(5,1) mean_soz_insign0_rad(5,2) mean_soz_insign0_rad(5,3)] = circ_mean(loc5);
[mean_soz_insign0_Z(5,1) mean_soz_insign0_Z(5,2)] = circ_rtest(loc5);
mean_soz_insign0_Z(5,3)=numel(loc5);
[t, r] = rose(loc5, 60); 
polar(t, r,'black')
title('Delta limbic SOZ non-prop out')
figure
polar(0,150,'-k')
hold on
[idx,~]=find(delta_soz_in_sign0_loc==1);
loc1=delta_soz_in_sign0(idx);
[mean_soz_insign0_rad(1,1) mean_soz_insign0_rad(1,2) mean_soz_insign0_rad(1,3)] = circ_mean(loc1);
[mean_soz_insign0_Z(1,1) mean_soz_insign0_Z(1,2)] = circ_rtest(loc1);
mean_soz_insign0_Z(1,3)=numel(loc1);
[t, r] = rose(loc1, 60); 
polar(t, r,'cyan')
[idx,~]=find(delta_soz_in_sign0_loc==3);
loc3=delta_soz_in_sign0(idx);
[mean_soz_insign0_rad(3,1) mean_soz_insign0_rad(3,2) mean_soz_insign0_rad(3,3)] = circ_mean(loc3);
[mean_soz_insign0_Z(3,1) mean_soz_insign0_Z(3,2)] = circ_rtest(loc3);
mean_soz_insign0_Z(3,3)=numel(loc3);
[t, r] = rose(loc3, 60); 
polar(t, r,'red')
[idx,~]=find(delta_soz_in_sign0_loc==2);
loc2=delta_soz_in_sign0(idx);
[mean_soz_insign0_Z(2,1) mean_soz_insign0_Z(2,2)] = circ_rtest(loc2);
mean_soz_insign0_Z(2,3)=numel(loc2);
[mean_soz_insign0_rad(2,1) mean_soz_insign0_rad(2,2) mean_soz_insign0_rad(2,3)] = circ_mean(loc2);
[t, r] = rose(loc2, 60); 
polar(t, r,'blue')
[idx,~]=find(delta_soz_in_sign0_loc==4);
loc4=delta_soz_in_sign0(idx);
[mean_soz_insign0_Z(4,1) mean_soz_insign0_Z(4,2)] = circ_rtest(loc4);
mean_soz_insign0_Z(4,3)=numel(loc4);
[mean_soz_insign0_rad(2,1) mean_soz_insign0_rad(4,2) mean_soz_insign0_rad(4,3)] = circ_mean(loc2);
[t, r] = rose(loc4, 60); 
polar(t, r,'green')
title('Delta Other SOZ non-prop out')

mean_soz_outsign0_rad=[];
mean_soz_outsign0_Z=[];
figure
polar(0,650,'-k')
hold on
[idx,~]=find(delta_soz_out_sign0_loc>4);
loc5=delta_soz_out_sign0(idx);
[mean_soz_outsign0_rad(5,1) mean_soz_outsign0_rad(5,2) mean_soz_outsign0_rad(5,3)] = circ_mean(loc5);
[mean_soz_outsign0_Z(5,1) mean_soz_outsign0_Z(5,2)] = circ_rtest(loc5);
mean_soz_outsign0_Z(5,3)=numel(loc5);
[t, r] = rose(loc5, 60); 
polar(t, r,'black')
title('Delta limbic SOZ non-prop in')
figure
polar(0,200,'-k')
hold on
[idx,~]=find(delta_soz_out_sign0_loc==1);
loc1=delta_soz_out_sign0(idx);
[mean_soz_outsign0_rad(1,1) mean_soz_outsign0_rad(1,2) mean_soz_outsign0_rad(1,3)] = circ_mean(loc1);
[mean_soz_outsign0_Z(1,1) mean_soz_outsign0_Z(1,2)] = circ_rtest(loc1);
mean_soz_outsign0_Z(1,3)=numel(loc1);
[t, r] = rose(loc1, 60); 
polar(t, r,'cyan')
[idx,~]=find(delta_soz_out_sign0_loc==3);
loc3=delta_soz_out_sign0(idx);
[mean_soz_outsign0_rad(3,1) mean_soz_outsign0_rad(3,2) mean_soz_outsign0_rad(3,3)] = circ_mean(loc3);
[mean_soz_outsign0_Z(3,1) mean_soz_outsign0_Z(3,2)] = circ_rtest(loc3);
mean_soz_outsign0_Z(3,3)=numel(loc3);
[t, r] = rose(loc3, 60); 
polar(t, r,'red')
[idx,~]=find(delta_soz_out_sign0_loc==2);
loc2=delta_soz_out_sign0(idx);
[mean_soz_outsign0_rad(2,1) mean_soz_outsign0_rad(2,2) mean_soz_outsign0_rad(2,3)] = circ_mean(loc2);
[mean_soz_outsign0_Z(2,1) mean_soz_outsign0_Z(2,2)] = circ_rtest(loc2);
mean_soz_outsign0_Z(2,3)=numel(loc2);
[t, r] = rose(loc2, 60); 
polar(t, r,'blue')
[idx,~]=find(delta_soz_out_sign0_loc==4);
loc4=delta_soz_out_sign0(idx);
[mean_soz_outsign0_rad(4,1) mean_soz_outsign0_rad(4,2) mean_soz_outsign0_rad(4,3)] = circ_mean(loc4);
[mean_soz_outsign0_Z(4,1) mean_soz_outsign0_Z(4,2)] = circ_rtest(loc4);
mean_soz_outsign0_Z(4,3)=numel(loc4);
[t, r] = rose(loc4, 60); 
polar(t, r,'green')
title('Delta Other SOZ non-prop in')

mean_soz_insign1_rad=[];
mean_soz_insign1_Z=[];
% delta soz loc figures
figure
polar(0,200,'-k')
hold on
[idx,~]=find(delta_soz_in_sign1_loc>4);
loc5=delta_soz_in_sign0(idx);
[mean_soz_insign1_rad(5,1) mean_soz_insign1_rad(5,2) mean_soz_insign1_rad(5,3)] = circ_mean(loc5);
[mean_soz_insign1_Z(5,1) mean_soz_insign1_Z(5,2)] = circ_rtest(loc5);
mean_soz_insign1_Z(5,3)=numel(loc5);
[t, r] = rose(loc5, 60); 
polar(t, r,'black')
title('Delta limbic SOZ prop out')
figure
polar(0,30,'-k')
hold on
[idx,~]=find(delta_soz_in_sign1_loc==1);
loc1=delta_soz_in_sign0(idx);
[mean_soz_insign1_rad(1,1) mean_soz_insign1_rad(1,2) mean_soz_insign1_rad(1,3)] = circ_mean(loc1);
[mean_soz_insign1_Z(1,1) mean_soz_insign1_Z(1,2)] = circ_rtest(loc1);
mean_soz_insign1_Z(1,3)=numel(loc1);
[t, r] = rose(loc1, 60); 
polar(t, r,'cyan')
[idx,~]=find(delta_soz_in_sign1_loc==3);
loc3=delta_soz_in_sign0(idx);
[mean_soz_insign1_rad(3,1) mean_soz_insign1_rad(3,2) mean_soz_insign1_rad(3,3)] = circ_mean(loc3);
[mean_soz_insign1_Z(3,1) mean_soz_insign1_Z(3,2)] = circ_rtest(loc3);
mean_soz_insign1_Z(3,3)=numel(loc3);
[t, r] = rose(loc3, 60); 
polar(t, r,'red')
[idx,~]=find(delta_soz_in_sign1_loc==2);
loc2=delta_soz_in_sign0(idx);
[mean_soz_insign1_rad(2,1) mean_soz_insign1_rad(2,2) mean_soz_insign1_rad(2,3)] = circ_mean(loc2);
[mean_soz_insign1_Z(2,1) mean_soz_insign1_Z(2,2)] = circ_rtest(loc2);
mean_soz_insign1_Z(2,3)=numel(loc2);
[t, r] = rose(loc2, 60); 
polar(t, r,'blue')
[idx,~]=find(delta_soz_in_sign1_loc==4);
loc4=delta_soz_in_sign0(idx);
[mean_soz_insign1_rad(4,1) mean_soz_insign1_rad(4,2) mean_soz_insign1_rad(4,3)] = circ_mean(loc4);
[mean_soz_insign1_Z(4,1) mean_soz_insign1_Z(4,2)] = circ_rtest(loc4);
mean_soz_insign1_Z(4,3)=numel(loc4);
[t, r] = rose(loc4, 60); 
polar(t, r,'green')
title('Delta Other SOZ prop out')

mean_soz_outsign1_rad=[];
mean_soz_outsign1_Z=[];
figure
polar(0,250,'-k')
hold on
[idx,~]=find(delta_soz_out_sign1_loc>4);
loc5=delta_soz_out_sign0(idx);
[mean_soz_outsign1_rad(5,1) mean_soz_outsign1_rad(5,2) mean_soz_outsign1_rad(5,3)] = circ_mean(loc5);
[mean_soz_outsign1_Z(5,1) mean_soz_outsign1_Z(5,2)] = circ_rtest(loc5);
mean_soz_outsign1_Z(5,3)=numel(loc5);
[t, r] = rose(loc5, 60); 
polar(t, r,'black')
title('Delta limbic SOZ prop in')
figure
polar(0,30,'-k')
hold on
[idx,~]=find(delta_soz_out_sign1_loc==1);
loc1=delta_soz_out_sign0(idx);
[mean_soz_outsign1_rad(1,1) mean_soz_outsign1_rad(1,2) mean_soz_outsign1_rad(1,3)] = circ_mean(loc1);
[mean_soz_outsign1_Z(1,1) mean_soz_outsign1_Z(1,2)] = circ_rtest(loc1);
mean_soz_outsign1_Z(1,3)=numel(loc1);
[t, r] = rose(loc1, 60); 
polar(t, r,'cyan')
[idx,~]=find(delta_soz_out_sign1_loc==3);
loc3=delta_soz_out_sign0(idx);
[mean_soz_outsign1_rad(3,1) mean_soz_outsign1_rad(3,2) mean_soz_outsign1_rad(3,3)] = circ_mean(loc3);
[mean_soz_outsign1_Z(3,1) mean_soz_outsign1_Z(3,2)] = circ_rtest(loc3);
mean_soz_outsign1_Z(3,3)=numel(loc3);
[t, r] = rose(loc3, 60); 
polar(t, r,'red')
[idx,~]=find(delta_soz_out_sign1_loc==2);
loc2=delta_soz_out_sign0(idx);
[mean_soz_outsign1_rad(2,1) mean_soz_outsign1_rad(2,2) mean_soz_outsign1_rad(2,3)] = circ_mean(loc2);
[mean_soz_outsign1_Z(2,1) mean_soz_outsign1_Z(2,2)] = circ_rtest(loc2);
mean_soz_outsign1_Z(2,3)=numel(loc2);
[t, r] = rose(loc2, 60); 
polar(t, r,'blue')
[idx,~]=find(delta_soz_out_sign1_loc==4);
loc4=delta_soz_out_sign0(idx);
[mean_soz_outsign1_rad(4,1) mean_soz_outsign1_rad(4,2) mean_soz_outsign1_rad(4,3)] = circ_mean(loc4);
[mean_soz_outsign1_Z(4,1) mean_soz_outsign1_Z(4,2)] = circ_rtest(loc2);
mean_soz_outsign1_Z(4,3)=numel(loc4);
[t, r] = rose(loc4, 60); 
polar(t, r,'green')
title('Delta Other SOZ prop in')


% delta nsoz loc figures
mean_nsoz_insign0_rad=[];
mean_nsoz_insign0_Z=[];
figure
polar(0,50,'-k')
hold on
[idx,~]=find(delta_nsoz_in_sign0_loc>4);
loc5=delta_nsoz_in_sign0(idx);
[mean_nsoz_insign0_rad(5,1) mean_nsoz_insign0_rad(5,2) mean_nsoz_insign0_rad(5,3)] = circ_mean(loc5);
[mean_nsoz_insign0_Z(5,1) mean_nsoz_insign0_Z(5,2)] = circ_rtest(loc5);
mean_nsoz_insign0_Z(5,3)=numel(loc5);
[t, r] = rose(loc5, 60); 
polar(t, r,'black')
title('Delta limbic NSOZ non-prop out')
figure
polar(0,50,'-k')
hold on
[idx,~]=find(delta_nsoz_in_sign0_loc==1);
loc1=delta_nsoz_in_sign0(idx);
[mean_nsoz_insign0_rad(1,1) mean_nsoz_insign0_rad(1,2) mean_nsoz_insign0_rad(1,3)] = circ_mean(loc1);
[mean_nsoz_insign0_Z(1,1) mean_nsoz_insign0_Z(1,2)] = circ_rtest(loc1);
mean_nsoz_insign0_Z(1,3)=numel(loc1);
[t, r] = rose(loc1, 60); 
polar(t, r,'cyan')
[idx,~]=find(delta_nsoz_in_sign0_loc==3);
loc3=delta_nsoz_in_sign0(idx);
[mean_nsoz_insign0_rad(3,1) mean_nsoz_insign0_rad(3,2) mean_nsoz_insign0_rad(3,3)] = circ_mean(loc3);
[mean_nsoz_insign0_Z(3,1) mean_nsoz_insign0_Z(3,2)] = circ_rtest(loc3);
mean_nsoz_insign0_Z(3,3)=numel(loc3);
[t, r] = rose(loc3, 60); 
polar(t, r,'red')
[idx,~]=find(delta_nsoz_in_sign0_loc==2);
loc2=delta_nsoz_in_sign0(idx);
[mean_nsoz_insign0_rad(2,1) mean_nsoz_insign0_rad(2,2) mean_nsoz_insign0_rad(2,3)] = circ_mean(loc2);
[mean_nsoz_insign0_Z(2,1) mean_nsoz_insign0_Z(2,2)] = circ_rtest(loc2);
mean_nsoz_insign0_Z(2,3)=numel(loc2);
[t, r] = rose(loc2, 60); 
polar(t, r,'blue')
[idx,~]=find(delta_nsoz_in_sign0_loc==4);
loc4=delta_nsoz_in_sign0(idx);
[mean_nsoz_insign0_rad(4,1) mean_nsoz_insign0_rad(4,2) mean_nsoz_insign0_rad(4,3)] = circ_mean(loc4);
[mean_nsoz_insign0_Z(4,1) mean_nsoz_insign0_Z(4,2)] = circ_rtest(loc4);
mean_nsoz_insign0_Z(4,3)=numel(loc4);
[t, r] = rose(loc4, 60); 
polar(t, r,'green')
title('Delta Other NSOZ non-prop out')

mean_nsoz_outsign0_rad=[];
mean_nsoz_outsign0_Z=[];
figure
polar(0,50,'-k')
hold on
[idx,~]=find(delta_nsoz_out_sign0_loc>4);
loc5=delta_nsoz_out_sign0(idx);
[mean_nsoz_outsign0_rad(5,1) mean_nsoz_outsign0_rad(5,2) mean_nsoz_outsign0_rad(5,3)] = circ_mean(loc5);
[mean_nsoz_outsign0_Z(5,1) mean_nsoz_outsign0_Z(5,2)] = circ_rtest(loc5);
mean_nsoz_outsign0_Z(5,3)=numel(loc5);
[t, r] = rose(loc5, 60); 
polar(t, r,'black')
title('Delta limbic NSOZ non-prop in')
figure
polar(0,50,'-k')
hold on
[idx,~]=find(delta_nsoz_out_sign0_loc==1);
loc1=delta_soz_out_sign0(idx);
[mean_nsoz_outsign0_rad(1,1) mean_nsoz_outsign0_rad(1,2) mean_nsoz_outsign0_rad(1,3)] = circ_mean(loc1);
[mean_nsoz_outsign0_Z(1,1) mean_nsoz_outsign0_Z(1,2)] = circ_rtest(loc1);
mean_nsoz_outsign0_Z(1,3)=numel(loc1);
[t, r] = rose(loc1, 60); 
polar(t, r,'cyan')
[idx,~]=find(delta_nsoz_out_sign0_loc==3);
loc3=delta_soz_out_sign0(idx);
[mean_nsoz_outsign0_rad(3,1) mean_nsoz_outsign0_rad(3,2) mean_nsoz_outsign0_rad(3,3)] = circ_mean(loc3);
[mean_nsoz_outsign0_Z(3,1) mean_nsoz_outsign0_Z(3,2)] = circ_rtest(loc3);
mean_nsoz_outsign0_Z(3,3)=numel(loc3);
[t, r] = rose(loc3, 60); 
polar(t, r,'red')
[idx,~]=find(delta_nsoz_out_sign0_loc==2);
loc2=delta_soz_out_sign0(idx);
[mean_nsoz_outsign0_rad(2,1) mean_nsoz_outsign0_rad(2,2) mean_nsoz_outsign0_rad(2,3)] = circ_mean(loc2);
[mean_nsoz_outsign0_Z(2,1) mean_nsoz_outsign0_Z(2,2)] = circ_rtest(loc2);
mean_nsoz_outsign0_Z(2,3)=numel(loc2);
[t, r] = rose(loc2, 60); 
polar(t, r,'blue')
[idx,~]=find(delta_nsoz_out_sign0_loc==4);
loc4=delta_soz_out_sign0(idx);
[mean_nsoz_outsign0_rad(4,1) mean_nsoz_outsign0_rad(4,2) mean_nsoz_outsign0_rad(4,3)] = circ_mean(loc4);
[mean_nsoz_outsign0_Z(4,1) mean_nsoz_outsign0_Z(4,2)] = circ_rtest(loc4);
mean_nsoz_outsign0_Z(4,3)=numel(loc4);
[t, r] = rose(loc4, 60); 
polar(t, r,'green')
title('Delta Other NSOZ non-prop in')

% delta loc figures nsoz
mean_nsoz_insign1_rad=[];
mean_nsoz_insign1_Z=[];
figure
polar(0,20,'-k')
hold on
[idx,~]=find(delta_nsoz_in_sign1_loc>4);
loc5=delta_soz_in_sign0(idx);
[mean_nsoz_insign1_rad(5,1) mean_nsoz_insign1_rad(5,2) mean_nsoz_insign1_rad(5,3)] = circ_mean(loc5);
[mean_nsoz_insign1_Z(5,1) mean_nsoz_insign1_Z(5,2)] = circ_rtest(loc5);
mean_nsoz_insign1_Z(5,3)=numel(loc5);
[t, r] = rose(loc5, 60); 
polar(t, r,'black')
title('Delta limbic NSOZ prop out')
figure
polar(0,20,'-k')
hold on
[idx,~]=find(delta_nsoz_in_sign1_loc==1);
loc1=delta_soz_in_sign0(idx);
[mean_nsoz_insign1_rad(1,1) mean_nsoz_insign1_rad(1,2) mean_nsoz_insign1_rad(1,3)] = circ_mean(loc1);
[mean_nsoz_insign1_Z(1,1) mean_nsoz_insign1_Z(1,2)] = circ_rtest(loc1);
mean_nsoz_insign1_Z(1,3)=numel(loc1);
[t, r] = rose(loc1, 60); 
polar(t, r,'cyan')
[idx,~]=find(delta_nsoz_in_sign1_loc==3);
loc3=delta_soz_in_sign0(idx);
[mean_nsoz_insign1_rad(3,1) mean_nsoz_insign1_rad(3,2) mean_nsoz_insign1_rad(3,3)] = circ_mean(loc3);
[mean_nsoz_insign1_Z(3,1) mean_nsoz_insign1_Z(3,2)] = circ_rtest(loc3);
mean_nsoz_insign1_Z(3,3)=numel(loc3);
[t, r] = rose(loc3, 60); 
polar(t, r,'red')
[idx,~]=find(delta_nsoz_in_sign1_loc==2);
loc2=delta_soz_in_sign0(idx);
[mean_nsoz_insign1_rad(2,1) mean_nsoz_insign1_rad(2,2) mean_nsoz_insign1_rad(2,3)] = circ_mean(loc2);
[mean_nsoz_insign1_Z(2,1) mean_nsoz_insign1_Z(2,2)] = circ_rtest(loc2);
mean_nsoz_insign1_Z(2,3)=numel(loc2);
[t, r] = rose(loc2, 60); 
polar(t, r,'blue')
[idx,~]=find(delta_nsoz_in_sign1_loc==4);
loc4=delta_soz_in_sign0(idx);
[mean_nsoz_insign1_rad(4,1) mean_nsoz_insign1_rad(4,2) mean_nsoz_insign1_rad(4,3)] = circ_mean(loc4);
[mean_nsoz_insign1_Z(4,1) mean_nsoz_insign1_Z(4,2)] = circ_rtest(loc4);
mean_nsoz_insign1_Z(4,3)=numel(loc4);
[t, r] = rose(loc4, 60); 
polar(t, r,'green')
title('Delta Other NSOZ prop out')

mean_nsoz_outsign1_rad=[];
mean_nsoz_outsign1_Z=[];
figure
polar(0,30,'-k')
hold on
[idx,~]=find(delta_nsoz_out_sign1_loc>4);
loc5=delta_soz_out_sign0(idx);
[mean_nsoz_outsign1_rad(5,1) mean_nsoz_outsign1_rad(5,2) mean_nsoz_outsign1_rad(5,3)] = circ_mean(loc5);
[mean_nsoz_outsign1_Z(5,1) mean_nsoz_outsign1_Z(5,2)] = circ_rtest(loc5);
mean_nsoz_outsign1_Z(5,3)=numel(loc5);
[t, r] = rose(loc5, 60); 
polar(t, r,'black')
title('Delta limbic NSOZ prop in')
figure
polar(0,30,'-k')
hold on
[idx,~]=find(delta_nsoz_out_sign1_loc==1);
loc1=delta_soz_out_sign0(idx);
[mean_nsoz_outsign1_rad(1,1) mean_nsoz_outsign1_rad(1,2) mean_nsoz_outsign1_rad(1,3)] = circ_mean(loc1);
[mean_nsoz_outsign1_Z(1,1) mean_nsoz_outsign1_Z(1,2)] = circ_rtest(loc1);
mean_nsoz_outsign1_Z(1,3)=numel(loc1);
[t, r] = rose(loc1, 60); 
polar(t, r,'cyan')
[idx,~]=find(delta_nsoz_out_sign1_loc==3);
loc3=delta_soz_out_sign0(idx);
[mean_nsoz_outsign1_rad(3,1) mean_nsoz_outsign1_rad(3,2) mean_nsoz_outsign1_rad(3,3)] = circ_mean(loc3);
[mean_nsoz_outsign1_Z(3,1) mean_nsoz_outsign1_Z(3,2)] = circ_rtest(loc3);
mean_nsoz_outsign1_Z(3,3)=numel(loc3);
[t, r] = rose(loc3, 60); 
polar(t, r,'red')
[idx,~]=find(delta_nsoz_out_sign1_loc==2);
loc2=delta_soz_out_sign0(idx);
[mean_nsoz_outsign1_rad(2,1) mean_nsoz_outsign1_rad(2,2) mean_nsoz_outsign1_rad(2,3)] = circ_mean(loc2);
[mean_nsoz_outsign1_Z(2,1) mean_nsoz_outsign1_Z(2,2)] = circ_rtest(loc2);
mean_nsoz_outsign1_Z(2,3)=numel(loc2);
[t, r] = rose(loc2, 60); 
polar(t, r,'blue')
[idx,~]=find(delta_nsoz_out_sign1_loc==4);
loc4=delta_soz_out_sign0(idx);
[mean_nsoz_outsign1_rad(4,1) mean_nsoz_outsign1_rad(4,2) mean_nsoz_outsign1_rad(4,3)] = circ_mean(loc4);
[mean_nsoz_outsign1_Z(4,1) mean_nsoz_outsign1_Z(4,2)] = circ_rtest(loc4);
mean_nsoz_outsign1_Z(4,3)=numel(loc4);
[t, r] = rose(loc4, 60); 
polar(t, r,'green')
title('Delta Other NSOZ prop in')
save('part20321.mat','FRpropertiesVr0306','nsozedges','sozedges','nsozsozedges','soznsozedges')