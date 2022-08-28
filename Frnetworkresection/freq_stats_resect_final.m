[idx]=find(frono_table.patcoded_frono==1);
e1_frono_table=frono_table(idx,:);
glme = fitglme(e1_frono_table,'freq_frono ~ 1 + location_frono + resected_frono + (1|patients_frono)', ...
    'Distribution','Gaussian','Link','log','FitMethod','MPL', ...
    'DummyVarCoding','effects');
fprintf('all patients frono frequency');
disp(glme)

[idx]=find(frono_table.patcoded_frono==3);
e3_frono_table=frono_table(idx,:);
glme = fitglme(e3_frono_table,'freq_frono ~ 1 + location_frono + resected_frono + (1|patients_frono)', ...
    'Distribution','Gaussian','Link','log','FitMethod','MPL', ...
    'DummyVarCoding','effects');
fprintf('all patients frono frequency');
disp(glme);

[idx]=find(frono_table.patcoded_frono==4);
e4_frono_table=frono_table(idx,:);
glme = fitglme(e4_frono_table,'freq_frono ~ 1 + location_frono + resected_frono + (1|patients_frono)', ...
    'Distribution','Gaussian','Link','log','FitMethod','MPL', ...
    'DummyVarCoding','effects');
fprintf('all patients frono frequency');
disp(glme)