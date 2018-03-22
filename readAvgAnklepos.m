function [AverageAnklePosition] = readAvgAnklepos( parentfolder, string, colheader_start_line)
%Reads CALEX Each_Cycle Files, now follows ANkleposition template but can
%be edited.
%   Outputs Ankleposition in x and y, reads each x and y column, ignored z
%   position columns.
%   make more lines to 
    
    filelist = rdir( [ parentfolder, strcat( string ) ]);
    
    fprintf( ['Reading ', string(2:end) ,  ' files...' ] )
    aposx = [];
    aposy = [];
    
    filedata = importdata(filelist.name, '\t', colheader_start_line);
        
    aposx = [aposx, filedata.data(:, 1)];  
    aposy = [aposy, filedata.data(:, 2)];
    
    fprintf( 'Done!\n' )
    
    AverageAnklePosition.x = aposx;
    AverageAnklePosition.y = aposy;
    

end

