[idx]=isnan(ratedistance.fripple_rate_resected);
ratedistance.fripple_rate_resected(idx)=0;
radius_rate_sub=ratedistance.fripple_rate-ratedistance.fripple_rate_resected;
radius_rate_ratio=ratedistance.fripple_rate_resected./ratedistance.fripple_rate;
radius_rate_sub_sqrt=sqrt(radius_rate_sub);
CODED(11)=3;
radius_sub={''};
radius_sub{1}=radius_rate_sub_sqrt(find(CODED==1));
radius_sub{2}=radius_rate_sub_sqrt(find(CODED==3));
radius_sub{3}=radius_rate_sub_sqrt(find(CODED==4));
figure
daboxplot(radius_sub)
title('SQRT FR RD whole-resected radius')
radius_ratio={''};
radius_ratio{1}=radius_rate_ratio(find(CODED==1));
radius_ratio{2}=radius_rate_ratio(find(CODED==3));
radius_ratio{3}=radius_rate_ratio(find(CODED==4));
figure
daboxplot(radius_ratio)
title('FR RD resected/whole ratio')
[rho,p,rsq,Pfit] = spearman(CODED',radius_rate_sub)

%ROC
szfree=vertcat(ones(10,1),zeros(13,1));
resp=vertcat(ones(13,1),zeros(10,1));
resp(21)=1;
AUC=[];
[X_ratesub_e1,Y_ratesub_e1,T,AUC(1)] = perfcurve(szfree,radius_rate_sub,1);
youden=(1-Y_ratesub_e1)+(1-(1-X_ratesub_e1))-1;
[~,idx]=max(youden);
cutoff=T(idx+1);
positives=find(radius_rate_sub<=cutoff);
negatives=find(radius_rate_sub>cutoff);
posclas=find(szfree==1);
negclas=find(szfree==0);
FP_ID_e1=ID_sorted(intersect(positives,negclas))
FN=numel(intersect(negatives,posclas));
TN=numel(intersect(negatives,negclas));
TP=numel(intersect(positives,posclas));
FP=numel(intersect(positives,negclas));
[metrics ci] = contingency_table(TP,TN,FP,FN)
ratedist_szfree_out={''};
for i=1:5
   ratedist_szfree_out{1,i}=[num2str(round(metrics(i),3)) ' ' num2str(round(ci(i,1),2)) ' ' num2str(round(ci(i,2),2))];
end;

% Reflex testing analysis
rrpos=[1	2	3	4	5	6	7	8	9	10	11	12	13	14	15	17	21	23];
temp=[1:23];
[C,IA,IB]=intersect(rrpos,temp);
temp(IB)=[];
szfree_reflex=szfree;
szfree_reflex(temp)=[];
radius_rate_sub_reflex=radius_rate_sub;
radius_rate_sub_reflex(temp)=[];
[X_ratesub_e1_reflex,Y_ratesub_e1_reflex,T,AUC(2)] = perfcurve(szfree_reflex,radius_rate_sub_reflex,1);
youden=(1-Y_ratesub_e1_reflex)+(1-(1-X_ratesub_e1_reflex))-1;
[~,idx]=max(youden);
cutoff=T(idx+1);
positives=find(radius_rate_sub_reflex<=cutoff);
negatives=find(radius_rate_sub_reflex>cutoff);
posclas=find(szfree==1);
negclas=find(szfree==0);
FP_ID_e1=ID_sorted(intersect(positives,negclas))
FN=numel(intersect(negatives,posclas));
TN=numel(intersect(negatives,negclas));
TP=numel(intersect(positives,posclas));
FP=numel(intersect(positives,negclas));
[metrics ci] = contingency_table(TP,TN,FP,FN)
ratedist_szfree_out={''};
for i=1:5
   ratedist_szfree_out{1,i}=[num2str(round(metrics(i),3)) ' ' num2str(round(ci(i,1),2)) ' ' num2str(round(ci(i,2),2))];
end;

[X_ratesub_r,Y_ratesub_r,T,AUC(3)] = perfcurve(resp,radius_rate_sub,1);
youden=(1-Y_ratesub_r)+(1-(1-X_ratesub_r))-1;
[~,idx]=max(youden);
cutoff=T(idx+1);
positives=find(radius_rate_sub<=cutoff);
negatives=find(radius_rate_sub>cutoff);
posclas=find(resp==1);
negclas=find(resp==0);
FN=numel(intersect(negatives,posclas));
TN=numel(intersect(negatives,negclas));
TP=numel(intersect(positives,posclas));
FP=numel(intersect(positives,negclas));
[metrics ci] = contingency_table(TP,TN,FP,FN)
ratedist_resp_out={''};
for i=1:5
   ratedist_resp_out{1,i}=[num2str(round(metrics(i),3)) ' ' num2str(round(ci(i,1),2)) ' ' num2str(round(ci(i,2),2))];
end;
figure
plot(1-X_ratesub_e1,1-Y_ratesub_e1);
title('FR RD sub E1')

figure
plot(1-X_ratesub_r,1-Y_ratesub_r);
title('FR RD sub R')
