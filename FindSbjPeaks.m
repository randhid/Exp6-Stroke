function [res] = FindSbjPeaks(parentfolderavg)
%% Joint Angles Averages

%%%%%%%%%%%%%%%%%%%%%Overground%%%%%%%%%%%%%%%%%%%%%
% Passive
flP = rdir([parentfolderavg,strcat('\*freewalking*.txt')]);
[ hipfP, ~ , kneeP ] = readJAAvg(flP, 2);

% Pre-training
flT = rdir([parentfolderavg,strcat('\*pretraining*.txt')]);
[ hipfT, ~ , kneeT ] = readJAAvg(flT, 2);

% Training
flA = rdir([parentfolderavg,strcat('\*_training*.txt')]);
[ hipfA, ~ , kneeA ] = readJAAvg(flA, 2);

% Post A
flposta = rdir([parentfolderavg,strcat('\*posta*.txt')]);
[ hipfpostA, ~ , kneepostA ] = readJAAvg(flposta, 2);

% Post B
flpostb = rdir([parentfolderavg,strcat('\*postb*.txt')]);
[ hipfpostB, ~ , kneepostB ] = readJAAvg(flpostb, 2);

% Post C
flpostc = rdir([parentfolderavg,strcat('\*postc*.txt')]);
[ hipfpostC, ~ , kneepostC ] = readJAAvg(flpostc, 2);

%% Plot Knee and Hip Flexion changes from Baseline
% Knee
figure, 
subplot(221), hold on, set(gca, 'xcolor', 'none');
plotJASelected(rad2deg(kneeP), '-r'), plotJASelected(rad2deg(kneeA), ...
    '--b'), %title('(a)')
legend('Baseline', 'Training', 'Location', 'southwest'), legend boxoff

subplot(222),  hold on
plotJASelected(rad2deg(kneeP), '-r'), set(gca, 'xcolor', 'none', 'ycolor' ...
    , 'none');
plotJASelected(rad2deg(kneepostA), '--b'), % title('(b)')
legend('Baseline', 'Post A', 'Location', 'southwest'), legend boxoff

subplot(223), hold on, 
plotJASelected(rad2deg(kneeP), '-r'), plotJASelected(rad2deg(kneepostB), ...
    '--b'), % title('(a)')
legend('Baseline', 'Post B', 'Location', 'southwest'), legend boxoff

subplot(224),  hold on, set(gca, 'ycolor', 'none');
plotJASelected(rad2deg(kneeP), '-r'), plotJASelected(rad2deg(kneepostC), ...
    '--b'), % title('(b)')
legend('Baseline', 'Post C', 'Location', 'southwest'), legend boxoff

% Hip
figure, 
subplot(221), hold on, set(gca, 'xcolor', 'none');
plotJASelected(rad2deg(hipfP), '-r'), plotJASelected(rad2deg(hipfA), ...
    '--b'), % title('(a)')
legend('Baseline', 'Training'), legend boxoff

subplot(222),  hold on, set(gca, 'xcolor', 'none', 'ycolor', 'none' );
plotJASelected(rad2deg(hipfP), '-r'), plotJASelected(rad2deg(hipfpostA), ...
    '--b'), % title('(b)')
legend('Baseline', 'Post A'), legend boxoff

subplot(223), hold on, 
plotJASelected(rad2deg(hipfP), '-r'), plotJASelected(rad2deg(hipfpostB), ...
    '--b'), % title('(c)')
legend('Baseline', 'Post B'), legend boxoff

subplot(224),  hold on, set(gca, 'ycolor', 'none');
plotJASelected(rad2deg(hipfP), '-r'), plotJASelected(rad2deg(hipfpostC), ...
    '--b'), % title('(d)')
legend('Baseline', 'Post C'), legend boxoff



%% Finding Knee and Hip Angle Peaks
% Knee
[res.knee.Ppeaks, res.knee.Plocs] = findpeaks(rad2deg(-kneeP), ...
    linspace(0, 100, length(kneeP)), 'MinPeakDistance', 40, 'MinPeakHeight', 20);
[res.knee.Apeaks, res.knee.Alocs] = findpeaks(rad2deg(- mean(kneeA, 2) ), ...
    linspace(0, 100, length(kneeA)), 'MinPeakDistance', 40 , 'MinPeakHeight', 20);

[res.knee.postApeaks, res.knee.postAlocs] = findpeaks(rad2deg(-kneepostA), ...
    linspace(0, 100, length(kneepostA)), 'MinPeakDistance', 40, 'MinPeakHeight', 20);
[res.knee.postBpeaks, res.knee.postBlocs] = findpeaks(rad2deg(-kneepostB), ...
    linspace(0, 100, length(kneepostB)), 'MinPeakDistance', 40, 'MinPeakHeight', 20);
[res.knee.postCpeaks, res.knee.postClocs] = findpeaks(rad2deg(-kneepostC), ...
    linspace(0, 100, length(kneepostC)), 'MinPeakDistance', 40, 'MinPeakHeight', 20);

% Hip
[res.hip.Ppeaks, res.hip.Plocs] = findpeaks(rad2deg(-hipfP), ...
    linspace(0, 100, length(hipfP)), 'MinPeakHeight', 1.8, 'MinPeakDistance', 55 );
[res.hip.Apeaks, res.hip.Alocs] = findpeaks(rad2deg(-mean(hipfA, 2)), ...
    linspace(0, 100, length(hipfA)), 'MinPeakHeight', 1.8, 'MinPeakDistance', 55 );

[res.hip.postApeaks, res.hip.postAlocs] = findpeaks(rad2deg(-hipfpostA), ...
    linspace(0, 100, length(hipfpostA)), 'MinPeakHeight', 1.8, 'MinPeakDistance', 55 );
[res.hip.postBpeaks, res.hip.postBlocs] = findpeaks(rad2deg(-hipfpostB), ...
    linspace(0, 100, length(hipfpostB)), 'MinPeakHeight', 1.8, 'MinPeakDistance', 55 );

[res.hip.postCpeaks, res.hip.postClocs] = findpeaks(rad2deg(-hipfpostC), ...
    linspace(0, 100, length(hipfpostC)), 'MinPeakHeight', 1.8, 'MinPeakDistance', 55 );

end


