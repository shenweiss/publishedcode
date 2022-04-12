function dataout = main_nsoz_types(RESP) 

server='localhost';
username='admin';
password='';
dbname='deckard_new';
port=27017;
conn = mongo(server,port,dbname,'UserName',username,'Password',password);
collection = "HFOs";

r_radius_soz=[];
r_radius_fripple=[];
r_radius_fripple_rate=[];
r_radius_allfripple_rate=[];
r_radius_fripple_nsoz=[];
r_radius_fripple_rate_nsoz=[];
r_radius_allfripple_rate_nsoz=[];
r_radius_spikes_rate=[];
r_radius_spikes_rate_nsoz=[];
r_radius_rons_rate=[];
r_radius_rons_rate_nsoz=[];
r_radius_rono_rate=[];
r_radius_rono_rate_nsoz=[];

for i=1:numel(RESP)
    x=[];
    y=[];
    z=[];
    soz_matrix=[];
    fripple_matrix=[];
    fripple_rate_matrix=[];
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
         if numel(x_temp) > 1
         x_temp(cellfun(@ischar,x_temp)) = {nan};
         end;
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
             if numel(y_temp) > 1
             y_temp(cellfun(@ischar,y_temp)) = {nan};
             end;
             y_temp = cell2mat(y_temp);
             y(j)=y_temp(1);
             z_temp = distinct(conn,collection,"z",'Query',test_query);
             if numel(z_temp) > 1
             z_temp(cellfun(@ischar,z_temp)) = {nan};
             end;
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
  
  soz_matrix=distance_matrix;
  for j=1:numel(unique_electrodes)
      test_query=['{"patient_id":"' RESP{i} '","electrode":"' unique_electrodes{j} '"}'];
      collection = "HFOs";
      soz = distinct(conn,collection,"soz",'Query',test_query);
      soz=cell2mat(soz);
      if ~isempty(soz)       
          soz=str2double(soz);       
          soz=soz(1);
      else
      collection = "Electrodes";
      soz = distinct(conn,collection,"soz",'Query',test_query);
      soz=cell2mat(soz);
      if ~isempty(soz)       
          soz=str2double(soz);      
          soz=soz(1);
      end;
      end;
      if soz == 0
          collection = "Electrodes";
          soz = distinct(conn,collection,"soz",'Query',test_query);
          soz=cell2mat(soz);
          if ~isempty(soz)      soz=str2double(soz);    soz=soz(1);     end;   
      end;    
      if soz == 0
          for k=1:numel(unique_electrodes)
              soz_matrix(j,k)=inf;
          end;
      else
          for k=1:numel(unique_electrodes)
              test_query=['{"patient_id":"' RESP{i} '","electrode":"' unique_electrodes{k} '"}'];
              collection = "HFOs";
              soz = distinct(conn,collection,"soz",'Query',test_query);
              soz=cell2mat(soz);
              if ~isempty(soz)       soz=str2double(soz);                     
              soz=soz(1);
              else
                  collection = "Electrodes";
                  soz = distinct(conn,collection,"soz",'Query',test_query);
                  soz=cell2mat(soz);
                  if ~isempty(soz)       soz=str2double(soz);       end;
                  soz=soz(1);
              end;
                if soz == 0
                  collection = "Electrodes";
                  soz = distinct(conn,collection,"soz",'Query',test_query);
                  soz=cell2mat(soz);
                  if ~isempty(soz)       soz=str2double(soz);       end;
                  soz=soz(1);
                end;
             if soz == 0
                 soz_matrix(j,k)=inf;
             end;
          end; 
      end;
  end;
    
 
 fripple_matrix=distance_matrix;
 fripple_rate_matrix=distance_matrix;
 fripple_nsoz_matrix=distance_matrix;
 fripple_rate_nsoz_matrix=distance_matrix;
 fprintf('fripple ');
 collection = "HFOs";
 for j=1:numel(unique_electrodes)
   electrode1_soz=0;
   electrode2_soz=0;
     % find if soz electrode 1 is soz
              test_query=['{"patient_id":"' RESP{i} '","electrode":"' unique_electrodes{j} '"}'];
              collection = "HFOs";
              soz = distinct(conn,collection,"soz",'Query',test_query);
              soz=cell2mat(soz);
              if ~isempty(soz)       soz=str2double(soz);       end;
              if ~isempty(soz)
              soz=soz(1);
              else
                  collection = "Electrodes";
                  soz = distinct(conn,collection,"soz",'Query',test_query);
                  soz=cell2mat(soz);
                  if ~isempty(soz)       soz=str2double(soz);       end;
                  soz=soz(1);
              end;
                if soz == 0
                  collection = "Electrodes";
                  soz = distinct(conn,collection,"soz",'Query',test_query);
                  soz=cell2mat(soz);
                  if ~isempty(soz)       soz=str2double(soz);       end;
                  soz=soz(1);
                end;
             if soz == 0
                 electrode1_soz=0;
             else
                 electrode1_soz=1;
             end;
     % Find Events   
     collection = "HFOs";
     test_query=['{"patient_id":"' RESP{i} '","electrode":"' unique_electrodes{j} '","type":"' num2str(4) '","freq_pk": {$gt:350} }'];
     num_records = count(conn,collection,'Query',test_query);
     if num_records == 0
         test_query=['{"patient_id":"' RESP{i} '","electrode":"' unique_electrodes{j} '","type":"' num2str(5) '","freq_pk": {$gt:350} }'];
         num_records = count(conn,collection,'Query',test_query);
     end;
     if num_records == 0
         for k=1:numel(unique_electrodes)
             fripple_matrix(j,k)=inf;
             fripple_rate_matrix(j,k)=inf;
             fripple_nsoz_matrix(j,k)=inf;
             fripple_rate_nsoz_matrix(j,k)=inf;
         end;
     else
         for k=1:numel(unique_electrodes)
             electrode2_soz=0;
             
             % find if soz electrode 2 is soz
              test_query=['{"patient_id":"' RESP{i} '","electrode":"' unique_electrodes{k} '"}'];
              collection = "HFOs";
              soz = distinct(conn,collection,"soz",'Query',test_query);
              soz=cell2mat(soz);
              if ~isempty(soz)       soz=str2double(soz);       end;
              if ~isempty(soz)
              soz=soz(1);
              else
                  collection = "Electrodes";
                  soz = distinct(conn,collection,"soz",'Query',test_query);
                  soz=cell2mat(soz);
                  if ~isempty(soz)       soz=str2double(soz);       end;
                  soz=soz(1);
              end;
                if soz == 0
                  collection = "Electrodes";
                  soz = distinct(conn,collection,"soz",'Query',test_query);
                  soz=cell2mat(soz);
                  if ~isempty(soz)       soz=str2double(soz);       end;
                  soz=soz(1);
                end;
             if soz == 0
                 electrode2_soz=0;
             else
                 electrode2_soz=1;
             end;
             
             %find events
             collection = "HFOs";
             test_query=['{"patient_id":"' RESP{i} '","electrode":"' unique_electrodes{k} '","type":"' num2str(4) '","freq_pk": {$gt:350} }'];
              num_records = count(conn,collection,'Query',test_query);
                 if num_records == 0
                    test_query=['{"patient_id":"' RESP{i} '","electrode":"' unique_electrodes{k} '","type":"' num2str(5) '","freq_pk": {$gt:350} }'];
                    num_records = count(conn,collection,'Query',test_query);
                 end;
             if num_records == 0
               fripple_matrix(j,k)=inf;
               fripple_rate_matrix(j,k)=inf;
               fripple_nsoz_matrix(j,k)=inf;
               fripple_rate_nsoz_matrix(j,k)=inf;
             else                       
               test_query=['{"patient_id":"' RESP{i} '","electrode":"' unique_electrodes{j} '","type":"' num2str(4) '","freq_pk": {$gt:350} }'];
               frono_events = count(conn,collection,'Query',test_query);  
               test_query=['{"patient_id":"' RESP{i} '","electrode":"' unique_electrodes{j} '","type":"' num2str(5) '","freq_pk": {$gt:350} }'];
               frons_events = count(conn,collection,'Query',test_query); 
               test_query=['{"patient_id":"' RESP{i} '"}'];
               blocks = distinct(conn,collection,"file_block",'Query',test_query);
               electrode_1_fr_rate=(frono_events+frons_events)/(numel(blocks)*10);
               test_query=['{"patient_id":"' RESP{i} '","electrode":"' unique_electrodes{k} '","type":"' num2str(4) '","freq_pk": {$gt:350} }'];
               frono_events = count(conn,collection,'Query',test_query);  
               test_query=['{"patient_id":"' RESP{i} '","electrode":"' unique_electrodes{k} '","type":"' num2str(5) '","freq_pk": {$gt:350} }'];
               frons_events = count(conn,collection,'Query',test_query); 
               electrode_2_fr_rate=(frono_events+frons_events)/(numel(blocks)*10);
               fripple_rate_matrix(j,k)=fripple_rate_matrix(j,k)*((electrode_1_fr_rate+electrode_2_fr_rate)/2);
               if electrode1_soz == 1
                   fripple_nsoz_matrix(j,k)=inf;
                   fripple_rate_nsoz_matrix(j,k)=inf;
               else
                   if electrode2_soz == 1
                      fripple_nsoz_matrix(j,k)=inf;
                      fripple_rate_nsoz_matrix(j,k)=inf;
                   else    
                      fripple_rate_nsoz_matrix(j,k)=fripple_rate_nsoz_matrix(j,k)*((electrode_1_fr_rate+electrode_2_fr_rate)/2);
                   end;
               end;    
             end;
         end;
     end;
 end;
 
 fprintf('all fast ripple ');
 allfripple_rate_matrix=distance_matrix;
 allfripple_rate_nsoz_matrix=distance_matrix;
 collection = "HFOs";
 for j=1:numel(unique_electrodes)
   electrode1_soz=0;
   electrode2_soz=0;
     % find if soz electrode 1 is soz
              test_query=['{"patient_id":"' RESP{i} '","electrode":"' unique_electrodes{j} '"}'];
              collection = "HFOs";
              soz = distinct(conn,collection,"soz",'Query',test_query);
              soz=cell2mat(soz);
              if ~isempty(soz)       soz=str2double(soz);       end;
              if ~isempty(soz)
              soz=soz(1);
              else
                  collection = "Electrodes";
                  soz = distinct(conn,collection,"soz",'Query',test_query);
                  soz=cell2mat(soz);
                  if ~isempty(soz)       soz=str2double(soz);       end;
                  soz=soz(1);
              end;
                if soz == 0
                  collection = "Electrodes";
                  soz = distinct(conn,collection,"soz",'Query',test_query);
                  soz=cell2mat(soz);
                  if ~isempty(soz)       soz=str2double(soz);       end;
                  soz=soz(1);
                end;
             if soz == 0
                 electrode1_soz=0;
             else
                 electrode1_soz=1;
             end;
     % Find Events   
     collection = "HFOs";
     test_query=['{"patient_id":"' RESP{i} '","electrode":"' unique_electrodes{j} '","type":"' num2str(4) '"}'];
     num_records = count(conn,collection,'Query',test_query);
     if num_records == 0
         test_query=['{"patient_id":"' RESP{i} '","electrode":"' unique_electrodes{j} '","type":"' num2str(5) '"}'];
         num_records = count(conn,collection,'Query',test_query);
     end;
     if num_records == 0
         for k=1:numel(unique_electrodes)             
             allfripple_rate_matrix(j,k)=inf;
             allfripple_rate_nsoz_matrix(j,k)=inf;
         end;
     else
         for k=1:numel(unique_electrodes)
             electrode2_soz=0;
             
             % find if soz electrode 2 is soz
              test_query=['{"patient_id":"' RESP{i} '","electrode":"' unique_electrodes{k} '"}'];
              collection = "HFOs";
              soz = distinct(conn,collection,"soz",'Query',test_query);
              soz=cell2mat(soz);
              if ~isempty(soz)       soz=str2double(soz);       end;
              if ~isempty(soz)
              soz=soz(1);
              else
                  collection = "Electrodes";
                  soz = distinct(conn,collection,"soz",'Query',test_query);
                  soz=cell2mat(soz);
                  if ~isempty(soz)       soz=str2double(soz);       end;
                  soz=soz(1);
              end;
                if soz == 0
                  collection = "Electrodes";
                  soz = distinct(conn,collection,"soz",'Query',test_query);
                  soz=cell2mat(soz);
                  if ~isempty(soz)       soz=str2double(soz);       end;
                  soz=soz(1);
                end;
             if soz == 0
                 electrode2_soz=0;
             else
                 electrode2_soz=1;
             end;
             
             %find events
             collection = "HFOs";
             test_query=['{"patient_id":"' RESP{i} '","electrode":"' unique_electrodes{k} '","type":"' num2str(4) '"}'];
              num_records = count(conn,collection,'Query',test_query);
                 if num_records == 0
                    test_query=['{"patient_id":"' RESP{i} '","electrode":"' unique_electrodes{k} '","type":"' num2str(5) '"}'];
                    num_records = count(conn,collection,'Query',test_query);
                 end;
             if num_records == 0
               allfripple_rate_matrix(j,k)=inf;
               allfripple_rate_nsoz_matrix(j,k)=inf;
             else                       
               test_query=['{"patient_id":"' RESP{i} '","electrode":"' unique_electrodes{j} '","type":"' num2str(4) '"}'];
               frono_events = count(conn,collection,'Query',test_query);  
               test_query=['{"patient_id":"' RESP{i} '","electrode":"' unique_electrodes{j} '","type":"' num2str(5) '"}'];
               frons_events = count(conn,collection,'Query',test_query); 
               test_query=['{"patient_id":"' RESP{i} '"}'];
               blocks = distinct(conn,collection,"file_block",'Query',test_query);
               electrode_1_fr_rate=(frono_events+frons_events)/(numel(blocks)*10);
               test_query=['{"patient_id":"' RESP{i} '","electrode":"' unique_electrodes{k} '","type":"' num2str(4) '" }'];
               frono_events = count(conn,collection,'Query',test_query);  
               test_query=['{"patient_id":"' RESP{i} '","electrode":"' unique_electrodes{k} '","type":"' num2str(5) '" }'];
               frons_events = count(conn,collection,'Query',test_query); 
               electrode_2_fr_rate=(frono_events+frons_events)/(numel(blocks)*10);
               allfripple_rate_matrix(j,k)=allfripple_rate_matrix(j,k)*((electrode_1_fr_rate+electrode_2_fr_rate)/2);
               if electrode1_soz == 1
                   allfripple_rate_nsoz_matrix(j,k)=inf;
               else
                   if electrode2_soz == 1
                      allfripple_rate_nsoz_matrix(j,k)=inf;
                   else    
                      allfripple_rate_nsoz_matrix(j,k)=allfripple_rate_nsoz_matrix(j,k)*((electrode_1_fr_rate+electrode_2_fr_rate)/2);
                   end;
               end;    
             end;
         end;
     end;
 end;
 
 fprintf('all spikes ');
 allspikes_rate_matrix=distance_matrix;
 allspikes_rate_nsoz_matrix=distance_matrix;
 collection = "HFOs";
 for j=1:numel(unique_electrodes)
   electrode1_soz=0;
   electrode2_soz=0;
     % find if soz electrode 1 is soz
              test_query=['{"patient_id":"' RESP{i} '","electrode":"' unique_electrodes{j} '"}'];
              collection = "HFOs";
              soz = distinct(conn,collection,"soz",'Query',test_query);
              soz=cell2mat(soz);
              if ~isempty(soz)       soz=str2double(soz);       end;
              if ~isempty(soz)
              soz=soz(1);
              else
                  collection = "Electrodes";
                  soz = distinct(conn,collection,"soz",'Query',test_query);
                  soz=cell2mat(soz);
                  if ~isempty(soz)       soz=str2double(soz);       end;
                  soz=soz(1);
              end;
                if soz == 0
                  collection = "Electrodes";
                  soz = distinct(conn,collection,"soz",'Query',test_query);
                  soz=cell2mat(soz);
                  if ~isempty(soz)       soz=str2double(soz);       end;
                  soz=soz(1);
                end;
             if soz == 0
                 electrode1_soz=0;
             else
                 electrode1_soz=1;
             end;
     % Find Events   
     collection = "HFOs";
     test_query=['{"patient_id":"' RESP{i} '","electrode":"' unique_electrodes{j} '","type":"' num2str(3) '"}'];
     num_records = count(conn,collection,'Query',test_query);
     if num_records == 0
         test_query=['{"patient_id":"' RESP{i} '","electrode":"' unique_electrodes{j} '","type":"' num2str(6) '"}'];
         num_records = count(conn,collection,'Query',test_query);
     end;
     if num_records == 0
         for k=1:numel(unique_electrodes)             
             allspikes_rate_matrix(j,k)=inf;
             allspikes_rate_nsoz_matrix(j,k)=inf;
         end;
     else
         for k=1:numel(unique_electrodes)
             electrode2_soz=0;
             
             % find if soz electrode 2 is soz
              test_query=['{"patient_id":"' RESP{i} '","electrode":"' unique_electrodes{k} '"}'];
              collection = "HFOs";
              soz = distinct(conn,collection,"soz",'Query',test_query);
              soz=cell2mat(soz);
              if ~isempty(soz)       soz=str2double(soz);       end;
              if ~isempty(soz)
              soz=soz(1);
              else
                  collection = "Electrodes";
                  soz = distinct(conn,collection,"soz",'Query',test_query);
                  soz=cell2mat(soz);
                  if ~isempty(soz)       soz=str2double(soz);       end;
                  soz=soz(1);
              end;
                if soz == 0
                  collection = "Electrodes";
                  soz = distinct(conn,collection,"soz",'Query',test_query);
                  soz=cell2mat(soz);
                  if ~isempty(soz)       soz=str2double(soz);       end;
                  soz=soz(1);
                end;
             if soz == 0
                 electrode2_soz=0;
             else
                 electrode2_soz=1;
             end;
             
             %find events
             collection = "HFOs";
             test_query=['{"patient_id":"' RESP{i} '","electrode":"' unique_electrodes{k} '","type":"' num2str(3) '"}'];
              num_records = count(conn,collection,'Query',test_query);
                 if num_records == 0
                    test_query=['{"patient_id":"' RESP{i} '","electrode":"' unique_electrodes{k} '","type":"' num2str(6) '"}'];
                    num_records = count(conn,collection,'Query',test_query);
                 end;
             if num_records == 0
               allspikes_rate_matrix(j,k)=inf;
               allspikes_rate_nsoz_matrix(j,k)=inf;
             else                       
               test_query=['{"patient_id":"' RESP{i} '","electrode":"' unique_electrodes{j} '","type":"' num2str(3) '" }'];
               spike_events = count(conn,collection,'Query',test_query);  
               test_query=['{"patient_id":"' RESP{i} '","electrode":"' unique_electrodes{j} '","type":"' num2str(6) '" }'];
               sspike_events = count(conn,collection,'Query',test_query); 
               test_query=['{"patient_id":"' RESP{i} '"}'];
               blocks = distinct(conn,collection,"file_block",'Query',test_query);
               electrode_1_s_rate=(spike_events+sspike_events)/(numel(blocks)*10);
               test_query=['{"patient_id":"' RESP{i} '","electrode":"' unique_electrodes{k} '","type":"' num2str(3) '" }'];
               spike_events = count(conn,collection,'Query',test_query);  
               test_query=['{"patient_id":"' RESP{i} '","electrode":"' unique_electrodes{k} '","type":"' num2str(6) '" }'];
               sspike_events = count(conn,collection,'Query',test_query); 
               electrode_2_s_rate=(spike_events+sspike_events)/(numel(blocks)*10);
               allspikes_rate_matrix(j,k)=allspikes_rate_matrix(j,k)*((electrode_1_s_rate+electrode_2_s_rate)/2);
               if electrode1_soz == 1
                   allspikes_rate_nsoz_matrix(j,k)=inf;
               else
                   if electrode2_soz == 1
                      allspikes_rate_nsoz_matrix(j,k)=inf;
                   else    
                      allspikes_rate_nsoz_matrix(j,k)=allspikes_rate_nsoz_matrix(j,k)*((electrode_1_s_rate+electrode_2_s_rate)/2);
                   end;
               end;    
             end;
         end;
     end;
 end;
 
 fprintf('rons ');
 rons_rate_matrix=distance_matrix;
 rons_rate_nsoz_matrix=distance_matrix;
 collection = "HFOs";
 for j=1:numel(unique_electrodes)
   electrode1_soz=0;
   electrode2_soz=0;
     % find if soz electrode 1 is soz
              test_query=['{"patient_id":"' RESP{i} '","electrode":"' unique_electrodes{j} '"}'];
              collection = "HFOs";
              soz = distinct(conn,collection,"soz",'Query',test_query);
              soz=cell2mat(soz);
              if ~isempty(soz)       soz=str2double(soz);       end;
              if ~isempty(soz)
              soz=soz(1);
              else
                  collection = "Electrodes";
                  soz = distinct(conn,collection,"soz",'Query',test_query);
                  soz=cell2mat(soz);
                  if ~isempty(soz)       soz=str2double(soz);       end;
                  soz=soz(1);
              end;
                if soz == 0
                  collection = "Electrodes";
                  soz = distinct(conn,collection,"soz",'Query',test_query);
                  soz=cell2mat(soz);
                  if ~isempty(soz)       soz=str2double(soz);       end;
                  soz=soz(1);
                end;
             if soz == 0
                 electrode1_soz=0;
             else
                 electrode1_soz=1;
             end;
     % Find Events   
     collection = "HFOs";
     test_query=['{"patient_id":"' RESP{i} '","electrode":"' unique_electrodes{j} '","type":"' num2str(2) '"}'];
     num_records = count(conn,collection,'Query',test_query);
     if num_records == 0
         for k=1:numel(unique_electrodes)             
             rons_rate_matrix(j,k)=inf;
             rons_rate_nsoz_matrix(j,k)=inf;
         end;
     else
         for k=1:numel(unique_electrodes)
             electrode2_soz=0;
             
             % find if soz electrode 2 is soz
              test_query=['{"patient_id":"' RESP{i} '","electrode":"' unique_electrodes{k} '"}'];
              collection = "HFOs";
              soz = distinct(conn,collection,"soz",'Query',test_query);
              soz=cell2mat(soz);
              if ~isempty(soz)       soz=str2double(soz);       end;
              if ~isempty(soz)
              soz=soz(1);
              else
                  collection = "Electrodes";
                  soz = distinct(conn,collection,"soz",'Query',test_query);
                  soz=cell2mat(soz);
                  if ~isempty(soz)       soz=str2double(soz);       end;
                  soz=soz(1);
              end;
                if soz == 0
                  collection = "Electrodes";
                  soz = distinct(conn,collection,"soz",'Query',test_query);
                  soz=cell2mat(soz);
                  if ~isempty(soz)       soz=str2double(soz);       end;
                  soz=soz(1);
                end;
             if soz == 0
                 electrode2_soz=0;
             else
                 electrode2_soz=1;
             end;
             
             %find events
             collection = "HFOs";
             test_query=['{"patient_id":"' RESP{i} '","electrode":"' unique_electrodes{k} '","type":"' num2str(2) '"}'];
             num_records = count(conn,collection,'Query',test_query); 
             if num_records == 0
               rons_rate_matrix(j,k)=inf;
               rons_rate_nsoz_matrix(j,k)=inf;
             else                       
               test_query=['{"patient_id":"' RESP{i} '","electrode":"' unique_electrodes{j} '","type":"' num2str(2) '" }'];
               rons_events = count(conn,collection,'Query',test_query);  
               test_query=['{"patient_id":"' RESP{i} '"}'];
               blocks = distinct(conn,collection,"file_block",'Query',test_query);
               electrode_1_rons_rate=(rons_events)/(numel(blocks)*10);
               test_query=['{"patient_id":"' RESP{i} '","electrode":"' unique_electrodes{k} '","type":"' num2str(2) '" }'];
               rons_events = count(conn,collection,'Query',test_query);  
               electrode_2_rons_rate=(rons_events)/(numel(blocks)*10);
               rons_rate_matrix(j,k)=rons_rate_matrix(j,k)*((electrode_1_rons_rate+electrode_2_rons_rate)/2);
               if electrode1_soz == 1
                   rons_rate_nsoz_matrix(j,k)=inf;
               else
                   if electrode2_soz == 1
                      rons_rate_nsoz_matrix(j,k)=inf;
                   else    
                      rons_rate_nsoz_matrix(j,k)=rons_rate_nsoz_matrix(j,k)*((electrode_1_rons_rate+electrode_2_rons_rate)/2);
                   end;
               end;    
             end;
         end;
     end;
 end;
 
 fprintf('rono ');
 rono_rate_matrix=distance_matrix;
 rono_rate_nsoz_matrix=distance_matrix;
 collection = "HFOs";
 for j=1:numel(unique_electrodes)
   electrode1_soz=0;
   electrode2_soz=0;
     % find if soz electrode 1 is soz
              test_query=['{"patient_id":"' RESP{i} '","electrode":"' unique_electrodes{j} '"}'];
              collection = "HFOs";
              soz = distinct(conn,collection,"soz",'Query',test_query);
              soz=cell2mat(soz);
              if ~isempty(soz)       soz=str2double(soz);       end;
              if ~isempty(soz)
              soz=soz(1);
              else
                  collection = "Electrodes";
                  soz = distinct(conn,collection,"soz",'Query',test_query);
                  soz=cell2mat(soz);
                  if ~isempty(soz)       soz=str2double(soz);       end;
                  soz=soz(1);
              end;
                if soz == 0
                  collection = "Electrodes";
                  soz = distinct(conn,collection,"soz",'Query',test_query);
                  soz=cell2mat(soz);
                  if ~isempty(soz)       soz=str2double(soz);       end;
                  soz=soz(1);
                end;
             if soz == 0
                 electrode1_soz=0;
             else
                 electrode1_soz=1;
             end;
     % Find Events   
     collection = "HFOs";
     test_query=['{"patient_id":"' RESP{i} '","electrode":"' unique_electrodes{j} '","type":"' num2str(1) '"}'];
     num_records = count(conn,collection,'Query',test_query);
     if num_records == 0
         for k=1:numel(unique_electrodes)             
             rono_rate_matrix(j,k)=inf;
             rono_rate_nsoz_matrix(j,k)=inf;
         end;
     else
         for k=1:numel(unique_electrodes)
             electrode2_soz=0;
             
             % find if soz electrode 2 is soz
              test_query=['{"patient_id":"' RESP{i} '","electrode":"' unique_electrodes{k} '"}'];
              collection = "HFOs";
              soz = distinct(conn,collection,"soz",'Query',test_query);
              soz=cell2mat(soz);
              if ~isempty(soz)       soz=str2double(soz);       end;
              if ~isempty(soz)
              soz=soz(1);
              else
                  collection = "Electrodes";
                  soz = distinct(conn,collection,"soz",'Query',test_query);
                  soz=cell2mat(soz);
                  if ~isempty(soz)       soz=str2double(soz);       end;
                  soz=soz(1);
              end;
                if soz == 0
                  collection = "Electrodes";
                  soz = distinct(conn,collection,"soz",'Query',test_query);
                  soz=cell2mat(soz);
                  if ~isempty(soz)       soz=str2double(soz);       end;
                  soz=soz(1);
                end;
             if soz == 0
                 electrode2_soz=0;
             else
                 electrode2_soz=1;
             end;
             
             %find events
             collection = "HFOs";
             test_query=['{"patient_id":"' RESP{i} '","electrode":"' unique_electrodes{k} '","type":"' num2str(1) '"}'];
             num_records = count(conn,collection,'Query',test_query); 
             if num_records == 0
               rono_rate_matrix(j,k)=inf;
               rono_rate_nsoz_matrix(j,k)=inf;
             else                       
               test_query=['{"patient_id":"' RESP{i} '","electrode":"' unique_electrodes{j} '","type":"' num2str(1) '" }'];
               rono_events = count(conn,collection,'Query',test_query);  
               test_query=['{"patient_id":"' RESP{i} '"}'];
               blocks = distinct(conn,collection,"file_block",'Query',test_query);
               electrode_1_rono_rate=(rono_events)/(numel(blocks)*10);
               test_query=['{"patient_id":"' RESP{i} '","electrode":"' unique_electrodes{k} '","type":"' num2str(1) '" }'];
               rono_events = count(conn,collection,'Query',test_query);  
               electrode_2_rono_rate=(rono_events)/(numel(blocks)*10);
               rono_rate_matrix(j,k)=rono_rate_matrix(j,k)*((electrode_1_rono_rate+electrode_2_rono_rate)/2);
               if electrode1_soz == 1
                   rono_rate_nsoz_matrix(j,k)=inf;
               else
                   if electrode2_soz == 1
                      rono_rate_nsoz_matrix(j,k)=inf;
                   else    
                      rono_rate_nsoz_matrix(j,k)=rono_rate_nsoz_matrix(j,k)*((electrode_1_rono_rate+electrode_2_rono_rate)/2);
                   end;
               end;    
             end;
         end;
     end;
 end;
 
 i
 [~,~,~,r_radius_soz(i),~] = charpath(soz_matrix,0,0);
 [~,~,~,r_radius_fripple(i),~] = charpath(fripple_matrix,0,0);
 [~,~,~,r_radius_fripple_rate(i),~] = charpath(fripple_rate_matrix,0,0);
 [~,~,~,r_radius_fripple_nsoz(i),~] = charpath(fripple_nsoz_matrix,0,0);
 [~,~,~,r_radius_fripple_rate_nsoz(i),~] = charpath(fripple_rate_nsoz_matrix,0,0);
 [~,~,~,r_radius_allfripple_rate(i),~] = charpath(allfripple_rate_matrix,0,0);
 [~,~,~,r_radius_allfripple_rate_nsoz(i),~] = charpath(allfripple_rate_nsoz_matrix,0,0);
 [~,~,~,r_radius_spikes_rate(i),~] = charpath(allspikes_rate_matrix,0,0);
 [~,~,~,r_radius_spikes_rate_nsoz(i),~] = charpath(allspikes_rate_nsoz_matrix,0,0);
 [~,~,~,r_radius_rons_rate(i),~] = charpath(rons_rate_matrix,0,0);
 [~,~,~,r_radius_rons_rate_nsoz(i),~] = charpath(rons_rate_nsoz_matrix,0,0);
 [~,~,~,r_radius_rono_rate(i),~] = charpath(rono_rate_matrix,0,0);
 [~,~,~,r_radius_rono_rate_nsoz(i),~] = charpath(rono_rate_nsoz_matrix,0,0);
 
end;

dataout.soz=r_radius_soz'
dataout.fripple=r_radius_fripple'
dataout.fripple_rate=r_radius_fripple_rate';
dataout.fripple_nsoz=r_radius_fripple_nsoz';
dataout.fripple_rate_nsoz=r_radius_fripple_rate_nsoz';
dataout.allfripple_rate=r_radius_allfripple_rate';
dataout.allfripple_rate_nsoz=r_radius_allfripple_rate_nsoz';
dataout.spikes_rate=r_radius_spikes_rate';
dataout.spikes_rate_nsoz=r_radius_spikes_rate_nsoz';
dataout.rons_rate=r_radius_rons_rate';
dataout.rons_rate_nsoz=r_radius_rons_rate_nsoz';
dataout.rono_rate=r_radius_rono_rate';
dataout.rono_rate_nsoz=r_radius_rono_rate_nsoz';


% 
% 
% nr_radius_soz=[];
% nr_radius_fripple=[];
% nr_radius_fripple_rate=[];
% nr_radius_fripple_nsoz=[];
% nr_radius_fripple_rate_nsoz=[];
% 
% for i=1:numel(NONRESP)
%     x=[];
%     y=[];
%     z=[];
%     soz_matrix=[];
%     fripple_matrix=[];
%     fripple_rate_matrix=[];
%     deleted_electrodes=[];
%     test_query=['{"patient_id":"' NONRESP{i} '"}'];
%     electrodes = distinct(conn,collection,"electrode",'Query',test_query);
%     collection = "Electrodes";
%     electrodes_2 = distinct(conn,collection,"electrode",'Query',test_query);
%     total_electrodes=[electrodes electrodes_2];
%     unique_electrodes=unique(total_electrodes);
%   for j=1:numel(unique_electrodes)
%       collection = "HFOs";
%       test_query=['{"patient_id":"' NONRESP{i} '","electrode":"' unique_electrodes{j} '"}'];
%       x_temp = distinct(conn,collection,"x",'Query',test_query);
%       x_temp=cell2mat(x_temp);
%       if ~isempty(x_temp)
%           x(j)=x_temp(1);          
%           y_temp = distinct(conn,collection,"y",'Query',test_query);
%           y_temp = cell2mat(y_temp);
%           y(j)=y_temp(1);
%           z_temp = distinct(conn,collection,"z",'Query',test_query);
%           z_temp = cell2mat(z_temp);
%           z(j)=z_temp(1); 
%       else
%          collection = "Electrodes";
%          x_temp = distinct(conn,collection,"x",'Query',test_query);
%          x_temp = cell2mat(x_temp);
%          if isempty(x_temp)
%              edited_unique_electrodes=unique_electrodes;
%              deleted_electrodes=[deleted_electrodes j];
%              x(j)=NaN;
%              y(j)=NaN;
%              z(j)=NaN;
%          else
%              x(j)=x_temp(1);
%              y_temp = distinct(conn,collection,"y",'Query',test_query);
%              y_temp = cell2mat(y_temp);
%              y(j)=y_temp(1);
%              z_temp = distinct(conn,collection,"z",'Query',test_query);
%              z_temp = cell2mat(z_temp);
%              z(j)=z_temp(1);
%          end;
%       end;  
%        if x(j) == -1
%          collection = "Electrodes";
%          x_temp = distinct(conn,collection,"x",'Query',test_query);
%          x_temp = cell2mat(x_temp);
%          x(j)=x_temp(1);
%          y_temp = distinct(conn,collection,"y",'Query',test_query);
%          y_temp = cell2mat(y_temp);
%          y(j)=y_temp(1);
%          z_temp = distinct(conn,collection,"z",'Query',test_query);
%          z_temp = cell2mat(z_temp);
%          z(j)=z_temp(1);
%        end;
%        if x(j) == -1
%            deleted_electrodes=[deleted_electrodes j];
%            x(j)=NaN;
%            y(j)=NaN;
%            z(j)=NaN;
%        end;
%   end; 
%   unique_electrodes(deleted_electrodes)=[];
%   x(deleted_electrodes)=[];
%   y(deleted_electrodes)=[];
%   z(deleted_electrodes)=[];
%   distance_matrix=inf(numel(unique_electrodes), numel(unique_electrodes));
%   for j=1:numel(unique_electrodes)
%     for k=1:numel(unique_electrodes)
%         distance_matrix(j,k)=sqrt(((x(j)-x(k))^2)+((y(j)-y(k))^2)+((z(j)-z(k))^2));
%     end;
%   end;
%   
%   soz_matrix=distance_matrix;
%   for j=1:numel(unique_electrodes)
%       test_query=['{"patient_id":"' NONRESP{i} '","electrode":"' unique_electrodes{j} '"}'];
%       collection = "HFOs";
%       soz = distinct(conn,collection,"soz",'Query',test_query);
%       soz=cell2mat(soz);
%       if ~isempty(soz)       soz=str2double(soz);       end;
%       if ~isempty(soz)
%       soz=soz(1);
%       else
%       collection = "Electrodes";
%       soz = distinct(conn,collection,"soz",'Query',test_query);
%       soz=cell2mat(soz);
%       if ~isempty(soz)       soz=str2double(soz);       end;
%       soz=soz(1);
%       end;
%       if soz == 0
%           collection = "Electrodes";
%           soz = distinct(conn,collection,"soz",'Query',test_query);
%           soz=cell2mat(soz);
%           if ~isempty(soz)       soz=str2double(soz);       end;
%           soz=soz(1);
%       end;
%       if soz == 0
%           for k=1:numel(unique_electrodes)
%               soz_matrix(j,k)=inf;
%           end;
%       else
%           for k=1:numel(unique_electrodes)
%               test_query=['{"patient_id":"' NONRESP{i} '","electrode":"' unique_electrodes{k} '"}'];
%               collection = "HFOs";
%               soz = distinct(conn,collection,"soz",'Query',test_query);
%               soz=cell2mat(soz);
%               if ~isempty(soz)       soz=str2double(soz);       end;
%               if ~isempty(soz)
%               soz=soz(1);
%               else
%                   collection = "Electrodes";
%                   soz = distinct(conn,collection,"soz",'Query',test_query);
%                   soz=cell2mat(soz);
%                   if ~isempty(soz)       soz=str2double(soz);       end;
%                   soz=soz(1);
%               end;
%                 if soz == 0
%                   collection = "Electrodes";
%                   soz = distinct(conn,collection,"soz",'Query',test_query);
%                   soz=cell2mat(soz);
%                   if ~isempty(soz)       soz=str2double(soz);       end;
%                   soz=soz(1);
%                 end;
%              if soz == 0
%                  soz_matrix(j,k)=inf;
%              end;
%           end;
%       end;
%   end;      
%  
%  fripple_matrix=distance_matrix;
%  fripple_rate_matrix=distance_matrix;
%  fripple_nsoz_matrix=distance_matrix;
%  fripple_rate_nsoz_matrix=distance_matrix;
%  collection = "HFOs";
%  for j=1:numel(unique_electrodes)
%    electrode1_soz=0;
%    electrode2_soz=0;
%      % find if soz electrode 1 is soz
%               test_query=['{"patient_id":"' NONRESP{i} '","electrode":"' unique_electrodes{j} '"}'];
%               collection = "HFOs";
%               soz = distinct(conn,collection,"soz",'Query',test_query);
%               soz=cell2mat(soz);
%               if ~isempty(soz)       soz=str2double(soz);       end;
%               if ~isempty(soz)
%               soz=soz(1);
%               else
%                   collection = "Electrodes";
%                   soz = distinct(conn,collection,"soz",'Query',test_query);
%                   soz=cell2mat(soz);
%                   if ~isempty(soz)       soz=str2double(soz);       end;
%                   soz=soz(1);
%               end;
%                 if soz == 0
%                   collection = "Electrodes";
%                   soz = distinct(conn,collection,"soz",'Query',test_query);
%                   soz=cell2mat(soz);
%                   if ~isempty(soz)       soz=str2double(soz);       end;
%                   soz=soz(1);
%                 end;
%              if soz == 0
%                  electrode1_soz=0;
%              else
%                  electrode1_soz=1;
%              end;
%      % Find Events   
%      collection = "HFOs";
%      test_query=['{"patient_id":"' NONRESP{i} '","electrode":"' unique_electrodes{j} '","type":"' num2str(4) '","freq_pk": {$gt:350} }'];
%      num_records = count(conn,collection,'Query',test_query);
%      if num_records == 0
%          test_query=['{"patient_id":"' NONRESP{i} '","electrode":"' unique_electrodes{j} '","type":"' num2str(5) '","freq_pk": {$gt:350} }'];
%          num_records = count(conn,collection,'Query',test_query);
%      end;
%      if num_records == 0
%          for k=1:numel(unique_electrodes)
%              fripple_matrix(j,k)=inf;
%              fripple_rate_matrix(j,k)=inf;
%              fripple_nsoz_matrix(j,k)=inf;
%              fripple_rate_nsoz_matrix(j,k)=inf;
%          end;
%      else
%          for k=1:numel(unique_electrodes)
%              electrode2_soz=0;
%              
%              % find if soz electrode 2 is soz
%               test_query=['{"patient_id":"' NONRESP{i} '","electrode":"' unique_electrodes{k} '"}'];
%               collection = "HFOs";
%               soz = distinct(conn,collection,"soz",'Query',test_query);
%               soz=cell2mat(soz);
%               if ~isempty(soz)       soz=str2double(soz);       end;
%               if ~isempty(soz)
%               soz=soz(1);
%               else
%                   collection = "Electrodes";
%                   soz = distinct(conn,collection,"soz",'Query',test_query);
%                   soz=cell2mat(soz);
%                   if ~isempty(soz)       soz=str2double(soz);       end;
%                   soz=soz(1);
%               end;
%                 if soz == 0
%                   collection = "Electrodes";
%                   soz = distinct(conn,collection,"soz",'Query',test_query);
%                   soz=cell2mat(soz);
%                   if ~isempty(soz)       soz=str2double(soz);       end;
%                   soz=soz(1);
%                 end;
%              if soz == 0
%                  electrode2_soz=0;
%              else
%                  electrode2_soz=1;
%              end;
%              
%              %find events
%              collection = "HFOs";
%              test_query=['{"patient_id":"' NONRESP{i} '","electrode":"' unique_electrodes{k} '","type":"' num2str(4) '","freq_pk": {$gt:350} }'];
%               num_records = count(conn,collection,'Query',test_query);
%                  if num_records == 0
%                     test_query=['{"patient_id":"' NONRESP{i} '","electrode":"' unique_electrodes{k} '","type":"' num2str(5) '","freq_pk": {$gt:350} }'];
%                     num_records = count(conn,collection,'Query',test_query);
%                  end;
%              if num_records == 0
%                fripple_matrix(j,k)=inf;
%                fripple_rate_matrix(j,k)=inf;
%                fripple_nsoz_matrix(j,k)=inf;
%                fripple_rate_nsoz_matrix(j,k)=inf;
%              else                       
%                test_query=['{"patient_id":"' NONRESP{i} '","electrode":"' unique_electrodes{j} '","type":"' num2str(4) '","freq_pk": {$gt:350} }'];
%                frono_events = count(conn,collection,'Query',test_query);  
%                test_query=['{"patient_id":"' NONRESP{i} '","electrode":"' unique_electrodes{j} '","type":"' num2str(5) '","freq_pk": {$gt:350} }'];
%                frons_events = count(conn,collection,'Query',test_query); 
%                test_query=['{"patient_id":"' NONRESP{i} '"}'];
%                blocks = distinct(conn,collection,"file_block",'Query',test_query);
%                electrode_1_fr_rate=(frono_events+frons_events)/(numel(blocks)*10);
%                test_query=['{"patient_id":"' NONRESP{i} '","electrode":"' unique_electrodes{k} '","type":"' num2str(4) '","freq_pk": {$gt:350} }'];
%                frono_events = count(conn,collection,'Query',test_query);  
%                test_query=['{"patient_id":"' NONRESP{i} '","electrode":"' unique_electrodes{k} '","type":"' num2str(5) '","freq_pk": {$gt:350} }'];
%                frons_events = count(conn,collection,'Query',test_query); 
%                electrode_2_fr_rate=(frono_events+frons_events)/(numel(blocks)*10);
%                fripple_rate_matrix(j,k)=fripple_rate_matrix(j,k)*((electrode_1_fr_rate+electrode_2_fr_rate)/2);
%                if electrode1_soz == 1
%                    fripple_nsoz_matrix(j,k)=inf;
%                    fripple_rate_nsoz_matrix(j,k)=inf;
%                else
%                    if electrode2_soz == 1
%                       fripple_nsoz_matrix(j,k)=inf;
%                       fripple_rate_nsoz_matrix(j,k)=inf;
%                    else    
%                       fripple_rate_nsoz_matrix(j,k)=fripple_rate_matrix(j,k)*((electrode_1_fr_rate+electrode_2_fr_rate)/2);
%                    end;
%                end;    
%              end;
%          end;
%      end;
%  end;
%  i
%  [r_lambda_soz,eff,ecc,nr_radius_soz(i),r_diameter_soz] = charpath(soz_matrix,0,0);
%  [r_lambda_fripple,eff,ecc,nr_radius_fripple(i),r_diameter_fripple] = charpath(fripple_matrix,0,0);
%  [r_lambda_fripple_rate,eff,ecc,nr_radius_fripple_rate(i),r_diameter_fripple_rate] = charpath(fripple_rate_matrix,0,0);
%  [r_lambda_fripple_nsoz,eff,ecc,nr_radius_fripple_nsoz(i),r_diameter_fripple_nsoz] = charpath(fripple_nsoz_matrix,0,0);
%  [r_lambda_fripple_rate_nsoz,eff,ecc,nr_radius_fripple_rate_nsoz(i),r_diameter_fripple_rate_nsoz] = charpath(fripple_rate_nsoz_matrix,0,0);
% end;
% 
% ns_radius_soz=[];
% ns_radius_fripple=[];
% ns_radius_fripple_rate=[];
% ns_radius_fripple_nsoz=[];
% ns_radius_fripple_rate_nsoz=[];
% 
% for i=1:numel(NOSURG)
%     x=[];
%     y=[];
%     z=[];
%     soz_matrix=[];
%     fripple_matrix=[];
%     fripple_rate_matrix=[];
%     deleted_electrodes=[];
%     test_query=['{"patient_id":"' NOSURG{i} '"}'];
%     electrodes = distinct(conn,collection,"electrode",'Query',test_query);
%     collection = "Electrodes";
%     electrodes_2 = distinct(conn,collection,"electrode",'Query',test_query);
%     total_electrodes=[electrodes electrodes_2];
%     unique_electrodes=unique(total_electrodes);
%   for j=1:numel(unique_electrodes)
%       collection = "HFOs";
%       test_query=['{"patient_id":"' NOSURG{i} '","electrode":"' unique_electrodes{j} '"}'];
%       x_temp = distinct(conn,collection,"x",'Query',test_query);
%       x_temp=cell2mat(x_temp);
%       if ~isempty(x_temp)
%           x(j)=x_temp(1);          
%           y_temp = distinct(conn,collection,"y",'Query',test_query);
%           y_temp = cell2mat(y_temp);
%           y(j)=y_temp(1);
%           z_temp = distinct(conn,collection,"z",'Query',test_query);
%           z_temp = cell2mat(z_temp);
%           z(j)=z_temp(1); 
%       else
%          collection = "Electrodes";
%          x_temp = distinct(conn,collection,"x",'Query',test_query);
%          x_temp(cellfun(@ischar,x_temp)) = {nan};
%          x_temp = cell2mat(x_temp);
%          if isempty(x_temp)
%              edited_unique_electrodes=unique_electrodes;
%              deleted_electrodes=[deleted_electrodes j];
%              x(j)=NaN;
%              y(j)=NaN;
%              z(j)=NaN;
%          else
%              x(j)=x_temp(1);
%              y_temp = distinct(conn,collection,"y",'Query',test_query);
%              y_temp(cellfun(@ischar,y_temp)) = {nan};
%              y_temp = cell2mat(y_temp);
%              y(j)=y_temp(1);
%              z_temp = distinct(conn,collection,"z",'Query',test_query);
%              z_temp(cellfun(@ischar,z_temp)) = {nan};
%              z_temp = cell2mat(z_temp);
%              z(j)=z_temp(1);
%          end;
%       end;  
%        if x(j) == -1
%          collection = "Electrodes";
%          x_temp = distinct(conn,collection,"x",'Query',test_query);
%          x_temp = cell2mat(x_temp);
%          x(j)=x_temp(1);
%          y_temp = distinct(conn,collection,"y",'Query',test_query);
%          y_temp = cell2mat(y_temp);
%          y(j)=y_temp(1);
%          z_temp = distinct(conn,collection,"z",'Query',test_query);
%          z_temp = cell2mat(z_temp);
%          z(j)=z_temp(1);
%        end;
%        if x(j) == -1
%            deleted_electrodes=[deleted_electrodes j];
%            x(j)=NaN;
%            y(j)=NaN;
%            z(j)=NaN;
%        end;
%   end; 
%   unique_electrodes(deleted_electrodes)=[];
%   x(deleted_electrodes)=[];
%   y(deleted_electrodes)=[];
%   z(deleted_electrodes)=[];
%   distance_matrix=inf(numel(unique_electrodes), numel(unique_electrodes));
%   for j=1:numel(unique_electrodes)
%     for k=1:numel(unique_electrodes)
%         distance_matrix(j,k)=sqrt(((x(j)-x(k))^2)+((y(j)-y(k))^2)+((z(j)-z(k))^2));
%     end;
%   end;
%   
%   soz_matrix=distance_matrix;
%   for j=1:numel(unique_electrodes)
%       test_query=['{"patient_id":"' NOSURG{i} '","electrode":"' unique_electrodes{j} '"}'];
%       collection = "HFOs";
%       soz = distinct(conn,collection,"soz",'Query',test_query);
%       soz=cell2mat(soz);
%       if ~isempty(soz)       soz=str2double(soz);       end;
%       if ~isempty(soz)
%       soz=soz(1);
%       else
%       collection = "Electrodes";
%       soz = distinct(conn,collection,"soz",'Query',test_query);
%       soz=cell2mat(soz);
%       if ~isempty(soz)       soz=str2double(soz);       end;
%       soz=soz(1);
%       end;
%       if soz == 0
%           collection = "Electrodes";
%           soz = distinct(conn,collection,"soz",'Query',test_query);
%           soz=cell2mat(soz);
%           if ~isempty(soz)       soz=str2double(soz);       end;
%           soz=soz(1);
%       end;
%       if soz == 0
%           for k=1:numel(unique_electrodes)
%               soz_matrix(j,k)=inf;
%           end;
%       else
%           for k=1:numel(unique_electrodes)
%               test_query=['{"patient_id":"' NOSURG{i} '","electrode":"' unique_electrodes{k} '"}'];
%               collection = "HFOs";
%               soz = distinct(conn,collection,"soz",'Query',test_query);
%               soz=cell2mat(soz);
%               if ~isempty(soz)       soz=str2double(soz);       end;
%               if ~isempty(soz)
%               soz=soz(1);
%               else
%                   collection = "Electrodes";
%                   soz = distinct(conn,collection,"soz",'Query',test_query);
%                   soz=cell2mat(soz);
%                   if ~isempty(soz)       soz=str2double(soz);       end;
%                   soz=soz(1);
%               end;
%                 if soz == 0
%                   collection = "Electrodes";
%                   soz = distinct(conn,collection,"soz",'Query',test_query);
%                   soz=cell2mat(soz);
%                   if ~isempty(soz)       soz=str2double(soz);       end;
%                   soz=soz(1);
%                 end;
%              if soz == 0
%                  soz_matrix(j,k)=inf;
%              end;
%           end;
%       end;
%   end;      
%  
%  fripple_matrix=distance_matrix;
%  fripple_rate_matrix=distance_matrix;
%  fripple_nsoz_matrix=distance_matrix;
%  fripple_rate_nsoz_matrix=distance_matrix;
%  collection = "HFOs";
%  for j=1:numel(unique_electrodes)
%    electrode1_soz=0;
%    electrode2_soz=0;
%      % find if soz electrode 1 is soz
%               test_query=['{"patient_id":"' NOSURG{i} '","electrode":"' unique_electrodes{j} '"}'];
%               collection = "HFOs";
%               soz = distinct(conn,collection,"soz",'Query',test_query);
%               soz=cell2mat(soz);
%               if ~isempty(soz)       soz=str2double(soz);       end;
%               if ~isempty(soz)
%               soz=soz(1);
%               else
%                   collection = "Electrodes";
%                   soz = distinct(conn,collection,"soz",'Query',test_query);
%                   soz=cell2mat(soz);
%                   if ~isempty(soz)       soz=str2double(soz);       end;
%                   soz=soz(1);
%               end;
%                 if soz == 0
%                   collection = "Electrodes";
%                   soz = distinct(conn,collection,"soz",'Query',test_query);
%                   soz=cell2mat(soz);
%                   if ~isempty(soz)       soz=str2double(soz);       end;
%                   soz=soz(1);
%                 end;
%              if soz == 0
%                  electrode1_soz=0;
%              else
%                  electrode1_soz=1;
%              end;
%      % Find Events   
%      collection = "HFOs";
%      test_query=['{"patient_id":"' NOSURG{i} '","electrode":"' unique_electrodes{j} '","type":"' num2str(4) '","freq_pk": {$gt:350} }'];
%      num_records = count(conn,collection,'Query',test_query);
%      if num_records == 0
%          test_query=['{"patient_id":"' NOSURG{i} '","electrode":"' unique_electrodes{j} '","type":"' num2str(5) '","freq_pk": {$gt:350} }'];
%          num_records = count(conn,collection,'Query',test_query);
%      end;
%      if num_records == 0
%          for k=1:numel(unique_electrodes)
%              fripple_matrix(j,k)=inf;
%              fripple_rate_matrix(j,k)=inf;
%              fripple_nsoz_matrix(j,k)=inf;
%              fripple_rate_nsoz_matrix(j,k)=inf;
%          end;
%      else
%          for k=1:numel(unique_electrodes)
%              electrode2_soz=0;
%              
%              % find if soz electrode 2 is soz
%               test_query=['{"patient_id":"' NOSURG{i} '","electrode":"' unique_electrodes{k} '"}'];
%               collection = "HFOs";
%               soz = distinct(conn,collection,"soz",'Query',test_query);
%               soz=cell2mat(soz);
%               if ~isempty(soz)       soz=str2double(soz);       end;
%               if ~isempty(soz)
%               soz=soz(1);
%               else
%                   collection = "Electrodes";
%                   soz = distinct(conn,collection,"soz",'Query',test_query);
%                   soz=cell2mat(soz);
%                   if ~isempty(soz)       soz=str2double(soz);       end;
%                   soz=soz(1);
%               end;
%                 if soz == 0
%                   collection = "Electrodes";
%                   soz = distinct(conn,collection,"soz",'Query',test_query);
%                   soz=cell2mat(soz);
%                   if ~isempty(soz)       soz=str2double(soz);       end;
%                   soz=soz(1);
%                 end;
%              if soz == 0
%                  electrode2_soz=0;
%              else
%                  electrode2_soz=1;
%              end;
%              
%              %find events
%              collection = "HFOs";
%              test_query=['{"patient_id":"' NOSURG{i} '","electrode":"' unique_electrodes{k} '","type":"' num2str(4) '","freq_pk": {$gt:350} }'];
%               num_records = count(conn,collection,'Query',test_query);
%                  if num_records == 0
%                     test_query=['{"patient_id":"' NOSURG{i} '","electrode":"' unique_electrodes{k} '","type":"' num2str(5) '","freq_pk": {$gt:350} }'];
%                     num_records = count(conn,collection,'Query',test_query);
%                  end;
%              if num_records == 0
%                fripple_matrix(j,k)=inf;
%                fripple_rate_matrix(j,k)=inf;
%                fripple_nsoz_matrix(j,k)=inf;
%                fripple_rate_nsoz_matrix(j,k)=inf;
%              else                       
%                test_query=['{"patient_id":"' NOSURG{i} '","electrode":"' unique_electrodes{j} '","type":"' num2str(4) '","freq_pk": {$gt:350} }'];
%                frono_events = count(conn,collection,'Query',test_query);  
%                test_query=['{"patient_id":"' NOSURG{i} '","electrode":"' unique_electrodes{j} '","type":"' num2str(5) '","freq_pk": {$gt:350} }'];
%                frons_events = count(conn,collection,'Query',test_query); 
%                test_query=['{"patient_id":"' NOSURG{i} '"}'];
%                blocks = distinct(conn,collection,"file_block",'Query',test_query);
%                electrode_1_fr_rate=(frono_events+frons_events)/(numel(blocks)*10);
%                test_query=['{"patient_id":"' NOSURG{i} '","electrode":"' unique_electrodes{k} '","type":"' num2str(4) '","freq_pk": {$gt:350} }'];
%                frono_events = count(conn,collection,'Query',test_query);  
%                test_query=['{"patient_id":"' NOSURG{i} '","electrode":"' unique_electrodes{k} '","type":"' num2str(5) '","freq_pk": {$gt:350} }'];
%                frons_events = count(conn,collection,'Query',test_query); 
%                electrode_2_fr_rate=(frono_events+frons_events)/(numel(blocks)*10);
%                fripple_rate_matrix(j,k)=fripple_rate_matrix(j,k)*((electrode_1_fr_rate+electrode_2_fr_rate)/2);
%                if electrode1_soz == 1
%                    fripple_nsoz_matrix(j,k)=inf;
%                    fripple_rate_nsoz_matrix(j,k)=inf;
%                else
%                    if electrode2_soz == 1
%                       fripple_nsoz_matrix(j,k)=inf;
%                       fripple_rate_nsoz_matrix(j,k)=inf;
%                    else    
%                       fripple_rate_nsoz_matrix(j,k)=fripple_rate_matrix(j,k)*((electrode_1_fr_rate+electrode_2_fr_rate)/2);
%                    end;
%                end;    
%              end;
%          end;
%      end;
%  end;
%  i
%  [r_lambda_soz,eff,ecc,ns_radius_soz(i),r_diameter_soz] = charpath(soz_matrix,0,0);
%  [r_lambda_fripple,eff,ecc,ns_radius_fripple(i),r_diameter_fripple] = charpath(fripple_matrix,0,0);
%  [r_lambda_fripple_rate,eff,ecc,ns_radius_fripple_rate(i),r_diameter_fripple_rate] = charpath(fripple_rate_matrix,0,0);
%  [r_lambda_fripple_nsoz,eff,ecc,ns_radius_fripple_nsoz(i),r_diameter_fripple_nsoz] = charpath(fripple_nsoz_matrix,0,0);
%  [r_lambda_fripple_rate_nsoz,eff,ecc,ns_radius_fripple_rate_nsoz(i),r_diameter_fripple_rate_nsoz] = charpath(fripple_rate_nsoz_matrix,0,0);
% end;
% 
% r_radius_soz=r_radius_soz';
% r_radius_fripple=r_radius_fripple';
% r_radius_fripple_rate=r_radius_fripple_rate';
% r_radius_fripple_nsoz=r_radius_fripple_nsoz';
% r_radius_fripple_rate_nsoz=r_radius_fripple_rate_nsoz';
% nr_radius_soz=nr_radius_soz';
% nr_radius_fripple=nr_radius_fripple';
% nr_radius_fripple_rate=nr_radius_fripple_rate';
% nr_radius_fripple_nsoz=nr_radius_fripple_nsoz';
% nr_radius_fripple_rate_nsoz=nr_radius_fripple_rate_nsoz';
% ns_radius_soz=ns_radius_soz';
% ns_radius_fripple=ns_radius_fripple';
% ns_radius_fripple_rate=ns_radius_fripple_rate';
% ns_radius_fripple_nsoz=ns_radius_fripple_nsoz';
% ns_radius_fripple_rate_nsoz=ns_radius_fripple_rate_nsoz';
