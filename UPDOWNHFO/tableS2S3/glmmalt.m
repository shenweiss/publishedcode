% final glmm
power_quantile=quantile(MDLdata.power,125);
[idx]=find(MDLdata.power<power_quantile(26));
MDLdata(idx,:)=[];

% [idx]=find(MDLdata.soz==1);
% sozMDLdata=MDLdata(idx,:);
% [idx]=find(MDLdata.soz==0);
% nsozMDLdata=MDLdata(idx,:);
% 
% glme = fitglme(nsozMDLdata,'hfo ~ 1 + bl + slowangle + bl:slowangle + (1|patient) + (1|electrode) + (1|unit)', ... % random effect is by location. No location needed. 
% 'Distribution','Gaussian','Link','log','FitMethod','MPL', ...
% 'DummyVarCoding','effects');
% 
% glme = fitglme(sozMDLdata,'hfo ~ 1 + bl + slowangle + bl:slowangle + (1|patient) + (1|electrode) + (1|unit)', ... % random effect is by location. No location needed. 
% 'Distribution','Gaussian','Link','log','FitMethod','MPL', ...
% 'DummyVarCoding','effects');

[idx]=find(MDLdata.slowangle<0);
MDLdata.slowangle(idx)=MDLdata.slowangle(idx)+2*pi();
[idx]=find(MDLdata.loc==2);
ehMDLdata=MDLdata;
ehMDLdata(idx,:)=[];
[idx]=find(ehMDLdata.soz==1);
ehsozMDLdata=ehMDLdata(idx,:);
[idx]=find(ehMDLdata.soz==0);
ehnsozMDLdata=ehMDLdata(idx,:);

glme = fitglme(ehnsozMDLdata,'hfo ~ 1 + bl + slowangle + bl:slowangle + (1|patient) + (1|electrode) + (1|unit)', ... % random effect is by location. No location needed. 
'Distribution','Gaussian','Link','identity','FitMethod','MPL', ...
'DummyVarCoding','effects');

glme = fitglme(ehsozMDLdata,'hfo ~ 1 + bl + slowangle + bl:slowangle + (1|patient) + (1|electrode) + (1|unit)', ... % random effect is by location. No location needed. 
'Distribution','Gaussian','Link','identity','FitMethod','MPL', ...
'DummyVarCoding','effects');