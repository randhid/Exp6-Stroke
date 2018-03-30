function [ stats ] = DAOneSubjectStroke( subject , averagesfolder, lap )
% This calcualtes the deviation area between the average ankle trajectory
% of Active mode with the target of treadmill and Overground each.
    parentfolder = SelectFolder(averagesfolder, subject);

    %% Gait Templates

    TFile = rdir( [parentfolder, strcat( '\*GaitTemplate*.txt' ) ] );

    % Importing gait templates:
    Temp = importdata(TFile.name, '\t', 3);
    P.TargetX = Temp.data(:,8);
    P.TargetY = Temp.data(:,9); % get targe x and y gait positions from column 8 and 9 in template data

    %% Anklepositions
    % Active mode
    Assistive_FileList = rdir( [ parentfolder, '\*_training*.txt' ] );
    for i = 1:length(Assistive_FileList)
        Ai(i) = readAvgAnklepos( Assistive_FileList(i).name, '', 2 ); %Each Cycle
        A.x = mean( [ Ai(i).x ] , 2 );
        A.y = mean( [ Ai(i).y ] , 2 );
    end
    % Post training A
    [ Posta ] = readAvgAnklepos( parentfolder, '\*posta*.txt', 2 );

    % Post training B
    [ Postb ] = readAvgAnklepos( parentfolder, '\*postb*.txt', 2 );

    % Post training C
    [ Postc ] = readAvgAnklepos( parentfolder, '\*postc*.txt', 2 );

    %% Plots and Deviation Areas
    % Add figure handle to inputs to function for plots.
    [ da_A, ~ , ref ] = calculateDAparams( A.x, A.y, P.TargetX, P.TargetY ); %
    [ da_posta, ~, ~ ] = calculateDAparams( Posta.x, Posta.y, ...
        P.TargetX, P.TargetY );
    [ da_postb, ~, ~ ] = calculateDAparams( Postb.x, Postb.y, ...
        P.TargetX, P.TargetY );
    [ da_postc, ~, ~ ] = calculateDAparams( Postc.x, Postc.y, ... 
        P.TargetX, P.TargetY );

    %% Calculating Means and Standard Deviations for Deviation Areas
    %Deviation Areas
    stats.A = mean( da_A./ref );
    stats.Posta = mean( da_posta./ref );
    stats.Postb = mean( da_postb./ref );
    stats.Postc = mean( da_postc./ref );

end

