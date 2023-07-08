
% final glmm
glme = fitglme(MDLdata,'hfodiff ~ 1 + power + preSPIKE + power:preSPIKE + (1|patient) + (1|electrode) + (1|unit)', ... % random effect is by location. No location needed. 
'Distribution','Gaussian','Link','log','FitMethod','MPL', ...
'DummyVarCoding','effects');

glme = fitglme(MDLdata,'bl ~ 1 + power + preSPIKE + power:preSPIKE + (1|patient) + (1|electrode) + (1|unit)', ... % random effect is by location. No location needed. 
'Distribution','Gaussian','Link','log','FitMethod','MPL', ...
'DummyVarCoding','effects');

% power dist calcs
[idx]=find(MDLdata.preSPIKE==0);
a=MDLdata.power(idx);
a=unique(a);
[idx]=find(MDLdata.preSPIKE==1);
b=MDLdata.power(idx);
b=unique(b);
[h,p,ci,stats] = ttest2(a,b)
d = computeCohen_d(b,a)

glme = fitglme(MDLdata,'bl ~ 1 + power + preFR + power:preFR + (1|patient) + (1|electrode) + (1|unit)', ... % random effect is by location. No location needed. 
'Distribution','Gaussian','Link','log','FitMethod','MPL', ...
'DummyVarCoding','effects');

glme = fitglme(MDLdata,'bl ~ 1 + power + preR + power:preR + (1|patient) + (1|electrode) + (1|unit)', ... % random effect is by location. No location needed. 
'Distribution','Gaussian','Link','log','FitMethod','MPL', ...
'DummyVarCoding','effects');

glme = fitglme(MDLdata,'hfodiff ~ 1 + power + preFR + power:preFR + (1|patient) + (1|electrode) + (1|unit)', ... % random effect is by location. No location needed. 
'Distribution','Gaussian','Link','log','FitMethod','MPL', ...
'DummyVarCoding','effects');

glme = fitglme(MDLdata,'hfodiff ~ 1 + power + preR + power:preR + (1|patient) + (1|electrode) + (1|unit)', ... % random effect is by location. No location needed. 
'Distribution','Gaussian','Link','log','FitMethod','MPL', ...
'DummyVarCoding','effects');

% power dist calcs
[idx]=find(MDLdata.preFR==0);
a=MDLdata.power(idx);
a=unique(a);
[idx]=find(MDLdata.preFR==1);
b=MDLdata.power(idx);
b=unique(b);
[h,p,ci,stats] = ttest2(a,b)
d = computeCohen_d(b,a)

[idx]=find(MDLdata.preR==0);
a=MDLdata.power(idx);
a=unique(a);
[idx]=find(MDLdata.preR==1);
b=MDLdata.power(idx);
b=unique(b);
[h,p,ci,stats] = ttest2(a,b)
d = computeCohen_d(b,a)