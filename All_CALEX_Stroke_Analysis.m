%% clear
    clc;
    clear;
    close all;
    addpath(pwd);

%% Single Subject and multiple subject list
    Single_Subject = "*1";
    Subject_List = [ "*1", "*3", "*4" ];

% %% Extracting JointTorques
%     JointTorqueParams( Single_Subject )
%     
% %% Joint Torque Error for One Subject
% % This calculates the Root Mean Square Error for cable tensions for one 
% % subject.
% parentfolderJT = 'C:\Users\ROARLab\Dropbox\Exp6-Stroke\clx_JT_Avg';
% [ ogavg, ~ ] = RMSTorques( parentfolderJT, '\s004*og*.txt' ) ; 
% [ tmavg, ~] = RMSTorques( parentfolderJT, '\s004*tm_ff*.txt' ); %Treadmill
% 
% %% Joint Joint Torque Error for All Subjects
% parentfolderJT = 'C:\Users\ROARLab\Dropbox\Exp6-Overground\clx_JT_Avg'; 
% for i = 1: length(Subject_List)
%     [ ogavg, ~ ] = RMSTorques( parentfolderJT, ['\', char( Subject_List(i) ), '*og*.txt'] ) ; %OverGround
%     [ tmavg, ~ ] = RMSTorques( parentfolderJT, ['\', char( Subject_List(i) ), '*tm*.txt'] ); %Treadmill  
%     allavg.og(i) = ogavg;
%     allavg.tm(i) = tmavg;
% end
%  
%  RMS_Error.og.avg = mean( [allavg.og.hip] );
%  RMS_Error.og.hip.sd = std( [allavg.og.hip] );
%  
%  RMS_Error.og.knee.avg = mean( [allavg.og.knee] );
%  RMS_Error.og.knee.sd = std( [allavg.og.knee] );
%  
%  
%  RMS_Error.tm.hip.avg = mean( [allavg.tm.hip] );
%  RMS_Error.tm.hip.sd = std( [allavg.tm.hip] );
%  
%  RMS_Error.tm.knee.avg = mean( [allavg.tm.knee] );
%  RMS_Error.tm.knee.sd = std( [allavg.tm.knee] );

%% Ankle ROM and Plots for one subject:
    [ ROM ] = AnkleAnalysisStroke( Single_Subject, 1 ); % Second input produces a plot

%% Ankle Kinematics and optoional Plots of all subjects
    for i  = 1:length(Subject_List)
        allROM(i) = AnkleAnalysisStroke( char( Subject_List(i) ), 1);
    end
    
%% Means of Ankle Kinematics     
    Step_Means = getAvgKinematicsStroke(allROM);
    plotGaitKinematicsStroke(allROM, 1, 1, 'Average Step Length', ' cm')
    plotGaitKinematicsStroke(allROM, 1, 2, 'Average Step Height', ' cm')
    
%% Plotting Gait Kinematics
    plotGaitKinematicsStroke(allROM, 1, 1, 'Step Length', ' cm')
    plotGaitKinematicsStroke(allROM, 1, 2, 'Step Height', ' cm')

    plotGaitKinematicsStroke(allROM, 2, 1, 'Step Length', ' cm')
    plotGaitKinematicsStroke(allROM, 2, 2, 'Step Height', ' cm')

    plotGaitKinematicsStroke(allROM, 3, 1, 'Step Length', ' cm')
    plotGaitKinematicsStroke(allROM, 3, 2, 'Step Height', ' cm')

%% Joint Angles
    JAAnalysisStroke( Single_Subject, 1 )
 
%% Joint Angle Peaks Single Subject
    [Peak_Locations, Peak_Magnitudes, Peak_Changes] = ...
        JointAnglePeaksOverground( Single_Subject );
    
%% All subjects
for i = 1:length(Subject_List)
    [ all_Peak_Locations(i), all_Peak_Magnitudes(i), all_Peak_Changes(i) ] =...
        JointAnglePeaksOverground( Subject_List(i) );
end


%% Deviation Area for one Subject
    [ DA ] = DAOneSubjectStroke( Single_Subject, '' );

%% Deviation Area for all Subjects
    for i = 1:length(Subject_List)
        [ allDA(i) ] = DAOneSubjectStroke( Subject_List(i) , '' );
    end
    allDAStats.A = [ mean( [ allDA.A ] ), std( [ allDA.A ] ) ];
    allDAStats.Posta = [ mean( [ allDA.Posta ] ), std( [ allDA.Posta ] ) ];
    allDAStats.Postb = [ mean( [ allDA.Postb ] ), std( [ allDA.Postb ] ) ];
    allDAStats.Postc = [ mean( [ allDA.Postc ] ), std( [ allDA.Postc ] ) ];  
    

%% Adaptation Between Sessions Assistive mod eand Posts for one subject.
    [ DAs1 ] = DAOneSubjectStroke( Single_Subject, '_s1*' );
    [ DAs3 ] = DAOneSubjectStroke( Single_Subject, '_s2*' );
    [ DAs4 ] = DAOneSubjectStroke( Single_Subject, '_s4*' );

%% Average Adaptation Between Laps for All Subjects
    for i = 1:length(Subject_List)
        [ DAs1(i) ] = DAOneSubjectStroke( char( Subject_List(i) ), '_s1*' );
        [ DAs3(i) ] = DAOneSubjectStroke( char( Subject_List(i) ), '_s3*' );
        [ DAs4(i) ] = DAOneSubjectStroke( char( Subject_List(i) ), '_s4*' );
    end  
    DAs1Avg = [ mean( [ DAs1.A ] ), std( [ DAs1.A ] ) ];
    DAs3Avg = [ mean( [ DAs3.A ] ), std( [ DAs3.A ] ) ];
    DAs4Avg = [ mean( [ DAs4.A ] ), std( [ DAs4.A ] ) ];
 
%% Plotting the deviation area lap by lap
    da_session_cats = categorical( {'S1', 'S3' ,'S4'} );
    figure, hold on
    bar( da_session_cats, [DAs1Avg(1) DAs3Avg(1) DAs4Avg(1)], 'grouped', ... 
        'w', 'LineWidth', 1.5)
    errorbar( da_session_cats, [ DAs1Avg(1) DAs3Avg(1) DAs4Avg(1) ], ...
        [ DAs1Avg(2) DAs3Avg(2) DAs4Avg(2) ], '.k', 'Linewidth', 1.5)
    ylabel('Normalized Deviation Area')
    set(gca, 'LineWidth', 2, 'FontSize', 16.0), box off

