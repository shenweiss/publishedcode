analysistable=vertcat(table4110, table4145, table481, tableIO002, tableIO006, tableIO022);

glme = fitglme(analysistable,'offset ~ 1 + FR_sign + FR_power + FR_freqs + FR_duration + FR_sign:FR_power + (1|FR_pairnum)', ...
'Distribution','Gaussian','Link','log','FitMethod','MPL', ...
'DummyVarCoding','effects');
disp(glme)

figure
[idx,~]=find(analysistable.FR_sign==0);
scatter(analysistable.FR_power(idx),analysistable.offset(idx))
hold on
[idx,~]=find(analysistable.FR_sign==1);
scatter(analysistable.FR_power(idx),analysistable.offset(idx))
