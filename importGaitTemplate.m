function [ ref ] = importGaitTemplate( parentfolder, string, colheader_start_line )
% returns a vector of baseline ankle positions, and Target ankle positions 
% inputs: parentfold path, walking type, columnheaders line in text file.

%To do - make new sturcture entreis for joint angles and z end-effector
%position

    Template_File = rdir([parentfolder, strcat(string)]);
    
    Template_Data = importdata(Template_File.name, '\t', colheader_start_line);
    
    ref.TargetX = Template_Data.data(:,8);
    ref.TargetY = Template_Data.data(:,9);
    
    ref.BaselineX = Template_Data.data(:,1);
    ref.BaselineY = Template_Data.data(:,2);
    

end

