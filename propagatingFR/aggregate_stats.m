% aggregate analysis
clear
% load('edges4145.mat')
% load('edgesIO022.mat')
% load('edges481.mat')
% load('edges4110.mat')
% load('edgesIO006.mat')
% load('edgesIO002.mat')
% load('edgesIO018.mat')
load('edges0326done.mat')
soz_indices=[];
statedges=vertcat(edgesIO022,edgesIO019, edgesIO018, edgesIO015, edgesIO006, edgesIO005, edgesIO002, edges481, edges474, edges4163 ,edges4145, edges4110);
for i=1:numel(statedges.SOZstatusVector)
    temp=statedges.SOZstatusVector(i);
    if temp{1}(1)==1
        if temp{1}(2)==1
            soz_indices=[soz_indices i];
        end;
    end;
end;

statedges_soz=[];
for i=1:numel(soz_indices)
   index=soz_indices(i);
   statedges_soz=vertcat(statedges_soz, statedges(index,:));
end;
p_vals=[];
t_values=[];
[h,p_vals(1,1),ci,stats] = ttest(statedges_soz.ao_np_aperiodic(:,1), statedges_soz.ao_p_aperiodic(:,1));
t_values(1,1)=stats.tstat;
[h,p_vals(1,2),ci,stats] = ttest(statedges_soz.ai_np_aperiodic(:,1), statedges_soz.ai_p_aperiodic(:,1));
t_values(1,2)=stats.tstat;
[h,p_vals(1,3),ci,stats] = ttest(statedges_soz.ai_np_aperiodic(:,2), statedges_soz.ai_p_aperiodic(:,2));
t_values(1,3)=stats.tstat;
[h,p_vals(1,4),ci,stats] = ttest(statedges_soz.ao_np_aperiodic(:,2), statedges_soz.ao_p_aperiodic(:,2));
t_values(1,4)=stats.tstat;
[h,p_vals(1,5),ci,stats] = ttest(statedges_soz.ao_np_peak(:,1), statedges_soz.ao_p_peak(:,1));
t_values(1,5)=stats.tstat;
[h,p_vals(1,6),ci,stats] = ttest(statedges_soz.ai_np_peak(:,1), statedges_soz.ai_p_peak(:,1));
t_values(1,6)=stats.tstat;
[h,p_vals(1,7),ci,stats] = ttest(statedges_soz.ao_np_peak(:,2), statedges_soz.ao_p_peak(:,2));
t_values(1,7)=stats.tstat;
[h,p_vals(1,8),ci,stats] = ttest(statedges_soz.ai_np_peak(:,2), statedges_soz.ai_p_peak(:,2));
t_values(1,8)=stats.tstat;
[h, crit_p, adj_ci_cvrg, adj_p]=fdr_bh(p_vals);

statss=[p_vals' t_values' adj_p'];
xlswrite('sozpandnpcomparison.xls',statss)

p_vals_c=[];
t_values=[];
[h,p_vals_c(1,1),ci,stats] = ttest(statedges_soz.abo_np_aperiodic(:,1), statedges_soz.abo_p_aperiodic(:,1));
t_values(1,1)=stats.tstat;
[h,p_vals_c(1,2),ci,stats] = ttest(statedges_soz.abi_np_aperiodic(:,1), statedges_soz.abi_p_aperiodic(:,1));
t_values(1,2)=stats.tstat;
[h,p_vals_c(1,3),ci,stats] = ttest(statedges_soz.abi_np_aperiodic(:,2), statedges_soz.abi_p_aperiodic(:,2));
t_values(1,3)=stats.tstat;
[h,p_vals_c(1,4),ci,stats] = ttest(statedges_soz.abo_np_aperiodic(:,2), statedges_soz.abo_p_aperiodic(:,2));
t_values(1,4)=stats.tstat;
[h,p_vals_c(1,5),ci,stats] = ttest(statedges_soz.abo_np_peak(:,1), statedges_soz.abo_p_peak(:,1));
t_values(1,5)=stats.tstat;
[h,p_vals_c(1,6),ci,stats] = ttest(statedges_soz.abi_np_peak(:,1), statedges_soz.abi_p_peak(:,1));
t_values(1,6)=stats.tstat;
[h,p_vals_c(1,7),ci,stats] = ttest(statedges_soz.abo_np_peak(:,2), statedges_soz.abo_p_peak(:,2));
t_values(1,7)=stats.tstat;
[h,p_vals_c(1,8),ci,stats] = ttest(statedges_soz.abi_np_peak(:,2), statedges_soz.abi_p_peak(:,2));
t_values(1,8)=stats.tstat;
[h, crit_p, adj_ci_cvrg, adj_p_c]=fdr_bh(p_vals_c);

statss=[p_vals_c' t_values' adj_p_c'];
xlswrite('sozpandnpcomparisonbaseline.xls',statss)

% Pair wise compariosn offset
% out node
patient=statedges_soz.patientvector(i);
red=0;
green=1;
blue=.5;
figure
hold on
for i=1:29
    new_patient=statedges_soz.patientvector(i);
    if new_patient~=patient
        red=red+.16;
        green=green-.16;
        blue=blue+.08;
    end;
    y=[statedges_soz.ao_np_aperiodic(i,1) statedges_soz.ao_p_aperiodic(i,1)];
    x=[1 2];
    plot(x,y,'linewidth',1,'color',[red green blue])
    patient=statedges_soz.patientvector(i);
end;
title('SOZ out aperiodic offset np p')

% Pair wise compariosn exponent
% out node
patient=statedges_soz.patientvector(i);
red=0;
green=1;
blue=.5;
figure
hold on
for i=1:29
    new_patient=statedges_soz.patientvector(i);
    if new_patient~=patient
        red=red+.16;
        green=green-.16;
        blue=blue+.08;
    end;
    y=[statedges_soz.ao_np_aperiodic(i,2) statedges_soz.ao_p_aperiodic(i,2)];
    x=[1 2];
    plot(x,y,'linewidth',1,'color',[red green blue])
    patient=statedges_soz.patientvector(i);
end;
title('SOZ out aperiodic exponent np p')

% Pair wise compariosn frequency
% out node
patient=statedges_soz.patientvector(i);
red=0;
green=1;
blue=.5;
figure
hold on
for i=1:29
    new_patient=statedges_soz.patientvector(i);
    if new_patient~=patient
        red=red+.16;
        green=green-.16;
        blue=blue+.08;
    end;
    y=[statedges_soz.ao_np_peak(i,1) statedges_soz.ao_p_peak(i,1)];
    x=[1 2];
    plot(x,y,'linewidth',1,'color',[red green blue])
    patient=statedges_soz.patientvector(i);
end;
title('SOZ out peak freequency np p')

% Pair wise compariosn peak height
% out node
patient=statedges_soz.patientvector(i);
red=0;
green=1;
blue=.5;
figure
hold on
for i=1:29
    new_patient=statedges_soz.patientvector(i);
    if new_patient~=patient
        red=red+.16;
        green=green-.16;
        blue=blue+.08;
    end;
    y=[statedges_soz.ao_np_peak(i,2) statedges_soz.ao_p_peak(i,2)];
    x=[1 2];
    plot(x,y,'linewidth',1,'color',[red green blue])
    patient=statedges_soz.patientvector(i);
end;
title('SOZ in peak height np p')

% Pair wise compariosn offset
% in node
patient=statedges_soz.patientvector(i);
red=0;
green=1;
blue=.5;
figure
hold on
for i=1:29
    new_patient=statedges_soz.patientvector(i);
    if new_patient~=patient
        red=red+.16;
        green=green-.16;
        blue=blue+.08;
    end;
    y=[statedges_soz.ai_np_aperiodic(i,1) statedges_soz.ai_p_aperiodic(i,1)];
    x=[1 2];
    plot(x,y,'linewidth',1,'color',[red green blue])
    patient=statedges_soz.patientvector(i);
end;
title('SOZ in aperiodic offset np p')

% Pair wise compariosn exponent
% in node
patient=statedges_soz.patientvector(i);
red=0;
green=1;
blue=.5;
figure
hold on
for i=1:29
    new_patient=statedges_soz.patientvector(i);
    if new_patient~=patient
        red=red+.16;
        green=green-.16;
        blue=blue+.08;
    end;
    y=[statedges_soz.ai_np_aperiodic(i,2) statedges_soz.ai_p_aperiodic(i,2)];
    x=[1 2];
    plot(x,y,'linewidth',1,'color',[red green blue])
    patient=statedges_soz.patientvector(i);
end;
title('SOZ in aperiodic exponent np p')

% Pair wise compariosn frequency
% in node
patient=statedges_soz.patientvector(i);
red=0;
green=1;
blue=.5;
figure
hold on
for i=1:29
    new_patient=statedges_soz.patientvector(i);
    if new_patient~=patient
        red=red+.16;
        green=green-.16;
        blue=blue+.08;
    end;
    y=[statedges_soz.ai_np_peak(i,1) statedges_soz.ai_p_peak(i,1)];
    x=[1 2];
    plot(x,y,'linewidth',1,'color',[red green blue])
    patient=statedges_soz.patientvector(i);
end;
title('SOZ in peak freequency np p')

% Pair wise compariosn peak height
% in node
patient=statedges_soz.patientvector(i);
red=0;
green=1;
blue=.5;
figure
hold on
for i=1:29
    new_patient=statedges_soz.patientvector(i);
    if new_patient~=patient
        red=red+.16;
        green=green-.16;
        blue=blue+.08;
    end;
    y=[statedges_soz.ai_np_peak(i,2) statedges_soz.ai_p_peak(i,2)];
    x=[1 2];
    plot(x,y,'linewidth',1,'color',[red green blue])
    patient=statedges_soz.patientvector(i);
end;
title('SOZ in peak height np p')

% p_valsx=[]
% [h,p_valsx(1,1),ci,stats] = ttest(statedges_soz.ao_np_aperiodic(:,1), statedges_soz.ao_p_aperiodic(:,1))
% [h,p_valsx(1,2),ci,stats] = ttest(statedges_soz.ai_np_aperiodic(:,1), statedges_soz.ai_p_aperiodic(:,1))
% [h,p_valsx(1,3),ci,stats] = ttest(statedges_soz.ai_np_aperiodic(:,2), statedges_soz.ai_p_aperiodic(:,2))
% [h,p_valsx(1,4),ci,stats] = ttest(statedges_soz.ao_np_aperiodic(:,2), statedges_soz.ao_p_aperiodic(:,2))
% [h,p_valsx(1,5),ci,stats] = ttest(statedges_soz.ao_np_peak(:,1), statedges_soz.ao_p_peak(:,1))
% [h,p_valsx(1,6),ci,stats] = ttest(statedges_soz.ai_np_peak(:,1), statedges_soz.ai_p_peak(:,1))
% [h,p_valsx(1,7),ci,stats] = ttest(statedges_soz.ao_np_aperiodic(:,1), statedges_soz.ai_np_aperiodic(:,1))
% [h,p_valsx(1,8),ci,stats] = ttest(statedges_soz.ao_p_aperiodic(:,1), statedges_soz.ai_p_aperiodic(:,1))
% [h,p_valsx(1,9),ci,stats] = ttest(statedges_soz.ao_np_aperiodic(:,2), statedges_soz.ai_np_aperiodic(:,2))
% [h,p_valsx(1,10),ci,stats] = ttest(statedges_soz.ao_p_aperiodic(:,2), statedges_soz.ai_p_aperiodic(:,2))
% [h,p_valsx(1,11),ci,stats] = ttest(statedges_soz.ao_np_peak(:,1), statedges_soz.ai_p_peak(:,1))
% [h,p_valsx(1,12),ci,stats] = ttest(statedges_soz.ao_p_peak(:,1), statedges_soz.ai_p_peak(:,1))
% [h, crit_p, adj_ci_cvrg, adj_p_x]=fdr_bh(p_valsx);

statedges_soz=statedges;
statedges_soz(soz_indices,:)=[];
p_vals=[];
t_values=[];
[h,p_vals(1,1),ci,stats] = ttest(statedges_soz.ao_np_aperiodic(:,1), statedges_soz.ao_p_aperiodic(:,1));
t_values(1,1)=stats.tstat;
[h,p_vals(1,2),ci,stats] = ttest(statedges_soz.ai_np_aperiodic(:,1), statedges_soz.ai_p_aperiodic(:,1));
t_values(1,2)=stats.tstat;
[h,p_vals(1,3),ci,stats] = ttest(statedges_soz.ai_np_aperiodic(:,2), statedges_soz.ai_p_aperiodic(:,2));
t_values(1,3)=stats.tstat;
[h,p_vals(1,4),ci,stats] = ttest(statedges_soz.ao_np_aperiodic(:,2), statedges_soz.ao_p_aperiodic(:,2));
t_values(1,4)=stats.tstat;
[h,p_vals(1,5),ci,stats] = ttest(statedges_soz.ao_np_peak(:,1), statedges_soz.ao_p_peak(:,1));
t_values(1,5)=stats.tstat;
[h,p_vals(1,6),ci,stats] = ttest(statedges_soz.ai_np_peak(:,1), statedges_soz.ai_p_peak(:,1));
t_values(1,6)=stats.tstat;
[h,p_vals(1,7),ci,stats] = ttest(statedges_soz.ao_np_peak(:,2), statedges_soz.ao_p_peak(:,2));
t_values(1,7)=stats.tstat;
[h,p_vals(1,8),ci,stats] = ttest(statedges_soz.ai_np_peak(:,2), statedges_soz.ai_p_peak(:,2));
t_values(1,8)=stats.tstat;
[h, crit_p, adj_ci_cvrg, adj_p]=fdr_bh(p_vals);

statss=[p_vals' t_values' adj_p'];
xlswrite('nsozpandnpcomparison.xls',statss)

p_vals_c=[];
t_values=[];
[h,p_vals_c(1,1),ci,stats] = ttest(statedges_soz.abo_np_aperiodic(:,1), statedges_soz.abo_p_aperiodic(:,1));
t_values(1,1)=stats.tstat;
[h,p_vals_c(1,2),ci,stats] = ttest(statedges_soz.abi_np_aperiodic(:,1), statedges_soz.abi_p_aperiodic(:,1));
t_values(1,2)=stats.tstat;
[h,p_vals_c(1,3),ci,stats] = ttest(statedges_soz.abi_np_aperiodic(:,2), statedges_soz.abi_p_aperiodic(:,2));
t_values(1,3)=stats.tstat;
[h,p_vals_c(1,4),ci,stats] = ttest(statedges_soz.abo_np_aperiodic(:,2), statedges_soz.abo_p_aperiodic(:,2));
t_values(1,4)=stats.tstat;
[h,p_vals_c(1,5),ci,stats] = ttest(statedges_soz.abo_np_peak(:,1), statedges_soz.abo_p_peak(:,1));
t_values(1,5)=stats.tstat;
[h,p_vals_c(1,6),ci,stats] = ttest(statedges_soz.abi_np_peak(:,1), statedges_soz.abi_p_peak(:,1));
t_values(1,6)=stats.tstat;
[h,p_vals_c(1,7),ci,stats] = ttest(statedges_soz.abo_np_peak(:,2), statedges_soz.abo_p_peak(:,2));
t_values(1,7)=stats.tstat;
[h,p_vals_c(1,8),ci,stats] = ttest(statedges_soz.abi_np_peak(:,2), statedges_soz.abi_p_peak(:,2));
t_values(1,8)=stats.tstat;
[h, crit_p, adj_ci_cvrg, adj_p_c]=fdr_bh(p_vals_c);

statss=[p_vals_c' t_values' adj_p_c'];
xlswrite('nsozpandnpcomparisonbaseline.xls',statss)

% Pair wise compariosn offset
% out node
patient=statedges_soz.patientvector(1);
red=0;
green=1;
blue=.5;
figure
hold on
for i=1:35
    new_patient=statedges_soz.patientvector(i);
    if new_patient~=patient
        red=red+.09;
        green=green-.09;
        blue=blue+.06;
    end;
    y=[statedges_soz.ao_np_aperiodic(i,1) statedges_soz.ao_p_aperiodic(i,1)];
    x=[1 2];
    plot(x,y,'linewidth',1,'color',[red green blue])
    patient=statedges_soz.patientvector(i);
end;
title('NSOZ out aperiodic offset np p')

% Pair wise compariosn exponent
% out node
patient=statedges_soz.patientvector(i);
red=0;
green=1;
blue=.5;
figure
hold on
for i=1:35
    new_patient=statedges_soz.patientvector(i);
    if new_patient~=patient
        red=red+.09;
        green=green-.09;
        blue=blue+.06;
    end;
    y=[statedges_soz.ao_np_aperiodic(i,2) statedges_soz.ao_p_aperiodic(i,2)];
    x=[1 2];
    plot(x,y,'linewidth',1,'color',[red green blue])
    patient=statedges_soz.patientvector(i);
end;
title('NSOZ out aperiodic exponent np p')

% Pair wise compariosn frequency
% out node
patient=statedges_soz.patientvector(i);
red=0;
green=1;
blue=.5;
figure
hold on
for i=1:35
    new_patient=statedges_soz.patientvector(i);
    if new_patient~=patient
        red=red+.09;
        green=green-.09;
        blue=blue+.06;
    end;
    y=[statedges_soz.ao_np_peak(i,1) statedges_soz.ao_p_peak(i,1)];
    x=[1 2];
    plot(x,y,'linewidth',1,'color',[red green blue])
    patient=statedges_soz.patientvector(i);
end;
title('NSOZ out peak freequency np p')

% Pair wise compariosn peak height
% out node
patient=statedges_soz.patientvector(i);
red=0;
green=1;
blue=.5;
figure
hold on
for i=1:35
    new_patient=statedges_soz.patientvector(i);
    if new_patient~=patient
        red=red+.09;
        green=green-.09;
        blue=blue+.06;
    end;
    y=[statedges_soz.ao_np_peak(i,2) statedges_soz.ao_p_peak(i,2)];
    x=[1 2];
    plot(x,y,'linewidth',1,'color',[red green blue])
    patient=statedges_soz.patientvector(i);
end;
title('NSOZ in peak height np p')

% Pair wise compariosn offset
% in node
patient=statedges_soz.patientvector(i);
red=0;
green=1;
blue=.5;
figure
hold on
for i=1:35
    new_patient=statedges_soz.patientvector(i);
    if new_patient~=patient
        red=red+.09;
        green=green-.09;
        blue=blue+.06;
    end;
    y=[statedges_soz.ai_np_aperiodic(i,1) statedges_soz.ai_p_aperiodic(i,1)];
    x=[1 2];
    plot(x,y,'linewidth',1,'color',[red green blue])
    patient=statedges_soz.patientvector(i);
end;
title('NSOZ in aperiodic offset np p')

% Pair wise compariosn exponent
% in node
patient=statedges_soz.patientvector(i);
red=0;
green=1;
blue=.5;
figure
hold on
for i=1:35
    new_patient=statedges_soz.patientvector(i);
    if new_patient~=patient
        red=red+.09;
        green=green-.09;
        blue=blue+.06;
    end;
    y=[statedges_soz.ai_np_aperiodic(i,2) statedges_soz.ai_p_aperiodic(i,2)];
    x=[1 2];
    plot(x,y,'linewidth',1,'color',[red green blue])
    patient=statedges_soz.patientvector(i);
end;
title('NSOZ in aperiodic exponent np p')

% Pair wise compariosn frequency
% in node
patient=statedges_soz.patientvector(i);
red=0;
green=1;
blue=.5;
figure
hold on
for i=1:35
    new_patient=statedges_soz.patientvector(i);
    if new_patient~=patient
        red=red+.09;
        green=green-.09;
        blue=blue+.06;
    end;
    y=[statedges_soz.ai_np_peak(i,1) statedges_soz.ai_p_peak(i,1)];
    x=[1 2];
    plot(x,y,'linewidth',1,'color',[red green blue])
    patient=statedges_soz.patientvector(i);
end;
title('NSOZ in peak freequency np p')

% Pair wise compariosn peak height
% in node
patient=statedges_soz.patientvector(i);
red=0;
green=1;
blue=.5;
figure
hold on
for i=1:35
    new_patient=statedges_soz.patientvector(i);
    if new_patient~=patient
        red=red+.09;
        green=green-.09;
        blue=blue+.06;
    end;
    y=[statedges_soz.ai_np_peak(i,2) statedges_soz.ai_p_peak(i,2)];
    x=[1 2];
    plot(x,y,'linewidth',1,'color',[red green blue])
    patient=statedges_soz.patientvector(i);
end;
title('NSOZ in peak height np p')
