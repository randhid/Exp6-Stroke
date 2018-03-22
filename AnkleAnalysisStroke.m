function [ROM ] = AnkleAnalysisStroke(subjectnumber, ~)
    
    % Filepaths for Experiment data
    parentfolderavg = SelectFolder( 'clx_average_1min', subjectnumber );

    %% Gait Templates

    [ ref ] = importGaitTemplate( parentfolderavg, '\*GaitTemplate*.txt', 3 );

    %% Anklepositions
    %%%%%%%%%%%%%%%%%%%%%Overground%%%%%%%%%%%%%%%%%%%%%
    % Baseline
    [ Pav ] = readAvgAnklepos( parentfolderavg, '\*freewalking*.txt',  2); %Average

    % Transparent mode
    [ Tav ] = readAvgAnklepos( parentfolderavg, '\*pretraining*.txt', 2 ); %Average

    % Training the Stroke Patients
    Assistive_FileList = rdir( [ parentfolderavg, '\*_training*.txt' ] );
    for i = 1: length(Assistive_FileList)
        Aavi(i) = readAvgAnklepos( Assistive_FileList(i).name, '', 2 ); %Average
        Aav.x = mean( [ Aavi.x ], 2 );
        Aav.y = mean( [ Aavi.y ], 2);
    end

    %%%%%%%%%%%%%%%%%%%%%Treadmill%%%%%%%%%%%%%%%%%%%%%
    % Post training A mode
    [ Posta ] = readAvgAnklepos( parentfolderavg, '\*posta*.txt', 2 ); %Average

    % Post Training B
    [ Postb ] = readAvgAnklepos(parentfolderavg, '\*postb*.txt', 2 ); %Average

    % Active mode
    [ Postc ] = readAvgAnklepos(parentfolderavg, '\*postc*.txt', 2 ); %Average


    %% Plotting Graphs 
    
    if nargin > 1
        figure, hold on

        subplot(323)
        plotAnklePosAll( ref, Posta )
        legend(gca, 'boxoff'), set(gca, 'xcolor', 'none'); title('(a)') %Postb
        title('Posta')

        subplot(324)
        plotAnklePosAll( ref, Postb ) %Postc
        legend(gca, 'hide'), set(gca, 'ycolor', 'none'); set(gca, 'xcolor', 'none'); title('(b)')
        title('Postb')

        subplot(325)
        plotAnklePosAll( ref, Postc ) % Transparent
        legend(gca, 'hide'), title('(c)'), xlabel('x position (m)'),  ylabel('y position (m)')
        title('Postc')
    
        subplot(321)
        plotAnklePosAll( ref, Tav )  % Active/Training
        legend(gca, 'hide'), title('(d)'), set(gca, 'ycolor', 'none')
        title('Pretraining')
        
        subplot(322)
        plotAnklePosAll( ref, Aav )  % Active/Training
        legend(gca, 'hide'), title('(d)'), set(gca, 'ycolor', 'none')
        title('Training')
    else
        fprintf('Add a second input to function if plots needed.')
    
    end

    %% StepHeights
    %Treadmill
    [ ROM.P ] = CalcAnkleROM( [Pav.x, Pav.y] ); %Passive
    [ ROM.T ] = CalcAnkleROM( [Tav.x, Tav.y] ); %Transparent
    [ ROM.A ] = CalcAnkleROM( [Aav.x, Aav.y] ); %Active/Training

    %Overground
    [ ROM.Posta ] = CalcAnkleROM( [Posta.x, Posta.y] ); %Posta
    [ ROM.Postb ] = CalcAnkleROM( [Postb.x, Postb.y] ); %Postb
    [ ROM.Postc ] = CalcAnkleROM( [Postc.x, Postc.y] ); %Postc


end
