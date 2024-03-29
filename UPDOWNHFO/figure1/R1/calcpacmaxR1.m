function [output_t_max] = calcpacmax(output_t)
patient={''};
electrode={''};
unitnum=[];
soz=[];
loc=[];
maxUP=[];
UP_p=[];
UP_z=[];
counter=0;
z=[];
p=[];
DOWN=[];
DOWN_a=[];
theta=[];
unitnum_t=[];
for i=1:numel(output_t(:,1))
if i>1
if ~strcmp(output_t.electrode{i},output_t.electrode{i-1})
   counter=counter+1;
   patient(counter)=id;
   electrode(counter)=electrode_t;
   soz(counter)=soz_t;
   loc(counter)=loc_t;
   [~,idx]=max(z);
   [smallp]=min(p);
   if smallp<1e-3
       unitnum(counter)=unitnum_t(idx);
       maxUP(counter)=theta(idx);
       UP_p(counter)=p(idx);
       UP_z(counter)=z(idx);
       DOWN_a(counter)=DOWN(idx);
   else
       unitnum(counter)=NaN;
       maxUP(counter)=NaN;
       UP_p(counter)=NaN;
       UP_z(counter)=NaN;
       DOWN_a(counter)=NaN;
   end;
   z=[];
   p=[];
   theta=[];
   unitnum_t=[];
end;
end;
id=output_t.patient(i);
electrode_t=output_t.electrode(i);
z=vertcat(z,output_t.UP_z(i));
p=vertcat(p,output_t.UP_p(i));
theta=vertcat(theta,output_t.maxUP(i));
unitnum_t=vertcat(unitnum_t,output_t.unitnum(i));
DOWN=vertcat(DOWN,output_t.DOWN(i));
soz_t=output_t.soz(i);
loc_t=output_t.loc(i);
end;
   counter=counter+1;
   patient(counter)=id;
   electrode(counter)=electrode_t;
   soz(counter)=soz_t;
   loc(counter)=loc_t;
   [~,idx]=max(z);
   [smallp]=min(p);
   if smallp<1e-3
       unitnum(counter)=unitnum_t(idx);
       maxUP(counter)=theta(idx);
       UP_p(counter)=p(idx);
       UP_z(counter)=z(idx);
       DOWN_a(counter)=DOWN(idx);
   else
       unitnum(counter)=NaN;
       maxUP(counter)=NaN;
       UP_p(counter)=NaN;
       UP_z(counter)=NaN;
       DOWN_a(counter)=NaN;
   end;

patient=patient';
electrode=electrode';
unitnum=unitnum';
soz=soz';
loc=loc';
maxUP=maxUP';
UP_p=UP_p';
UP_z=UP_z';
DOWN_a=DOWN_a';
output_t_max=table(patient,electrode,unitnum,soz,loc,maxUP,UP_p,UP_z,DOWN_a);