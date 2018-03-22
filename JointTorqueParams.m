function JointTorqueParams( subjectnumber )


% Filepath for Experiment data
parentfolder = SelectFolder( 'clx_JointTorque', subjectnumber );

%% Joint Torques

%%%%%%%%%%%%%%%%%%%%%Overground%%%%%%%%%%%%%%%%%%%%%
% Transparent mode
JTogtr = rdir([parentfolder,strcat('\*og_tr*.txt')]);
[dtogtrmean, dtogtrstd, ptogtrmean, ptogtrstd, atogtrmean, atogtrstd] = readJT(JTogtr, 6);

% Active mode
JTogff = rdir([parentfolder,strcat('\*og_ff*.txt')]);
[dtogffmean, dtogffstd, ptogffmean, ptogffstd, atogffmean, atogffstd] = readJT(JTogff, 6);

%%%%%%%%%%%%%%%%%%%%%Treadmill%%%%%%%%%%%%%%%%%%%%%
% Transparent mode
JTtmtr = rdir([parentfolder,strcat('\*tm_tr*.txt')]);
[dttmtrmean, dttmtrstd, pttmtrmean, pttmtrstd, attmtrmean, attmtrstd] = readJT(JTtmtr, 6);

% Active mode
JTtmff = rdir([parentfolder,strcat('\*tm_ff*.txt')]);
[dttmffmean, dttmffstd, pttmffmean, pttmffstd, attmffmean, attmffstd] = readJT(JTtmff, 6);


%% Plot Stuff
%%ff overground
plotJTavgs(dtogffmean, ptogffmean, atogffmean,1), title('End Effector 1, Force Field Overground')
plotJTavgs(dtogffmean, ptogffmean, atogffmean,2)
plotJTavgs(dtogffmean, ptogffmean, atogffmean,3)
plotJTavgs(dtogffmean, ptogffmean, atogffmean,4)


%%ff treadmill
plotJTavgs(dttmffmean, pttmffmean, attmffmean,1), title('End Effector 1, Force Field Treadmill')
plotJTavgs(dttmffmean, pttmffmean, attmffmean,2)
plotJTavgs(dttmffmean, pttmffmean, attmffmean,3)
plotJTavgs(dttmffmean, pttmffmean, attmffmean,4)

%% tr overground
plotJTavgs(dtogtrmean, ptogtrmean, atogtrmean,1), title('End Effector 1, Transparent Overground')
plotJTavgs(dtogtrmean, ptogtrmean, atogtrmean,2)
plotJTavgs(dtogtrmean, ptogtrmean, atogtrmean,3)
plotJTavgs(dtogtrmean, ptogtrmean, atogtrmean,4)

%% tr treadmill
plotJTavgs(dttmtrmean, pttmtrmean, attmtrmean,1), title('End Effector 1, Transparent Treadmill')
plotJTavgs(dttmtrmean, pttmtrmean, attmtrmean,2)
plotJTavgs(dttmtrmean, pttmtrmean, attmtrmean,3)
plotJTavgs(dttmtrmean, pttmtrmean, attmtrmean,4)


end
