
%tstart=26500001
%tstart=2350000+50000;interesting
tstart=(2350000+15000+15000+(5000*5)) %best
tstart=round((tstart/4),0)
idx=[tstart:1:((tstart-1)+(5*500))];
time=[(1/500):(1/500):5];
%eegchan 9 RAH 10 REC
eegchan=9;
yval=eeg_data(eegchan,idx); %downsapled
%yval=zSlow(eegchan,idx);
phase_rah=(atan2(imag(hSlow(eegchan,idx)),real(hSlow(eegchan,idx))));
figure
yyaxis left
plot(yval)
hold on
yyaxis right
plot(phase_rah)

%color_line(time,yval,C)
figure
z=phase_rah;
patch([time nan],[yval nan],[z nan],[z nan], 'edgecolor', 'interp'); 
colorbar;colormap("hsv");
hold on
cmap=hsv(360);
A=[16:31];
for j=1:16
    temp=spike.raster(A(j),tstart:(tstart+5*2000));
    [spiketimes]=find(temp==1);
    j
    numel(spiketimes)
    inputphase=ceil((spiketimes/4));
    phases=phase_rah(inputphase);
    [idx2]=find(phases<0);
    phases(idx2)=phases(idx2)+(2*pi());
    phases=rad2deg(phases);
    phases=floor(phases)+1;
for i=1:numel(spiketimes)
          x=[(spiketimes(i)*0.0005) (spiketimes(i)*0.0005)];
          y=[(-400-(40*j)+15) (-400-(40*j)-15)];
          phases(i)=phases(i)-180;
          if phases(i)<0
              phases(i)=phases(i)+360;
          end;
          if phases(i)>360
              phases(i)=360;
          end;
          if phases(i)<1
              phases(i)=1;
          end;
          c=cmap(phases(i),:);
          plot(x,y,'linewidth',1,'Color',c);
    end;
end;

%RA

%tstart=26500001
%tstart=2350000+50000;interesting
tstart=(2350000+15000+15000+(5000*5)) %best
tstart=round((tstart/4),0)
idx=[tstart:1:((tstart-1)+(5*500))];
time=[(1/500):(1/500):5];
%eegchan 9 RAH 10 REC
eegchan=7;
yval=eeg_data(eegchan,idx); %downsapled
%yval=zSlow(eegchan,idx);
phase_rah=(atan2(imag(hSlow(eegchan,idx)),real(hSlow(eegchan,idx))));
figure
yyaxis left
plot(yval)
hold on
yyaxis right
plot(phase_rah)

%color_line(time,yval,C)
figure
z=phase_rah;
patch([time nan],[yval nan],[z nan],[z nan], 'edgecolor', 'interp'); 
colorbar;colormap("hsv");
hold on
cmap=hsv(360);
A=[1:9];
for j=1:9
    temp=spike.raster(A(j),tstart:(tstart+5*2000));
    [spiketimes]=find(temp==1);
    j
    numel(spiketimes)
    inputphase=round((spiketimes/4),0);
    phases=phase_rah(inputphase);
    [idx2]=find(phases<0);
    phases(idx2)=phases(idx2)+(2*pi());
    phases=rad2deg(phases);
    phases=floor(phases)+1;
for i=1:numel(spiketimes)
          x=[(spiketimes(i)*0.0005) (spiketimes(i)*0.0005)];
          y=[(-400-(40*j)+15) (-400-(40*j)-15)];
          phases(i)=phases(i)-180;
          if phases(i)<0
              phases(i)=phases(i)+360;
          end;
          if phases(i)>360
              phases(i)=360;
          end;
          if phases(i)<1
              phases(i)=1;
          end;
          c=cmap(phases(i),:);
          plot(x,y,'linewidth',1,'Color',c);
    end;
end;
