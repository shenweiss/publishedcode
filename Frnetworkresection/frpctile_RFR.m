resect_fr=[];
tempvar=output_t.Var1;
tempvar2={''};
for i=1:numel(tempvar)
    tempvar2{i}=tempvar{i}{1};
end;
[C,IA,IC] = unique(tempvar2);

[IAsort,idx]=sort(IA,'ascend');
Cpat=C(idx);

for i=1:(numel(Cpat)-1)
    rates_percent=[];
    rate_table_temp=output_t.rates;
    rate_table_temp=rate_table_temp(IAsort(i):(IAsort(i+1)-1),:);
    resect_table_temp=output_t.Var4;
    resect_table_temp=resect_table_temp(IAsort(i):(IAsort(i+1)-1));
    fr_rates=rate_table_temp(:,5);
    rates_pct=prctile(fr_rates,99);
    rates_percent(:,1)=(fr_rates >= rates_pct(1));
    resect_table_array=[];
    for j=1:numel(resect_table_temp)
        if isnumeric(resect_table_temp{j})
            resect_table_array(j)=resect_table_temp{j};
        else
            resect_table_array(j)=str2num(resect_table_temp{j}{1});
        end;
    end;
    [C,IA,IB]=intersect(find(resect_table_array==1),find(rates_percent==1));
    if numel(C)<numel(find(rates_percent==1))
        resect_fr(i)=0;
    else
        resect_fr(i)=1;
    end;
end;
    rates_percent=[];
    rate_table_temp=output_t.rates;
    rate_table_temp=rate_table_temp(IAsort(i+1):numel(output_t.Var1),:);
    resect_table_temp=output_t.Var4;
    resect_table_temp=resect_table_temp(IAsort(i+1):numel(output_t.Var1));
    fr_rates=rate_table_temp(:,4)+rate_table_temp(:,5);
    rates_pct=prctile(fr_rates,99);
    rates_percent(:,1)=(fr_rates >= rates_pct(1));
    resect_table_array=[];
    for j=1:numel(resect_table_temp)
        if isnumeric(resect_table_temp{j})
            resect_table_array(j)=resect_table_temp{j};
        else
            resect_table_array(j)=str2num(resect_table_temp{j}{1});
        end;
    end;
    [C,IA,IB]=intersect(find(resect_table_array==1),find(rates_percent==1));
    if numel(C)<numel(find(rates_percent==1))
        resect_fr(i+1)=0;
    else
        resect_fr(i+1)=1;
    end;

SZFREE = [1	1	1	1	1	1	1	1	1	1	0	0	0	0	0	0	0	0	0	0	0	0	0];
RESP = [1	1	1	1	1	1	1	1	1	1	1	1	1	0	0	0	0	0	0	0	1	0	0];
TP=numel(intersect(find(resect_fr==1),find(SZFREE==1)));
FP=numel(intersect(find(resect_fr==0),find(SZFREE==1)));
TN=numel(intersect(find(resect_fr==0),find(SZFREE==0)));
FN=numel(intersect(find(resect_fr==1),find(SZFREE==0)));

TP_r=numel(intersect(find(resect_fr==1),find(RESP==1)));
FP_r=numel(intersect(find(resect_fr==0),find(RESP==1)));
TN_r=numel(intersect(find(resect_fr==0),find(RESP==0)));
FN_r=numel(intersect(find(resect_fr==1),find(RESP==0)));