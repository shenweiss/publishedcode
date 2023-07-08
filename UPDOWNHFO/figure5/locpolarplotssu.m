% location phase plots
clear
load('eRONOdataoutV1.mat')
power_quantile=quantile(MDLdata.power,125);
[idx_power]=find(MDLdata.power>power_quantile(25));

%%
slow=[];
[idx]=find(MDLdata.soz==0);
[int]=intersect(idx,idx_power);
[idx2]=find(MDLdata.loc==2);
[int2]=intersect(int,idx2);
ieegslowangsoz=ieegslowang(int2);
for i=1:numel(ieegslowangsoz)
    temp=ieegslowangsoz{i};
    slow=horzcat(slow,temp);
end;
[idx]=find(slow==0);
slow(idx)=[];
[idx]=find(slow<0);
slow(idx)=slow(idx)+(2*pi());
slow=unique(slow);
save('hippnsoz.mat','slow')
figure
[t, r_hippnsoz] = rose(slow, 18); % 100 is desired number of bins. Set as needed
r_hippnsoz = r_hippnsoz./numel(slow); % normalize
figure
polar(t, r_hippnsoz) % polar plot
title('hipp nsoz')
%%
slow=[];
[idx]=find(MDLdata.soz==1);
[int]=intersect(idx,idx_power);
[idx2]=find(MDLdata.loc==2);
[int2]=intersect(int,idx2);
ieegslowangsoz=ieegslowang(int2);
for i=1:numel(ieegslowangsoz)
    temp=ieegslowangsoz{i};
    slow=horzcat(slow,temp);
end;
[idx]=find(slow==0);
slow(idx)=[];
[idx]=find(slow<0);
slow(idx)=slow(idx)+(2*pi());
slow=unique(slow);
save('hippsoz.mat','slow')
figure
[t, r_hippsoz] = rose(slow, 18); % 100 is desired number of bins. Set as needed
r_hippsoz = r_hippsoz./numel(slow); % normalize
figure
polar(t, r_hippsoz) % polar plot
title('hipp soz')
%%
slow=[];
[idx]=find(MDLdata.soz==0);
[int]=intersect(idx,idx_power);
MDLdata_t=MDLdata(int,:);
[int2]=intersect(int,idx2);
ieegslowangsoz=ieegslowang(int);
idx2=find(MDLdata_t.loc==2);
ieegslowangsoz(idx2)=[];
for i=1:numel(ieegslowangsoz)
    temp=ieegslowangsoz{i};
    slow=horzcat(slow,temp);
end;
[idx]=find(slow==0);
slow(idx)=[];
[idx]=find(slow<0);
slow(idx)=slow(idx)+(2*pi());
slow=unique(slow);
save('ehnsoz.mat','slow')
figure
[t, r_nonhippnsoz] = rose(slow, 18); % 100 is desired number of bins. Set as needed
r_nonhippnsoz = r_nonhippnsoz./numel(slow); % normalize
polar(t, r_nonhippnsoz) % polar plot
title('nonhipp nonsoz')
%%
slow=[];
[idx]=find(MDLdata.soz==1);
[int]=intersect(idx,idx_power);
[idx2]=[1:1:numel(MDLdata.soz)]';
[idx3]=find(MDLdata.loc==2);
idx2(idx3)=[];
[int2]=intersect(int,idx2);
ieegslowangsoz=ieegslowang(int2);
for i=1:numel(ieegslowangsoz)
    temp=ieegslowangsoz{i};
    slow=horzcat(slow,temp);
end;
[idx]=find(slow==0);
slow(idx)=[];
[idx]=find(slow<0);
slow(idx)=slow(idx)+(2*pi());
slow=unique(slow);
save('ehsoz.mat','slow')
figure
[t, r_nonhippsoz] = rose(slow, 18); % 100 is desired number of bins. Set as needed
r_nonhippsoz = r_nonhippsoz./numel(slow); % normalize
polar(t, r_nonhippsoz) % polar plot
title('nonhipp soz')

v=[2:4:72];
r_hippnsoz=r_hippnsoz(v)';
r_hippsoz=r_hippsoz(v)';
r_nonhippnsoz=r_nonhippnsoz(v)';
r_nonhippsoz=r_nonhippsoz(v)';
phase=[0:20:350]';
A=horzcat(phase,r_hippnsoz,r_hippsoz,r_nonhippnsoz,r_nonhippsoz);
save('Rlocdatanew.mat','A')

clear
load('eRONOdataoutV1.mat')
power_quantile=quantile(MDLdata.power,125);
[idx_power]=find(MDLdata.power>power_quantile(25));

%%
slow=[];
[idx]=find(MDLdata.soz==0);
[int]=intersect(idx,idx_power);
[idx2]=find(MDLdata.loc==2);
[int2]=intersect(int,idx2);
slow=MDLdata.slowangle(int2);
[idx]=find(slow==0);
slow(idx)=[];
[idx]=find(slow<0);
slow(idx)=slow(idx)+(2*pi());
slow=unique(slow);
save('hippnsozphasor.mat','slow')
figure
[t, r_hippnsoz] = rose(slow, 18); % 100 is desired number of bins. Set as needed
r_hippnsoz = r_hippnsoz./numel(slow); % normalize
figure
polar(t, r_hippnsoz) % polar plot
title('hipp nsoz')
%%
slow=[];
[idx]=find(MDLdata.soz==1);
[int]=intersect(idx,idx_power);
[idx2]=find(MDLdata.loc==2);
[int2]=intersect(int,idx2);
slow=MDLdata.slowangle(int2);
[idx]=find(slow==0);
slow(idx)=[];
[idx]=find(slow<0);
slow(idx)=slow(idx)+(2*pi());
slow=unique(slow);
save('hippsozphasor.mat','slow')
figure
[t, r_hippsoz] = rose(slow, 18); % 100 is desired number of bins. Set as needed
r_hippsoz = r_hippsoz./numel(slow); % normalize
figure
polar(t, r_hippsoz) % polar plot
title('hipp soz')
%%
slow=[];
[idx]=find(MDLdata.soz==0);
[int]=intersect(idx,idx_power);
[idx2]=[1:1:numel(MDLdata.soz)]';
[idx3]=find(MDLdata.loc==2);
idx2(idx3)=[];
[int2]=intersect(int,idx2);
slow=MDLdata.slowangle(int2);
[idx]=find(slow==0);
slow(idx)=[];
[idx]=find(slow<0);
slow(idx)=slow(idx)+(2*pi());
slow=unique(slow);
save('ehnsozphasor.mat','slow')
figure
[t, r_nonhippnsoz] = rose(slow, 18); % 100 is desired number of bins. Set as needed
r_nonhippnsoz = r_nonhippnsoz./numel(slow); % normalize
polar(t, r_nonhippnsoz) % polar plot
title('nonhipp nonsoz')
%%
slow=[];
[idx]=find(MDLdata.soz==1);
[int]=intersect(idx,idx_power);
[idx2]=[1:1:numel(MDLdata.soz)]';
[idx3]=find(MDLdata.loc==2);
idx2(idx3)=[];
[int2]=intersect(int,idx2);
slow=MDLdata.slowangle(int2);
[idx]=find(slow==0);
slow(idx)=[];
[idx]=find(slow<0);
slow(idx)=slow(idx)+(2*pi());
slow=unique(slow);
save('ehsozphasor.mat','slow')
figure
[t, r_nonhippsoz] = rose(slow, 18); % 100 is desired number of bins. Set as needed
r_nonhippsoz = r_nonhippsoz./numel(slow); % normalize
polar(t, r_nonhippsoz) % polar plot
title('nonhipp soz')

v=[2:4:72];
r_hippnsoz=r_hippnsoz(v)';
r_hippsoz=r_hippsoz(v)';
r_nonhippnsoz=r_nonhippnsoz(v)';
r_nonhippsoz=r_nonhippsoz(v)';
phase=[0:20:350]';
A=horzcat(phase,r_hippnsoz,r_hippsoz,r_nonhippnsoz,r_nonhippsoz);
save('Rlocdataphasornew.mat','A')
