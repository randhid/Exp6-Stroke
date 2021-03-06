function  [ change_vectors ] = JAAnalysisStroke( subjectnumber, ... 
    averagesfolder, jointanglefolder, lap, ~)
% Returns plots of all hip flexion, adduction and knee flexion for one
% subject. Outputs 18 plots for one subject showing the changes for each
% session from baseline. First three plots show baseline calculated from
% GiatTemplate file (red), vs baseline calculated from marked files as a
% check that the same subject files are being used.

    parentfolderavg = SelectFolder( averagesfolder, subjectnumber );
    parentfolderecy = SelectFolder( jointanglefolder, subjectnumber );

    %% Gait Templates
    TFile = rdir([parentfolderavg, strcat('\*GaitTemplate*.txt')]);

    % Importing baseline joint angles from gaitt templates:
    Temp = importdata(TFile.name, '\t', 3);
    hipf = Temp.data(:,4);
    hipa = Temp.data(:,5);
    knee = Temp.data(:,7); % get targe x and y gait positions from column 8 and 9 in template data

    %% Joint Angles Averages
    %%%%%%%%%%%%%%%%%%%%%Overground%%%%%%%%%%%%%%%%%%%%%
    % Free walking
    flP = rdir( [ parentfolderavg, strcat('\*freewalking*.txt' ) ] );
    [Phipf, Phipa, Pknee] = readJAAvg(flP, 2);

    % Transparent mode
    flT = rdir( [ parentfolderavg, strcat('\*pretraining*.txt') ] );
    [Thipf, Thipa, Tknee] = readJAAvg(flT, 2);

    %Force Field mode
    if nargin == 4
       flA = rdir([parentfolderavg,strcat('\*_training*.txt')]);
    else
       flA = rdir( [ parentfolderavg, strcat( [ '\*_training', lap, ...
           '*.txt'] ) ] );
    end
    
    [ A_hipf, A_hipa, A_knee ] = readJAAvg( flA, 2 );
    Ahipf = mean(A_hipf, 2);
    Ahipa = mean(A_hipa, 2);
    Aknee = mean(A_knee, 2);

    %%%%%%%%%%%%%%%%%%%%%Treadmill%%%%%%%%%%%%%%%%%%%%%
    % Free walking
    flPA = rdir([parentfolderavg,strcat('\*posta*.txt')]);
    [PAhipf, PAhipa, PAknee] = readJAAvg(flPA, 2);

    % Transparent mode
    flPB = rdir([parentfolderavg,strcat('\*postb*.txt')]);
    [PBhipf, PBhipa, PBknee] = readJAAvg(flPB, 2);

    %Force Field mode
    flPC = rdir([parentfolderavg,strcat('\*postc*.txt')]);
    [PChipf, PChipa, PCknee] = readJAAvg(flPC, 2);

    %% Joint Angles Each Cycle
    %%%%%%%%%%%%%%%%%%%%%Overground%%%%%%%%%%%%%%%%%%%%%
    % Passive Mode
    flP = rdir([parentfolderecy, strcat('\*freewalking*.txt')]);
    [Phipfec, Phipaec, Pkneeec] = readJAeachcycle(flP, 1);

    % Transparent mode
    flT = rdir([parentfolderecy, strcat('\*pretraining*.txt')]);
    [Thipfec, Thipaec, Tkneeec] = readJAeachcycle(flT, 1);

    % Active mode
    flA = rdir([parentfolderecy, strcat('\*_training*.txt')]);
    [Ahipfec, Ahipaec, Akneeec] = readJAeachcycle(flA, 1);

    %%%%%%%%%%%%%%%%%%%%%Treadmill%%%%%%%%%%%%%%%%%%%%%
    % Passive Mode
    flPA = rdir([parentfolderecy, strcat('\*posta*.txt')]);
    [PAhipfec, PAhipaec, PAkneeec] = readJAeachcycle(flPA, 1);

    % Transparent mode
    flPB = rdir([parentfolderecy, strcat('\*postb*.txt')]);
    [PBhipfec, PBhipaec, PBkneeec] = readJAeachcycle(flPB, 1);

    % Active mode
    flPC = rdir([parentfolderecy, strcat('\*postc*.txt')]);
    [PChipfec, PChipaec, PCkneeec] = readJAeachcycle(flPC, 1);

%% Plotting all cases
    if nargin > 4
        % Overground Freewalking
        plotJAall(hipf, Phipf, Phipfec), title('Hip Flexion Passive') %Hip Flexion
        plotJAall(hipa, Phipa, Phipaec), title('Hip Adduction Passive') %Hip Adduction
        plotJAall(knee, Pknee, Pkneeec), title('Knee Flexion Passive') %Knee

        % Overground Transparent
        plotJAall(hipf, Thipf, Thipfec), title('Hip Flexion Pretraining') %Hip
        plotJAall(hipa, Thipa, Thipaec), title('Hip Adduction Pretraining') %Add
        plotJAall(knee, Tknee, Tkneeec), title('Knee Flexion Pretraining') %Knee

        %Overground Force Field
        plotJAall(hipf, Ahipf, Ahipfec), title('Hip Flexion Training') %Hip
        plotJAall(hipa, Ahipa, Ahipaec), title('Hip Adduction Training') %Add
        plotJAall(knee, Aknee, Akneeec), title('Knee Flexion Training') %Knee


        %Treadmill Freewalking
        plotJAall(hipf, PAhipf, PAhipfec), title('Hip Flexion Post a') %Hip
        plotJAall(hipa, PAhipa, PAhipaec), title('Hip Adduction Post a') %Knee
        plotJAall(knee, PAknee, PAkneeec), title('Knee Flexion Post a') %Adduction

        %Treadmill Transparent
        plotJAall(hipf, PBhipf, PBhipfec), title('Hip Flexion Post b') %Hip
        plotJAall(hipa, PBhipa, PBhipaec), title('Hip Adduction Post b') %Knee
        plotJAall(knee, PBknee, PBkneeec), title('Knee Flexion Post b') %Adduction

        %Treadmill Force Field
        plotJAall(hipf, PChipf, PChipfec), title('Hip Flexion Post c')  %Hip
        plotJAall(hipa, PChipa, PChipaec), title('Hip Adduction Post c') %Knee
        plotJAall(knee, PCknee, PCkneeec), title('Knee Flexion Post c') %Adduction
    end

change_vectors.Hipf = [ ['Active'; Ahipf - hipf], ['Post A'; PAhipf - hipf], ...
    ['Post B'; PBhipf - hipf], ['Post C';  PChipf - hipf ] ] ;
change_vectors.Hipa = [ Ahipa - hipa, PAhipa - hipa, PBhipa - hipa, ...
    PChipf - hipa ];
change_vectors.Knee = [ Aknee - knee, PAknee - knee, PBknee - knee, ...
    PCknee - knee ];

end 


