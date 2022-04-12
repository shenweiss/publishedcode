server='localhost';
username='admin';
password='';
dbname='deckard_new';
port=27017;
conn = mongo(server,port,dbname,'UserName',username,'Password',password);
collection = "HFOs";

IO04io={'LB1';'LB2';'LB3';'LB4';'LB5';'LB6';'LB7';'LB8';'LPT10';'LPT11';'LPT12';'LPT13';'LPT2';'LPT3';'LPT4';'LPT5';'LPT6';'LPT7';'LPT8';'LPT9'};
IO04={'POL Lb1';'POL Lb2';'POL Lb3';'POL Lb4';'POL Lb5';'POL Lb6';'POL Lb7';'POL Lb8';'POL LPT10';'POL LPT11';'POL LPT12';'POL LPT13';'POL LPT2';'POL LPT3';'POL LPT4';'POL LPT5';'POL LPT6';'POL LPT7';'POL LPT8';'POL LPT9'};
IO05io={'POL Ra3';'POL Ra4';'POL Ra5';'POL Ra6';'POL Ra7';'POL Rb1';'POL Rb2';'POL Rb3';'POL Rb4';'POL Rd1';'POL Rd10';'POL Rd11';'POL Rd2';'POL Rd3';'POL Rd4';'POL Rd5';'POL Rd6';'POL Rd7';'POL Rd8';'POL Rd9';'POL Re1';'POL Re4';'POL Re5';'POL Re7';'POL Re8';'POL Re9';'POL Ri15';'POL Ri2';'POL Ri3';'POL Ri4';'POL Ri5';'POL Ri6';'POL Ri7';'POL Ri8';'POL Rb5';'POL Re6';'POL Ri10';'POL Ri11';'POL Ri13';'POL Ri14';'POL Ri9';'POL Rpo1';'POL Rpo2'};
IO05={'POL Ra3';'POL Ra4';'POL Ra5';'POL Ra6';'POL Ra7';'POL Rb1';'POL Rb2';'POL Rb3';'POL Rb4';'POL Rd1';'POL Rd10';'POL Rd11';'POL Rd2';'POL Rd3';'POL Rd4';'POL Rd5';'POL Rd6';'POL Rd7';'POL Rd8';'POL Rd9';'POL Re1';'POL Re4';'POL Re5';'POL Re7';'POL Re8';'POL Re9';'POL Ri15';'POL Ri2';'POL Ri3';'POL Ri4';'POL Ri5';'POL Ri6';'POL Ri7';'POL Ri8';'POL Rb5';'POL Re6';'POL Ri10';'POL Ri11';'POL Ri13';'POL Ri14';'POL Ri9';'POL Rpo1';'POL Rpo2'};
IO06io={'POL LSMA1';'POL LSMA2';'POL LSMA3';'POL LSMA4';'POL LSMA5';'POL LSMA6';'POL LSMA7';'POL LSMP1';'POL LSMP2';'POL LSMP3';'POL LSMP4';'POL LSMP5';'POL LSMP6';'POL LSMP7';'POL LSMP8';'POL LSMP9';'POL RC1';'POL RC10';'POL RC11';'POL RC2';'POL RC3';'POL RC4';'POL RC5';'POL RC6';'POL RMFC1';'POL RMFC3';'POL RMFC8';'POL RMFC9';'POL RMH1';'POL RMH2';'POL RMH3';'POL RMH4';'POL RMH5';'POL RMH6';'POL RMH7';'POL RML1';'POL RML2';'POL RML3';'POL RML4';'POL RML5';'POL RML6';'POL RML7';'POL RSPM1';'POL RSPM3';'POL RSPM4';'POL RSPM5';'POL RSPM6';'POL RSPM7';'POL RMFC2';'POL RMFC4';'POL RMFC5';'POL RMFC7';'POL RSPM2'};
IO06={'POL LSMA1';'POL LSMA2';'POL LSMA3';'POL LSMA4';'POL LSMA5';'POL LSMA6';'POL LSMA7';'POL LSMP1';'POL LSMP2';'POL LSMP3';'POL LSMP4';'POL LSMP5';'POL LSMP6';'POL LSMP7';'POL LSMP8';'POL LSMP9';'POL RC1';'POL RC10';'POL RC11';'POL RC2';'POL RC3';'POL RC4';'POL RC5';'POL RC6';'POL RMFC1';'POL RMFC3';'POL RMFC8';'POL RMFC9';'POL RMH1';'POL RMH2';'POL RMH3';'POL RMH4';'POL RMH5';'POL RMH6';'POL RMH7';'POL RML1';'POL RML2';'POL RML3';'POL RML4';'POL RML5';'POL RML6';'POL RML7';'POL RSPM1';'POL RSPM3';'POL RSPM4';'POL RSPM5';'POL RSPM6';'POL RSPM7';'POL RMFC2';'POL RMFC4';'POL RMFC5';'POL RMFC7';'POL RSPM2'};
IO08io={'POL LA1';'POL LA10';'POL LA11';'POL LA2';'POL LA3';'POL LA4';'POL LA7';'POL LA8';'POL LA9';'POL LC10';'POL LC11';'POL LC12';'POL LC2';'POL LC3';'POL LC4';'POL LC5';'POL LC6';'POL LC8';'POL LC9';'POL LE2';'POL LE3';'POL LE4';'POL LE5';'POL LE6';'POL LE7';'POL LE8';'POL LE9';'POL RA1';'POL RA13';'POL RA4';'POL RA5';'POL RC1';'POL RC10';'POL RC11';'POL RC2';'POL RC3';'POL RC4';'POL RC5';'POL RC6';'POL RC7';'POL RC8';'POL RC9';'POL LC7';'POL RA10';'POL RA11';'POL RA12';'POL RA8';'POL RA9'};
IO08={'POL LA1';'POL LA10';'POL LA11';'POL LA2';'POL LA3';'POL LA4';'POL LA7';'POL LA8';'POL LA9';'POL LC10';'POL LC11';'POL LC12';'POL LC2';'POL LC3';'POL LC4';'POL LC5';'POL LC6';'POL LC8';'POL LC9';'POL LE2';'POL LE3';'POL LE4';'POL LE5';'POL LE6';'POL LE7';'POL LE8';'POL LE9';'POL RA1';'POL RA13';'POL RA4';'POL RA5';'POL RC1';'POL RC10';'POL RC11';'POL RC2';'POL RC3';'POL RC4';'POL RC5';'POL RC6';'POL RC7';'POL RC8';'POL RC9';'POL LC7';'POL RA10';'POL RA11';'POL RA12';'POL RA8';'POL RA9'};
IO09io={'POL Rd1';'POL Rd10';'POL Rd11';'POL Rd2';'POL Rd3';'POL Rd4';'POL Rd8';'POL Rd9';'POL RifF10';'POL RifF11';'POL RifF12';'POL RifF13';'POL RifF14';'POL RifF15';'POL RifF2';'POL LBrf1';'POL LBrf10';'POL LBrf11';'POL LBrf2';'POL LBrf3';'POL LBrf4';'POL LBrf5';'POL LBrf6';'POL LBrf9';'POL Rd5';'POL Rd6';'POL Rd7';'POL RifF3';'POL RifF4';'POL RifF5';'POL RifF6';'POL RifF7';'POL RifF8';'POL RifF9'};
IO09={'POL RD1';'POL RD10';'POL RD11';'POL RD2';'POL RD3';'POL RD4';'POL RD8';'POL RD9';'POL RIFF10';'POL RIFF11';'POL RIFF12';'POL RIFF13';'POL RIFF14';'POL RIFF15';'POL RIFF2';'POL LBRF1';'POL LBRF10';'POL LBRF11';'POL LBRF2';'POL LBRF3';'POL LBRF4';'POL LBRF5';'POL LBRF6';'POL LBRF9';'POL RD5';'POL RD6';'POL RD7';'POL RIFF3';'POL RIFF4';'POL RIFF5';'POL RIFF6';'POL RIFF7';'POL RIFF8';'POL RIFF9'};
IO10io={'POL RB4';'POL ROF1';'POL ROF10';'POL ROF11';'POL ROF12';'POL ROF14';'POL ROF2';'POL ROF3';'POL ROF4';'POL ROF5';'POL ROF6';'POL ROF7';'POL ROF8';'POL ROF9';'POL RB1';'POL RB3';'POL RB5';'POL RB6';'POL ROF13'};
IO10={'POL RB4';'POL ROF1';'POL ROF10';'POL ROF11';'POL ROF12';'POL ROF14';'POL ROF2';'POL ROF3';'POL ROF4';'POL ROF5';'POL ROF6';'POL ROF7';'POL ROF8';'POL ROF9';'POL RB1';'POL RB3';'POL RB5';'POL RB6';'POL ROF13'};
IO12io={'POL Lb1';'POL Lb6';'POL Lb7';'POL Rb1';'POL Rb5';'POL Lb10';'POL Lb3';'POL Lb5';'POL Lb8';'POL Lb9';'POL Rb10';'POL Rb11';'POL Rb12';'POL Rb13';'POL Rb14';'POL Rb6';'POL Rb7';'POL Rb8';'POL Rb9';'POL RoF10';'POL RoF11';'POL RoF12';'POL RoF3';'POL RoF4';'POL RoF5';'POL RoF6';'POL RoF7';'POL RoF9'};
IO12={'POL Lb1';'POL Lb6';'POL Lb7';'POL Rb1';'POL Rb5';'POL Lb10';'POL Lb3';'POL Lb5';'POL Lb8';'POL Lb9';'POL Rb10';'POL Rb11';'POL Rb12';'POL Rb13';'POL Rb14';'POL Rb6';'POL Rb7';'POL Rb8';'POL Rb9';'POL Rofc10';'POL Rofc11';'POL Rofc12';'POL Rofc3';'POL Rofc4';'POL Rofc5';'POL Rofc6';'POL Rofc7';'POL Rofc9'};
IO13io={'POL LAC10';'POL LAC11';'POL LAC12';'POL LAC13';'POL LAC14';'POL LAC15';'POL LAC5';'POL LAC6';'POL LAC7';'POL LAC8';'POL LAC9';'POL LB4';'POL LB5';'POL LPMC1';'POL LPMC11';'POL LPMC12';'POL LPMC13';'POL LPMC14';'POL LPMC15';'POL LPMC2';'POL LPMC7';'POL LAC2';'POL LPMC10';'POL LPMC3';'POL LPMC4';'POL LPMC5';'POL LPMC6';'POL LPMC8';'POL LPMC9'};
IO13={'POL LAC10';'POL LAC11';'POL LAC12';'POL LAC13';'POL LAC14';'POL LAC15';'POL LAC5';'POL LAC6';'POL LAC7';'POL LAC8';'POL LAC9';'POL LB4';'POL LB5';'POL LPMC1';'POL LPMC11';'POL LPMC12';'POL LPMC13';'POL LPMC14';'POL LPMC15';'POL LPMC2';'POL LPMC7';'POL LAC2';'POL LPMC10';'POL LPMC3';'POL LPMC4';'POL LPMC5';'POL LPMC6';'POL LPMC8';'POL LPMC9'};
IO15io={'POL LA1';'POL LA2';'POL LA4';'POL LB3';'POL LB4';'POL LB5';'POL LB6';'POL LB7';'POL LB8';'POL LA10';'POL LA11';'POL LA12';'POL LA13';'POL LA3';'POL LA5';'POL LA6';'POL LA7';'POL LA8';'POL LA9';'POL LB1'};
IO15={'POL LA1';'POL LA2';'POL LA4';'POL LB3';'POL LB4';'POL LB5';'POL LB6';'POL LB7';'POL LB8';'POL LA10';'POL LA11';'POL LA12';'POL LA13';'POL LA3';'POL LA5';'POL LA6';'POL LA7';'POL LA8';'POL LA9';'POL LB1'};
IO17io={'POL Rimc1';'POL Rsoc1';'POL Rsoc2';'POL Rsoc6';'POL Rsoc7';'POL Rsci1';'POL Rsoc10';'POL Rsoc11';'POL Rsci2';'POL Rsoc12';'POL Rsci7';'POL Rsci8';'POL Rst21';'POL Rst22';'POL Rst23';'POL Rst24';'POL Rstc1';'POL Rstg1';'POL Rstg2';'POL Rsoc3';'POL Rsci4';'POL Rsci9';'POL Rsoc4';'POL Rsoc5';'POL Rstc5';'POL Rstc2';'POL Rstc3';'POL Rstc6';'POL Rstc7';'POL Rstg3';'POL Rstg4';'POL Rstg5'};
IO17={'POL RIMC1';'POL RSOCm1';'POL RSOCm2';'POL RSOCm6';'POL RSOCm7';'POL RSOCo1';'POL RSOCo10';'POL RSOCo11';'POL RSOCo2';'POL RSOCo3';'POL RSOCo7';'POL RSOCo8';'POL RSTC2-1';'POL RSTC2-2';'POL RSTC2-3';'POL RSTC2-4';'POL RSTC1';'POL RSTG1';'POL RSTG2';'POL RSOCi3';'POL RSOCi4';'POL RSOCi9';'POL RSOCm4';'POL RSOCm5';'POL RSTC2-5';'POL RSTC2';'POL RSTC3';'POL RSTC6';'POL RSTC7';'POL RSTG3';'POL RSTG4';'POL RSTG5'};
IO18io={'POL RFI11';'POL RFI12';'POL RFI13';'POL RFI14';'POL ROFC1';'POL ROFC10';'POL ROFC11';'POL ROFC12';'POL ROFC13';'POL ROFC14';'POL ROFC2';'POL ROFC4';'POL ROFC6';'POL ROFC7';'POL ROFC8';'POL ROFC9';'POL RPMI5';'POL RPMI6';'POL RPMI7';'POL RPMI8';'POL RPMI9';'POL RPMM1';'POL RPMM10';'POL RPMM11';'POL RPMM12';'POL RPMM2';'POL RPMM3';'POL RPMM6';'POL RPMM7';'POL RPMM8';'POL RPMM9';'POL RFI10';'POL RFI7';'POL RFI8';'POL RFI9';'POL RFO7';'POL RFO8';'POL ROFC3';'POL ROFC5';'POL RPMM4';'POL RPMM5'};
IO18={'POL RFI11';'POL RFI12';'POL RFI13';'POL RFI14';'POL ROFC1';'POL ROFC10';'POL ROFC11';'POL ROFC12';'POL ROFC13';'POL ROFC14';'POL ROFC2';'POL ROFC4';'POL ROFC6';'POL ROFC7';'POL ROFC8';'POL ROFC9';'POL RPMI5';'POL RPMI6';'POL RPMI7';'POL RPMI8';'POL RPMI9';'POL RPMM1';'POL RPMM10';'POL RPMM11';'POL RPMM12';'POL RPMM2';'POL RPMM3';'POL RPMM6';'POL RPMM7';'POL RPMM8';'POL RPMM9';'POL RFI10';'POL RFI7';'POL RFI8';'POL RFI9';'POL RFO7';'POL RFO8';'POL ROFC3';'POL ROFC5';'POL RPMM4';'POL RPMM5'};
IO21io={'POL 2H10';'POL 2H11';'POL 2H12';'POL 2H13';'POL 2H14';'POL 2H15';'POL 2H7';'POL 2H8';'POL 2H9';'POL 2OFC12';'POL 2OFC13';'POL 2OFC14';'POL 2OFC15';'POL 2OFC16';'POL 2OFC6';'POL H1';'POL H10';'POL H11';'POL H12';'POL H13';'POL H14';'POL H2';'POL H3';'POL H9';'POL ITG1';'POL ITG2';'POL ITG3';'POL ITG4';'POL ITG5';'POL ITG6';'POL 2OFC10';'POL 2OFC11';'POL 2OFC2';'POL 2OFC3';'POL 2OFC4';'POL 2OFC5';'POL 2OFC9';'POL H4';'POL H5'};
IO21={'POL 2H10';'POL 2H11';'POL 2H12';'POL 2H13';'POL 2H14';'POL 2H15';'POL 2H7';'POL 2H8';'POL 2H9';'POL 2OFC12';'POL 2OFC13';'POL 2OFC14';'POL 2OFC15';'POL 2OFC16';'POL 2OFC6';'POL H1';'POL H10';'POL H11';'POL H12';'POL H13';'POL H14';'POL H2';'POL H3';'POL H9';'POL ITG1';'POL ITG2';'POL ITG3';'POL ITG4';'POL ITG5';'POL ITG6';'POL 2OFC10';'POL 2OFC11';'POL 2OFC2';'POL 2OFC3';'POL 2OFC4';'POL 2OFC5';'POL 2OFC9';'POL H4';'POL H5'};
IO22io={'POL LG1';'POL LM1';'POL LM3';'POL LM4';'POL LM5';'POL LM6';'POL LM7';'POL LM8';'POL LM9';'POL LPm1';'POL LPm10';'POL LPm11';'POL LPm12';'POL LPm4';'POL LPm5';'POL LPm6';'POL LPm7';'POL LPm8';'POL LPm9';'POL LSMA1';'POL LSMA11';'POL LSMA12';'POL LSMA13';'POL LSMA14';'POL LSMA15';'POL LSMA8';'POL LG2';'POL LG6';'POL LG7';'POL LG8';'POL LM2';'POL LPm2';'POL LPm3';'POL LSMA4';'POL LSMA5';'POL LSMA6'};
IO22={'POL LG1';'POL LM1';'POL LM3';'POL LM4';'POL LM5';'POL LM6';'POL LM7';'POL LM8';'POL LM9';'POL LPm1';'POL LPm10';'POL LPm11';'POL LPm12';'POL LPm4';'POL LPm5';'POL LPm6';'POL LPm7';'POL LPm8';'POL LPm9';'POL LSMA1';'POL LSMA11';'POL LSMA12';'POL LSMA13';'POL LSMA14';'POL LSMA15';'POL LSMA8';'POL LG2';'POL LG6';'POL LG7';'POL LG8';'POL LM2';'POL LPm2';'POL LPm3';'POL LSMA4';'POL LSMA5';'POL LSMA6'};
IO25io={'LC1';'LC2';'LC3';'LC4';'LC5';'LC6';'LC7';'LC8';'RB21';'RB210';'RB211';'RB22';'RB23';'RB24';'RB25';'RB26';'RB27';'RC1';'RC2';'RC3';'RC4';'RC5';'RC6';'RPAR1';'RPAR2';'RPAR3';'RPAR4';'RPAR5';'RPAR6';'RPAR7';'RSEN1';'RSEN2';'RSEN3';'RSEN4';'LC10';'LC11';'LC12';'LC9';'RC7';'RC8';'RSEN5';'RSEN6'};
IO25={'POL LC1';'POL LC2';'POL LC3';'POL LC4';'POL LC5';'POL LC6';'POL LC7';'POL LC8';'POL RB1';'POL RB10';'POL RB11';'POL RB2';'POL RB3';'POL RB4';'POL RB5';'POL RB6';'POL RB7';'POL RC1';'POL RC2';'POL RC3';'POL RC4';'POL RC5';'POL RC6';'POL Rpar1';'POL Rpar2';'POL Rpar3';'POL Rpar4';'POL Rpar5';'POL Rpar6';'POL Rpar7';'POL Rsen1';'POL Rsen2';'POL Rsen3';'POL Rsen4';'POL LC10';'POL LC11';'POL LC12';'POL LC9';'POL RC7';'POL RC8';'POL Rsen5';'POL Rsen6'};

io_rono_soz=[];
io_rons_soz=[];
io_frono_soz=[];
io_frons_soz=[];

s_rono_soz=[];
s_rons_soz=[];
s_frono_soz=[];
s_frons_soz=[];

io_rono_anesthesia=[];
io_rons_anesthesia=[];
io_frono_anesthesia=[];
io_frons_anesthesia=[];

s_rono_anesthesia=[];
s_rons_anesthesia=[];
s_frono_anesthesia=[];
s_frons_anesthesia=[];

io_rono_power=[];
io_rons_power=[];
io_frono_power=[];
io_frons_power=[];

s_rono_power=[];
s_rons_power=[];
s_frono_power=[];
s_frons_power=[];

io_rono_freq=[];
io_rons_freq=[];
io_frono_freq=[];
io_frons_freq=[];

s_rono_freq=[];
s_rons_freq=[];
s_frono_freq=[];
s_frons_freq=[];

io_patient_rono=[];
io_patient_rons=[];
io_patient_frono=[];
io_patient_frons=[];

s_patient_rono=[];
s_patient_rons=[];
s_patient_frono=[];
s_patient_frons=[];

%IO04

for i=1:numel(IO04io);
patients={'IO004'};
test_query=['{"patient_id":"' patients{1} '","electrode":"' IO04{i} '","type":"' num2str(1) '"}'];
soz = cell2mat(distinct(conn,collection,"soz",'query',test_query))';
if ~isnumeric(soz)
    soz=str2num(soz);
end;

patients={'IO004io'};
test_query=['{"patient_id":"' patients{1} '","electrode":"' IO04io{i} '","type":"' num2str(1) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
io_rono_power=vertcat(io_rono_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
io_rono_freq=vertcat(io_rono_freq, temp);
if soz == 0
    io_rono_soz=vertcat(io_rono_soz, zeros(numel(temp),1));
else
    io_rono_soz=vertcat(io_rono_soz, ones(numel(temp),1));
end;
io_rono_anesthesia=vertcat(io_rono_anesthesia, ones(numel(temp),1)*2);
io_patient_rono=vertcat(io_patient_rono, ones(numel(temp),1));

test_query=['{"patient_id":"' patients{1} '","electrode":"' IO04io{i} '","type":"' num2str(2) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
io_rons_power=vertcat(io_rons_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
io_rons_freq=vertcat(io_rons_freq, temp);
if soz == 0
    io_rons_soz=vertcat(io_rons_soz, zeros(numel(temp),1));
else
    io_rons_soz=vertcat(io_rons_soz, ones(numel(temp),1));
end;
io_rons_anesthesia=vertcat(io_rons_anesthesia, ones(numel(temp),1)*2);
io_patient_rons=vertcat(io_patient_rons, ones(numel(temp),1));

test_query=['{"patient_id":"' patients{1} '","electrode":"' IO04io{i} '","type":"' num2str(4) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
io_frono_power=vertcat(io_frono_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
io_frono_freq=vertcat(io_frono_freq, temp);
if soz == 0
    io_frono_soz=vertcat(io_frono_soz, zeros(numel(temp),1));
else
    io_frono_soz=vertcat(io_frono_soz, ones(numel(temp),1));
end;
io_frono_anesthesia=vertcat(io_frono_anesthesia, ones(numel(temp),1)*2);
io_patient_frono=vertcat(io_patient_frono, ones(numel(temp),1));

test_query=['{"patient_id":"' patients{1} '","electrode":"' IO04io{i} '","type":"' num2str(5) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
io_frons_power=vertcat(io_frons_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
io_frons_freq=vertcat(io_frons_freq, temp);
if soz == 0
    io_frons_soz=vertcat(io_frons_soz, zeros(numel(temp),1));
else
    io_frons_soz=vertcat(io_frons_soz, ones(numel(temp),1));
end;
io_frons_anesthesia=vertcat(io_frons_anesthesia, ones(numel(temp),1)*2);
io_patient_frons=vertcat(io_patient_frons, ones(numel(temp),1));
end;

for i=1:numel(IO04);
patients={'IO004'};
test_query=['{"patient_id":"' patients{1} '","electrode":"' IO04{i} '","type":"' num2str(1) '"}'];
soz = cell2mat(distinct(conn,collection,"soz",'query',test_query))';
if ~isnumeric(soz)
    soz=str2num(soz);
end;

patients={'IO004'};
test_query=['{"patient_id":"' patients{1} '","electrode":"' IO04{i} '","type":"' num2str(1) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
s_rono_power=vertcat(s_rono_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
s_rono_freq=vertcat(s_rono_freq, temp);
if soz == 0
    s_rono_soz=vertcat(s_rono_soz, zeros(numel(temp),1));
else
    s_rono_soz=vertcat(s_rono_soz, ones(numel(temp),1));
end;
s_rono_anesthesia=vertcat(s_rono_anesthesia, ones(numel(temp),1)*2);
s_patient_rono=vertcat(s_patient_rono, ones(numel(temp),1));

test_query=['{"patient_id":"' patients{1} '","electrode":"' IO04{i} '","type":"' num2str(2) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
s_rons_power=vertcat(s_rons_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
s_rons_freq=vertcat(s_rons_freq, temp);
if soz == 0
    s_rons_soz=vertcat(s_rons_soz, zeros(numel(temp),1));
else
    s_rons_soz=vertcat(s_rons_soz, ones(numel(temp),1));
end;
s_rons_anesthesia=vertcat(s_rons_anesthesia, ones(numel(temp),1)*2);
s_patient_rons=vertcat(s_patient_rons, ones(numel(temp),1));

test_query=['{"patient_id":"' patients{1} '","electrode":"' IO04{i} '","type":"' num2str(4) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
s_frono_power=vertcat(s_frono_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
s_frono_freq=vertcat(s_frono_freq, temp);
if soz == 0
    s_frono_soz=vertcat(s_frono_soz, zeros(numel(temp),1));
else
    s_frono_soz=vertcat(s_frono_soz, ones(numel(temp),1));
end;
s_frono_anesthesia=vertcat(s_frono_anesthesia, ones(numel(temp),1)*2);
s_patient_frono=vertcat(s_patient_frono, ones(numel(temp),1));

test_query=['{"patient_id":"' patients{1} '","electrode":"' IO04{i} '","type":"' num2str(5) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
s_frons_power=vertcat(s_frons_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
s_frons_freq=vertcat(s_frons_freq, temp);
if soz == 0
    s_frons_soz=vertcat(s_frons_soz, zeros(numel(temp),1));
else
    s_frons_soz=vertcat(s_frons_soz, ones(numel(temp),1));
end;
s_frons_anesthesia=vertcat(s_frons_anesthesia, ones(numel(temp),1)*2);
s_patient_frons=vertcat(s_patient_frons, ones(numel(temp),1));
end;

%IO05

for i=1:numel(IO05io);
patients={'IO005'};
test_query=['{"patient_id":"' patients{1} '","electrode":"' IO05{i} '","type":"' num2str(1) '"}'];
soz = cell2mat(distinct(conn,collection,"soz",'query',test_query))';
if ~isnumeric(soz)
    soz=str2num(soz);
end;

patients={'IO005io'};
test_query=['{"patient_id":"' patients{1} '","electrode":"' IO05io{i} '","type":"' num2str(1) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
io_rono_power=vertcat(io_rono_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
io_rono_freq=vertcat(io_rono_freq, temp);
if soz == 0
    io_rono_soz=vertcat(io_rono_soz, zeros(numel(temp),1));
else
    io_rono_soz=vertcat(io_rono_soz, ones(numel(temp),1));
end;
io_rono_anesthesia=vertcat(io_rono_anesthesia, ones(numel(temp),1));
io_patient_rono=vertcat(io_patient_rono, ones(numel(temp),1)*2);

test_query=['{"patient_id":"' patients{1} '","electrode":"' IO05io{i} '","type":"' num2str(2) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
io_rons_power=vertcat(io_rons_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
io_rons_freq=vertcat(io_rons_freq, temp);
if soz == 0
    io_rons_soz=vertcat(io_rons_soz, zeros(numel(temp),1));
else
    io_rons_soz=vertcat(io_rons_soz, ones(numel(temp),1));
end;
io_rons_anesthesia=vertcat(io_rons_anesthesia, ones(numel(temp),1));
io_patient_rons=vertcat(io_patient_rons, ones(numel(temp),1)*2);

test_query=['{"patient_id":"' patients{1} '","electrode":"' IO05io{i} '","type":"' num2str(4) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
io_frono_power=vertcat(io_frono_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
io_frono_freq=vertcat(io_frono_freq, temp);
if soz == 0
    io_frono_soz=vertcat(io_frono_soz, zeros(numel(temp),1));
else
    io_frono_soz=vertcat(io_frono_soz, ones(numel(temp),1));
end;
io_frono_anesthesia=vertcat(io_frono_anesthesia, ones(numel(temp),1));
io_patient_frono=vertcat(io_patient_frono, ones(numel(temp),1)*2);

test_query=['{"patient_id":"' patients{1} '","electrode":"' IO05io{i} '","type":"' num2str(5) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
io_frons_power=vertcat(io_frons_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
io_frons_freq=vertcat(io_frons_freq, temp);
if soz == 0
    io_frons_soz=vertcat(io_frons_soz, zeros(numel(temp),1));
else
    io_frons_soz=vertcat(io_frons_soz, ones(numel(temp),1));
end;
io_frons_anesthesia=vertcat(io_frons_anesthesia, ones(numel(temp),1));
io_patient_frons=vertcat(io_patient_frons, ones(numel(temp),1)*2);
end;

for i=1:numel(IO05);
patients={'IO005'};
test_query=['{"patient_id":"' patients{1} '","electrode":"' IO05{i} '","type":"' num2str(1) '"}'];
soz = cell2mat(distinct(conn,collection,"soz",'query',test_query))';
if ~isnumeric(soz)
    soz=str2num(soz);
end;

patients={'IO005'};
test_query=['{"patient_id":"' patients{1} '","electrode":"' IO05{i} '","type":"' num2str(1) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
s_rono_power=vertcat(s_rono_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
s_rono_freq=vertcat(s_rono_freq, temp);
if soz == 0
    s_rono_soz=vertcat(s_rono_soz, zeros(numel(temp),1));
else
    s_rono_soz=vertcat(s_rono_soz, ones(numel(temp),1));
end;
s_rono_anesthesia=vertcat(s_rono_anesthesia, ones(numel(temp),1));
s_patient_rono=vertcat(s_patient_rono, ones(numel(temp),1)*2);

test_query=['{"patient_id":"' patients{1} '","electrode":"' IO05{i} '","type":"' num2str(2) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
s_rons_power=vertcat(s_rons_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
s_rons_freq=vertcat(s_rons_freq, temp);
if soz == 0
    s_rons_soz=vertcat(s_rons_soz, zeros(numel(temp),1));
else
    s_rons_soz=vertcat(s_rons_soz, ones(numel(temp),1));
end;
s_rons_anesthesia=vertcat(s_rons_anesthesia, ones(numel(temp),1));
s_patient_rons=vertcat(s_patient_rons, ones(numel(temp),1)*2);

test_query=['{"patient_id":"' patients{1} '","electrode":"' IO05{i} '","type":"' num2str(4) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
s_frono_power=vertcat(s_frono_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
s_frono_freq=vertcat(s_frono_freq, temp);
if soz == 0
    s_frono_soz=vertcat(s_frono_soz, zeros(numel(temp),1));
else
    s_frono_soz=vertcat(s_frono_soz, ones(numel(temp),1));
end;
s_frono_anesthesia=vertcat(s_frono_anesthesia, ones(numel(temp),1));
s_patient_frono=vertcat(s_patient_frono, ones(numel(temp),1)*2);

test_query=['{"patient_id":"' patients{1} '","electrode":"' IO05{i} '","type":"' num2str(5) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
s_frons_power=vertcat(s_frons_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
s_frons_freq=vertcat(s_frons_freq, temp);
if soz == 0
    s_frons_soz=vertcat(s_frons_soz, zeros(numel(temp),1));
else
    s_frons_soz=vertcat(s_frons_soz, ones(numel(temp),1));
end;
s_frons_anesthesia=vertcat(s_frons_anesthesia, ones(numel(temp),1));
s_patient_frons=vertcat(s_patient_frons, ones(numel(temp),1)*2);
end;

%IO06

for i=1:numel(IO06io);
patients={'IO006'};
test_query=['{"patient_id":"' patients{1} '","electrode":"' IO06{i} '","type":"' num2str(1) '"}'];
soz = cell2mat(distinct(conn,collection,"soz",'query',test_query))';
if ~isnumeric(soz)
    soz=str2num(soz);
end;

patients={'IO006io'};
test_query=['{"patient_id":"' patients{1} '","electrode":"' IO06io{i} '","type":"' num2str(1) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
io_rono_power=vertcat(io_rono_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
io_rono_freq=vertcat(io_rono_freq, temp);
if soz == 0
    io_rono_soz=vertcat(io_rono_soz, zeros(numel(temp),1));
else
    io_rono_soz=vertcat(io_rono_soz, ones(numel(temp),1));
end;
io_rono_anesthesia=vertcat(io_rono_anesthesia, ones(numel(temp),1));
io_patient_rono=vertcat(io_patient_rono, ones(numel(temp),1)*3);

test_query=['{"patient_id":"' patients{1} '","electrode":"' IO06io{i} '","type":"' num2str(2) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
io_rons_power=vertcat(io_rons_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
io_rons_freq=vertcat(io_rons_freq, temp);
if soz == 0
    io_rons_soz=vertcat(io_rons_soz, zeros(numel(temp),1));
else
    io_rons_soz=vertcat(io_rons_soz, ones(numel(temp),1));
end;
io_rons_anesthesia=vertcat(io_rons_anesthesia, ones(numel(temp),1));
io_patient_rons=vertcat(io_patient_rons, ones(numel(temp),1)*3);

test_query=['{"patient_id":"' patients{1} '","electrode":"' IO06io{i} '","type":"' num2str(4) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
io_frono_power=vertcat(io_frono_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
io_frono_freq=vertcat(io_frono_freq, temp);
if soz == 0
    io_frono_soz=vertcat(io_frono_soz, zeros(numel(temp),1));
else
    io_frono_soz=vertcat(io_frono_soz, ones(numel(temp),1));
end;
io_frono_anesthesia=vertcat(io_frono_anesthesia, ones(numel(temp),1));
io_patient_frono=vertcat(io_patient_frono, ones(numel(temp),1)*3);

test_query=['{"patient_id":"' patients{1} '","electrode":"' IO06io{i} '","type":"' num2str(5) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
io_frons_power=vertcat(io_frons_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
io_frons_freq=vertcat(io_frons_freq, temp);
if soz == 0
    io_frons_soz=vertcat(io_frons_soz, zeros(numel(temp),1));
else
    io_frons_soz=vertcat(io_frons_soz, ones(numel(temp),1));
end;
io_frons_anesthesia=vertcat(io_frons_anesthesia, ones(numel(temp),1));
io_patient_frons=vertcat(io_patient_frons, ones(numel(temp),1)*3);
end;

for i=1:numel(IO06);
patients={'IO006'};
test_query=['{"patient_id":"' patients{1} '","electrode":"' IO06{i} '","type":"' num2str(1) '"}'];
soz = cell2mat(distinct(conn,collection,"soz",'query',test_query))';
if ~isnumeric(soz)
    soz=str2num(soz);
end;

patients={'IO006'};
test_query=['{"patient_id":"' patients{1} '","electrode":"' IO06{i} '","type":"' num2str(1) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
s_rono_power=vertcat(s_rono_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
s_rono_freq=vertcat(s_rono_freq, temp);
if soz == 0
    s_rono_soz=vertcat(s_rono_soz, zeros(numel(temp),1));
else
    s_rono_soz=vertcat(s_rono_soz, ones(numel(temp),1));
end;
s_rono_anesthesia=vertcat(s_rono_anesthesia, ones(numel(temp),1));
s_patient_rono=vertcat(s_patient_rono, ones(numel(temp),1)*3);

test_query=['{"patient_id":"' patients{1} '","electrode":"' IO06{i} '","type":"' num2str(2) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
s_rons_power=vertcat(s_rons_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
s_rons_freq=vertcat(s_rons_freq, temp);
if soz == 0
    s_rons_soz=vertcat(s_rons_soz, zeros(numel(temp),1));
else
    s_rons_soz=vertcat(s_rons_soz, ones(numel(temp),1));
end;
s_rons_anesthesia=vertcat(s_rons_anesthesia, ones(numel(temp),1));
s_patient_rons=vertcat(s_patient_rons, ones(numel(temp),1)*3);

test_query=['{"patient_id":"' patients{1} '","electrode":"' IO06{i} '","type":"' num2str(4) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
s_frono_power=vertcat(s_frono_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
s_frono_freq=vertcat(s_frono_freq, temp);
if soz == 0
    s_frono_soz=vertcat(s_frono_soz, zeros(numel(temp),1));
else
    s_frono_soz=vertcat(s_frono_soz, ones(numel(temp),1));
end;
s_frono_anesthesia=vertcat(s_frono_anesthesia, ones(numel(temp),1));
s_patient_frono=vertcat(s_patient_frono, ones(numel(temp),1)*3);

test_query=['{"patient_id":"' patients{1} '","electrode":"' IO06{i} '","type":"' num2str(5) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
s_frons_power=vertcat(s_frons_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
s_frons_freq=vertcat(s_frons_freq, temp);
if soz == 0
    s_frons_soz=vertcat(s_frons_soz, zeros(numel(temp),1));
else
    s_frons_soz=vertcat(s_frons_soz, ones(numel(temp),1));
end;
s_frons_anesthesia=vertcat(s_frons_anesthesia, ones(numel(temp),1));
s_patient_frons=vertcat(s_patient_frons, ones(numel(temp),1)*3);
end;

%IO08

for i=1:numel(IO08io);
patients={'IO008'};
test_query=['{"patient_id":"' patients{1} '","electrode":"' IO08{i} '","type":"' num2str(1) '"}'];
soz = cell2mat(distinct(conn,collection,"soz",'query',test_query))';
if ~isnumeric(soz)
    soz=str2num(soz);
end;

patients={'IO008io'};
test_query=['{"patient_id":"' patients{1} '","electrode":"' IO08io{i} '","type":"' num2str(1) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
io_rono_power=vertcat(io_rono_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
io_rono_freq=vertcat(io_rono_freq, temp);
if soz == 0
    io_rono_soz=vertcat(io_rono_soz, zeros(numel(temp),1));
else
    io_rono_soz=vertcat(io_rono_soz, ones(numel(temp),1));
end;
io_rono_anesthesia=vertcat(io_rono_anesthesia, ones(numel(temp),1)*4);
io_patient_rono=vertcat(io_patient_rono, ones(numel(temp),1)*4);

test_query=['{"patient_id":"' patients{1} '","electrode":"' IO08io{i} '","type":"' num2str(2) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
io_rons_power=vertcat(io_rons_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
io_rons_freq=vertcat(io_rons_freq, temp);
if soz == 0
    io_rons_soz=vertcat(io_rons_soz, zeros(numel(temp),1));
else
    io_rons_soz=vertcat(io_rons_soz, ones(numel(temp),1));
end;
io_rons_anesthesia=vertcat(io_rons_anesthesia, ones(numel(temp),1)*4);
io_patient_rons=vertcat(io_patient_rons, ones(numel(temp),1)*4);

test_query=['{"patient_id":"' patients{1} '","electrode":"' IO08io{i} '","type":"' num2str(4) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
io_frono_power=vertcat(io_frono_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
io_frono_freq=vertcat(io_frono_freq, temp);
if soz == 0
    io_frono_soz=vertcat(io_frono_soz, zeros(numel(temp),1));
else
    io_frono_soz=vertcat(io_frono_soz, ones(numel(temp),1));
end;
io_frono_anesthesia=vertcat(io_frono_anesthesia, ones(numel(temp),1)*4);
io_patient_frono=vertcat(io_patient_frono, ones(numel(temp),1)*4);

test_query=['{"patient_id":"' patients{1} '","electrode":"' IO08io{i} '","type":"' num2str(5) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
io_frons_power=vertcat(io_frons_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
io_frons_freq=vertcat(io_frons_freq, temp);
if soz == 0
    io_frons_soz=vertcat(io_frons_soz, zeros(numel(temp),1));
else
    io_frons_soz=vertcat(io_frons_soz, ones(numel(temp),1));
end;
io_frons_anesthesia=vertcat(io_frons_anesthesia, ones(numel(temp),1)*4);
io_patient_frons=vertcat(io_patient_frons, ones(numel(temp),1)*4);
end;

for i=1:numel(IO08);
patients={'IO008'};
test_query=['{"patient_id":"' patients{1} '","electrode":"' IO08{i} '","type":"' num2str(1) '"}'];
soz = cell2mat(distinct(conn,collection,"soz",'query',test_query))';
if ~isnumeric(soz)
    soz=str2num(soz);
end;

patients={'IO008'};
test_query=['{"patient_id":"' patients{1} '","electrode":"' IO08{i} '","type":"' num2str(1) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
s_rono_power=vertcat(s_rono_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
s_rono_freq=vertcat(s_rono_freq, temp);
if soz == 0
    s_rono_soz=vertcat(s_rono_soz, zeros(numel(temp),1));
else
    s_rono_soz=vertcat(s_rono_soz, ones(numel(temp),1));
end;
s_rono_anesthesia=vertcat(s_rono_anesthesia, ones(numel(temp),1)*4);
s_patient_rono=vertcat(s_patient_rono, ones(numel(temp),1)*4);

test_query=['{"patient_id":"' patients{1} '","electrode":"' IO08{i} '","type":"' num2str(2) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
s_rons_power=vertcat(s_rons_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
s_rons_freq=vertcat(s_rons_freq, temp);
if soz == 0
    s_rons_soz=vertcat(s_rons_soz, zeros(numel(temp),1));
else
    s_rons_soz=vertcat(s_rons_soz, ones(numel(temp),1));
end;
s_rons_anesthesia=vertcat(s_rons_anesthesia, ones(numel(temp),1)*4);
s_patient_rons=vertcat(s_patient_rons, ones(numel(temp),1)*4);

test_query=['{"patient_id":"' patients{1} '","electrode":"' IO08{i} '","type":"' num2str(4) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
s_frono_power=vertcat(s_frono_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
s_frono_freq=vertcat(s_frono_freq, temp);
if soz == 0
    s_frono_soz=vertcat(s_frono_soz, zeros(numel(temp),1));
else
    s_frono_soz=vertcat(s_frono_soz, ones(numel(temp),1));
end;
s_frono_anesthesia=vertcat(s_frono_anesthesia, ones(numel(temp),1)*4);
s_patient_frono=vertcat(s_patient_frono, ones(numel(temp),1)*4);

test_query=['{"patient_id":"' patients{1} '","electrode":"' IO08{i} '","type":"' num2str(5) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
s_frons_power=vertcat(s_frons_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
s_frons_freq=vertcat(s_frons_freq, temp);
if soz == 0
    s_frons_soz=vertcat(s_frons_soz, zeros(numel(temp),1));
else
    s_frons_soz=vertcat(s_frons_soz, ones(numel(temp),1));
end;
s_frons_anesthesia=vertcat(s_frons_anesthesia, ones(numel(temp),1)*4);
s_patient_frons=vertcat(s_patient_frons, ones(numel(temp),1)*4);
end;

%IO09

for i=1:numel(IO09io);
patients={'IO009'};
test_query=['{"patient_id":"' patients{1} '","electrode":"' IO09{i} '","type":"' num2str(1) '"}'];
soz = cell2mat(distinct(conn,collection,"soz",'query',test_query))';
if ~isnumeric(soz)
    soz=str2num(soz);
end;

patients={'IO009io'};
test_query=['{"patient_id":"' patients{1} '","electrode":"' IO09io{i} '","type":"' num2str(1) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
io_rono_power=vertcat(io_rono_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
io_rono_freq=vertcat(io_rono_freq, temp);
if soz == 0
    io_rono_soz=vertcat(io_rono_soz, zeros(numel(temp),1));
else
    io_rono_soz=vertcat(io_rono_soz, ones(numel(temp),1));
end;
io_rono_anesthesia=vertcat(io_rono_anesthesia, ones(numel(temp),1)*4);
io_patient_rono=vertcat(io_patient_rono, ones(numel(temp),1)*5);

test_query=['{"patient_id":"' patients{1} '","electrode":"' IO09io{i} '","type":"' num2str(2) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
io_rons_power=vertcat(io_rons_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
io_rons_freq=vertcat(io_rons_freq, temp);
if soz == 0
    io_rons_soz=vertcat(io_rons_soz, zeros(numel(temp),1));
else
    io_rons_soz=vertcat(io_rons_soz, ones(numel(temp),1));
end;
io_rons_anesthesia=vertcat(io_rons_anesthesia, ones(numel(temp),1)*4);
io_patient_rons=vertcat(io_patient_rons, ones(numel(temp),1)*5);

test_query=['{"patient_id":"' patients{1} '","electrode":"' IO09io{i} '","type":"' num2str(4) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
io_frono_power=vertcat(io_frono_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
io_frono_freq=vertcat(io_frono_freq, temp);
if soz == 0
    io_frono_soz=vertcat(io_frono_soz, zeros(numel(temp),1));
else
    io_frono_soz=vertcat(io_frono_soz, ones(numel(temp),1));
end;
io_frono_anesthesia=vertcat(io_frono_anesthesia, ones(numel(temp),1)*4);
io_patient_frono=vertcat(io_patient_frono, ones(numel(temp),1)*5);

test_query=['{"patient_id":"' patients{1} '","electrode":"' IO09io{i} '","type":"' num2str(5) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
io_frons_power=vertcat(io_frons_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
io_frons_freq=vertcat(io_frons_freq, temp);
if soz == 0
    io_frons_soz=vertcat(io_frons_soz, zeros(numel(temp),1));
else
    io_frons_soz=vertcat(io_frons_soz, ones(numel(temp),1));
end;
io_frons_anesthesia=vertcat(io_frons_anesthesia, ones(numel(temp),1)*4);
io_patient_frons=vertcat(io_patient_frons, ones(numel(temp),1)*5);
end;

for i=1:numel(IO09);
patients={'IO009'};
test_query=['{"patient_id":"' patients{1} '","electrode":"' IO09{i} '","type":"' num2str(1) '"}'];
soz = cell2mat(distinct(conn,collection,"soz",'query',test_query))';
if ~isnumeric(soz)
    soz=str2num(soz);
end;

patients={'IO009'};
test_query=['{"patient_id":"' patients{1} '","electrode":"' IO09{i} '","type":"' num2str(1) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
s_rono_power=vertcat(s_rono_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
s_rono_freq=vertcat(s_rono_freq, temp);
if soz == 0
    s_rono_soz=vertcat(s_rono_soz, zeros(numel(temp),1));
else
    s_rono_soz=vertcat(s_rono_soz, ones(numel(temp),1));
end;
s_rono_anesthesia=vertcat(s_rono_anesthesia, ones(numel(temp),1)*4);
s_patient_rono=vertcat(s_patient_rono, ones(numel(temp),1)*5);

test_query=['{"patient_id":"' patients{1} '","electrode":"' IO09{i} '","type":"' num2str(2) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
s_rons_power=vertcat(s_rons_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
s_rons_freq=vertcat(s_rons_freq, temp);
if soz == 0
    s_rons_soz=vertcat(s_rons_soz, zeros(numel(temp),1));
else
    s_rons_soz=vertcat(s_rons_soz, ones(numel(temp),1));
end;
s_rons_anesthesia=vertcat(s_rons_anesthesia, ones(numel(temp),1)*4);
s_patient_rons=vertcat(s_patient_rons, ones(numel(temp),1)*5);

test_query=['{"patient_id":"' patients{1} '","electrode":"' IO09{i} '","type":"' num2str(4) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
s_frono_power=vertcat(s_frono_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
s_frono_freq=vertcat(s_frono_freq, temp);
if soz == 0
    s_frono_soz=vertcat(s_frono_soz, zeros(numel(temp),1));
else
    s_frono_soz=vertcat(s_frono_soz, ones(numel(temp),1));
end;
s_frono_anesthesia=vertcat(s_frono_anesthesia, ones(numel(temp),1)*4);
s_patient_frono=vertcat(s_patient_frono, ones(numel(temp),1)*5);

test_query=['{"patient_id":"' patients{1} '","electrode":"' IO09{i} '","type":"' num2str(5) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
s_frons_power=vertcat(s_frons_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
s_frons_freq=vertcat(s_frons_freq, temp);
if soz == 0
    s_frons_soz=vertcat(s_frons_soz, zeros(numel(temp),1));
else
    s_frons_soz=vertcat(s_frons_soz, ones(numel(temp),1));
end;
s_frons_anesthesia=vertcat(s_frons_anesthesia, ones(numel(temp),1)*4);
s_patient_frons=vertcat(s_patient_frons, ones(numel(temp),1)*5);
end;

%IO10

for i=1:numel(IO10io);
patients={'IO010'};
test_query=['{"patient_id":"' patients{1} '","electrode":"' IO10{i} '","type":"' num2str(1) '"}'];
soz = cell2mat(distinct(conn,collection,"soz",'query',test_query))';
if ~isnumeric(soz)
    soz=str2num(soz);
end;

patients={'IO010io'};
test_query=['{"patient_id":"' patients{1} '","electrode":"' IO10io{i} '","type":"' num2str(1) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
io_rono_power=vertcat(io_rono_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
io_rono_freq=vertcat(io_rono_freq, temp);
if soz == 0
    io_rono_soz=vertcat(io_rono_soz, zeros(numel(temp),1));
else
    io_rono_soz=vertcat(io_rono_soz, ones(numel(temp),1));
end;
io_rono_anesthesia=vertcat(io_rono_anesthesia, ones(numel(temp),1)*2);
io_patient_rono=vertcat(io_patient_rono, ones(numel(temp),1)*6);

test_query=['{"patient_id":"' patients{1} '","electrode":"' IO10io{i} '","type":"' num2str(2) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
io_rons_power=vertcat(io_rons_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
io_rons_freq=vertcat(io_rons_freq, temp);
if soz == 0
    io_rons_soz=vertcat(io_rons_soz, zeros(numel(temp),1));
else
    io_rons_soz=vertcat(io_rons_soz, ones(numel(temp),1));
end;
io_rons_anesthesia=vertcat(io_rons_anesthesia, ones(numel(temp),1)*2);
io_patient_rons=vertcat(io_patient_rons, ones(numel(temp),1)*6);

test_query=['{"patient_id":"' patients{1} '","electrode":"' IO10io{i} '","type":"' num2str(4) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
io_frono_power=vertcat(io_frono_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
io_frono_freq=vertcat(io_frono_freq, temp);
if soz == 0
    io_frono_soz=vertcat(io_frono_soz, zeros(numel(temp),1));
else
    io_frono_soz=vertcat(io_frono_soz, ones(numel(temp),1));
end;
io_frono_anesthesia=vertcat(io_frono_anesthesia, ones(numel(temp),1)*2);
io_patient_frono=vertcat(io_patient_frono, ones(numel(temp),1)*6);

test_query=['{"patient_id":"' patients{1} '","electrode":"' IO10io{i} '","type":"' num2str(5) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
io_frons_power=vertcat(io_frons_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
io_frons_freq=vertcat(io_frons_freq, temp);
if soz == 0
    io_frons_soz=vertcat(io_frons_soz, zeros(numel(temp),1));
else
    io_frons_soz=vertcat(io_frons_soz, ones(numel(temp),1));
end;
io_frons_anesthesia=vertcat(io_frons_anesthesia, ones(numel(temp),1)*2);
io_patient_frons=vertcat(io_patient_frons, ones(numel(temp),1)*6);
end;

for i=1:numel(IO10);
patients={'IO010'};
test_query=['{"patient_id":"' patients{1} '","electrode":"' IO10{i} '","type":"' num2str(1) '"}'];
soz = cell2mat(distinct(conn,collection,"soz",'query',test_query))';
if ~isnumeric(soz)
    soz=str2num(soz);
end;

patients={'IO010'};
test_query=['{"patient_id":"' patients{1} '","electrode":"' IO10{i} '","type":"' num2str(1) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
s_rono_power=vertcat(s_rono_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
s_rono_freq=vertcat(s_rono_freq, temp);
if soz == 0
    s_rono_soz=vertcat(s_rono_soz, zeros(numel(temp),1));
else
    s_rono_soz=vertcat(s_rono_soz, ones(numel(temp),1));
end;
s_rono_anesthesia=vertcat(s_rono_anesthesia, ones(numel(temp),1)*2);
s_patient_rono=vertcat(s_patient_rono, ones(numel(temp),1)*6);

test_query=['{"patient_id":"' patients{1} '","electrode":"' IO10{i} '","type":"' num2str(2) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
s_rons_power=vertcat(s_rons_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
s_rons_freq=vertcat(s_rons_freq, temp);
if soz == 0
    s_rons_soz=vertcat(s_rons_soz, zeros(numel(temp),1));
else
    s_rons_soz=vertcat(s_rons_soz, ones(numel(temp),1));
end;
s_rons_anesthesia=vertcat(s_rons_anesthesia, ones(numel(temp),1)*2);
s_patient_rons=vertcat(s_patient_rons, ones(numel(temp),1)*6);

test_query=['{"patient_id":"' patients{1} '","electrode":"' IO10{i} '","type":"' num2str(4) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
s_frono_power=vertcat(s_frono_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
s_frono_freq=vertcat(s_frono_freq, temp);
if soz == 0
    s_frono_soz=vertcat(s_frono_soz, zeros(numel(temp),1));
else
    s_frono_soz=vertcat(s_frono_soz, ones(numel(temp),1));
end;
s_frono_anesthesia=vertcat(s_frono_anesthesia, ones(numel(temp),1)*2);
s_patient_frono=vertcat(s_patient_frono, ones(numel(temp),1)*6);

test_query=['{"patient_id":"' patients{1} '","electrode":"' IO10{i} '","type":"' num2str(5) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
s_frons_power=vertcat(s_frons_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
s_frons_freq=vertcat(s_frons_freq, temp);
if soz == 0
    s_frons_soz=vertcat(s_frons_soz, zeros(numel(temp),1));
else
    s_frons_soz=vertcat(s_frons_soz, ones(numel(temp),1));
end;
s_frons_anesthesia=vertcat(s_frons_anesthesia, ones(numel(temp),1)*2);
s_patient_frons=vertcat(s_patient_frons, ones(numel(temp),1)*6);
end;

%IO12

for i=1:numel(IO12io);
patients={'IO012'};
test_query=['{"patient_id":"' patients{1} '","electrode":"' IO12{i} '","type":"' num2str(1) '"}'];
soz = cell2mat(distinct(conn,collection,"soz",'query',test_query))';
if ~isnumeric(soz)
    soz=str2num(soz);
end;

patients={'IO012io'};
test_query=['{"patient_id":"' patients{1} '","electrode":"' IO12io{i} '","type":"' num2str(1) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
io_rono_power=vertcat(io_rono_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
io_rono_freq=vertcat(io_rono_freq, temp);
if soz == 0
    io_rono_soz=vertcat(io_rono_soz, zeros(numel(temp),1));
else
    io_rono_soz=vertcat(io_rono_soz, ones(numel(temp),1));
end;
io_rono_anesthesia=vertcat(io_rono_anesthesia, ones(numel(temp),1)*2);
io_patient_rono=vertcat(io_patient_rono, ones(numel(temp),1)*7);

test_query=['{"patient_id":"' patients{1} '","electrode":"' IO12io{i} '","type":"' num2str(2) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
io_rons_power=vertcat(io_rons_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
io_rons_freq=vertcat(io_rons_freq, temp);
if soz == 0
    io_rons_soz=vertcat(io_rons_soz, zeros(numel(temp),1));
else
    io_rons_soz=vertcat(io_rons_soz, ones(numel(temp),1));
end;
io_rons_anesthesia=vertcat(io_rons_anesthesia, ones(numel(temp),1)*2);
io_patient_rons=vertcat(io_patient_rons, ones(numel(temp),1)*7);

test_query=['{"patient_id":"' patients{1} '","electrode":"' IO12io{i} '","type":"' num2str(4) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
io_frono_power=vertcat(io_frono_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
io_frono_freq=vertcat(io_frono_freq, temp);
if soz == 0
    io_frono_soz=vertcat(io_frono_soz, zeros(numel(temp),1));
else
    io_frono_soz=vertcat(io_frono_soz, ones(numel(temp),1));
end;
io_frono_anesthesia=vertcat(io_frono_anesthesia, ones(numel(temp),1)*2);
io_patient_frono=vertcat(io_patient_frono, ones(numel(temp),1)*7);

test_query=['{"patient_id":"' patients{1} '","electrode":"' IO12io{i} '","type":"' num2str(5) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
io_frons_power=vertcat(io_frons_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
io_frons_freq=vertcat(io_frons_freq, temp);
if soz == 0
    io_frons_soz=vertcat(io_frons_soz, zeros(numel(temp),1));
else
    io_frons_soz=vertcat(io_frons_soz, ones(numel(temp),1));
end;
io_frons_anesthesia=vertcat(io_frons_anesthesia, ones(numel(temp),1)*2);
io_patient_frons=vertcat(io_patient_frons, ones(numel(temp),1)*7);
end;

for i=1:numel(IO12);
patients={'IO012'};
test_query=['{"patient_id":"' patients{1} '","electrode":"' IO12{i} '","type":"' num2str(1) '"}'];
soz = cell2mat(distinct(conn,collection,"soz",'query',test_query))';
if ~isnumeric(soz)
    soz=str2num(soz);
end;

patients={'IO012'};
test_query=['{"patient_id":"' patients{1} '","electrode":"' IO12{i} '","type":"' num2str(1) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
s_rono_power=vertcat(s_rono_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
s_rono_freq=vertcat(s_rono_freq, temp);
if soz == 0
    s_rono_soz=vertcat(s_rono_soz, zeros(numel(temp),1));
else
    s_rono_soz=vertcat(s_rono_soz, ones(numel(temp),1));
end;
s_rono_anesthesia=vertcat(s_rono_anesthesia, ones(numel(temp),1)*2);
s_patient_rono=vertcat(s_patient_rono, ones(numel(temp),1)*7);

test_query=['{"patient_id":"' patients{1} '","electrode":"' IO12{i} '","type":"' num2str(2) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
s_rons_power=vertcat(s_rons_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
s_rons_freq=vertcat(s_rons_freq, temp);
if soz == 0
    s_rons_soz=vertcat(s_rons_soz, zeros(numel(temp),1));
else
    s_rons_soz=vertcat(s_rons_soz, ones(numel(temp),1));
end;
s_rons_anesthesia=vertcat(s_rons_anesthesia, ones(numel(temp),1)*2);
s_patient_rons=vertcat(s_patient_rons, ones(numel(temp),1)*7);

test_query=['{"patient_id":"' patients{1} '","electrode":"' IO12{i} '","type":"' num2str(4) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
s_frono_power=vertcat(s_frono_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
s_frono_freq=vertcat(s_frono_freq, temp);
if soz == 0
    s_frono_soz=vertcat(s_frono_soz, zeros(numel(temp),1));
else
    s_frono_soz=vertcat(s_frono_soz, ones(numel(temp),1));
end;
s_frono_anesthesia=vertcat(s_frono_anesthesia, ones(numel(temp),1)*2);
s_patient_frono=vertcat(s_patient_frono, ones(numel(temp),1)*7);

test_query=['{"patient_id":"' patients{1} '","electrode":"' IO12{i} '","type":"' num2str(5) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
s_frons_power=vertcat(s_frons_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
s_frons_freq=vertcat(s_frons_freq, temp);
if soz == 0
    s_frons_soz=vertcat(s_frons_soz, zeros(numel(temp),1));
else
    s_frons_soz=vertcat(s_frons_soz, ones(numel(temp),1));
end;
s_frons_anesthesia=vertcat(s_frons_anesthesia, ones(numel(temp),1)*2);
s_patient_frons=vertcat(s_patient_frons, ones(numel(temp),1)*7);
end;

%IO13

for i=1:numel(IO13io);
patients={'IO013'};
test_query=['{"patient_id":"' patients{1} '","electrode":"' IO13{i} '","type":"' num2str(1) '"}'];
soz = cell2mat(distinct(conn,collection,"soz",'query',test_query))';
if ~isnumeric(soz)
    soz=str2num(soz);
end;

patients={'IO013io'};
test_query=['{"patient_id":"' patients{1} '","electrode":"' IO13io{i} '","type":"' num2str(1) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
io_rono_power=vertcat(io_rono_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
io_rono_freq=vertcat(io_rono_freq, temp);
if soz == 0
    io_rono_soz=vertcat(io_rono_soz, zeros(numel(temp),1));
else
    io_rono_soz=vertcat(io_rono_soz, ones(numel(temp),1));
end;
io_rono_anesthesia=vertcat(io_rono_anesthesia, ones(numel(temp),1)*2);
io_patient_rono=vertcat(io_patient_rono, ones(numel(temp),1)*8);

test_query=['{"patient_id":"' patients{1} '","electrode":"' IO13io{i} '","type":"' num2str(2) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
io_rons_power=vertcat(io_rons_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
io_rons_freq=vertcat(io_rons_freq, temp);
if soz == 0
    io_rons_soz=vertcat(io_rons_soz, zeros(numel(temp),1));
else
    io_rons_soz=vertcat(io_rons_soz, ones(numel(temp),1));
end;
io_rons_anesthesia=vertcat(io_rons_anesthesia, ones(numel(temp),1)*2);
io_patient_rons=vertcat(io_patient_rons, ones(numel(temp),1)*8);

test_query=['{"patient_id":"' patients{1} '","electrode":"' IO13io{i} '","type":"' num2str(4) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
io_frono_power=vertcat(io_frono_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
io_frono_freq=vertcat(io_frono_freq, temp);
if soz == 0
    io_frono_soz=vertcat(io_frono_soz, zeros(numel(temp),1));
else
    io_frono_soz=vertcat(io_frono_soz, ones(numel(temp),1));
end;
io_frono_anesthesia=vertcat(io_frono_anesthesia, ones(numel(temp),1)*2);
io_patient_frono=vertcat(io_patient_frono, ones(numel(temp),1)*8);

test_query=['{"patient_id":"' patients{1} '","electrode":"' IO13io{i} '","type":"' num2str(5) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
io_frons_power=vertcat(io_frons_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
io_frons_freq=vertcat(io_frons_freq, temp);
if soz == 0
    io_frons_soz=vertcat(io_frons_soz, zeros(numel(temp),1));
else
    io_frons_soz=vertcat(io_frons_soz, ones(numel(temp),1));
end;
io_frons_anesthesia=vertcat(io_frons_anesthesia, ones(numel(temp),1)*2);
io_patient_frons=vertcat(io_patient_frons, ones(numel(temp),1)*8);
end;

for i=1:numel(IO13);
patients={'IO013'};
test_query=['{"patient_id":"' patients{1} '","electrode":"' IO13{i} '","type":"' num2str(1) '"}'];
soz = cell2mat(distinct(conn,collection,"soz",'query',test_query))';
if ~isnumeric(soz)
    soz=str2num(soz);
end;

patients={'IO013'};
test_query=['{"patient_id":"' patients{1} '","electrode":"' IO13{i} '","type":"' num2str(1) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
s_rono_power=vertcat(s_rono_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
s_rono_freq=vertcat(s_rono_freq, temp);
if soz == 0
    s_rono_soz=vertcat(s_rono_soz, zeros(numel(temp),1));
else
    s_rono_soz=vertcat(s_rono_soz, ones(numel(temp),1));
end;
s_rono_anesthesia=vertcat(s_rono_anesthesia, ones(numel(temp),1)*2);
s_patient_rono=vertcat(s_patient_rono, ones(numel(temp),1)*8);

test_query=['{"patient_id":"' patients{1} '","electrode":"' IO13{i} '","type":"' num2str(2) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
s_rons_power=vertcat(s_rons_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
s_rons_freq=vertcat(s_rons_freq, temp);
if soz == 0
    s_rons_soz=vertcat(s_rons_soz, zeros(numel(temp),1));
else
    s_rons_soz=vertcat(s_rons_soz, ones(numel(temp),1));
end;
s_rons_anesthesia=vertcat(s_rons_anesthesia, ones(numel(temp),1)*2);
s_patient_rons=vertcat(s_patient_rons, ones(numel(temp),1)*8);

test_query=['{"patient_id":"' patients{1} '","electrode":"' IO13{i} '","type":"' num2str(4) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
s_frono_power=vertcat(s_frono_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
s_frono_freq=vertcat(s_frono_freq, temp);
if soz == 0
    s_frono_soz=vertcat(s_frono_soz, zeros(numel(temp),1));
else
    s_frono_soz=vertcat(s_frono_soz, ones(numel(temp),1));
end;
s_frono_anesthesia=vertcat(s_frono_anesthesia, ones(numel(temp),1)*2);
s_patient_frono=vertcat(s_patient_frono, ones(numel(temp),1)*8);

test_query=['{"patient_id":"' patients{1} '","electrode":"' IO13{i} '","type":"' num2str(5) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
s_frons_power=vertcat(s_frons_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
s_frons_freq=vertcat(s_frons_freq, temp);
if soz == 0
    s_frons_soz=vertcat(s_frons_soz, zeros(numel(temp),1));
else
    s_frons_soz=vertcat(s_frons_soz, ones(numel(temp),1));
end;
s_frons_anesthesia=vertcat(s_frons_anesthesia, ones(numel(temp),1)*2);
s_patient_frons=vertcat(s_patient_frons, ones(numel(temp),1)*8);
end;

%IO15

for i=1:numel(IO15io);
patients={'IO015'};
test_query=['{"patient_id":"' patients{1} '","electrode":"' IO15{i} '","type":"' num2str(1) '"}'];
soz = cell2mat(distinct(conn,collection,"soz",'query',test_query))';
if ~isnumeric(soz)
    soz=str2num(soz);
end;

patients={'IO015io'};
test_query=['{"patient_id":"' patients{1} '","electrode":"' IO15io{i} '","type":"' num2str(1) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
io_rono_power=vertcat(io_rono_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
io_rono_freq=vertcat(io_rono_freq, temp);
if soz == 0
    io_rono_soz=vertcat(io_rono_soz, zeros(numel(temp),1));
else
    io_rono_soz=vertcat(io_rono_soz, ones(numel(temp),1));
end;
io_rono_anesthesia=vertcat(io_rono_anesthesia, ones(numel(temp),1)*2);
io_patient_rono=vertcat(io_patient_rono, ones(numel(temp),1)*9);

test_query=['{"patient_id":"' patients{1} '","electrode":"' IO15io{i} '","type":"' num2str(2) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
io_rons_power=vertcat(io_rons_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
io_rons_freq=vertcat(io_rons_freq, temp);
if soz == 0
    io_rons_soz=vertcat(io_rons_soz, zeros(numel(temp),1));
else
    io_rons_soz=vertcat(io_rons_soz, ones(numel(temp),1));
end;
io_rons_anesthesia=vertcat(io_rons_anesthesia, ones(numel(temp),1)*2);
io_patient_rons=vertcat(io_patient_rons, ones(numel(temp),1)*9);

test_query=['{"patient_id":"' patients{1} '","electrode":"' IO15io{i} '","type":"' num2str(4) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
io_frono_power=vertcat(io_frono_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
io_frono_freq=vertcat(io_frono_freq, temp);
if soz == 0
    io_frono_soz=vertcat(io_frono_soz, zeros(numel(temp),1));
else
    io_frono_soz=vertcat(io_frono_soz, ones(numel(temp),1));
end;
io_frono_anesthesia=vertcat(io_frono_anesthesia, ones(numel(temp),1)*2);
io_patient_frono=vertcat(io_patient_frono, ones(numel(temp),1)*9);

test_query=['{"patient_id":"' patients{1} '","electrode":"' IO15io{i} '","type":"' num2str(5) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
io_frons_power=vertcat(io_frons_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
io_frons_freq=vertcat(io_frons_freq, temp);
if soz == 0
    io_frons_soz=vertcat(io_frons_soz, zeros(numel(temp),1));
else
    io_frons_soz=vertcat(io_frons_soz, ones(numel(temp),1));
end;
io_frons_anesthesia=vertcat(io_frons_anesthesia, ones(numel(temp),1)*2);
io_patient_frons=vertcat(io_patient_frons, ones(numel(temp),1)*9);
end;

for i=1:numel(IO15);
patients={'IO015'};
test_query=['{"patient_id":"' patients{1} '","electrode":"' IO15{i} '","type":"' num2str(1) '"}'];
soz = cell2mat(distinct(conn,collection,"soz",'query',test_query))';
if ~isnumeric(soz)
    soz=str2num(soz);
end;

patients={'IO015'};
test_query=['{"patient_id":"' patients{1} '","electrode":"' IO15{i} '","type":"' num2str(1) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
s_rono_power=vertcat(s_rono_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
s_rono_freq=vertcat(s_rono_freq, temp);
if soz == 0
    s_rono_soz=vertcat(s_rono_soz, zeros(numel(temp),1));
else
    s_rono_soz=vertcat(s_rono_soz, ones(numel(temp),1));
end;
s_rono_anesthesia=vertcat(s_rono_anesthesia, ones(numel(temp),1)*2);
s_patient_rono=vertcat(s_patient_rono, ones(numel(temp),1)*9);

test_query=['{"patient_id":"' patients{1} '","electrode":"' IO15{i} '","type":"' num2str(2) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
s_rons_power=vertcat(s_rons_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
s_rons_freq=vertcat(s_rons_freq, temp);
if soz == 0
    s_rons_soz=vertcat(s_rons_soz, zeros(numel(temp),1));
else
    s_rons_soz=vertcat(s_rons_soz, ones(numel(temp),1));
end;
s_rons_anesthesia=vertcat(s_rons_anesthesia, ones(numel(temp),1)*2);
s_patient_rons=vertcat(s_patient_rons, ones(numel(temp),1)*9);

test_query=['{"patient_id":"' patients{1} '","electrode":"' IO15{i} '","type":"' num2str(4) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
s_frono_power=vertcat(s_frono_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
s_frono_freq=vertcat(s_frono_freq, temp);
if soz == 0
    s_frono_soz=vertcat(s_frono_soz, zeros(numel(temp),1));
else
    s_frono_soz=vertcat(s_frono_soz, ones(numel(temp),1));
end;
s_frono_anesthesia=vertcat(s_frono_anesthesia, ones(numel(temp),1)*2);
s_patient_frono=vertcat(s_patient_frono, ones(numel(temp),1)*9);

test_query=['{"patient_id":"' patients{1} '","electrode":"' IO15{i} '","type":"' num2str(5) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
s_frons_power=vertcat(s_frons_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
s_frons_freq=vertcat(s_frons_freq, temp);
if soz == 0
    s_frons_soz=vertcat(s_frons_soz, zeros(numel(temp),1));
else
    s_frons_soz=vertcat(s_frons_soz, ones(numel(temp),1));
end;
s_frons_anesthesia=vertcat(s_frons_anesthesia, ones(numel(temp),1)*2);
s_patient_frons=vertcat(s_patient_frons, ones(numel(temp),1)*9);
end;

%IO17

for i=1:numel(IO17io);
patients={'IO017'};
test_query=['{"patient_id":"' patients{1} '","electrode":"' IO17{i} '","type":"' num2str(1) '"}'];
soz = cell2mat(distinct(conn,collection,"soz",'query',test_query))';
if ~isnumeric(soz)
    soz=str2num(soz);
end;

patients={'IO017io'};
test_query=['{"patient_id":"' patients{1} '","electrode":"' IO17io{i} '","type":"' num2str(1) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
io_rono_power=vertcat(io_rono_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
io_rono_freq=vertcat(io_rono_freq, temp);
if soz == 0
    io_rono_soz=vertcat(io_rono_soz, zeros(numel(temp),1));
else
    io_rono_soz=vertcat(io_rono_soz, ones(numel(temp),1));
end;
io_rono_anesthesia=vertcat(io_rono_anesthesia, ones(numel(temp),1)*2);
io_patient_rono=vertcat(io_patient_rono, ones(numel(temp),1)*10);

test_query=['{"patient_id":"' patients{1} '","electrode":"' IO17io{i} '","type":"' num2str(2) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
io_rons_power=vertcat(io_rons_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
io_rons_freq=vertcat(io_rons_freq, temp);
if soz == 0
    io_rons_soz=vertcat(io_rons_soz, zeros(numel(temp),1));
else
    io_rons_soz=vertcat(io_rons_soz, ones(numel(temp),1));
end;
io_rons_anesthesia=vertcat(io_rons_anesthesia, ones(numel(temp),1)*2);
io_patient_rons=vertcat(io_patient_rons, ones(numel(temp),1)*10);

test_query=['{"patient_id":"' patients{1} '","electrode":"' IO17io{i} '","type":"' num2str(4) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
io_frono_power=vertcat(io_frono_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
io_frono_freq=vertcat(io_frono_freq, temp);
if soz == 0
    io_frono_soz=vertcat(io_frono_soz, zeros(numel(temp),1));
else
    io_frono_soz=vertcat(io_frono_soz, ones(numel(temp),1));
end;
io_frono_anesthesia=vertcat(io_frono_anesthesia, ones(numel(temp),1)*2);
io_patient_frono=vertcat(io_patient_frono, ones(numel(temp),1)*10);

test_query=['{"patient_id":"' patients{1} '","electrode":"' IO17io{i} '","type":"' num2str(5) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
io_frons_power=vertcat(io_frons_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
io_frons_freq=vertcat(io_frons_freq, temp);
if soz == 0
    io_frons_soz=vertcat(io_frons_soz, zeros(numel(temp),1));
else
    io_frons_soz=vertcat(io_frons_soz, ones(numel(temp),1));
end;
io_frons_anesthesia=vertcat(io_frons_anesthesia, ones(numel(temp),1)*2);
io_patient_frons=vertcat(io_patient_frons, ones(numel(temp),1)*10);
end;

for i=1:numel(IO17);
patients={'IO017'};
test_query=['{"patient_id":"' patients{1} '","electrode":"' IO17{i} '","type":"' num2str(1) '"}'];
soz = cell2mat(distinct(conn,collection,"soz",'query',test_query))';
if ~isnumeric(soz)
    soz=str2num(soz);
end;

patients={'IO017'};
test_query=['{"patient_id":"' patients{1} '","electrode":"' IO17{i} '","type":"' num2str(1) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
s_rono_power=vertcat(s_rono_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
s_rono_freq=vertcat(s_rono_freq, temp);
if soz == 0
    s_rono_soz=vertcat(s_rono_soz, zeros(numel(temp),1));
else
    s_rono_soz=vertcat(s_rono_soz, ones(numel(temp),1));
end;
s_rono_anesthesia=vertcat(s_rono_anesthesia, ones(numel(temp),1)*2);
s_patient_rono=vertcat(s_patient_rono, ones(numel(temp),1)*10);

test_query=['{"patient_id":"' patients{1} '","electrode":"' IO17{i} '","type":"' num2str(2) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
s_rons_power=vertcat(s_rons_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
s_rons_freq=vertcat(s_rons_freq, temp);
if soz == 0
    s_rons_soz=vertcat(s_rons_soz, zeros(numel(temp),1));
else
    s_rons_soz=vertcat(s_rons_soz, ones(numel(temp),1));
end;
s_rons_anesthesia=vertcat(s_rons_anesthesia, ones(numel(temp),1)*2);
s_patient_rons=vertcat(s_patient_rons, ones(numel(temp),1)*10);

test_query=['{"patient_id":"' patients{1} '","electrode":"' IO17{i} '","type":"' num2str(4) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
s_frono_power=vertcat(s_frono_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
s_frono_freq=vertcat(s_frono_freq, temp);
if soz == 0
    s_frono_soz=vertcat(s_frono_soz, zeros(numel(temp),1));
else
    s_frono_soz=vertcat(s_frono_soz, ones(numel(temp),1));
end;
s_frono_anesthesia=vertcat(s_frono_anesthesia, ones(numel(temp),1)*2);
s_patient_frono=vertcat(s_patient_frono, ones(numel(temp),1)*10);

test_query=['{"patient_id":"' patients{1} '","electrode":"' IO17{i} '","type":"' num2str(5) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
s_frons_power=vertcat(s_frons_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
s_frons_freq=vertcat(s_frons_freq, temp);
if soz == 0
    s_frons_soz=vertcat(s_frons_soz, zeros(numel(temp),1));
else
    s_frons_soz=vertcat(s_frons_soz, ones(numel(temp),1));
end;
s_frons_anesthesia=vertcat(s_frons_anesthesia, ones(numel(temp),1)*2);
s_patient_frons=vertcat(s_patient_frons, ones(numel(temp),1)*10);
end;

%IO18

for i=1:numel(IO18io);
patients={'IO018'};
test_query=['{"patient_id":"' patients{1} '","electrode":"' IO18{i} '","type":"' num2str(1) '"}'];
soz = cell2mat(distinct(conn,collection,"soz",'query',test_query))';
if ~isnumeric(soz)
    soz=str2num(soz);
end;

patients={'IO018io'};
test_query=['{"patient_id":"' patients{1} '","electrode":"' IO18io{i} '","type":"' num2str(1) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
io_rono_power=vertcat(io_rono_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
io_rono_freq=vertcat(io_rono_freq, temp);
if soz == 0
    io_rono_soz=vertcat(io_rono_soz, zeros(numel(temp),1));
else
    io_rono_soz=vertcat(io_rono_soz, ones(numel(temp),1));
end;
io_rono_anesthesia=vertcat(io_rono_anesthesia, ones(numel(temp),1)*2);
io_patient_rono=vertcat(io_patient_rono, ones(numel(temp),1)*11);

test_query=['{"patient_id":"' patients{1} '","electrode":"' IO18io{i} '","type":"' num2str(2) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
io_rons_power=vertcat(io_rons_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
io_rons_freq=vertcat(io_rons_freq, temp);
if soz == 0
    io_rons_soz=vertcat(io_rons_soz, zeros(numel(temp),1));
else
    io_rons_soz=vertcat(io_rons_soz, ones(numel(temp),1));
end;
io_rons_anesthesia=vertcat(io_rons_anesthesia, ones(numel(temp),1)*2);
io_patient_rons=vertcat(io_patient_rons, ones(numel(temp),1)*11);

test_query=['{"patient_id":"' patients{1} '","electrode":"' IO18io{i} '","type":"' num2str(4) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
io_frono_power=vertcat(io_frono_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
io_frono_freq=vertcat(io_frono_freq, temp);
if soz == 0
    io_frono_soz=vertcat(io_frono_soz, zeros(numel(temp),1));
else
    io_frono_soz=vertcat(io_frono_soz, ones(numel(temp),1));
end;
io_frono_anesthesia=vertcat(io_frono_anesthesia, ones(numel(temp),1)*2);
io_patient_frono=vertcat(io_patient_frono, ones(numel(temp),1)*11);

test_query=['{"patient_id":"' patients{1} '","electrode":"' IO18io{i} '","type":"' num2str(5) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
io_frons_power=vertcat(io_frons_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
io_frons_freq=vertcat(io_frons_freq, temp);
if soz == 0
    io_frons_soz=vertcat(io_frons_soz, zeros(numel(temp),1));
else
    io_frons_soz=vertcat(io_frons_soz, ones(numel(temp),1));
end;
io_frons_anesthesia=vertcat(io_frons_anesthesia, ones(numel(temp),1)*2);
io_patient_frons=vertcat(io_patient_frons, ones(numel(temp),1)*11);
end;

for i=1:numel(IO18);
patients={'IO018'};
test_query=['{"patient_id":"' patients{1} '","electrode":"' IO18{i} '","type":"' num2str(1) '"}'];
soz = cell2mat(distinct(conn,collection,"soz",'query',test_query))';
if ~isnumeric(soz)
    soz=str2num(soz);
end;

patients={'IO018'};
test_query=['{"patient_id":"' patients{1} '","electrode":"' IO18{i} '","type":"' num2str(1) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
s_rono_power=vertcat(s_rono_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
s_rono_freq=vertcat(s_rono_freq, temp);
if soz == 0
    s_rono_soz=vertcat(s_rono_soz, zeros(numel(temp),1));
else
    s_rono_soz=vertcat(s_rono_soz, ones(numel(temp),1));
end;
s_rono_anesthesia=vertcat(s_rono_anesthesia, ones(numel(temp),1)*2);
s_patient_rono=vertcat(s_patient_rono, ones(numel(temp),1)*11);

test_query=['{"patient_id":"' patients{1} '","electrode":"' IO18{i} '","type":"' num2str(2) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
s_rons_power=vertcat(s_rons_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
s_rons_freq=vertcat(s_rons_freq, temp);
if soz == 0
    s_rons_soz=vertcat(s_rons_soz, zeros(numel(temp),1));
else
    s_rons_soz=vertcat(s_rons_soz, ones(numel(temp),1));
end;
s_rons_anesthesia=vertcat(s_rons_anesthesia, ones(numel(temp),1)*2);
s_patient_rons=vertcat(s_patient_rons, ones(numel(temp),1)*11);

test_query=['{"patient_id":"' patients{1} '","electrode":"' IO18{i} '","type":"' num2str(4) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
s_frono_power=vertcat(s_frono_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
s_frono_freq=vertcat(s_frono_freq, temp);
if soz == 0
    s_frono_soz=vertcat(s_frono_soz, zeros(numel(temp),1));
else
    s_frono_soz=vertcat(s_frono_soz, ones(numel(temp),1));
end;
s_frono_anesthesia=vertcat(s_frono_anesthesia, ones(numel(temp),1)*2);
s_patient_frono=vertcat(s_patient_frono, ones(numel(temp),1)*11);

test_query=['{"patient_id":"' patients{1} '","electrode":"' IO18{i} '","type":"' num2str(5) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
s_frons_power=vertcat(s_frons_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
s_frons_freq=vertcat(s_frons_freq, temp);
if soz == 0
    s_frons_soz=vertcat(s_frons_soz, zeros(numel(temp),1));
else
    s_frons_soz=vertcat(s_frons_soz, ones(numel(temp),1));
end;
s_frons_anesthesia=vertcat(s_frons_anesthesia, ones(numel(temp),1)*2);
s_patient_frons=vertcat(s_patient_frons, ones(numel(temp),1)*11);
end;

%IO21

for i=1:numel(IO21io);
patients={'IO021'};
test_query=['{"patient_id":"' patients{1} '","electrode":"' IO21{i} '","type":"' num2str(1) '"}'];
soz = cell2mat(distinct(conn,collection,"soz",'query',test_query))';
if ~isnumeric(soz)
    soz=str2num(soz);
end;

patients={'IO021io'};
test_query=['{"patient_id":"' patients{1} '","electrode":"' IO21io{i} '","type":"' num2str(1) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
io_rono_power=vertcat(io_rono_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
io_rono_freq=vertcat(io_rono_freq, temp);
if soz == 0
    io_rono_soz=vertcat(io_rono_soz, zeros(numel(temp),1));
else
    io_rono_soz=vertcat(io_rono_soz, ones(numel(temp),1));
end;
io_rono_anesthesia=vertcat(io_rono_anesthesia, ones(numel(temp),1)*2);
io_patient_rono=vertcat(io_patient_rono, ones(numel(temp),1)*12);

test_query=['{"patient_id":"' patients{1} '","electrode":"' IO21io{i} '","type":"' num2str(2) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
io_rons_power=vertcat(io_rons_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
io_rons_freq=vertcat(io_rons_freq, temp);
if soz == 0
    io_rons_soz=vertcat(io_rons_soz, zeros(numel(temp),1));
else
    io_rons_soz=vertcat(io_rons_soz, ones(numel(temp),1));
end;
io_rons_anesthesia=vertcat(io_rons_anesthesia, ones(numel(temp),1)*2);
io_patient_rons=vertcat(io_patient_rons, ones(numel(temp),1)*12);

test_query=['{"patient_id":"' patients{1} '","electrode":"' IO21io{i} '","type":"' num2str(4) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
io_frono_power=vertcat(io_frono_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
io_frono_freq=vertcat(io_frono_freq, temp);
if soz == 0
    io_frono_soz=vertcat(io_frono_soz, zeros(numel(temp),1));
else
    io_frono_soz=vertcat(io_frono_soz, ones(numel(temp),1));
end;
io_frono_anesthesia=vertcat(io_frono_anesthesia, ones(numel(temp),1)*2);
io_patient_frono=vertcat(io_patient_frono, ones(numel(temp),1)*12);

test_query=['{"patient_id":"' patients{1} '","electrode":"' IO21io{i} '","type":"' num2str(5) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
io_frons_power=vertcat(io_frons_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
io_frons_freq=vertcat(io_frons_freq, temp);
if soz == 0
    io_frons_soz=vertcat(io_frons_soz, zeros(numel(temp),1));
else
    io_frons_soz=vertcat(io_frons_soz, ones(numel(temp),1));
end;
io_frons_anesthesia=vertcat(io_frons_anesthesia, ones(numel(temp),1)*2);
io_patient_frons=vertcat(io_patient_frons, ones(numel(temp),1)*12);
end;

for i=1:numel(IO21);
patients={'IO021'};
test_query=['{"patient_id":"' patients{1} '","electrode":"' IO21{i} '","type":"' num2str(1) '"}'];
soz = cell2mat(distinct(conn,collection,"soz",'query',test_query))';
if ~isnumeric(soz)
    soz=str2num(soz);
end;

patients={'IO021'};
test_query=['{"patient_id":"' patients{1} '","electrode":"' IO21{i} '","type":"' num2str(1) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
s_rono_power=vertcat(s_rono_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
s_rono_freq=vertcat(s_rono_freq, temp);
if soz == 0
    s_rono_soz=vertcat(s_rono_soz, zeros(numel(temp),1));
else
    s_rono_soz=vertcat(s_rono_soz, ones(numel(temp),1));
end;
s_rono_anesthesia=vertcat(s_rono_anesthesia, ones(numel(temp),1)*2);
s_patient_rono=vertcat(s_patient_rono, ones(numel(temp),1)*12);

test_query=['{"patient_id":"' patients{1} '","electrode":"' IO21{i} '","type":"' num2str(2) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
s_rons_power=vertcat(s_rons_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
s_rons_freq=vertcat(s_rons_freq, temp);
if soz == 0
    s_rons_soz=vertcat(s_rons_soz, zeros(numel(temp),1));
else
    s_rons_soz=vertcat(s_rons_soz, ones(numel(temp),1));
end;
s_rons_anesthesia=vertcat(s_rons_anesthesia, ones(numel(temp),1)*2);
s_patient_rons=vertcat(s_patient_rons, ones(numel(temp),1)*12);

test_query=['{"patient_id":"' patients{1} '","electrode":"' IO21{i} '","type":"' num2str(4) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
s_frono_power=vertcat(s_frono_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
s_frono_freq=vertcat(s_frono_freq, temp);
if soz == 0
    s_frono_soz=vertcat(s_frono_soz, zeros(numel(temp),1));
else
    s_frono_soz=vertcat(s_frono_soz, ones(numel(temp),1));
end;
s_frono_anesthesia=vertcat(s_frono_anesthesia, ones(numel(temp),1)*2);
s_patient_frono=vertcat(s_patient_frono, ones(numel(temp),1)*12);

test_query=['{"patient_id":"' patients{1} '","electrode":"' IO21{i} '","type":"' num2str(5) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
s_frons_power=vertcat(s_frons_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
s_frons_freq=vertcat(s_frons_freq, temp);
if soz == 0
    s_frons_soz=vertcat(s_frons_soz, zeros(numel(temp),1));
else
    s_frons_soz=vertcat(s_frons_soz, ones(numel(temp),1));
end;
s_frons_anesthesia=vertcat(s_frons_anesthesia, ones(numel(temp),1)*2);
s_patient_frons=vertcat(s_patient_frons, ones(numel(temp),1)*12);
end;

%IO22

for i=1:numel(IO22io);
patients={'IO022'};
test_query=['{"patient_id":"' patients{1} '","electrode":"' IO22{i} '","type":"' num2str(1) '"}'];
soz = cell2mat(distinct(conn,collection,"soz",'query',test_query))';
if ~isnumeric(soz)
    soz=str2num(soz);
end;

patients={'IO022io'};
test_query=['{"patient_id":"' patients{1} '","electrode":"' IO22io{i} '","type":"' num2str(1) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
io_rono_power=vertcat(io_rono_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
io_rono_freq=vertcat(io_rono_freq, temp);
if soz == 0
    io_rono_soz=vertcat(io_rono_soz, zeros(numel(temp),1));
else
    io_rono_soz=vertcat(io_rono_soz, ones(numel(temp),1));
end;
io_rono_anesthesia=vertcat(io_rono_anesthesia, ones(numel(temp),1)*2);
io_patient_rono=vertcat(io_patient_rono, ones(numel(temp),1)*13);

test_query=['{"patient_id":"' patients{1} '","electrode":"' IO22io{i} '","type":"' num2str(2) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
io_rons_power=vertcat(io_rons_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
io_rons_freq=vertcat(io_rons_freq, temp);
if soz == 0
    io_rons_soz=vertcat(io_rons_soz, zeros(numel(temp),1));
else
    io_rons_soz=vertcat(io_rons_soz, ones(numel(temp),1));
end;
io_rons_anesthesia=vertcat(io_rons_anesthesia, ones(numel(temp),1)*2);
io_patient_rons=vertcat(io_patient_rons, ones(numel(temp),1)*13);

test_query=['{"patient_id":"' patients{1} '","electrode":"' IO22io{i} '","type":"' num2str(4) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
io_frono_power=vertcat(io_frono_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
io_frono_freq=vertcat(io_frono_freq, temp);
if soz == 0
    io_frono_soz=vertcat(io_frono_soz, zeros(numel(temp),1));
else
    io_frono_soz=vertcat(io_frono_soz, ones(numel(temp),1));
end;
io_frono_anesthesia=vertcat(io_frono_anesthesia, ones(numel(temp),1)*2);
io_patient_frono=vertcat(io_patient_frono, ones(numel(temp),1)*13);

test_query=['{"patient_id":"' patients{1} '","electrode":"' IO22io{i} '","type":"' num2str(5) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
io_frons_power=vertcat(io_frons_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
io_frons_freq=vertcat(io_frons_freq, temp);
if soz == 0
    io_frons_soz=vertcat(io_frons_soz, zeros(numel(temp),1));
else
    io_frons_soz=vertcat(io_frons_soz, ones(numel(temp),1));
end;
io_frons_anesthesia=vertcat(io_frons_anesthesia, ones(numel(temp),1)*2);
io_patient_frons=vertcat(io_patient_frons, ones(numel(temp),1)*13);
end;

for i=1:numel(IO22);
patients={'IO022'};
test_query=['{"patient_id":"' patients{1} '","electrode":"' IO22{i} '","type":"' num2str(1) '"}'];
soz = cell2mat(distinct(conn,collection,"soz",'query',test_query))';
if ~isnumeric(soz)
    soz=str2num(soz);
end;

patients={'IO022'};
test_query=['{"patient_id":"' patients{1} '","electrode":"' IO22{i} '","type":"' num2str(1) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
s_rono_power=vertcat(s_rono_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
s_rono_freq=vertcat(s_rono_freq, temp);
if soz == 0
    s_rono_soz=vertcat(s_rono_soz, zeros(numel(temp),1));
else
    s_rono_soz=vertcat(s_rono_soz, ones(numel(temp),1));
end;
s_rono_anesthesia=vertcat(s_rono_anesthesia, ones(numel(temp),1)*2);
s_patient_rono=vertcat(s_patient_rono, ones(numel(temp),1)*13);

test_query=['{"patient_id":"' patients{1} '","electrode":"' IO22{i} '","type":"' num2str(2) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
s_rons_power=vertcat(s_rons_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
s_rons_freq=vertcat(s_rons_freq, temp);
if soz == 0
    s_rons_soz=vertcat(s_rons_soz, zeros(numel(temp),1));
else
    s_rons_soz=vertcat(s_rons_soz, ones(numel(temp),1));
end;
s_rons_anesthesia=vertcat(s_rons_anesthesia, ones(numel(temp),1)*2);
s_patient_rons=vertcat(s_patient_rons, ones(numel(temp),1)*13);

test_query=['{"patient_id":"' patients{1} '","electrode":"' IO22{i} '","type":"' num2str(4) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
s_frono_power=vertcat(s_frono_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
s_frono_freq=vertcat(s_frono_freq, temp);
if soz == 0
    s_frono_soz=vertcat(s_frono_soz, zeros(numel(temp),1));
else
    s_frono_soz=vertcat(s_frono_soz, ones(numel(temp),1));
end;
s_frono_anesthesia=vertcat(s_frono_anesthesia, ones(numel(temp),1)*2);
s_patient_frono=vertcat(s_patient_frono, ones(numel(temp),1)*13);

test_query=['{"patient_id":"' patients{1} '","electrode":"' IO22{i} '","type":"' num2str(5) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
s_frons_power=vertcat(s_frons_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
s_frons_freq=vertcat(s_frons_freq, temp);
if soz == 0
    s_frons_soz=vertcat(s_frons_soz, zeros(numel(temp),1));
else
    s_frons_soz=vertcat(s_frons_soz, ones(numel(temp),1));
end;
s_frons_anesthesia=vertcat(s_frons_anesthesia, ones(numel(temp),1)*2);
s_patient_frons=vertcat(s_patient_frons, ones(numel(temp),1)*13);
end;

%IO25

for i=1:numel(IO25io);
patients={'IO025'};
test_query=['{"patient_id":"' patients{1} '","electrode":"' IO25{i} '","type":"' num2str(1) '"}'];
soz = cell2mat(distinct(conn,collection,"soz",'query',test_query))';
if ~isnumeric(soz)
    soz=str2num(soz);
end;

patients={'IO025io'};
test_query=['{"patient_id":"' patients{1} '","electrode":"' IO25io{i} '","type":"' num2str(1) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
io_rono_power=vertcat(io_rono_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
io_rono_freq=vertcat(io_rono_freq, temp);
if soz == 0
    io_rono_soz=vertcat(io_rono_soz, zeros(numel(temp),1));
else
    io_rono_soz=vertcat(io_rono_soz, ones(numel(temp),1));
end;
io_rono_anesthesia=vertcat(io_rono_anesthesia, ones(numel(temp),1)*2);
io_patient_rono=vertcat(io_patient_rono, ones(numel(temp),1)*14);

test_query=['{"patient_id":"' patients{1} '","electrode":"' IO25io{i} '","type":"' num2str(2) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
io_rons_power=vertcat(io_rons_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
io_rons_freq=vertcat(io_rons_freq, temp);
if soz == 0
    io_rons_soz=vertcat(io_rons_soz, zeros(numel(temp),1));
else
    io_rons_soz=vertcat(io_rons_soz, ones(numel(temp),1));
end;
io_rons_anesthesia=vertcat(io_rons_anesthesia, ones(numel(temp),1)*2);
io_patient_rons=vertcat(io_patient_rons, ones(numel(temp),1)*14);

test_query=['{"patient_id":"' patients{1} '","electrode":"' IO25io{i} '","type":"' num2str(4) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
io_frono_power=vertcat(io_frono_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
io_frono_freq=vertcat(io_frono_freq, temp);
if soz == 0
    io_frono_soz=vertcat(io_frono_soz, zeros(numel(temp),1));
else
    io_frono_soz=vertcat(io_frono_soz, ones(numel(temp),1));
end;
io_frono_anesthesia=vertcat(io_frono_anesthesia, ones(numel(temp),1)*2);
io_patient_frono=vertcat(io_patient_frono, ones(numel(temp),1)*14);

test_query=['{"patient_id":"' patients{1} '","electrode":"' IO25io{i} '","type":"' num2str(5) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
io_frons_power=vertcat(io_frons_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
io_frons_freq=vertcat(io_frons_freq, temp);
if soz == 0
    io_frons_soz=vertcat(io_frons_soz, zeros(numel(temp),1));
else
    io_frons_soz=vertcat(io_frons_soz, ones(numel(temp),1));
end;
io_frons_anesthesia=vertcat(io_frons_anesthesia, ones(numel(temp),1)*2);
io_patient_frons=vertcat(io_patient_frons, ones(numel(temp),1)*14);
end;

for i=1:numel(IO25);
patients={'IO025'};
test_query=['{"patient_id":"' patients{1} '","electrode":"' IO25{i} '","type":"' num2str(1) '"}'];
soz = cell2mat(distinct(conn,collection,"soz",'query',test_query))';
if ~isnumeric(soz)
    soz=str2num(soz);
end;

patients={'IO025'};
test_query=['{"patient_id":"' patients{1} '","electrode":"' IO25{i} '","type":"' num2str(1) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
s_rono_power=vertcat(s_rono_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
s_rono_freq=vertcat(s_rono_freq, temp);
if soz == 0
    s_rono_soz=vertcat(s_rono_soz, zeros(numel(temp),1));
else
    s_rono_soz=vertcat(s_rono_soz, ones(numel(temp),1));
end;
s_rono_anesthesia=vertcat(s_rono_anesthesia, ones(numel(temp),1)*2);
s_patient_rono=vertcat(s_patient_rono, ones(numel(temp),1)*14);

test_query=['{"patient_id":"' patients{1} '","electrode":"' IO25{i} '","type":"' num2str(2) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
s_rons_power=vertcat(s_rons_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
s_rons_freq=vertcat(s_rons_freq, temp);
if soz == 0
    s_rons_soz=vertcat(s_rons_soz, zeros(numel(temp),1));
else
    s_rons_soz=vertcat(s_rons_soz, ones(numel(temp),1));
end;
s_rons_anesthesia=vertcat(s_rons_anesthesia, ones(numel(temp),1)*2);
s_patient_rons=vertcat(s_patient_rons, ones(numel(temp),1)*14);

test_query=['{"patient_id":"' patients{1} '","electrode":"' IO25{i} '","type":"' num2str(4) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
s_frono_power=vertcat(s_frono_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
s_frono_freq=vertcat(s_frono_freq, temp);
if soz == 0
    s_frono_soz=vertcat(s_frono_soz, zeros(numel(temp),1));
else
    s_frono_soz=vertcat(s_frono_soz, ones(numel(temp),1));
end;
s_frono_anesthesia=vertcat(s_frono_anesthesia, ones(numel(temp),1)*2);
s_patient_frono=vertcat(s_patient_frono, ones(numel(temp),1)*14);

test_query=['{"patient_id":"' patients{1} '","electrode":"' IO25{i} '","type":"' num2str(5) '"}'];
temp = cell2mat(distinct(conn,collection,"power_pk",'query',test_query))';
s_frons_power=vertcat(s_frons_power, temp);
temp = cell2mat(distinct(conn,collection,"freq_av",'query',test_query))';
s_frons_freq=vertcat(s_frons_freq, temp);
if soz == 0
    s_frons_soz=vertcat(s_frons_soz, zeros(numel(temp),1));
else
    s_frons_soz=vertcat(s_frons_soz, ones(numel(temp),1));
end;
s_frons_anesthesia=vertcat(s_frons_anesthesia, ones(numel(temp),1)*2);
s_patient_frons=vertcat(s_patient_frons, ones(numel(temp),1)*14);
end;