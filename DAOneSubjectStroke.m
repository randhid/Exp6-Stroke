function [ average, standard_dev] = DAOneSubjectStroke( subject , lap )
% This calcualtes the deviation area between the average ankle trajectory
% of Active mode with the target of treadmill and Overground each.


parentfolder = SelectFolder('clx_anklepos', subject);

%% Gait Templates

TFile = rdir( [parentfolder, strcat('\*GaitTemplate*.txt')] );

% Importing gait templates:
Temp = importdata(TFile.name, '\t', 3);
P.TargetX = Temp.data(:,8);
P.TargetY = Temp.data(:,9); % get targe x and y gait positions from column 8 and 9 in template data


%% Anklepositions
%%%%%%%%%%%%%%%%%%%%%Overground%%%%%%%%%%%%%%%%%%%%%
%Active mode
[A] = readAnklepos(parentfolder, ['\*_training*', lap, '.txt' ] , 1); %Each Cycle


%% Plots and Deviation Areas
% Add figure handle to inputs to function for plots.
[da_ogff, ~ , ref] = calculateDAparams(A.x, A.y, P.TargetX, P.TargetY); %

%% Calculating Means and Standard Deviations for Deviation Areas
%Deviation Areas
average.A = mean(da_ogff./ref);
standard_dev.A = std(da_ogff./ref);


end

