[idx]=find(isnan(output_t_max.maxUP)==1);
output_t_max2=output_t_max;
output_t_max2(idx,:)=[];
UPcalc=output_t_max2.DOWN_a;
DOWNdiff=[];
for i=1:39
        DOWNdiff(i)=subrad_sw(output_t_max2.maxUP(i),UPcalc(i));
end;
DOWNdiff=abs(DOWNdiff);
[mu ul ll] = circ_mean(DOWNdiff');