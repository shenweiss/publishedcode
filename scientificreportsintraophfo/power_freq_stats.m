rono_power=vertcat(io_rono_power, s_rono_power);
rono_condition=vertcat(zeros(numel(io_rono_power),1),ones(numel(s_rono_power),1));
rono_anesthesia=vertcat(io_rono_anesthesia, s_rono_anesthesia);
rono_soz=vertcat(io_rono_soz, s_rono_soz);
rono_electrode=vertcat(io_patient_rono, s_patient_rono);
rono_anesthesia(196475:196489)=[];
rono_electrode(196475:196489)=[];
rono_soz(196475:196489)=[];
T=table(rono_electrode, rono_condition, rono_anesthesia, rono_soz, rono_power);
glme = fitglme(T,'rono_power ~ 1 + rono_condition + rono_soz + (1|rono_electrode)', ...
    'Distribution','Gaussian','Link','log','FitMethod','Laplace', ...
    'DummyVarCoding','effects');

rono_freq=vertcat(io_rono_freq, s_rono_freq);
rono_condition=vertcat(zeros(numel(io_rono_freq),1),ones(numel(s_rono_freq),1));
rono_anesthesia=vertcat(io_rono_anesthesia, s_rono_anesthesia);
rono_soz=vertcat(io_rono_soz, s_rono_soz);
rono_electrode=vertcat(io_patient_rono, s_patient_rono);
T=table(rono_electrode, rono_condition, rono_anesthesia, rono_soz, rono_freq);
glme = fitglme(T,'rono_freq ~ 1 + rono_condition + rono_soz + (1|rono_electrode)', ...
    'Distribution','Gaussian','Link','log','FitMethod','Laplace', ...
    'DummyVarCoding','effects');

rons_power=vertcat(io_rons_power, s_rons_power);
rons_condition=vertcat(zeros(numel(io_rons_power),1),ones(numel(s_rons_power),1));
rons_anesthesia=vertcat(io_rons_anesthesia, s_rons_anesthesia);
rons_soz=vertcat(io_rons_soz, s_rons_soz);
rons_electrode=vertcat(io_patient_rons, s_patient_rons);
rons_electrode(31483:31514)=[];
rons_soz(31483:31514)=[];
T=table(rons_electrode, rons_condition, rons_soz, rons_power);
glme = fitglme(T,'rons_power ~ 1 + rons_condition + rons_soz + (1|rons_electrode)', ...
    'Distribution','Gaussian','Link','log','FitMethod','Laplace', ...
    'DummyVarCoding','effects');

rons_freq=vertcat(io_rons_freq, s_rons_freq);
rons_condition=vertcat(zeros(numel(io_rons_freq),1),ones(numel(s_rons_freq),1));
rons_anesthesia=vertcat(io_rons_anesthesia, s_rons_anesthesia);
rons_soz=vertcat(io_rons_soz, s_rons_soz);
rons_electrode=vertcat(io_patient_rons, s_patient_rons);
T=table(rons_electrode, rons_condition, rons_soz, rons_freq);
glme = fitglme(T,'rons_freq ~ 1 + rons_condition + rons_soz + (1|rons_electrode)', ...
    'Distribution','Gaussian','Link','log','FitMethod','Laplace', ...
    'DummyVarCoding','effects');

frono_power=vertcat(io_frono_power, s_frono_power);
frono_condition=vertcat(zeros(numel(io_frono_power),1),ones(numel(s_frono_power),1));
frono_soz=vertcat(io_frono_soz, s_frono_soz);
frono_electrode=vertcat(io_patient_frono, s_patient_frono);
frono_electrode(8420:8424)=[];
frono_soz(8420:8424)=[];
T=table(frono_electrode, frono_condition, frono_soz, frono_power);
glme = fitglme(T,'frono_power ~ 1 + frono_condition + frono_soz + (1|frono_electrode)', ...
    'Distribution','Gaussian','Link','log','FitMethod','Laplace', ...
    'DummyVarCoding','effects');

frono_freq=vertcat(io_frono_freq, s_frono_freq);
frono_condition=vertcat(zeros(numel(io_frono_freq),1),ones(numel(s_frono_freq),1));
frono_soz=vertcat(io_frono_soz, s_frono_soz);
frono_electrode=vertcat(io_patient_frono, s_patient_frono);
T=table(frono_electrode, frono_condition, frono_soz, frono_freq);
glme = fitglme(T,'frono_freq ~ 1 + frono_condition + frono_soz + (1|frono_electrode)', ...
    'Distribution','Gaussian','Link','log','FitMethod','Laplace', ...
    'DummyVarCoding','effects');

frons_power=vertcat(io_frons_power, s_frons_power);
frons_condition=vertcat(zeros(numel(io_frons_power),1),ones(numel(s_frons_power),1));
frons_soz=vertcat(io_frons_soz, s_frons_soz);
frons_electrode=vertcat(io_patient_frons, s_patient_frons);
frons_electrode(2607:2608)=[];
frons_soz(2607:2608)=[];
T=table(frons_electrode, frons_condition, frons_soz, frons_power);
glme = fitglme(T,'frons_power ~ 1 + frons_condition + frons_soz + (1|frons_electrode)', ...
    'Distribution','Gaussian','Link','log','FitMethod','MPL', ...
    'DummyVarCoding','effects');

frons_freq=vertcat(io_frons_freq, s_frons_freq);
frons_condition=vertcat(zeros(numel(io_frons_freq),1),ones(numel(s_frons_freq),1));
frons_soz=vertcat(io_frons_soz, s_frons_soz);
frons_electrode=vertcat(io_patient_frons, s_patient_frons);
T=table(frons_electrode, frons_condition, frons_soz, frons_freq);
glme = fitglme(T,'frons_freq ~ 1 + frons_condition + frons_soz + (1|frons_electrode)', ...
    'Distribution','Gaussian','Link','log','FitMethod','Laplace', ...
    'DummyVarCoding','effects');

[a,b]=find(s_rono_anesthesia==1);
s_a1_rono_power=s_rono_power(a);
[a,b]=find(s_rono_anesthesia==2);
s_a2_rono_power=s_rono_power(a(1:74575));
[a,b]=find(s_rono_anesthesia==4);
s_a4_rono_power=s_rono_power(a);;
[a,b]=find(io_rono_anesthesia==1);
io_a1_rono_power=io_rono_power(a);
[a,b]=find(io_rono_anesthesia==2);
io_a2_rono_power=io_rono_power(a(1:13400));
[a,b]=find(io_rono_anesthesia==4);
io_a4_rono_power=io_rono_power(a);

[a,b]=find(s_rono_anesthesia==1);
s_a1_rono_soz=s_rono_soz(a);
[a,b]=find(s_rono_anesthesia==2);
s_a2_rono_soz=s_rono_soz(a(1:74575));
[a,b]=find(s_rono_anesthesia==4);
s_a4_rono_soz=s_rono_soz(a);;
[a,b]=find(io_rono_anesthesia==1);
io_a1_rono_soz=io_rono_soz(a);
[a,b]=find(io_rono_anesthesia==2);
io_a2_rono_soz=io_rono_soz(a(1:13400));
[a,b]=find(io_rono_anesthesia==4);
io_a4_rono_soz=io_rono_soz(a);

[a,b]=find(s_rono_anesthesia==1);
s_a1_rono_electrode=s_patient_rono(a);
[a,b]=find(s_rono_anesthesia==2);
s_a2_rono_electrode=s_patient_rono(a(1:74575));
[a,b]=find(s_rono_anesthesia==4);
s_a4_rono_electrode=s_patient_rono(a);;
[a,b]=find(io_rono_anesthesia==1);
io_a1_rono_electrode=io_patient_rono(a);
[a,b]=find(io_rono_anesthesia==2);
io_a2_rono_electrode=io_patient_rono(a(1:13400));
[a,b]=find(io_rono_anesthesia==4);
io_a4_rono_electrode=io_patient_rono(a);

rono_power=(vertcat(io_a1_rono_power, s_a1_rono_power));
rono_condition=vertcat(zeros(numel(io_a1_rono_power),1),ones(numel(s_a1_rono_power),1));
rono_soz=vertcat(io_a1_rono_soz, s_a1_rono_soz);
rono_electrode=vertcat(io_a1_rono_electrode, s_a1_rono_electrode);
T=table(rono_electrode, rono_condition, rono_soz, rono_power);
glme = fitglme(T,'rono_power ~ 1 + rono_condition + rono_soz + (1|rono_electrode)', ...
    'Distribution','Gaussian','Link','log','FitMethod','Laplace', ...
    'DummyVarCoding','effects');

rono_power=(vertcat(io_a2_rono_power, s_a2_rono_power));
rono_condition=vertcat(zeros(numel(io_a2_rono_power),1),ones(numel(s_a2_rono_power),1));
rono_soz=vertcat(io_a2_rono_soz, s_a2_rono_soz);
rono_electrode=vertcat(io_a2_rono_electrode, s_a2_rono_electrode);
T=table(rono_electrode, rono_condition, rono_soz, rono_power);
glme = fitglme(T,'rono_power ~ 1 + rono_condition + rono_soz + (1|rono_electrode)', ...
    'Distribution','Gaussian','Link','log','FitMethod','Laplace', ...
    'DummyVarCoding','effects');

rono_power=(vertcat(io_a4_rono_power, s_a4_rono_power));
rono_condition=vertcat(zeros(numel(io_a4_rono_power),1),ones(numel(s_a4_rono_power),1));
rono_soz=vertcat(io_a4_rono_soz, s_a4_rono_soz);
rono_electrode=vertcat(io_a4_rono_electrode, s_a4_rono_electrode);
T=table(rono_electrode, rono_condition, rono_soz, rono_power);
glme = fitglme(T,'rono_power ~ 1 + rono_condition + rono_soz + (1|rono_electrode)', ...
    'Distribution','Gaussian','Link','log','FitMethod','Laplace', ...
    'DummyVarCoding','effects');