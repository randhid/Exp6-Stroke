function [res] = FindSbjPeaks(parentfolderavg)
%% Joint Angles Averages

%%%%%%%%%%%%%%%%%%%%%Overground%%%%%%%%%%%%%%%%%%%%%
% Free walking

flogfw = rdir([parentfolderavg,strcat('\*og_fw*.txt')]);
[ oghipP, ~ , ogkneeP ] = readJAAvg(flogfw, 2);

%Force Field mode
flogff = rdir([parentfolderavg,strcat('\*og_ff*.txt')]);
[ oghipA, ~ , ogkneeA ] = readJAAvg(flogff, 2);

%%%%%%%%%%%%%%%%%%%%%Treadmill%%%%%%%%%%%%%%%%%%%%%

% Free walking

fltmfw = rdir([parentfolderavg,strcat('\*tm_fw*.txt')]);
[ tmhipP, ~ , tmkneeP ] = readJAAvg(fltmfw, 2);

%Force Field mode
fltmff = rdir([parentfolderavg,strcat('\*tm_ff*.txt')]);
[ tmhipA, ~ , tmkneeA ] = readJAAvg(fltmff, 2);



%% Plot Random Stuff
figure, 
subplot(211), hold on, set(gca, 'xcolor', 'none')
plotJASelected(rad2deg(ogkneeP), '-r'), plotJASelected(rad2deg(ogkneeA), ...
    '--b'), title('(a)') %Overground
legend('Passive', 'Active'), legend boxoff

subplot(212),  hold on
plotJASelected(rad2deg(tmkneeP), '-r'), plotJASelected(rad2deg(tmkneeA), ...
    '--b'), title('(b)') %Treadmill
%legend('Transparent', 'Active')

figure, 
subplot(211), hold on, set(gca, 'xcolor', 'none')
plotJASelected(rad2deg(oghipP), '-r'), plotJASelected(rad2deg(oghipA), '--b'), title('(a)') %Overground
legend('Passive', 'Active'), legend boxoff

subplot(212),  hold on
plotJASelected(rad2deg(tmhipP), '-r'), plotJASelected(rad2deg(tmhipA), '--b'), title('(b)') %Treadmill
%legend('Transparent', 'Active')


%% Finding Knee and Hip Angle Peaks
% Knee
[res.knee.ogpeaksA, res.knee.oglocsA] = findpeaks(rad2deg(-ogkneeP), ...
    linspace(0, 100, length(ogkneeP)), 'MinPeakDistance', 40, 'MinPeakHeight', 20);
[res.knee.ogpeaksP, res.knee.oglocsP] = findpeaks(rad2deg(-ogkneeA), ...
    linspace(0, 100, length(ogkneeA)), 'MinPeakDistance', 40 , 'MinPeakHeight', 20);

[res.knee.tmpeaksA, res.knee.tmlocsA] = findpeaks(rad2deg(-tmkneeA), ...
    linspace(0, 100, length(tmkneeA)), 'MinPeakDistance', 40, 'MinPeakHeight', 20);
[res.knee.tmpeaksP, res.knee.tmlocsP] = findpeaks(rad2deg(-tmkneeP), ...
    linspace(0, 100, length(tmkneeP)), 'MinPeakDistance', 40, 'MinPeakHeight', 20);

% Hip
[res.hip.ogpeaksA, res.hip.oglocsA] = findpeaks(rad2deg(-oghipP), ...
    linspace(0, 100, length(oghipP)), 'MinPeakHeight', 1.8, 'MinPeakDistance', 55 );
[res.hip.ogpeaksP, res.hip.oglocsP] = findpeaks(rad2deg(-oghipA), ...
    linspace(0, 100, length(oghipA)), 'MinPeakHeight', 1.8, 'MinPeakDistance', 55 );

[res.hip.tmpeaksA, res.hip.tmlocsA] = findpeaks(rad2deg(-tmhipA), ...
    linspace(0, 100, length(tmhipA)), 'MinPeakHeight', 1.8, 'MinPeakDistance', 55 );
[res.hip.tmpeaksP, res.hip.tmlocsP] = findpeaks(rad2deg(-tmhipP), ...
    linspace(0, 100, length(tmhipP)), 'MinPeakHeight', 1.8, 'MinPeakDistance', 55 );

end


