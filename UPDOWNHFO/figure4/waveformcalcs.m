function [halfwidth,troughtopeak] = waveformcalcs(spike,unitnum)
time=[0:(1/28000):((64/28000)-(1/28000))];
temp=spike.waveform(unitnum,:);
[minval,minidx]=min(temp);
temp2=diff(temp);
temp3=temp2(1:minidx-1);
[maxval1,maxidx1]=max(temp3);
maxval1_y=temp(maxidx1);
spike_h=maxval1-minval;
halfspike_h=spike_h/2;
temp4=temp(1:minidx);
temp4(find(temp4>0))=[];
[downminhalf,downminhalfidx]=min(abs((minval+halfspike_h-temp4)));
[downminhalfidx]=find(temp==temp4(downminhalfidx));
temp5=temp(minidx:47);
[maxval2,maxidx2]=max(temp5);
maxidx2=find(temp==temp5(maxidx2));
maxval1_y=temp(maxidx1);
temp6=temp(minidx:(minidx+numel(temp4)));
temp6(find(temp6>0))=[];
[downminhalfup,downminhalfupidx]=min(abs((minval+halfspike_h-temp6)));
[downminhalfupidx]=find(temp==temp6(downminhalfupidx));
halfwidth=time(downminhalfupidx)-time(downminhalfidx);
troughtopeak=time(maxidx2)-time(minidx);
