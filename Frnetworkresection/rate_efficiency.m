rate=frmi.rate_array;
patients=frmi.patient_array;
e_l=frmi.e_l;
e_l_nr=frmi.e_l_nr;
resected=frmi.resected_array
responder=frmi.responder_array';
szfree=vertcat(zeros(1194,1),ones(1375,1));
glmm_table=table(rate,e_l,e_l_nr,patients,szfree,responder,resected);
glmm_table2=glmm_table;
idx=find(rate==0);
glmm_table2(idx,:)=[];
idx2=find(e_l==0);
idx=vertcat(idx,idx2);
glmm_table(idx,:)=[];
X=[glmm_table.e_l log10(glmm_table.rate) ];
[kmeans_idx,centroid]=kmeans(X,3,'distance','cityblock');
load('kmeans_backup.mat')
[idx]=find(kmeans_idx==1);
figure
hold on
scatter(log10(glmm_table.rate(idx)),glmm_table.e_l(idx),'blue','filled');
[idx]=find(kmeans_idx==2);
scatter(log10(glmm_table.rate(idx)),glmm_table.e_l(idx),'red','filled');
[idx]=find(kmeans_idx==3);
scatter(log10(glmm_table.rate(idx)),glmm_table.e_l(idx),'green','filled');

patientlist=unique(glmm_table2.patients);
totalnode_r=[];
totalnode_nr=[];
zeronode_r=[];
zeronode_nr=[];
szfree=[];
clust1_r=[];
clust2_r=[];
clust3_r=[];
clust1_nr=[];
clust2_nr=[];
clust3_nr=[];
for i=1:numel(patientlist)
    [idx]=find(glmm_table2.patients==patientlist(i));
    [idx2]=find(glmm_table2.resected==1);
    totalnode_r(i)=numel(intersect(idx,idx2));
    [idx2]=find(glmm_table2.resected==0);
    totalnode_nr(i)=numel(intersect(idx,idx2));
    [idx3]=find(glmm_table2.e_l==0);
    [idx2]=find(glmm_table2.resected==1);
    zeronode_r(i)=numel(intersect(intersect(idx,idx2),idx3));
    [idx2]=find(glmm_table2.resected==0);
    zeronode_nr(i)=numel(intersect(intersect(idx,idx2),idx3));
    if i<=10
        szfree(i)=1;
    else
        szfree(i)=0;
    end;
    [idx]=find(glmm_table.patients==patientlist(i));
    [idx2]=find(glmm_table.resected==1);
    [idx3]=find(kmeans_idx==1);
    temp=intersect(intersect(idx,idx2),idx3);
    if ~isempty(temp)
    clust1_r(i)=numel(temp);
    else
    clust1_r(i)=NaN;
    end;
    [idx3]=find(kmeans_idx==2);
    temp=intersect(intersect(idx,idx2),idx3);
    if ~isempty(temp)
    clust2_r(i)=numel(temp);
    else
    clust2_r(i)=NaN;
    end;
    [idx3]=find(kmeans_idx==3);
    temp=intersect(intersect(idx,idx2),idx3);
    if ~isempty(temp)
    clust3_r(i)=numel(temp);
    else
    clust3_r(i)=NaN;
    end;

    [idx2]=find(glmm_table.resected==0);
    [idx3]=find(kmeans_idx==1);
    temp=intersect(intersect(idx,idx2),idx3);
    if ~isempty(temp)
    clust1_nr(i)=numel(temp);
    else
    clust1_nr(i)=NaN;
    end;
    [idx3]=find(kmeans_idx==2);
    temp=intersect(intersect(idx,idx2),idx3);
    if ~isempty(temp)
    clust2_nr(i)=numel(temp);
    else
    clust2_nr(i)=NaN;
    end;
    [idx3]=find(kmeans_idx==3);
    temp=intersect(intersect(idx,idx2),idx3);
    if ~isempty(temp)
    clust3_nr(i)=numel(temp);
    else
    clust3_nr(i)=NaN;
    end;
end;
p_vals=[];
p_vals2=[];
zeronode_r(isnan(zeronode_r))=0;
clust1_r(isnan(clust1_r))=0;
clust2_r(isnan(clust2_r))=0;
clust3_r(isnan(clust3_r))=0;
zeronode_nr(isnan(zeronode_nr))=0;
clust1_nr(isnan(clust1_nr))=0;
clust2_nr(isnan(clust2_nr))=0;
clust3_nr(isnan(clust3_nr))=0;

zero_ratio_r=(zeronode_r./totalnode_r)';
zero_ratio_nr=(zeronode_nr./totalnode_nr)';
clust1_ratio_r=(clust1_r./totalnode_r)';
clust2_ratio_r=(clust2_r./totalnode_r)';
clust3_ratio_r=(clust3_r./totalnode_r)';
clust1_ratio_nr=(clust1_nr./totalnode_nr)';
clust2_ratio_nr=(clust2_nr./totalnode_nr)';
clust3_ratio_nr=(clust3_nr./totalnode_nr)';


%clust1_resect_ratio=(clust1_r./(clust1_r+clust1_nr))
graphcolors{1}=[(143/255) (59/255) (27/255)];
graphcolors{2}=[(213/255) (117/255) (0/255)];
graphcolors{3}=[(219/255) (202/255) (105/255)];
group1=[1:10];
group2=[11:13 21];
group3=[14:20 22:23];
kw_groups=CODED;
kw_groups(find(kw_groups==3))=2;
kw_groups(find(kw_groups==4))=3;
figure
plot_box_scatter(zero_ratio_r,kw_groups,[1:3],graphcolors)
[p_vals(1,1),anovatab]=kruskalwallis(zero_ratio_r,kw_groups,'off');
[rho,p_vals1(1,1),rsq,Pfit] = spearman(zero_ratio_r,kw_groups')
title('zeronode resected ratio')
figure
plot_box_scatter(zero_ratio_nr,kw_groups,[1:3],graphcolors)
[p_vals(1,2),anovatab]=kruskalwallis(zero_ratio_nr,kw_groups,'off');
title('zeronode non-resected ratio')
figure
plot_box_scatter(clust1_ratio_r,kw_groups,[1:3],graphcolors)
[p_vals(2,1),anovatab]=kruskalwallis(clust1_ratio_r,kw_groups,'off');
[rho,p_vals2(1,2),rsq,Pfit] = spearman(clust1_ratio_r,kw_groups')
title('clust1 resected ratio')
figure
plot_box_scatter(clust2_ratio_r,kw_groups,[1:3],graphcolors)
[p_vals(3,1),anovatab]=kruskalwallis(clust2_ratio_r,kw_groups,'off');
title('clust2 resected ratio')
figure
plot_box_scatter(clust3_ratio_r,kw_groups,[1:3],graphcolors)
[p_vals(4,1),anovatab]=kruskalwallis(clust3_ratio_r,kw_groups,'off');
title('clust3 resected ratio')
figure
plot_box_scatter(clust1_ratio_nr,kw_groups,[1:3],graphcolors)
[p_vals(2,2),anovatab]=kruskalwallis(clust1_ratio_nr,kw_groups,'off');
[rho,p_vals1(1,3),rsq,Pfit] = spearman(clust1_ratio_nr,kw_groups')
title('clust1 unresected ratio')
figure
plot_box_scatter(clust2_ratio_nr,kw_groups,[1:3],graphcolors)
[p_vals(3,2),anovatab]=kruskalwallis(clust2_ratio_nr,kw_groups,'off');
title('clust2 unresected ratio')
figure
plot_box_scatter(clust3_ratio_nr,kw_groups,[1:3],graphcolors)
[p_vals(4,2),anovatab]=kruskalwallis(clust3_ratio_nr,kw_groups,'off');
title('clust3 unresected ratio')

idx=find(glmm_table2.e_l==0);
idx2=find(glmm_table2.szfree==0);
int=intersect(idx,idx2);
ratezero_free=glmm_table2.rate(int);
idx2=find(glmm_table2.szfree==1);
int=intersect(idx,idx2);
ratezero_notfree=glmm_table2.rate(int);
C=[0:0.02:0.2];
figure
[no,xo]=hist(ratezero_free,C)
bar(xo,no)
title('sz free zero LE rate hist')
figure
[no,xo]=hist(ratezero_notfree,C)
bar(xo,no)
title('non-sz free zero LE rate hist')

% p_z=[];
% z1=[1:13 21];
% z2=[14:20 22:23];
% A={''};
% A{1}=zero_ratio_r(z1);
% A{2}=zero_ratio_r(z2)
% figure
% daboxplot(A)
% title('resp zeronode resected ratio')
% A={''};
% A{1}=zero_ratio_nr(z1);
% A{2}=zero_ratio_nr(z2)
% figure
% daboxplot(A)
% title('resp zeronode resected ratio')
% A={''};
% A{1}=clust1_ratio_r(z1);
% A{2}=clust1_ratio_r(z2);
% figure
% daboxplot(A)
% [p_z(2,1), h, stats] = ranksum(clust1_ratio_r(z1),clust1_ratio_r(z2))
% title('resp clust1 resected ratio')
% A={''};
% A{1}=clust2_ratio_r(z1);
% A{2}=clust2_ratio_r(z2);
% figure
% daboxplot(A)
% title('resp clust2 resected ratio')
% A={''};
% A{1}=clust3_ratio_r(z1);
% A{2}=clust3_ratio_r(z2);
% figure
% daboxplot(A)
% title('resp clust3 resected ratio')
% A={''};
% A{1}=clust1_ratio_nr(z1);
% A{2}=clust1_ratio_nr(z2);
% figure
% daboxplot(A)
% title('resp clust1 unresected ratio')
% A={''};
% A{1}=clust2_ratio_nr(z1);
% A{2}=clust2_ratio_nr(z2);
% figure
% daboxplot(A)
% [p_z(2,2), h, stats] = ranksum(clust1_ratio_nr(z1),clust1_ratio_nr(z2))
% title('resp clust2 unresected ratio')
% A={''};
% A{1}=clust3_ratio_nr(z1);
% A{2}=clust3_ratio_nr(z2);
% figure
% daboxplot(A)
% title('resp clust3 unresected ratio')