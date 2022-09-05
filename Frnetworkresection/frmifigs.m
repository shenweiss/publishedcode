%patients 4 and 19 had no lambda
[frmi]=calc_localmeasures_0819(frmi);
ROC=[];
lambda_ratio={''};
temp=frmi.lambda_r;
temp(isnan(temp))=0;
lambda_nr=temp./frmi.lambda;
[idx]=isnan(frmi.lambda);
lambda_nr(idx)=NaN;
lambda_ratio{1}=lambda_nr(find(CODED==1));
CODED(11)=3;
lambda_ratio{2}=lambda_nr(find(CODED==3));
lambda_ratio{3}=lambda_nr(find(CODED==4));
figure
daboxplot(lambda_ratio);
title('lambda ratio')

% ROC
nulls=[4 13 15 17 19];
rrpos=[1	2	3	5	6	7	8	9	10	11	12	14  21	23]; 
PATIENTS_nulls=ALLPATIENTS(nulls);
PATIENT_nonulls=ALLPATIENTS;
PATIENT_nonulls(nulls)=[];

lambda_nr_roc=lambda_nr;
lambda_nr_roc(nulls)=[];
CODED_nulls=CODED;
CODED_nulls(nulls)=[];
[rho,p,rsq,Pfit] = spearman(CODED_nulls',lambda_nr_roc)

szfree=vertcat(ones(10,1),zeros(13,1));
szfree(nulls)=[];
[X_lambda_e1,Y_lambda_e1,T,ROC(1,1)] = perfcurve(szfree,lambda_nr_roc,1);
youden=Y_lambda_e1+(1-X_lambda_e1)-1;
[~,idx]=max(youden);
cutoff=T(idx);
positives=find(lambda_nr_roc>=cutoff);
negatives=find(lambda_nr_roc<cutoff);
posclas=find(szfree==1);
negclas=find(szfree==0);
FP=numel(intersect(positives,negclas));
TN=numel(intersect(negatives,negclas));
TP=numel(intersect(positives,posclas));
FN=numel(intersect(negatives,posclas));
TP=TP+1; % PAT4
FP=FP+4; %PAT
[metrics ci] = contingency_table(TP,TN,FP,FN)
lambda_e1_out={''};
for i=1:5
   lambda_e1_out{1,i}=[num2str(round(metrics(i),3)) ' ' num2str(round(ci(i,1),2)) ' ' num2str(round(ci(i,2),2))];
end;

% ROC reflex
szfree_reflex=vertcat(ones(10,1),zeros(13,1));
szfree_reflex=szfree_reflex(rrpos);
lambda_nr_roc_reflex=lambda_nr;
lambda_nr_roc_reflex=lambda_nr_roc_reflex(rrpos);
[X_lambda_e1_reflex,Y_lambda_e1_reflex,T] = perfcurve(szfree_reflex,lambda_nr_roc_reflex,1);
youden=Y_lambda_e1_reflex+(1-X_lambda_e1_reflex)-1;
[~,idx]=max(youden);
cutoff=T(idx);
positives=find(lambda_nr_roc_reflex>=cutoff);
negatives=find(lambda_nr_roc_reflex<cutoff);
posclas=find(szfree_reflex==1);
negclas=find(szfree_reflex==0);
FP=numel(intersect(positives,negclas));
TN=numel(intersect(negatives,negclas));
TP=numel(intersect(positives,posclas));
FN=numel(intersect(negatives,posclas));
TP=TP+1; % PAT4
FP=FP+4; %PAT
[metrics ci] = contingency_table(TP,TN,FP,FN)
lambda_e1_out={''};
for i=1:5
   lambda_e1_out{1,i}=[num2str(round(metrics(i),3)) ' ' num2str(round(ci(i,1),2)) ' ' num2str(round(ci(i,2),2))];
end;

resp=vertcat(ones(13,1),zeros(10,1));
resp(21)=1;
resp(nulls)=[];
[X_lambda_r,Y_lambda_r,T,ROC(1,2)] = perfcurve(resp,lambda_nr_roc,1);
youden=Y_lambda_r+(1-X_lambda_r)-1;
[~,idx]=max(youden);
cutoff=T(idx);
positives=find(lambda_nr_roc>=cutoff);
negatives=find(lambda_nr_roc<cutoff);
posclas=find(resp==1);
negclas=find(resp==0);
FP=numel(intersect(positives,negclas));
TN=numel(intersect(negatives,negclas));
TP=numel(intersect(positives,posclas));
FN=numel(intersect(negatives,posclas));
TP=TP+2; % PAT4
FP=FP+3; %PAT
[metrics ci] = contingency_table(TP,TN,FP,FN)
lambda_r_out={''};
for i=1:5
   lambda_r_out{1,i}=[num2str(round(metrics(i),3)) ' ' num2str(round(ci(i,1),2)) ' ' num2str(round(ci(i,2),2))];
end;

leff_nf={''};
[frmi]=calc_node_localeff_0822(frmi);
frmi.nsoz_node_leff(idx)=NaN;
% patients 13,15 and 17 had full resection of the FR MI network

nolambda=[13 15 17];
frmi.nsoz_node_leff(nolambda)=NaN;

leff_nr{1}=frmi.nsoz_node_leff(find(CODED==1));
leff_nr{2}=frmi.nsoz_node_leff(find(CODED==3));
leff_nr{3}=frmi.nsoz_node_leff(find(CODED==4));
figure
daboxplot(leff_nr); 
title('non-resected mean local efficiency')

% ROC
leff_nr_roc=frmi.nsoz_node_leff;
leff_nr_roc(nulls)=[];
leff_nr_roc_sp=leff_nr_roc;
leff_nr_roc_sp([1 11])=[];
CODED_nulls_leff=CODED_nulls;
CODED_nulls_leff([1 11])=[];
[rho,p,rsq,Pfit] = spearman(CODED_nulls_leff',leff_nr_roc_sp)
[X_le_e1,Y_le_e1,T,ROC(2,1)] = perfcurve(szfree,leff_nr_roc,1);
youden=Y_le_e1+(1-X_le_e1)-1;
[~,idx]=max(youden);
cutoff=T(idx);
positives=find(leff_nr_roc>=cutoff);
negatives=find(leff_nr_roc<cutoff);
posclas=find(szfree==1);
negclas=find(szfree==0);
FP=numel(intersect(positives,negclas));
TN=numel(intersect(negatives,negclas));
TP=numel(intersect(positives,posclas));
FN=numel(intersect(negatives,posclas));
TP=TP+1; % PAT4
FP=FP+4; %PAT
[metrics ci] = contingency_table(TP,TN,FP,FN)
leff_e1_out={''};
for i=1:5
   leff_e1_out{1,i}=[num2str(round(metrics(i),3)) ' ' num2str(round(ci(i,1),2)) ' ' num2str(round(ci(i,2),2))];
end;


[X_le_r,Y_le_r,T,ROC(2,2)] = perfcurve(resp,leff_nr_roc,1);
youden=Y_le_r+(1-X_le_r)-1;
[~,idx]=max(youden);
cutoff=T(idx);
positives=find(leff_nr_roc>=cutoff);
negatives=find(leff_nr_roc<cutoff);
posclas=find(resp==1);
negclas=find(resp==0);
FP=numel(intersect(positives,negclas));
TN=numel(intersect(negatives,negclas));
TP=numel(intersect(positives,posclas));
FN=numel(intersect(negatives,posclas));
TP=TP+2; % PAT4,13
FP=FP+3; %PAT
[metrics ci] = contingency_table(TP,TN,FP,FN)
leff_r_out={''};
for i=1:5
   leff_r_out{1,i}=[num2str(round(metrics(i),3)) ' ' num2str(round(ci(i,1),2)) ' ' num2str(round(ci(i,2),2))];
end;

%% New
% This is pretty useful!
values=frmi.nonresected_ur_leff_mean'
values(nulls)=NaN;
boxplotdat={''};
boxplotdat{1}=values(find(CODED==1));
CODED(11)=3;
boxplotdat{2}=values(find(CODED==3));
boxplotdat{3}=values(find(CODED==4));
figure
daboxplot(boxplotdat)
title('mean unresected LE resect')

% ROC
leff_nr_roc_nr=values;
leff_nr_roc_nr(nulls)=[];
[rho,p,rsq,Pfit] = spearman(CODED_nulls',leff_nr_roc_nr)
[X_le_nr_e1,Y_le_nr_e1,T,ROC(3,1)] = perfcurve(szfree,leff_nr_roc_nr,1);
youden=Y_le_nr_e1+(1-X_le_nr_e1)-1;
[~,idx]=max(youden);
cutoff=T(idx);
positives=find(leff_nr_roc_nr>=cutoff);
negatives=find(leff_nr_roc_nr<cutoff);
posclas=find(szfree==1);
negclas=find(szfree==0);
FP=numel(intersect(positives,negclas));
TN=numel(intersect(negatives,negclas));
TP=numel(intersect(positives,posclas));
FN=numel(intersect(negatives,posclas));
TP=TP+1; % PAT4,13
FP=FP+4; %PAT
[metrics ci] = contingency_table(TP,TN,FP,FN)
leff_nr_e1_out={''};
for i=1:5
   leff_nr_e1_out{1,i}=[num2str(round(metrics(i),3)) ' ' num2str(round(ci(i,1),2)) ' ' num2str(round(ci(i,2),2))];
end;

%ROC reflex
leff_nr_roc_nr_reflex=values(rrpos);
szfree_reflex=vertcat(ones(10,1),zeros(13,1));
szfree_reflex=szfree_reflex(rrpos);
[rho,p,rsq,Pfit] = spearman(szfree_reflex,leff_nr_roc_nr_reflex)
[X_le_nr_e1_reflex,Y_le_nr_e1_reflex,T] = perfcurve(szfree_reflex,leff_nr_roc_nr_reflex,1);
youden=Y_le_nr_e1_reflex+(1-X_le_nr_e1_reflex)-1;
[~,idx]=max(youden);
cutoff=T(idx);
positives=find(leff_nr_roc_nr_reflex>=cutoff);
negatives=find(leff_nr_roc_nr_reflex<cutoff);
posclas=find(szfree_reflex==1);
negclas=find(szfree_reflex==0);
FP=numel(intersect(positives,negclas));
TN=numel(intersect(negatives,negclas));
TP=numel(intersect(positives,posclas));
FN=numel(intersect(negatives,posclas));
TP=TP+1; % PAT4,13
FP=FP+4; %PAT
[metrics ci] = contingency_table(TP,TN,FP,FN)
leff_nr_e1_out={''};
for i=1:5
   leff_nr_e1_out{1,i}=[num2str(round(metrics(i),3)) ' ' num2str(round(ci(i,1),2)) ' ' num2str(round(ci(i,2),2))];
end;


[X_le_nr_r,Y_le_nr_r,T,ROC(3,2)] = perfcurve(resp,leff_nr_roc_nr,1);
youden=Y_le_nr_r+(1-X_le_nr_r)-1;
[~,idx]=max(youden);
cutoff=T(idx);
positives=find(leff_nr_roc_nr>=cutoff);
negatives=find(leff_nr_roc_nr<cutoff);
posclas=find(resp==1);
negclas=find(resp==0);
FP=numel(intersect(positives,negclas));
TN=numel(intersect(negatives,negclas));
TP=numel(intersect(positives,posclas));
FN=numel(intersect(negatives,posclas));
TP=TP+2; % PAT4,13
FP=FP+3; %PAT
[metrics ci] = contingency_table(TP,TN,FP,FN)
leff__nr_r_out={''};
for i=1:5
   leff_nr_r_out{1,i}=[num2str(round(metrics(i),3)) ' ' num2str(round(ci(i,1),2)) ' ' num2str(round(ci(i,2),2))];
end;

%%

%% New
% this is pretty useful
values=frmi.nonresected_whole_cc_max';
values(nulls)=NaN;
boxplotdat={''};
boxplotdat{1}=values(find(CODED==1));
CODED(11)=3;
boxplotdat{2}=values(find(CODED==3));
boxplotdat{3}=values(find(CODED==4));
figure
daboxplot(boxplotdat)
title('max unresected CC whole')

% ROC
cc_nr_roc=values;
cc_nr_roc(nulls)=[];
cc_nr_roc_sp=cc_nr_roc;
cc_nr_roc_sp(1)=[];
CODED_nulls_sp=CODED_nulls;
CODED_nulls_sp(1)=[];
[rho,p,rsq,Pfit] = spearman(CODED_nulls_sp',cc_nr_roc_sp)
[X_cc_e1,Y_cc_e1,T,ROC(4,1)] = perfcurve(szfree,cc_nr_roc,1);
youden=Y_cc_e1+(1-X_cc_e1)-1;
[~,idx]=max(youden);
cutoff=T(idx);
positives=find(cc_nr_roc>=cutoff);
negatives=find(cc_nr_roc<cutoff);
posclas=find(szfree==1);
negclas=find(szfree==0);
FP=numel(intersect(positives,negclas));
TN=numel(intersect(negatives,negclas));
TP=numel(intersect(positives,posclas));
FN=numel(intersect(negatives,posclas));
TP=TP+1; % PAT4,13
FP=FP+4; %PAT
[metrics ci] = contingency_table(TP,TN,FP,FN)
cc_e1_out={''};
for i=1:5
   cc_e1_out{1,i}=[num2str(round(metrics(i),3)) ' ' num2str(round(ci(i,1),2)) ' ' num2str(round(ci(i,2),2))];
end;

[X_cc_r,Y_cc_r,T,ROC(4,2)] = perfcurve(resp,cc_nr_roc,1);
youden=Y_cc_r+(1-X_cc_r)-1;
[~,idx]=max(youden);
cutoff=T(idx);
positives=find(cc_nr_roc>=cutoff);
negatives=find(cc_nr_roc<cutoff);
posclas=find(resp==1);
negclas=find(resp==0);
FP=numel(intersect(positives,negclas));
TN=numel(intersect(negatives,negclas));
TP=numel(intersect(positives,posclas));
FN=numel(intersect(negatives,posclas));
TP=TP+2; % PAT4,13
FP=FP+3; %PAT
[metrics ci] = contingency_table(TP,TN,FP,FN)
cc_nr_r_out={''};
for i=1:5
   cc_nr_r_out{1,i}=[num2str(round(metrics(i),3)) ' ' num2str(round(ci(i,1),2)) ' ' num2str(round(ci(i,2),2))];
end;

%%

centrality_ratio=(frmi.Cnt_nr)./(frmi.Cnt);
mean_centrality_ratio=[];
for i=1:23
    [idx0,~]=find(frmi.resected_array==0);
    [idx,~]=find(frmi.patient_array==i);
    [int]=intersect(idx0,idx);
    temp=centrality_ratio(int);
    [idx2,~]=find(isnan(temp)==1);
    temp(idx2)=[];
    [idx2,~]=find(isinf(temp)==1);    
    temp(idx2)=[];
    if ~isempty(temp)
        mean_centrality_ratio(i)=nanmean(temp);
    else
        mean_centrality_ratio(i)=NaN;
    end;
end;
mean_centrality_ratio(nolambda)=NaN;
mean_centrality_ratio=mean_centrality_ratio';
cent={''};
cent{1}=mean_centrality_ratio(find(CODED==1));
cent{2}=mean_centrality_ratio(find(CODED==3));
cent{3}=mean_centrality_ratio(find(CODED==4));
figure
daboxplot(cent); 
title('post-resection centrality ratio')

% ROC
cent_roc=mean_centrality_ratio;
cent_roc(nulls)=[];
[rho,p,rsq,Pfit] = spearman(CODED_nulls',cent_roc)
[X_cent_e1,Y_cent_e1,T,ROC(5,1)] = perfcurve(szfree,cent_roc,0);
youden=Y_cent_e1+(1-X_cent_e1)-1;
[~,idx]=max(youden);
cutoff=T(idx);
positives=find(cent_roc<=cutoff);
negatives=find(cent_roc>cutoff);
posclas=find(szfree==1);
negclas=find(szfree==0);
FN=numel(intersect(positives,negclas));
TN=numel(intersect(negatives,negclas));
TP=numel(intersect(positives,posclas));
FP=numel(intersect(negatives,posclas));
TP=TP+1; % PAT4,13
FP=FP+4; %PAT
[metrics ci] = contingency_table(TP,TN,FP,FN)
cent_e1_out={''};
for i=1:5
   cent_e1_out{1,i}=[num2str(round(metrics(i),3)) ' ' num2str(round(ci(i,1),2)) ' ' num2str(round(ci(i,2),2))];
end;

[X_cent_r,Y_cent_r,T,ROC(5,2)] = perfcurve(resp,cent_roc,0);
youden=Y_cent_r+(1-X_cent_r)-1;
[~,idx]=max(youden);
cutoff=T(idx);
positives=find(cent_roc<=cutoff);
negatives=find(cent_roc>cutoff);
posclas=find(resp==1);
negclas=find(resp==0);
FN=numel(intersect(positives,negclas));
TN=numel(intersect(negatives,negclas));
TP=numel(intersect(positives,posclas));
FP=numel(intersect(negatives,posclas));
TP=TP+2; % PAT4,13
FP=FP+3; %PAT
[metrics ci] = contingency_table(TP,TN,FP,FN)
cent_r_out={''};
for i=1:5
   cent_r_out{1,i}=[num2str(round(metrics(i),3)) ' ' num2str(round(ci(i,1),2)) ' ' num2str(round(ci(i,2),2))];
end;



figure
plot(X_lambda_r,Y_lambda_r,'black','linewidth',2);
hold on
plot(X_le_r,Y_le_r,'color',[(190/255) 0 0],'linewidth',2);
plot(X_le_nr_r,Y_le_nr_r,'color',[(247/255) (51/255) (14/255)],'linewidth',2);
plot(X_cc_r,Y_cc_r,'color',[(223/255) (160/255) (26/255)],'linewidth',2);
plot(X_cent_r,Y_cent_r,'color',[(0/255) (242/255) (222/255)],'linewidth',2);
title('FR MI measures - responder outcome')

figure
plot(X_lambda_e1,Y_lambda_e1,'black','linewidth',2);
hold on
plot(X_le_e1,Y_le_e1,'color',[(190/255) 0 0],'linewidth',2);
plot(X_le_nr_e1,Y_le_nr_e1,'color',[(247/255) (51/255) (14/255)],'linewidth',2);
plot(X_cc_e1,Y_cc_e1,'color',[(223/255) (160/255) (26/255)],'linewidth',2);
plot(X_cent_e1,Y_cent_e1,'color',[(0/255) (242/255) (222/255)],'linewidth',2);
title('FR MI measures - e1 outcome')

