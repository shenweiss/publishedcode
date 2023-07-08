scatter3(unitparam(:,3),unitparam(:,4),unitparam(:,6))
X=[zscore(unitparam(:,3)) zscore(unitparam(:,4)) zscore(unitparam(:,6))];
[coeff, score, latent, tsquared, explained, mu] = pca(X)
scatter3(score(:,1),score(:,2),score(:,3))
idx = kmeans(score,2)
% [idx_1]=find(idx==1);
% [idx_2]=find(idx==2);
% unitparam(:,7)=idx;
[idx_1]=find(unitparam(:,7)==1);
[idx_2]=find(unitparam(:,7)==2);
figure
scatter3(unitparam(idx_1,3),unitparam(idx_1,4),unitparam(idx_1,6),'blue')
hold on
scatter3(unitparam(idx_2,3),unitparam(idx_2,4),unitparam(idx_2,6),'red')
