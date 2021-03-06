function [ja1, ja2, ja3] = readJAeachcycle(filelist, colheader_start_line)
%Reads CALEX Each_Cycle Files, now follows ANkleposition template but can
%be edited.
%   Outputs Ankleposition in x and y, reads each x and y column, ignored z
%   position columns.
%   make more lines to 

    fprintf('Reading  files...')
    ja1 = [];
    ja2 = [];
    ja3 = [];
    
    for i = 1:length(filelist)
        if strfind(filelist(i).name, '~')
            continue %% skip files with "~" in the file name
    else
        filedata = importdata(filelist(i).name, '\t', colheader_start_line);
        
        for j = 1:4:length(filedata.colheaders)
            ja1 = [ja1, filedata.data(:, j)];  
            ja2 = [ja2, filedata.data(:, j+1)];
            ja3 = [ja3, filedata.data(:, j+3)];
        end
        end
    fprintf('Done! \n')
    end

end

