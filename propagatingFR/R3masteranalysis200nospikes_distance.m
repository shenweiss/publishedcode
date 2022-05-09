function [processed, properties] = R3masteranalysis200nospikes_distance(RESP,status)
server='localhost';
username='admin';
password='';
dbname='deckard_new';
port=27017;
conn = mongo(server,port,dbname,'UserName',username,'Password',password);
collection = "HFOs";
processed=[];
properties=[];
pair_count=0;
% create distance array (DISTANCE)
for i=1:numel(RESP)
    i
    soz_array=[];
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
  chname_matrix={};
  montage_matrix={};
  xcoord_matrix={};
  ycoord_matrix={};
  zcoord_matrix={};
  distance_matrix=inf(numel(unique_electrodes), numel(unique_electrodes));
  xdistance_matrix=inf(numel(unique_electrodes), numel(unique_electrodes));
  ydistance_matrix=inf(numel(unique_electrodes), numel(unique_electrodes));
  zdistance_matrix=inf(numel(unique_electrodes), numel(unique_electrodes));
  for j=1:numel(unique_electrodes)
    for k=1:numel(unique_electrodes)
        chname_matrix{j,k}={unique_electrodes(j) unique_electrodes(k)};
        collection = "HFOs";
        test_query=['{"patient_id":"' RESP{i} '","electrode":"' unique_electrodes{j} '"}'];
        montage_1=distinct(conn,collection,'montage','query',test_query);
        test_query=['{"patient_id":"' RESP{i} '","electrode":"' unique_electrodes{k} '"}'];
        montage_2=distinct(conn,collection,'montage','query',test_query);
        montage_matrix{j,k}={montage_1 montage_2};
        xcoord_matrix{j,k}=[x(j) x(k)];
        ycoord_matrix{j,k}=[y(j) y(k)];
        zcoord_matrix{j,k}=[z(j) z(k)];
        distance_matrix(j,k)=sqrt(((x(j)-x(k))^2)+((y(j)-y(k))^2)+((z(j)-z(k))^2));
        xdistance_matrix(j,k)=x(k)-x(j);
        ydistance_matrix(j,k)=y(k)-y(j);
        zdistance_matrix(j,k)=z(k)-z(j);
    end;
  end;
  
  
  %Find electrode locations
  location_array=[];
  for j=1:numel(unique_electrodes)  
  test_query=['{"patient_id":"' RESP{i} '","electrode":"' unique_electrodes{j} '"}'];
      collection = "HFOs";
      docs = find(conn,collection,'query',test_query,'limit',5000);
      if isempty(docs)
      collection = "Electrodes";
      docs = find(conn,collection,'query',test_query,'limit',5000);
      end;
                 if ~iscell(docs(1).loc2)
                     location=(docs(1).loc2);
                 else
                     location=(docs(1).loc2{1});
                 end;   
      
                 if strcmp(location,'Limbic Lobe')
                     if ~iscell(docs(1).loc5)
                        tempstr=(docs(1).loc5);
                     else
                        tempstr=(docs(1).loc5{1});
                     end;  
                     
                     if strcmp(tempstr,'Amygdala')
                        location='Amygdala';
                     end;
                     
                     if strcmp(tempstr,'Hippocampus')
                        location='Hippocampus';
                     end;
                     
                     if strcmp(tempstr,'Brodmann area 28')
                        location='EC';
                     end;
                 end;   
      location_t=char(location);
      
      switch location_t
          case 'Frontal Lobe'
              location_array(j)=1;
          case 'Temporal Lobe'
              location_array(j)=2;
          case 'Parietal Lobe'
              location_array(j)=3;
          case 'Occipital Lobe'
              location_array(j)=4;
          case 'Limbic Lobe'
              location_array(j)=5;
          case 'Amygdala'
              location_array(j)=6;
          case 'Hippocampus'
              location_array(j)=7;
          case 'EC'
              location_array(j)=8;
          otherwise
              location_array(j)=9; %white matter
      end;
end;         


  % find electrodes that are in the SOZ (re-evaluate to see if this needs
  % to be per patient
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
      else
          soz_array=[soz_array 1];
      end;
  end; 
  %Generate SOZ Status Matrix and Location Pair cell array
  SOZarray = {};
  locations={};
  for n=1:numel(soz_array)
      for m=1:numel(soz_array)
        SOZarray{n,m}=[soz_array(n) soz_array(m)];
        locations{n,m}=[location_array(n) location_array(m)];  
      end;
  end;

 fripple_mi_matrix=zeros(numel(unique_electrodes), numel(unique_electrodes));
 fripple_sign_p_matrix=ones(numel(unique_electrodes), numel(unique_electrodes));
 fripple_sign_z_matrix=zeros(numel(unique_electrodes), numel(unique_electrodes));
 mean_delay=zeros(numel(unique_electrodes), numel(unique_electrodes));
 std_delay=zeros(numel(unique_electrodes), numel(unique_electrodes));
 spike_distance=inf(numel(unique_electrodes), numel(unique_electrodes));
 incount=zeros(numel(unique_electrodes), numel(unique_electrodes));
 outcount=zeros(numel(unique_electrodes), numel(unique_electrodes));
 signcount=zeros(numel(unique_electrodes), numel(unique_electrodes));

 % Initialize properties fields for new table 
 FR_patient=[];
 FR_pairnum=[];
 FR_electrode_1={};
 FR_electrode_2={};
 FR_inout=[];
 FR_freqs=[];
 FR_duration=[];
 FR_power=[];
 FR_sign=[];
 FR_delay=[];
 FR_start_t=[];
 FR_block=[];
 FR_distance=[];
 FR_montage={};
 FR_slow_angle=[];
 FR_delta_angle=[];
 FR_elec1_SOZ=[];
 FR_elec2_SOZ=[];
 FR_elec1_loc=[];
 FR_elec2_loc=[];

 % Find number of file blocks 
 % find frequency, duration, power, t-onset in the in electrode
 % (define by Z), find frq
 collection = "HFOs";
 test_query=['{"patient_id":"' RESP{i} '"}'];
 blocks=distinct(conn, collection, 'file_block','query',test_query);
 blocks=cellfun(@str2num, blocks);
 
 file_id=distinct(conn, collection, 'file', 'query',test_query);
 fileid_matrix={};
 fileblock_matrix={};
 for j=1:numel(unique_electrodes)
     for k=1:numel(unique_electrodes)
         fileid_matrix{j,k}=file_id;
         fileblock_matrix{j,k}=blocks;
     end;
 end;

 for j=1:numel(unique_electrodes)
 in=[];
 in_frono=[];  
 for z=1:numel(blocks)
     test_query=['{"patient_id":"' RESP{i} '","electrode":"' unique_electrodes{j} '","file_block":"' num2str(blocks(z)) '", "type":"' num2str(4) '","freq_pk": {$gt:200} }'];
     docs = find(conn,collection,'query',test_query,'limit',5000);
     if ~isempty(docs)
     if numel(docs)==1
     in_t=docs.start_t;
     else
     docs=struct2table(docs);
     in_t=docs.start_t;
     end;
     else
     in_t=[];
     end;
     if z == 1
         in_frono = in_t;
     else 
         in_t=(in_t+(600*(z-1)));
         in_frono = vertcat(in_frono,in_t);
     end;
 end;    
 
 in = [in_frono];
 in = sort(in,'ascend');
 
 if numel(in) == 0
   for k=1:numel(unique_electrodes)
      fripple_mi_matrix(j,k)=0;
  end;
 else     
  for k=1:numel(unique_electrodes)
    out=[];  
    out_frono=[];  
       for z=1:numel(blocks)  
         test_query=['{"patient_id":"' RESP{i} '","electrode":"' unique_electrodes{k} '","file_block":"' num2str(blocks(z)) '", "type":"' num2str(4) '","freq_pk": {$gt:200} }'];
         docs = find(conn,collection,'query',test_query,'limit',5000);
         if ~isempty(docs)
         if numel(docs)==1
         out_t=docs.start_t;
         else
         docs=struct2table(docs);
         out_t=docs.start_t;
         end;
         else
         out_t=[];
         end;
       if z == 1
         out_frono = out_t;
       else 
         out_t=(out_t+(600*(z-1)));
         out_frono = vertcat(out_frono,out_t);
     end;
   end;    
  
 out = [out_frono];
 out = sort(out,'ascend');
 incount(j,k)=numel(in);
 outcount(j,k)=numel(out);
 
 if numel(out) == 0
     fripple_mi_matrix(j,k)=0;
     fripple_sign_p_matrix(j,k)=1;
     fripple_sign_z_matrix(j,k)=0;
     spike_distance(j,k)=inf;
     signcount(j,k)=0;
     mean_delay(j,k)=0;
     std_delay(j,k)=0;
 else
     mi = AIMIE(in,out);
     if isnan(mi)
        fripple_mi_matrix(j,k)=0;
     else
     if mi==0
        fripple_mi_matrix(j,k)=0;
     else   
     fripple_mi_matrix(j,k)=mi;
     end;
     end;   
   spike_distance(j,k)=spkd(in,out,1);
   [temp1,temp2]=meshgrid(in,out);
   temp3=temp2-temp1;
   temp4=reshape(temp3,[(numel(temp3(1,:))*numel(temp3(:,1))) 1]);
   [a,b]=find(abs(temp4)<0.251);
   test_prop=temp4(a);
   if numel(test_prop>2)
   [p, h, stats] = signtest(test_prop,'alpha',0.05,'method','approximate');
   fripple_sign_p_matrix(j,k)=p;
   fripple_sign_z_matrix(j,k)=stats.zval;
   signcount(j,k)=numel(test_prop);
   mean_delay(j,k)=mean(test_prop);
   std_delay(j,k)=std(test_prop)/(sqrt(numel(test_prop)));
  
   % Build Fast ripple properties table, disambiguate in and out nodes
   if p <= 0.005
       pair_count=pair_count+1;
         if stats.zval > 0
            in_node=j;
            out_node=k;
            temp_delay=mean_delay(j,k);
         else
            in_node=k;
            out_node=j;
            [temp1,temp2]=meshgrid(in,out);
            temp3=temp1-temp2;
            temp4=reshape(temp3,[(numel(temp3(1,:))*numel(temp3(:,1))) 1]);
            [a,b]=find(abs(temp4)<0.251);
            test_prop=temp4(a);
            temp_delay=-mean_delay(j,k)
         end;

        %in node 
        docs=[];
        for z=1:numel(blocks)
        test_query=['{"patient_id":"' RESP{i} '","electrode":"' unique_electrodes{in_node} '","file_block":"' num2str(blocks(z)) '", "type":"' num2str(4) '","freq_pk": {$gt:200} }'];
        doc = find(conn,collection,'query',test_query,'limit',5000);
        if ~isempty(doc)
            if numel(doc)==1
               doc=struct2table(doc,'AsArray',1)
            else
            doc=struct2table(doc);
            end;
            [start_t,idx] = sort(doc.start_t,'ascend');
            doc=doc(idx,:);
            if z == 1
                start_t = start_t;
            else
                start_t=(start_t+(600*(z-1)));
            end;
            doc.start_t=start_t;
            if ~iscell(doc.delta_angle(1))
                doc.delta_vs=num2cell(doc.delta_vs);
                doc.delta_angle=num2cell(doc.delta_angle);
            end;
            if ~iscell(doc.slow_angle(1))
                doc.slow_vs=num2cell(doc.slow_vs);
                doc.slow_angle=num2cell(doc.slow_angle);
            end;
            if ~iscell(doc.theta_angle(1))
                doc.theta_vs=num2cell(doc.theta_vs);
                doc.theta_angle=num2cell(doc.theta_angle);
            end;
            if ~iscell(doc.spindle_angle(1))
                doc.spindle_vs=num2cell(doc.spindle_vs);
                doc.spindle_angle=num2cell(doc.spindle_angle);
            end;
        else
            doc=[];
        end;
        docs=vertcat(docs,doc);
        end;

        FR_freqs=vertcat(FR_freqs,docs.freq_pk);
        FR_duration=vertcat(FR_duration,docs.duration);
        FR_power=vertcat(FR_power,docs.power_pk);
        FR_sign_t=zeros(numel(docs.power_pk),1);
        FR_start_t=vertcat(FR_start_t,docs.start_t);
        FR_block=vertcat(FR_block,docs.file_block);
        FR_distance=vertcat(FR_distance, (ones(numel(docs.power_pk),1)*distance_matrix(j,k)));
        FR_montage_t=cell(numel(docs.power_pk),1);
        FR_montage_t(:)=montage_matrix(j,k);
        FR_montage=vertcat(FR_montage, FR_montage_t);
        if iscell(docs.slow_angle)
            emptyIndex = cellfun('isempty', docs.slow_angle);     
            docs.slow_angle(emptyIndex) = {NaN};                   
            temp_slow_angle = cell2mat(docs.slow_angle);
        else
            temp_slow_angle=docs.slow_angle;
        end;
        if iscell(docs.delta_angle)
            emptyIndex = cellfun('isempty', docs.delta_angle);     
            docs.delta_angle(emptyIndex) = {NaN};                    
            temp_delta_angle = cell2mat(docs.delta_angle);
        else
            temp_delta_angle=docs.delta_angle;
        end;
        FR_slow_angle=vertcat(FR_slow_angle, temp_slow_angle);
        FR_delta_angle=vertcat(FR_delta_angle, temp_delta_angle);
        SOZ_t=SOZarray{j,k};
        elec1_SOZ_t=SOZ_t(1);
        elec2_SOZ_t=SOZ_t(2);
        FR_elec1_SOZ=vertcat(FR_elec1_SOZ, (ones(numel(docs.power_pk),1)*elec1_SOZ_t));
        FR_elec2_SOZ=vertcat(FR_elec2_SOZ, (ones(numel(docs.power_pk),1)*elec2_SOZ_t));
        loc_t=locations{j,k};
        loc_e1_t=loc_t(1);
        loc_e2_t=loc_t(2);      
        FR_elec1_loc=vertcat(FR_elec1_loc, (ones(numel(docs.power_pk),1)*loc_e1_t));
        FR_elec2_loc=vertcat(FR_elec2_loc, (ones(numel(docs.power_pk),1)*loc_e1_t));

        % find start_t in test_prop
        for m=1:numel(docs.power_pk)
            if numel(temp3(1,:))~=numel(docs.power_pk)
              for n=1:numel(temp3(1,:))
                if ~isempty(intersect((temp3(m,n)),test_prop))
                    FR_sign_t(m)=1;
                end;
              end;  
            else
              for n=1:numel(temp3(:,1))
                if ~isempty(intersect(abs(temp3(n,m)),test_prop))
                    FR_sign_t(m)=1;
                end;
              end;  
            end;
        end;

        FR_sign=vertcat(FR_sign, FR_sign_t);
        FR_delay=vertcat(FR_delay, (ones(numel(docs.power_pk),1)*temp_delay));
        FR_pairnum=vertcat(FR_pairnum, (ones(numel(docs.power_pk),1)*pair_count)); % * size of docs
        FR_patient=vertcat(FR_patient, (ones(numel(docs.power_pk),1)*i)); % size of docs
        temp_electrode_1=(cell(numel(docs.power_pk),1));
        temp_electrode_2=(cell(numel(docs.power_pk),1));
        temp_electrode_1(:)=unique_electrodes(j);
        temp_electrode_2(:)=unique_electrodes(k);
        FR_electrode_1=vertcat(FR_electrode_1, temp_electrode_1);
        FR_electrode_2=vertcat(FR_electrode_2, temp_electrode_2); 

        FR_inout=vertcat(FR_inout, (ones(numel(docs.power_pk),1)*0)); % zeros for size of docs for in and ones for size of docs for outs
       
        % out node
        docs=[];
        for z=1:numel(blocks)
            test_query=['{"patient_id":"' RESP{i} '","electrode":"' unique_electrodes{out_node} '","file_block":"' num2str(blocks(z)) '", "type":"' num2str(4) '","freq_pk": {$gt:200} }'];
            doc = find(conn,collection,'query',test_query,'limit',5000);
        if ~isempty(doc)
        if numel(doc)==1
            doc=struct2table(doc,'AsArray',1)
        else
            doc=struct2table(doc);
        end;     
            [start_t,idx] = sort(doc.start_t,'ascend');
            doc=doc(idx,:);
            if z == 1
                start_t = start_t;
            else
                start_t=(start_t+(600*(z-1)));
            end;
            doc.start_t=start_t;
            if ~iscell(doc.delta_angle(1))
                doc.delta_vs=num2cell(doc.delta_vs);
                doc.delta_angle=num2cell(doc.delta_angle);
            end;
            if ~iscell(doc.slow_angle(1))
                doc.slow_vs=num2cell(doc.slow_vs);
                doc.slow_angle=num2cell(doc.slow_angle);
            end;
            if ~iscell(doc.theta_angle(1))
                doc.theta_vs=num2cell(doc.theta_vs);
                doc.theta_angle=num2cell(doc.theta_angle);
            end;
            if ~iscell(doc.spindle_angle(1))
                doc.spindle_vs=num2cell(doc.spindle_vs);
                doc.spindle_angle=num2cell(doc.spindle_angle);
            end;
        else
            doc=[];
        end;
            docs=vertcat(docs,doc);
        end;

        FR_freqs=vertcat(FR_freqs,docs.freq_pk);
        FR_duration=vertcat(FR_duration,docs.duration);
        FR_power=vertcat(FR_power,docs.power_pk);
        FR_start_t=vertcat(FR_start_t,docs.start_t);
        FR_block=vertcat(FR_block,docs.file_block);
        FR_sign_t=zeros(numel(docs.power_pk),1);
        FR_distance=vertcat(FR_distance, (ones(numel(docs.power_pk),1)*distance_matrix(j,k)));
        FR_montage_t=cell(numel(docs.power_pk),1);
        FR_montage_t(:)=montage_matrix(j,k);
        FR_montage=vertcat(FR_montage, FR_montage_t);
        if iscell(docs.slow_angle)
            emptyIndex = cellfun('isempty', docs.slow_angle);     % Find indices of empty cells
            docs.slow_angle(emptyIndex) = {NaN};                    % Fill empty cells with 0
            temp_slow_angle = cell2mat(docs.slow_angle);
        else
            temp_slow_angle=docs.slow_angle;
        end;
        if iscell(docs.delta_angle)
            emptyIndex = cellfun('isempty', docs.delta_angle);     % Find indices of empty cells
            docs.delta_angle(emptyIndex) = {NaN};                    % Fill empty cells with 0
            temp_delta_angle = cell2mat(docs.delta_angle);
        else
            temp_delta_angle=docs.delta_angle;
        end;
        FR_slow_angle=vertcat(FR_slow_angle, temp_slow_angle);
        FR_delta_angle=vertcat(FR_delta_angle, temp_delta_angle);
        SOZ_t=SOZarray{j,k};
        elec1_SOZ_t=SOZ_t(1);
        elec2_SOZ_t=SOZ_t(2);
        FR_elec1_SOZ=vertcat(FR_elec1_SOZ, (ones(numel(docs.power_pk),1)*elec1_SOZ_t));
        FR_elec2_SOZ=vertcat(FR_elec2_SOZ, (ones(numel(docs.power_pk),1)*elec2_SOZ_t));
        loc_t=locations{j,k};
        loc_e1_t=loc_t(1);
        loc_e2_t=loc_t(2);      
        FR_elec1_loc=vertcat(FR_elec1_loc, (ones(numel(docs.power_pk),1)*loc_e1_t));
        FR_elec2_loc=vertcat(FR_elec2_loc, (ones(numel(docs.power_pk),1)*loc_e1_t));

        % find start_t in test_prop
        for m=1:numel(docs.power_pk)
            if numel(temp3(1,:))~=numel(docs.power_pk)
              for n=1:numel(temp3(1,:))
                if ~isempty(intersect(abs(temp3(m,n)),test_prop))
                    FR_sign_t(m)=1;
                end;
              end;  
            else
              for n=1:numel(temp3(:,1))
                if ~isempty(intersect(abs(temp3(n,m)),test_prop))
                    FR_sign_t(m)=1;
                end;
              end;  
            end;
        end;
        FR_sign=vertcat(FR_sign, FR_sign_t);
        FR_delay=vertcat(FR_delay, (ones(numel(docs.power_pk),1)*temp_delay));
        FR_pairnum=vertcat(FR_pairnum, (ones(numel(docs.power_pk),1)*pair_count)); % * size of docs
        FR_patient=vertcat(FR_patient, (ones(numel(docs.power_pk),1)*i)); % size of docs
        temp_electrode_1=(cell(numel(docs.power_pk),1));
        temp_electrode_2=(cell(numel(docs.power_pk),1));
        temp_electrode_1(:)=unique_electrodes(j);
        temp_electrode_2(:)=unique_electrodes(k);
        FR_electrode_1=vertcat(FR_electrode_1, temp_electrode_1);
        FR_electrode_2=vertcat(FR_electrode_2, temp_electrode_2); 
        FR_inout=vertcat(FR_inout, (ones(numel(docs.power_pk),1)*1)); % zeros for size of docs for in and ones for size of docs for outs
   end; % end properties table

   else
   fripple_sign_p_matrix(j,k)=1;
   fripple_sign_z_matrix(j,k)=0;
   signcount(j,k)=0;
   mean_delay(j,k)=0;
   std_delay(j,k)=0;
   end;

 end;
 if j==k
     fripple_mi_matrix(j,k)=0;
     fripple_sign_p_matrix(j,k)=1;
     fripple_sign_z_matrix(j,k)=0;
     spike_distance(j,k)=inf;
     signcount(j,k)=0;
     mean_delay(j,k)=0;
     std_delay(j,k)=0;
 end;    
 end;
 end;
 end;

Slow_Z=[];
Slow_A=[];
Slow_p=[];
Delta_Z=[];
Delta_A=[];
Delta_p=[];
for j=1:numel(unique_electrodes)
%determine number of slow fast ripples > 200 Hz
test_query=['{"patient_id":"' RESP{i} '","electrode":"' unique_electrodes{j} '","type":"' num2str(4) '","freq_pk": {$gt:200} }'];
docs = find(conn,collection,'query',test_query,'limit',5000);
sum_slow=0;
sum_delta=0;
slow_phasor=[];
delta_phasor=[];
for l=1:numel(docs)
   if docs(l).slow == 1
       sum_slow=sum_slow+1;
       slow_phasor=[slow_phasor docs(l).slow_angle];

   end;
   if docs(l).delta 
       sum_delta=sum_delta+1;
       delta_phasor=[delta_phasor docs(l).delta_angle];
   end;
end;

if sum_slow > 3
% add to output arrays
[pval z] = circ_rtest(slow_phasor);
[mu ul ll] = circ_mean(slow_phasor');
if isempty(mu)
    fprintf('mu empty')
    mu=NaN;
end;
Slow_Z=[Slow_Z z];
Slow_A=[Slow_A mu];
Slow_p=[Slow_p pval];
else
Slow_Z=[Slow_Z 0];
Slow_A=[Slow_A NaN];
Slow_p=[Slow_p 1];
end;

if sum_delta > 3
[pval z] = circ_rtest(delta_phasor);
[mu ul ll] = circ_mean(delta_phasor');
if isempty(mu)
    fprintf('mu empty')
    mu=NaN;
end;
Delta_Z=[Delta_Z z];
Delta_A=[Delta_A mu];
Delta_p=[Delta_p pval];
else
Delta_Z=[Delta_Z 0];
Delta_A=[Delta_A NaN];
Delta_p=[Delta_p 1];
end;
end;

Slow_Z_array={};
Slow_A_array={};
Slow_p_array={};
Delta_Z_array={};
Delta_A_array={};
Delta_p_array={};
for j=1:numel(unique_electrodes)
    for k=1:numel(unique_electrodes)
         Slow_Z_array{j,k}=[Slow_Z(j) Slow_Z(k)];
         Slow_A_array{j,k}=[Slow_A(j) Slow_A(k)];
         Slow_p_array{j,k}=[Slow_p(j) Slow_p(k)];
         Delta_Z_array{j,k}=[Delta_Z(j) Delta_Z(k)];
         Delta_A_array{j,k}=[Delta_A(j) Delta_A(k)];
         Delta_p_array{j,k}=[Delta_p(j) Delta_p(k)];
    end;
end;
fileidVector = reshape(fileid_matrix, [], 1);
fileblockVector = reshape(fileblock_matrix, [], 1);
chnameVector = reshape(chname_matrix, [], 1);
montageVector = reshape(montage_matrix, [], 1);
xcoordVector = reshape(xcoord_matrix, [], 1);
ycoordVector = reshape(ycoord_matrix, [], 1);
zcoordVector = reshape(zcoord_matrix, [], 1);
DistanceVector = reshape(distance_matrix, [], 1);
xDistanceVector = reshape(xdistance_matrix, [], 1);
yDistanceVector = reshape(ydistance_matrix, [], 1);
zDistanceVector = reshape(zdistance_matrix, [], 1);
SOZstatusVector= reshape(SOZarray, [], 1);
fripple_mi_matrix = reshape(fripple_mi_matrix, [], 1);
fripple_sign_p_matrix = reshape(fripple_sign_p_matrix, [], 1);
fripple_sign_z_matrix = reshape(fripple_sign_z_matrix, [], 1);
mean_delay = reshape(mean_delay, [], 1);
std_delay = reshape(std_delay, [], 1);
spike_distance = reshape(spike_distance, [], 1);
incount = reshape(incount, [], 1);
outcount = reshape(outcount, [], 1);
signcount = reshape(signcount, [], 1);
patientvector = (ones(numel(DistanceVector),1))*i;
respondervector = ones(numel(patientvector),1)*status(i);
locations = reshape(locations, [], 1); 
Slow_Z_array=reshape(Slow_Z_array, [], 1);
Slow_A_array=reshape(Slow_A_array, [], 1);
Slow_p_array=reshape(Slow_p_array, [], 1);
Delta_Z_array=reshape(Delta_Z_array, [], 1);
Delta_A_array=reshape(Delta_A_array, [], 1);
Delta_p_array=reshape(Delta_p_array, [], 1);

[a,b]=find(fripple_mi_matrix==0);
temp_table=table(fileidVector, fileblockVector, chnameVector, montageVector, xcoordVector, ycoordVector, zcoordVector, DistanceVector, xDistanceVector, yDistanceVector, zDistanceVector, SOZstatusVector, fripple_mi_matrix, fripple_sign_p_matrix, fripple_sign_z_matrix, mean_delay, std_delay, spike_distance, incount, outcount, signcount, patientvector, respondervector, locations, Slow_Z_array, Slow_A_array, Slow_p_array, Delta_Z_array, Delta_A_array, Delta_p_array);
temp_table(a,:)=[];
temp_properties_table=table(FR_patient,FR_pairnum,FR_electrode_1,FR_electrode_2,FR_inout,FR_freqs,FR_duration,FR_power,FR_sign, FR_start_t, FR_block, FR_delay, FR_distance, FR_montage, FR_slow_angle, FR_delta_angle, FR_elec1_SOZ, FR_elec2_SOZ, FR_elec1_loc, FR_elec2_loc);
processed=vertcat(processed,temp_table);
properties=vertcat(properties,temp_properties_table);
end;

