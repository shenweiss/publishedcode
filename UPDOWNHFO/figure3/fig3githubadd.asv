% UP/DOWN Max SOZ
clear
load('FRONOdataoutphaseMISTAKEv3.mat')
power_quantile=quantile(MDLdata.power,125);
[idx]=find(MDLdata.power<power_quantile(26));
MDLdata(idx,:)=[];
[idx]=find(MDLdata.soz==0);
MDLdata(idx,:)=[];

updownumean=[];
updownustd=[];
downupumean=[];
updownustd=[];
p_array=[];
d_array=[];
units=unique(MDLdata.unit);
for i=1:numel(units)
     [idx1]=find(MDLdata.slowangle>-2.35619449019235);
     [idx2]=find(MDLdata.slowangle<-1.57079632679490);
     [int]=intersect(idx1,idx2);
     [idx3]=find(MDLdata.unit==units(i));
     [int2]=intersect(int,idx3);
     updownu=MDLdata.hfodiff(int2);
     updownumean(i)=nanmean(updownu);
     updownustd(i)=nanstd(updownu)/sqrt(numel(updownu));
     [idx4]=find(MDLdata.slowangle>-0.392699081698724);
     [idx5]=find(MDLdata.slowangle<0.392699081698724);
     [int3]=intersect(idx4,idx5);
     [int4]=intersect(int3,idx3);
     downupu=MDLdata.hfodiff(int4);
     downupumean(i)=nanmean(downupu);
     downupustd(i)=nanstd(downupu)/sqrt(numel(downupu));
     [h,p_array(i),ci,stats] = ttest2(updownu,downupu);
     d_array(i)=computeCohen_d(updownu,downupu);
end;
[h_ud, crit_p_ud, adj_ci_cvrg, adj_p]=fdr_bh(p_array,0.05);
ratio_ud=updownumean-downupumean;
[idx]=find(ratio_ud>0);
[idx2]=find(ratio_ud<0);
[idx3]=find(h_ud==1);
[int]=intersect(idx,idx3);
[int2]=intersect(idx2,idx3);
unitnumud=units(int);
unitnumdu=units(int2);
d_array(int)
d_array(int2)

extracol=zeros(1,numel(updownumean))
c1=[0 1 0];
c2=[0 1 1];
color=vertcat(c1,c2,c1);
bardata=vertcat(updownumean,downupumean,extracol);
barstd=vertcat(updownustd,downupustd,extracol);
sig=int*3;
figure
errorbar_groups(bardata,barstd,'bar_colors',color);
hold on
for i=1:numel(sig)
text(sig(i), 2, '*','Color','r');
end;
sig2=int2*3
for i=1:numel(sig2)
text(sig2(i), 2, '*','Color','b');
end;
xticks([0:3:(44*3)])

% UP/DOWN Max NSOZ
clear
load('FRONOdataoutphaseMISTAKEv3.mat')
power_quantile=quantile(MDLdata.power,125);
[idx]=find(MDLdata.power<power_quantile(26));
MDLdata(idx,:)=[];
[idx]=find(MDLdata.soz==1);
MDLdata(idx,:)=[];

updownumean=[];
updownustd=[];
downupumean=[];
updownustd=[];
p_array=[];
units=unique(MDLdata.unit);
for i=1:numel(units)
     [idx1]=find(MDLdata.slowangle>-2.35619449019235);
     [idx2]=find(MDLdata.slowangle<-1.57079632679490);
     [int]=intersect(idx1,idx2);
     [idx3]=find(MDLdata.unit==units(i));
     [int2]=intersect(int,idx3);
     updownu=MDLdata.hfodiff(int2);
     updownumean(i)=nanmean(updownu);
     updownustd(i)=nanstd(updownu)/sqrt(numel(updownu));
     [idx4]=find(MDLdata.slowangle>-0.392699081698724);
     [idx5]=find(MDLdata.slowangle<0.392699081698724);
     [int3]=intersect(idx4,idx5);
     [int4]=intersect(int3,idx3);
     downupu=MDLdata.hfodiff(int4);
     downupumean(i)=nanmean(downupu);
     downupustd(i)=nanstd(downupu)/sqrt(numel(downupu));
     [h,p_array(i),ci,stats] = ttest2(updownu,downupu);
end;

ratio_ud=updownumean-downupumean;
[h_ud, crit_p_ud, adj_ci_cvrg, adj_p]=fdr_bh(p_array,0.05);
[idx]=find(ratio_ud>0);
[idx2]=find(ratio_ud<0);
[idx3]=find(h_ud==1);
[int]=intersect(idx,idx3);
[int2]=intersect(idx2,idx3);
unitnumud_nsoz=units(int);
unitnumdu_nsoz=units(int2);

extracol=zeros(1,numel(updownumean))
c1=[0 1 0];
c2=[0 1 1];
color=vertcat(c1,c2,c1);
bardata=vertcat(updownumean,downupumean,extracol);
barstd=vertcat(updownustd,downupustd,extracol);
sig=int*3;
errorbar_groups(bardata,barstd,'bar_colors',color);
hold on
for i=1:numel(sig)
text(sig(i), 2, '*','Color','r');
end;
sig2=int2*3
for i=1:numel(sig2)
text(sig2(i), 2, '*','Color','b');
end;
xticks([0:3:(numel(updownumean)*3)])