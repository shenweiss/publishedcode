;
rr350=[];
for i=1:23
    [idx,~]=find(frono_table.patients_frono==i);
    [idx2,~]=find(frons_table.patients_frons==i);
    [idx3,~]=find(frono_table.resected_frono==1);
    [idx4,~]=find(frons_table.resected_frons==1);
    [idx5,~]=find(frono_table.freq_frono>=350);
    resectedfrono=intersect(idx,idx3);
    resectedfrons=intersect(idx2,idx4);
    rr(i)=((numel(resectedfrono)+numel(resectedfrons))/(numel(idx)+numel(idx2)));
    total350frono=intersect(idx,idx5);
    resectedfrono350=intersect(resectedfrono,idx5);
    rr350(i)=((numel(resectedfrono350)+numel(resectedfrons))/(numel(total350frono)+numel(idx2)));
end;

% RR box plots
[idx]=find(CODED==1);
RR_plot{1}=rr350(idx)';
[idx]=find(CODED==3);
RR_plot{2}=rr350(idx)';
[idx]=find(CODED==4);
RR_plot{3}=rr350(idx)';
figure
daboxplot(RR_plot')
title('RR 350 Engel')
[rho,p,rsq,Pfit] = spearman(CODED',rr350')

[idx]=find(CODED==1);
RR_plot{1}=rr(idx)';
[idx]=find(CODED==3);
RR_plot{2}=rr(idx)';
[idx]=find(CODED==4);
RR_plot{3}=rr(idx)';
figure
daboxplot(RR_plot')
title('RR Engel')
[rho,p,rsq,Pfit] = spearman(CODED',rr')

AUC=[];
% ROC curves
% Sz free
% 350
[idx]=find(CODED==1);
szfree=rr350(idx);
[idx2]=find(CODED>1);
non=rr350(idx2);
ALLrrsorted=[szfree non];
sortedCODED=vertcat(ones(numel(idx),1), zeros(numel(idx2),1))';
ID_sorted=[ALLPATIENTS(idx) ALLPATIENTS(idx2)];
[X,Y,T,AUC(1,1)]=perfcurve(sortedCODED,ALLrrsorted,1);
youden=Y+(1-X)-1;
[~,idx]=max(youden);
cutoff=T(idx);
positives=find(ALLrrsorted>cutoff);
negatives=find(ALLrrsorted<cutoff);
posclas=find(sortedCODED==1);
negclas=find(sortedCODED==0);
FP=numel(intersect(positives,negclas));
FP_ID_e1=ID_sorted(intersect(positives,negclas))
TN=numel(intersect(negatives,negclas));
TP=numel(intersect(positives,posclas));
FN=numel(intersect(negatives,posclas));
FN_ID_e1=ID_sorted(intersect(negatives,posclas));
[metrics ci] = contingency_table(TP,TN,FP,FN)
szfree350_out={''};
for i=1:5
   szfree350_out{1,i}=[num2str(round(metrics(i),3)) ' ' num2str(round(ci(i,1),2)) ' ' num2str(round(ci(i,2),2))];
end;

figure
plot(X,Y)
title('ROC RR 350 sz free')

% ROC curves
% Sz free
% all 
[idx]=find(CODED==1)
szfree=rr(idx);
[idx2]=find(CODED>1)
non=rr(idx2);
ALLrrsorted=[szfree non];
sortedCODED=vertcat(ones(numel(idx),1), zeros(numel(idx2),1))';
[X,Y,T,AUC(1,2)]=perfcurve(sortedCODED,ALLrrsorted,1)
youden=Y+(1-X)-1;
[~,idx]=max(youden);
cutoff=T(idx);
positives=find(ALLrrsorted>=cutoff);
negatives=find(ALLrrsorted<cutoff);
posclas=find(sortedCODED==1);
negclas=find(sortedCODED==0);
FP=numel(intersect(positives,negclas));
TN=numel(intersect(negatives,negclas));
TP=numel(intersect(positives,posclas));
FN=numel(intersect(negatives,posclas));
[metrics ci] = contingency_table(TP,TN,FP,FN)
szfreeall_out={''};
for i=1:5
   szfreeall_out{1,i}=[num2str(round(metrics(i),3)) ' ' num2str(round(ci(i,1),2)) ' ' num2str(round(ci(i,2),2))];
end;

figure
plot(X,Y)
title('ROC RR sz free')

% ROC curves
% responders
% 350
[idx]=find(CODED<4)
szfree=rr350(idx);
[idx2]=find(CODED==4)
non=rr350(idx2);
ALLrrsorted=[szfree non];
sortedCODED=vertcat(ones(numel(idx),1), zeros(numel(idx2),1))';
ID_sorted=[ALLPATIENTS(idx) ALLPATIENTS(idx2)];
[X,Y,T,AUC(2,1)]=perfcurve(sortedCODED,ALLrrsorted,1)
youden=Y+(1-X)-1;
[~,idx]=max(youden);
cutoff=T(idx);
positives=find(ALLrrsorted>=cutoff);
negatives=find(ALLrrsorted<cutoff);
posclas=find(sortedCODED==1);
negclas=find(sortedCODED==0);
FP=numel(intersect(positives,negclas));
FP_ID_r=ID_sorted(intersect(positives,negclas))
TN=numel(intersect(negatives,negclas));
TP=numel(intersect(positives,posclas));
FN=numel(intersect(negatives,posclas));
FN_ID_r=ID_sorted(intersect(negatives,posclas));
[metrics ci] = contingency_table(TP,TN,FP,FN)
resp350_out={''};
for i=1:5
   resp350_out{1,i}=[num2str(round(metrics(i),3)) ' ' num2str(round(ci(i,1),2)) ' ' num2str(round(ci(i,2),2))];
end;

figure
plot(X,Y)
title('ROC RR 350 responders')

% ROC curves
% responders
% all 
[idx]=find(CODED<4)
szfree=rr(idx);
[idx2]=find(CODED==4)
non=rr(idx2);
ALLrrsorted=[szfree non];
sortedCODED=vertcat(ones(numel(idx),1), zeros(numel(idx2),1))';
[X,Y,T,AUC(2,2)]=perfcurve(sortedCODED,ALLrrsorted,1)
youden=Y+(1-X)-1;
[~,idx]=max(youden);
cutoff=T(idx);
positives=find(ALLrrsorted>=cutoff);
negatives=find(ALLrrsorted<cutoff);
posclas=find(sortedCODED==1);
negclas=find(sortedCODED==0);
FP=numel(intersect(positives,negclas));
TN=numel(intersect(negatives,negclas));
TP=numel(intersect(positives,posclas));
FN=numel(intersect(negatives,posclas));
[metrics ci] = contingency_table(TP,TN,FP,FN)
respall_out={''};
for i=1:5
   respall_out{1,i}=[num2str(round(metrics(i),3)) ' ' num2str(round(ci(i,1),2)) ' ' num2str(round(ci(i,2),2))];
end;
figure
plot(X,Y)
title('ROC RR non-responders')