function dataout = main_functional_fr(RESP) 
% 
% I think I can use a measure like path length for the global network to compare across patients in the functional connectivity analysis. 
% Another analysis I should do is to compare centrality or hubs.
% I can do this analysis at the electrode level, and ask if their is a difference in hubness for all electrodes, 
% SOZ electrodes, and non-SOZ electrodes in classifying non-reponders.
% 
server='localhost';
username='admin';
password='';
dbname='deckard_new';
port=27017;
conn = mongo(server,port,dbname,'UserName',username,'Password',password);
collection = "HFOs";

% For each subject
% 
% Identify all the unique electrodes in the HFO database, identify all the unique electrodes in the Electrode database. Merge unique electrodes
% Query MNI coordinates for each unique electrode in HFO database, and Electrode database. If not found in one, use the other. If MNI coordinates do not exist, remove electrode.
% Create two adjacency matrix for all electrodes by calculating geometric distance between the electrodes
% Query SOZ electrodes in the HFO database, Query SOZ electrodes in the Electrode database. Merge unique SOZ electrodes.
% For adjacency matrix one, delete all non-SOZ electrodes.
% Query HFO database for electrodes with total fRonO (>350 Hz) > 0, query HFO database for electrodes with total fRonS (>350 Hz) > 0. Merge these electrodes
% For adjacency matrix two, delete all non-fast ripple electrodes
% Query HFO database for number of blocks, use block number to calculate the fast ripple (>350 Hz) rate
% Duplicate adjacency matrix two creating adjacency matrix three and multiply geometric distance by the respective inverse fast ripple rates in each electrode pair.
% Calculate the distance for the three adjacency matrices

lambda=[];         
efficiency=[];     
radius=[];         
diameter=[];

w_lambda=[];         
w_efficiency=[];     
w_radius=[];         
w_diameter=[];

is=[];
os=[];
strength=[];
soz_array=[];
patient_array=[];

% create distance array
for i=1:numel(RESP)
    x=[];
    y=[];
    z=[];
    deleted_electrodes=[];
    test_query=['{"patient_id":"' RESP{i} '"}'];
    electrodes = distinct(conn,collection,"electrode",'Query',test_query);
    collection = "Electrodes";
    electrodes_2 = distinct(conn,collection,"electrode",'Query',test_query);
    total_electrodes=[electrodes electrodes_2];
    unique_electrodes=unique(total_electrodes);
  for j=1:numel(unique_electrodes)
      collection = "HFOs";
      test_query=['{"patient_id":"' RESP{i} '","electrode":"' unique_electrodes{j} '"}'];
      x_temp = distinct(conn,collection,"x",'Query',test_query);
      x_temp=cell2mat(x_temp);
      if ~isempty(x_temp)
          x(j)=x_temp(1);          
          y_temp = distinct(conn,collection,"y",'Query',test_query);
          y_temp = cell2mat(y_temp);
          y(j)=y_temp(1);
          z_temp = distinct(conn,collection,"z",'Query',test_query);
          z_temp = cell2mat(z_temp);
          z(j)=z_temp(1); 
      else
         collection = "Electrodes";
         x_temp = distinct(conn,collection,"x",'Query',test_query);
         x_temp(cellfun(@ischar,x_temp)) = {nan};
         x_temp = cell2mat(x_temp);         
         if isempty(x_temp)
             edited_unique_electrodes=unique_electrodes;
             deleted_electrodes=[deleted_electrodes j];
             x(j)=NaN;
             y(j)=NaN;
             z(j)=NaN;
         else
             x(j)=x_temp(1);
             y_temp = distinct(conn,collection,"y",'Query',test_query);
             y_temp(cellfun(@ischar,y_temp)) = {nan};
             y_temp = cell2mat(y_temp);
             y(j)=y_temp(1);
             z_temp = distinct(conn,collection,"z",'Query',test_query);
             z_temp(cellfun(@ischar,z_temp)) = {nan};
             z_temp = cell2mat(z_temp);
             z(j)=z_temp(1);
         end;
      end;  
       if x(j) == -1
         collection = "Electrodes";
         x_temp = distinct(conn,collection,"x",'Query',test_query);
         x_temp = cell2mat(x_temp);
         x(j)=x_temp(1);
         y_temp = distinct(conn,collection,"y",'Query',test_query);
         y_temp = cell2mat(y_temp);
         y(j)=y_temp(1);
         z_temp = distinct(conn,collection,"z",'Query',test_query);
         z_temp = cell2mat(z_temp);
         z(j)=z_temp(1);
       end;
       if x(j) == -1
           deleted_electrodes=[deleted_electrodes j];
           x(j)=NaN;
           y(j)=NaN;
           z(j)=NaN;
       end;
  end; 
  unique_electrodes(deleted_electrodes)=[];
  x(deleted_electrodes)=[];
  y(deleted_electrodes)=[];
  z(deleted_electrodes)=[];
  distance_matrix=inf(numel(unique_electrodes), numel(unique_electrodes));
  for j=1:numel(unique_electrodes)
    for k=1:numel(unique_electrodes)
        distance_matrix(j,k)=sqrt(((x(j)-x(k))^2)+((y(j)-y(k))^2)+((z(j)-z(k))^2));
    end;
  end;
  
  % find electrodes that are in the SOZ
  for j=1:numel(unique_electrodes)
      test_query=['{"patient_id":"' RESP{i} '","electrode":"' unique_electrodes{j} '"}'];
      collection = "HFOs";
      soz = distinct(conn,collection,"soz",'Query',test_query);
      soz=cell2mat(soz);
      if ~isempty(soz)
      soz=str2double(soz);
      end;
      if ~isempty(soz)
      soz=soz(1);
      else
      collection = "Electrodes";
      soz = distinct(conn,collection,"soz",'Query',test_query);      
      soz=cell2mat(soz);
      if ~isempty(soz)
      soz=str2double(soz);
      end;
      soz=soz(1);
      end;
      if soz == 0
          collection = "Electrodes";
          soz = distinct(conn,collection,"soz",'Query',test_query);
          soz=cell2mat(soz);
          if ~isempty(soz)
          soz=str2double(soz);
          end;
          soz=soz(1);
      end;
      if soz == 0
          soz_array=[soz_array 0];
          patient_array=[patient_array i];
      else
          soz_array=[soz_array 1];
          patient_array=[patient_array i];
      end;
  end;      
 
 fripple_dmi_matrix=inf(numel(unique_electrodes), numel(unique_electrodes));
 fripple_wmi_matrix=inf(numel(unique_electrodes), numel(unique_electrodes));
 fripple_mi_matrix=zeros(numel(unique_electrodes), numel(unique_electrodes));
 % Find number of file blocks
 collection = "HFOs";
 test_query=['{"patient_id":"' RESP{i} '"}'];
 blocks=distinct(conn, collection, 'file_block','query',test_query);
 if iscell(blocks)
     blocks=cell2mat(blocks);
 else
     blocks=cellfun(@str2num, blocks);
 end;
 
 for j=1:numel(unique_electrodes)
 in=[];    
 in_frono=[];  
 for z=1:numel(blocks)
     test_query=['{"patient_id":"' RESP{i} '","electrode":"' unique_electrodes{j} '","file_block":"' num2str(blocks(z)) '", "type":"' num2str(4) '","freq_pk": {$gt:350} }'];
     in_t=distinct(conn,collection,'start_t','query',test_query);
     in_t=cell2mat(in_t);
     if z == 1
         in_frono = in_t;
     else 
         in_t=(in_t+(600*(z-1)));
         in_frono = [in_frono in_t];
     end;
 end;    
 
 in_frons=[];  
 for z=1:numel(blocks)
     test_query=['{"patient_id":"' RESP{i} '","electrode":"' unique_electrodes{j} '","file_block":"' num2str(blocks(z)) '", "type":"' num2str(5) '","freq_pk": {$gt:350} }'];
     in_t=distinct(conn,collection,'start_t','query',test_query);
     in_t=cell2mat(in_t);
     if z == 1
         in_frons = in_t;
     else 
         in_t=(in_t+(600*(z-1)));
         in_frons = [in_frons in_t];
     end;
 end;    
 
 in = [in_frono in_frons];
 in = sort(in,'ascend');
 if numel(in) == 0
   for k=1:numel(unique_electrodes)
      fripple_dmi_matrix(j,k)=inf;
      fripple_wmi_matrix(j,k)=inf;
      fripple_mi_matrix(j,k)=0;
  end;
 else     
  for k=1:numel(unique_electrodes)
    out=[];  
    out_frono=[];  
       for z=1:numel(blocks)
         test_query=['{"patient_id":"' RESP{i} '","electrode":"' unique_electrodes{k} '","file_block":"' num2str(blocks(z)) '", "type":"' num2str(4) '","freq_pk": {$gt:350} }'];
         out_t=distinct(conn,collection,'start_t','query',test_query);
         out_t=cell2mat(out_t);
       if z == 1
         out_frono = out_t;
       else 
         out_t=(out_t+(600*(z-1)));
         out_frono = [out_frono out_t];
     end;
 end;    
 
 out_frons=[];  
 for z=1:numel(blocks)
     test_query=['{"patient_id":"' RESP{i} '","electrode":"' unique_electrodes{k} '","file_block":"' num2str(blocks(z)) '", "type":"' num2str(5) '","freq_pk": {$gt:350} }'];
     out_t=distinct(conn,collection,'start_t','query',test_query);
     out_t=cell2mat(out_t);
     if z == 1
         out_frons = out_t;
     else 
         out_t=(out_t+(600*(z-1)));
         out_frons = [out_frons out_t];
     end;
 end;    
 
 out = [out_frono out_frons];
 out = sort(out,'ascend');
 
 if numel(out) == 0
     fripple_dmi_matrix(j,k)=inf;
     fripple_wmi_matrix(j,k)=inf;
     fripple_mi_matrix(j,k)=0;
 else
     mi = AIMIE(in,out);
     if isnan(mi)
        fripple_dmi_matrix(j,k)=inf;
        fripple_wmi_matrix(j,k)=inf;
        fripple_mi_matrix(j,k)=0;
     else
     if mi==0
        fripple_dmi_matrix(j,k)=inf;
        fripple_wmi_matrix(j,k)=inf;
        fripple_mi_matrix(j,k)=0;
     else   
     fripple_dmi_matrix(j,k)=(1/mi);
     fripple_wmi_matrix(j,k)=distance_matrix(j,k)*(mi);
     fripple_mi_matrix(j,k)=mi;
     end;
     end;     
 end;
 if j==k
     fripple_dmi_matrix(j,k)=inf;
     fripple_wmi_matrix(j,k)=inf;
     fripple_mi_matrix(j,k)=0;
 end;    
 end;
 end;
 end;
i
[lambda(i),efficiency(i),~,radius(i),diameter(i)] = charpath(fripple_dmi_matrix,0,0);
[w_lambda(i),w_efficiency(i),~,w_radius(i),w_diameter(i)] = charpath(fripple_wmi_matrix,0,0);
[is_t, os_t, strength_t]=strengths_dir(fripple_mi_matrix);
is = [is, is_t];
os = [os, os_t];
strength = [strength strength_t];
i
end;

dataout.lambda=lambda';         
dataout.efficiency=efficiency';     
dataout.radius=radius';         
dataout.diameter=diameter';

dataout.w_lambda=w_lambda';         
dataout.w_efficiency=w_efficiency';     
dataout.w_radius=w_radius';         
dataout.w_diameter=w_diameter';

dataout.is=is';
dataout.os=os';
dataout.strenth=strength';
dataout.soz_array=soz_array';
dataout.patient_array=patient_array';
