function [dtmean, dtstd, ptmean, ptstd, atmean, atstd, holder] = readJT(filelist, colheader_line)
%%
%%Outputs 2 of nx4 arrays
    holder = [];
    dtmean = [];
    dtstd  = [];
    ptmean = [];
    ptstd  = [];
    atmean = [];
    atstd  = [];
  
    for i = 1:length(filelist)
        if strfind(filelist(i).name, '~')
            continue
        else
            filedata = importdata(filelist(i).name, '\t', colheader_line);
            holder = [holder, filedata];
%                 if type == 1
                    dtmean = [dtmean, holder(i).data(:,1:4)];
                    dtstd  = [dtstd, holder(i).data(:,5:8)];
%                 elseif type == 2
                    ptmean = [ptmean, holder(i).data(:,9:12)];
                    ptstd  = [ptstd, holder(i).data(:,13:16)];
%                 elseif type == 3
                    atmean = [atmean, holder(i).data(:,17:20)];
                    atstd  = [atstd, holder(i).data(:,21:24)];       
%                 else
%                     fprintf('Not right!')
%                 end
        end
    end
       



end