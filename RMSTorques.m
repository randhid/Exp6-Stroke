function [ avgall, sdall ] = RMSTorques( parentfolder, string )
% Calculates the Average and SD RMS Error for all 4 degrees of freedom
% for one subject
% inputs - string of case looked at, subject number

filelist = rdir([parentfolder, strcat( string ) ] );
alltorques = [];

for i = 1:length(filelist)
    filedata = importdata(filelist(i).name, '\t', 1);
    torques.desired = filedata.data(:, 1:4);
    torques.actual = filedata.data(:, 17:20);
    alltorques = [ alltorques, torques];
end

rmseall = [];
for i = 1:length(alltorques)
    rmse.ee1 = RMSError(alltorques(i).desired(:,1), ...
        alltorques(i).actual(:,1));
    rmse.ee2 = RMSError(alltorques(i).desired(:,2),  ...
        alltorques(i).actual(:,2));
    rmse.ee3 = RMSError(alltorques(i).desired(:,3), ...
        alltorques(i).actual(:,3));
    rmse.ee4 = RMSError(alltorques(i).desired(:,4), ...
        alltorques(i).actual(:,4));
    rmseall = [rmseall, rmse];
end

avgall = [];
sdall = [];
    avg.hip = mean([rmse.ee1]);
    avg.knee = mean([rmse.ee2]);
    avg.hipadd = mean([rmse.ee3]);
    avg.hipinv = mean([rmse.ee4]);
    sd.hip = std([rmse.ee1]);
    sd.knee = std([rmse.ee2]);
    sd.hipadd = std([rmse.ee3]);
    sd.hipinv = std([rmse.ee4]);
    avgall = [avgall, avg];
    adall = [sdall, sd];


end

