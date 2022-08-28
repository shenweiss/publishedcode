%patients 4 and 19 had no lambda

lambda_ratio={''};
temp=frmi.uw_lambda_r;
temp(isnan(temp))=0;
lambda_nr=temp./frmi.uw_lambda;
[idx]=isnan(frmi.uw_lambda);
lambda_nr(idx)=NaN;
lambda_ratio{1}=lambda_nr(find(CODED==1));
CODED(11)=3;
lambda_ratio{2}=lambda_nr(find(CODED==3));
lambda_ratio{3}=lambda_nr(find(CODED==4));
figure
daboxplot(lambda_ratio);
title('lambda ratio')

ROC=[];
% ROC
nulls=[4 13 15 17 19];
lambda_nr_roc=lambda_nr;
lambda_nr_roc(nulls)=[];
szfree=vertcat(ones(9,1),zeros(14,1));
szfree(nulls)=[];
[X_lambda_e1,Y_lambda_e1,T,ROC(1,1)] = perfcurve(szfree,lambda_nr_roc,1);

resp=vertcat(ones(13,1),zeros(10,1));
resp(21)=1;
resp(nulls)=[];
[X_lambda_r,Y_lambda_r,T,ROC(1,2)] = perfcurve(resp,lambda_nr_roc,1);

leff_nf={''};
nolambda=[13 15 17];
temp=frmi.nonresected_whole_leff_mean_uw';
temp(nolambda)=NaN;

leff_nr{1}=temp(find(CODED==1));
leff_nr{2}=temp(find(CODED==3));
leff_nr{3}=temp(find(CODED==4));
figure
daboxplot(leff_nr); 
title('non-resected mean local efficiency')

% ROC
leff_nr_roc=temp;
leff_nr_roc(nulls)=[];
[X_le_e1,Y_le_e1,T,ROC(2,1)] = perfcurve(szfree,leff_nr_roc,0);
[X_le_r,Y_le_r,T,ROC(2,2)] = perfcurve(resp,leff_nr_roc,0);

%% New
% This is pretty useful!
values=frmi.nonresected_ur_leff_mean_uw'
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
leff_nr_roc=values;
leff_nr_roc(nulls)=[];
[X_le_nr_e1,Y_le_nr_e1,T,ROC(3,1)] = perfcurve(szfree,leff_nr_roc,1);
[X_le_nr_r,Y_le_nr_r,T,ROC(3,2)] = perfcurve(resp,leff_nr_roc,1);
%%

%% New
% this is pretty useful
values=frmi.nonresected_whole_cc_max_uw';
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
[X_cc_e1,Y_cc_e1,T,ROC(4,1)] = perfcurve(szfree,cc_nr_roc,1);
[X_cc_r,Y_cc_r,T,ROC(4,2)] = perfcurve(resp,cc_nr_roc,1);
%%

centrality_ratio=(frmi.Cnt_nr_uw)./(frmi.Cnt_uw);
mean_centrality_ratio=[];
for i=1:23
    [idx,~]=find(frmi.patient_array==i);
    temp=centrality_ratio(idx);
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
[X_cent_e1,Y_cent_e1,T,ROC(5,1)] = perfcurve(szfree,cent_roc,0);
[X_cent_r,Y_cent_r,T,ROC(5,2)] = perfcurve(resp,cent_roc,0);
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
