function [ parentfolder ] = SelectFolder( variable, sbjstr )
% C-ALEX data files are in a dropbox on someone's computer in the parenfolder format. 
% dropboxstr - user's dropbox name, 
% variable is the variable you're looking at, usually grouped in a file
% folder
% sbjstr is the subject number.
% outputs a foldder path in CHARACTER format
        

        parentfolder = 'C:\Users\*\Dropbox\Exp6-Stroke\variable\sbjstr' ; %change sub number for next file!!!
        %parentfolder = strrep(parentfolder, 'dropboxstr', dropboxstr);
        parentfolder = strrep(parentfolder, 'sbjstr', sbjstr);
        parentfolder = strrep(parentfolder, 'variable', variable);
        parentfolder = char(parentfolder);
        
end

