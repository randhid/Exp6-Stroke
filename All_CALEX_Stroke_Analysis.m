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

%% AnkleROM and optoional Plots of all subjects
    for i  = 1:length(Subject_List)
        [ ROM ] = AnkleAnalysisStroke( char( Subject_List(i) ), 1);
        allROM(i) = ROM;
    end
    
    meanROM = 
    
%% Plotting Gait Kinematics
plotGaitKinematicsStroke(allROM, 1, 1, 'Step Length', 'cm')
plotGaitKinematicsStroke(allROM, 1, 2, 'Step Height', 'cm')

plotGaitKinematicsStroke(allROM, 2, 1, 'Step Length', 'cm')
plotGaitKinematicsStroke(allROM, 2, 2, 'Step Height', 'cm')

plotGaitKinematicsStroke(allROM, 3, 1, 'Step Length', 'cm')
plotGaitKinematicsStroke(allROM, 3, 2, 'Step Height', 'cm')

%% Joint Angles
    JAAnalysisStroke( Single_Subject, 1 )
 
%% Joint Angle Peaks
    [Peak_Locations, Peak_Magnitudes, Peak_Changes] = JointAnglePeaksOverground ( Subject_List );

%% Deviation Area for one Subject
    [ avDA, sdDA] = DAOneSubjectStroke( Single_Subject, '' );

%% Deviation Area for all Subjects
    for i = 1:length(Subject_List)
        [ avDA, sdDA] = DAOneSubjectStroke( Subject_List(i) , '' );     
        allavDA.avg(i) = avDA;
        allavDA.sd(i) = sdDA;
    end
    
    avDA.A = mean( [ allavDA.avg.ogA ] );
    sdDA.A = std( [ allavDA.avg.ogA ] );
    

%% Adaptation Between Laps for one Subject [[[Reorganize folders!!!]]]]]
    [ avDALap1, sdDALap1] = DAOneSubjectOverground( Single_Subject, '_s1*' );
    [ avDALap3, sdDALap3] = DAOneSubjectOverground( Single_Subject, '_s2*' );
    [ avDALap6, sdDALap6] = DAOneSubjectOverground( Single_Subject, '_s4*' );

%% Adaptation Between Laps for All Subjects
    for i = 1:length(Subject_List)
        [ avDALap1, sdDALap1] = DAOneSubjectStroke( char( Subject_List(i) ), '_s1*' );
        [ avDALap3, sdDALap3] = DAOneSubjectStroke( char( Subject_List(i) ), '_s3*' );
        [ avDALap6, sdDALap6] = DAOneSubjectStroke( char( Subject_List(i) ), '_s6*' );
        allavDALap1.avg(i) = avDALap1;
        allavDALap1.sd(i) = sdDALap1;
        allavDALap3.avg(i) = avDALap3;
        allavDALap3.sd(i) = sdDALap3;       
        allavDALap6.avg(i) = avDALap6;
        allavDALap6.sd(i) = sdDALap6;
    end
    
    avDALap1.A = mean( [ allavDALap1.avg.A ] );
    sdDALap1.A = std( [ allavDALap1.avg.A ] );
    avDALap3.A = mean( [ allavDALap3.avg.A ] );
    sdDALap3.A = std( [ allavDALap3.avg.A ] );
    avDALap6.A = mean( [ allavDALap6.avg.A ] );
    sdDALap6.A = std( [ allavDALap6.avg.A ] );

%% Plotting the deviation area lap by lap
    da_lap_cats = categorical( {'S1', 'S3' ,'S6'} );
    da_lap_cats = reordercats(da_lap_cats, {'S1', 'S3' ,'S6'} );
    figure, hold on
    bar(da_lap_cats, [avDALap1.A avDALap3.A avDALap6.A], 'grouped', 'w', 'LineWidth', 1.5)
    errorbar(da_lap_cats, [avDALap1.A avDALap3.A avDALap6.A], [sdDALap1.A sdDALap3.A sdDALap6.A], '.k', 'Linewidth', 1.5)
    ylabel('Normalized Deviation Area')
    set(gca, 'LineWidth', 2, 'FontSize', 16.0), box off

