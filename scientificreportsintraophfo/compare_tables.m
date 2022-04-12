function [comparison_t] = compare_tables(output_t,output_t_io)

values=output_t{:,2};
values_io=output_t_io{:,2};
for i=1:numel(values)
    channel_names{i}=values{i,1}{1};
end;
for i=1:numel(values_io)
    if iscell(values_io{i,1})
       channel_names_io{i}=(values_io{i,1}{1,1});
    else
       channel_names_io{i}=(values_io{i,1});
    end;   
end;
[LIA,match_index]=ismember(channel_names_io,channel_names);
counter=0;
for i=1:numel(match_index)
    if match_index(i)>0
        counter=counter+1
        pat_name=table2cell(output_t_io(i,1));
        pat_name=pat_name{1};
        chan_name=(channel_names_io(1,i));
        soz=table2cell(output_t(match_index(i),3));
        soz=soz{1};
        if ischar(soz)
            soz=str2num(soz);
        end;        
        mt=table2cell(output_t_io(i,4));
        mt=mt{1};
        if ischar(mt)
            mt=str2num(mt);
        end;
        loc3=table2cell(output_t(match_index(i),5));
        loc3=loc3;
        rates_io=table2cell(output_t_io(i,5));
        rates_io=rates_io{1};
        rates_sleep=table2cell(output_t(match_index(i),6));
        rates_sleep=rates_sleep{1};
        if counter==6
        temp_t=table(pat_name, chan_name, soz, mt, loc3, rates_io, rates_sleep);
        else
        temp_t=table(pat_name, chan_name, soz, mt, loc3, rates_io, rates_sleep);   
        end;
        if counter == 1 
            comparison_t=temp_t;
        else
            comparison_t=vertcat(comparison_t, temp_t);
        end;
    end;
end;
