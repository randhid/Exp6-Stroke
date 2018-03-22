function [AnklePositions] = readAnklepos(parentfolder, string, colheader_start_line)
%Reads CALEX Each_Cycle Files, follows the _anklepositions text file
%template.
% Outputs a structure of AnklePositions in x (col j) and y (col j+1). 
% Ignores z by having 
%   Outputs Ankleposition in x and y, reads each x and y column, ignored z
%   position columns.
%   make more lines to 
    
    filelist = rdir([parentfolder,strcat(string)]);
    
    fprintf( ['Reading ',  string(2:end) , ' files...'])
    aposx = [];
    aposy = [];
    for i = 1:length(filelist)
        if strfind(filelist(i).name, '~')
            continue %% skip files with "~" in the file name
    else
        filedata = importdata(filelist(i).name, '\t', colheader_start_line);
        
        for j = 1:3:length(filedata.colheaders)
            aposx = [aposx, filedata.data(:, j)];  
            aposy = [aposy, filedata.data(:, j+1)];
        end
        end
    
        
    end
    fprintf('Done! \n')

    AnklePositions.x = aposx; 
    AnklePositions.y = aposy;
end

