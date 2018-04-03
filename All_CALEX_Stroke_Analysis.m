%% clear
    clc;
    clear;
    close all;
    addpath(pwd);
%% Single Subject and multiple subject list
    Single_Subject = "*1";
    Subject_List = [ "*1", "*3", "*4" ];

%% Ankle ROM and Plots for one subject:
    [ ROM ] = AnkleAnalysisStroke( Single_Subject, 'clx_average_1min' );
    % Second input produces a plot
%% Ankle Kinematics and optoional Plots of all subjects
    for i  = 1:length(Subject_List)
        allROM(i) = AnkleAnalysisStroke( char( Subject_List(i) ), ...
            'clx_average_1min', 1 );
    end
%% Means of Ankle Kinematics for all Subjects
    Step_Means = getAvgKinematicsStroke(allROM);
    plotGaitKinematicsStroke(Step_Means, 1, 1, 'Average Step Length', ' m')
    plotGaitKinematicsStroke(Step_Means, 1, 2, 'Average Step Height', ' m')
%% Plotting Gait Kinematics for Single Subjects
    plotGaitKinematicsStroke(allROM, 1, 1, 'Step Length', ' m')
    plotGaitKinematicsStroke(allROM, 1, 2, 'Step Height', ' m')
    plotGaitKinematicsStroke(allROM, 2, 1, 'Step Length', ' m')
    plotGaitKinematicsStroke(allROM, 2, 2, 'Step Height', ' m')
    plotGaitKinematicsStroke(allROM, 3, 1, 'Step Length', ' m')
    plotGaitKinematicsStroke(allROM, 3, 2, 'Step Height', ' m')
%% Joint Angles
    Joint_Angle_Changes = JAAnalysisStroke( Single_Subject, ...
        'clx_average_1min', 'clx_ja_1min', 3);
%% Joint Angle Peaks for One Subject
    [Peak_Locations, Peak_Magnitudes, Peak_Changes] = ...
        JointAnglePeaksOverground( Single_Subject, 'clx_average_1min' );
%% Joint Angle Peaks for All Subjects
for i = 1:length(Subject_List)
    [ all_Peak_Locations(i), all_Peak_Magnitudes(i), all_Peak_Changes(i) ] =...
        JointAnglePeaksOverground( Subject_List(i), 'clx_average_1min' );
end
%% Deviation Area for One Subject
    [ DA ] = DAOneSubjectStroke( Single_Subject, 'clx_average_1min' );
%% Deviation Area for All Subjects
    for i = 1:length(Subject_List)
        [ allDA(i) ] = DAOneSubjectStroke( Subject_List(i) , ...
            'clx_average_1min' );
    end
    allDAStats.A = [ mean( [ allDA.A ] ), std( [ allDA.A ] ) ];
    allDAStats.Posta = [ mean( [ allDA.Posta ] ), std( [ allDA.Posta ] ) ];
    allDAStats.Postb = [ mean( [ allDA.Postb ] ), std( [ allDA.Postb ] ) ];
    allDAStats.Postc = [ mean( [ allDA.Postc ] ), std( [ allDA.Postc ] ) ];
%% Plot Deviation Area
    da_session_cats = categorical( {'A', 'Post A' , 'Post B', 'Post C'} );
    figure, hold on
    bar( da_session_cats, [ allDAStats.A(1) allDAStats.Posta(1) ...
         allDAStats.Postb(1) allDAStats.Postc(1) ], 'grouped', ... 
        'w', 'LineWidth', 1.5)
    errorbar( da_session_cats, [allDAStats.A(1) allDAStats.Posta(1) ...
         allDAStats.Postb(1), allDAStats.Postc(1) ], [ allDAStats.A(2) ...
         allDAStats.Posta(2) allDAStats.Postb(2), allDAStats.Postc(2) ], ...
         '.k', 'Linewidth', 1.5 )
    ylabel('Normalized Deviation Area')
    set(gca, 'LineWidth', 2, 'FontSize', 16.0), box off
%% Adaptation Between Sessions Assistive mode and Posts for One subject.
    [ DAs1_session1 ] = DAOneSubjectStroke( Single_Subject, 'clx_average_1min', ...
        '2*' );
    [ DAs1_session2 ] = DAOneSubjectStroke( Single_Subject, 'clx_average_1min', ...
        '4*' );
    [ DAs1_session3 ] = DAOneSubjectStroke( Single_Subject, 'clx_average_1min', ...
        '6*' );
%% Average Adaptation For same lap for All Subjects
    [ DAs1 ] = DAOneSubjectStroke( char( Subject_List(1) ), ...
        'clx_average_1min', '2*' );
    [ DAs3 ] = DAOneSubjectStroke( char( Subject_List(2) ), ... 
        'clx_average_1min', '2*' );
    [ DAs4 ] = DAOneSubjectStroke( char( Subject_List(3) ), ... 
        'clx_average_1min', '2*' );
%% Plotting the deviation area lap by lap
    da_session_cats = categorical( {'S1', 'S3' ,'S4'} );
    figure, hold on
    bar( da_session_cats, [DAs1.A(1) DAs3.A(1) DAs4.A(1)], 'grouped', ... 
        'w', 'LineWidth', 1.5)
    errorbar( da_session_cats, [ DAs1.A(1) DAs3.A(1) DAs4.A(1) ], ...
        [ DAs1.A(2) DAs3.A(2) DAs4.A(2) ], '.k', 'Linewidth', 1.5)
    ylabel('Normalized Deviation Area')
    set(gca, 'LineWidth', 2, 'FontSize', 16.0), box off