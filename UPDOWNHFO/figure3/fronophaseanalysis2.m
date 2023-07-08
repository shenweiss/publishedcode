% fRonO phase analysis

%%
slow=[];
for i=1:numel(ieegslowang)
    temp=ieegslowang{i};
    slow=horzcat(slow,temp);
end;
[idx]=find(slow==0);
slow(idx)=[];
[idx]=find(slow<0);
slow(idx)=slow(idx)+(2*pi());
slow=unique(slow)
figure
[t, r] = rose(slow, 72); % 100 is desired number of bins. Set as needed
r = r./numel(slow); % normalize
polar(t, r) % polar plot
title('all fRonO AP-slow')

slow=[];
[idx]=find(MDLdata.preSPIKE==1);
ieegslowangt=ieegslowang(idx);
for i=1:numel(ieegslowangt)
    temp=ieegslowangt{i};
    slow=horzcat(slow,temp);
end;
[idx]=find(slow==0);
slow(idx)=[];
[idx]=find(slow<0);
slow(idx)=slow(idx)+(2*pi());
slow=unique(slow)
figure
[t, r] = rose(slow, 18); % 100 is desired number of bins. Set as needed
r = r./numel(slow); % normalize
polar(t, r) % polar plot
title(['pre-Spike fRonO AP-slow'])

figure
[t, r] = rose(MDLdata.slowangle, 72); % 100 is desired number of bins. Set as needed
r = r./numel(MDLdata.slowangle); % normalize
polar(t, r) % polar plot
title('all fRonO phasor-slow')

[idx]=find(MDLdata.preSPIKE==1);
figure
[t, r] = rose(MDLdata.slowangle(idx), 18); % 100 is desired number of bins. Set as needed
r = r./numel(MDLdata.slowangle(idx)); % normalize
polar(t, r) % polar plot
title('pre-Spike fRonO phasor-slow')

ieegslowphasor=MDLdata.slowangle;
for i=1:numel(ieegslowphasor)
       DOWN_UP(i)=0;
       if ieegslowphasor(i) > pi()/2
                if ieegslowphasor(i) < pi()
                       DOWN_UP(i)=1;
                end;
       end;
       if ieegslowphasor(i) > -pi()
                if ieegslowphasor(i) < -pi()/2
                       DOWN_UP(i)=1;
                end;
       end;
end;

figure
time=[(2/84):(2/84):2];
[int1]=find(DOWN_UP==1);
[int2]=find(DOWN_UP==0);
rasterDU=masterraster(int1,:);
SEM = std(rasterDU)/sqrt(length(rasterDU));               % Standard Error
ts = tinv([0.025  0.975],length(rasterDU)-1);      % T-Score
CI_1 = mean(rasterDU) + ts(1)*SEM;              
CI_2 = mean(rasterDU) + ts(2)*SEM;
plot(time,mean(rasterDU),'black','linewidth',2)
hold on
plot(time,CI_1,'black','linewidth',0.25)
plot(time,CI_2,'black','linewidth',0.25)
rasterUD=masterraster(int2,:);
SEM = std(rasterUD)/sqrt(length(rasterUD));               % Standard Error
ts = tinv([0.025  0.975],length(rasterUD)-1);      % T-Score
CI_1 = mean(rasterUD) + ts(1)*SEM;              
CI_2 = mean(rasterUD) + ts(2)*SEM;
plot(time,mean(rasterUD),'red','linewidth',2)
hold on
plot(time,CI_1,'black','linewidth',0.25)
plot(time,CI_2,'black','linewidth',0.25)
title('fRonO black DOWN, red UP')

xlim([0.1,1.9])