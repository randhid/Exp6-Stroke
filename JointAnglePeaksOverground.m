function [locs, mags, changes] = JointAnglePeaksOverground (Subject_List)
% Find the locations and magnitudes of peaks and their locations in the
% gait cycle for hip and knee flexion for all subjects in a subject list.
% Inputs: - subject lest a string vector 

res = [];

for i = 1:length(Subject_List)
     parentfolderavg = SelectFolder('clx_average_1min', char ( Subject_List(i) ) );
     [resi] = FindSbjPeaks(parentfolderavg);
     res= [res, resi];
end

%% Extracting peak times and magnitudes

for i = 1 : length(res)
    peaks_kneeP(i) = res(i).knee.Ppeaks(end);
    locs_kneeP(i) = res(i).knee.Plocs(end);
    peaks_kneeA(i) = res(i).knee.Apeaks(end);
    locs_kneeA(i) = res(i).knee.Alocs(end);
    peaks_kneepostA = res(i).knee.postApeaks;
    locs_kneepostA = res(i).knee.postAlocs;
    peaks_kneepostB = res(i).knee.postBpeaks;
    locs_kneepostB = res(i).knee.postBlocs;
    peaks_kneepostC = res(i).knee.postCpeaks;
    locs_kneepostC = res(i).knee.postClocs;
end 

for i = 1 : length(res)
    peaks_hipP(i) = res(i).hip.Ppeaks(end);
    locs_hipP(i) = res(i).hip.Plocs(end);
    peaks_hipA(i) = res(i).hip.Apeaks(end);
    locs_hipA(i) = res(i).hip.Alocs(end);
    peaks_hippostA = res(i).hip.postApeaks;
    locs_hippostA = res(i).hip.postAlocs;
    peaks_hippostB = res(i).hip.postBpeaks;
    locs_hippostB = res(i).hip.postBlocs;
    peaks_hippostC = res(i).hip.postCpeaks;
    locs_hippostC = res(i).hip.postClocs;
end 

%%
figure
subplot(211), hold on
plot(locs_kneeP, peaks_kneeP, '.r')
plot(locs_kneeA, peaks_kneeA, '.b')
plot(locs_kneepostA, peaks_kneepostA, '.g')
plot(locs_kneepostB, peaks_kneepostB, '.m')
plot(locs_kneepostC, peaks_kneepostC, '.k')
legend('Baseline', 'Training', 'PostA', 'PostB', 'PostC', ...
    'Location', 'northeast')
title('Knee Flexion')

subplot(212), hold on
plot(locs_hipP, peaks_hipP, '.r')
plot(locs_hipA, peaks_hipA, '.b')
plot(locs_hippostA, peaks_hippostA, '.g')
plot(locs_hippostB, peaks_hippostB, '.m')
plot(locs_hippostC, peaks_hippostC, '.k')
title('Hip Flexion')



%% Knee and Hip Locations
locs.P.Kneeav = mean(locs_kneeP); locs.P.Kneesd = std(locs_kneeP);
locs.A.Kneeav = mean(locs_kneeA); locs.A.Kneesd = std(locs_kneeA);
locs.postA.Kneeav = mean(locs_kneepostA); locs.postA.Kneesd = std(locs_kneepostA);
locs.postB.Kneeav = mean(peaks_kneepostB); locs.postB.Kneesd = std(peaks_kneepostB);
locs.postC.Kneeav = mean(peaks_kneepostC); locs.postC.Kneesd = std(peaks_kneepostC);

locs.P.Hipav = mean(locs_hipP); locs.P.Kneesd = std(locs_hipP);
locs.A.Hipav = mean(locs_hipA); locs.A.Kneesd = std(locs_hipA);
locs.postA.Hipav = mean(locs_hippostA); locs.postA.Kneesd = std(locs_hippostA);
locs.postB.Hipav = mean(peaks_hippostB); locs.postB.Kneesd = std(peaks_hippostB);
locs.postC.Hipav = mean(peaks_hippostC); locs.postC.Kneesd = std(peaks_hippostC);


%% Knee And Hip Magnitudes and location vectors
mags.P.Knee = peaks_kneeP;
mags.A.Knee = peaks_kneeA;
mags.postA.Knee = peaks_kneepostA;
mags.postB.Knee = peaks_kneepostB;
mags.postC.Knee = peaks_kneepostC;

mags.P.Knee = peaks_kneeP;
mags.A.Knee = peaks_kneeA;
mags.postA.Knee = peaks_kneepostA;
mags.postB.Knee = peaks_kneepostB;
mags.postC.Knee = peaks_kneepostC;

locs.P.Knee = locs_kneeP;
locs.A.Knee = locs_kneeA;
locs.postA.Knee = locs_kneepostA;
locs.postB.Knee = locs_kneepostB;
locs.postC.Knee = locs_kneepostC;

locs.P.Hip = locs_hipP;
locs.A.Hip = locs_hipA;
locs.postA.Hip = locs_hippostA;
locs.postB.Hip = locs_hippostB;
locs.postC.Hip = locs_hippostC;

%% Calculating changes in locations and magnitudes of peaks.

% Knee flexion angle magnitudes and locations
changes.knee.postalocs = locs_kneepostA - locs_kneeP;
changes.knee.postblocs = locs_kneepostB - locs_kneeP;
changes.knee.postclocs = locs_kneepostC - locs_kneeP;

changes.knee.postaAVlocs = [ mean(changes.knee.postalocs); ...
    std( changes.knee.postalocs ) ];
changes.knee.postbAVlocs = [ mean(changes.knee.postblocs) ...
    std( changes.knee.postblocs ) ];
changes.knee.postcAVlocs = [ mean(changes.knee.postclocs) ...
    std( changes.knee.postclocs ) ];

changes.knee.postamags = peaks_kneepostA - peaks_kneeP;
changes.knee.postbmags = peaks_kneepostB - peaks_kneeP;
changes.knee.postcmags = peaks_kneepostC - peaks_kneeP;

%   Means and standard deviations
changes.knee.postaAVmags = [ mean(changes.knee.postamags) ...
    std( changes.knee.postamags ) ];
changes.knee.postbAVmags = [ mean(changes.knee.postbmags) ...
    std(changes.knee.postbmags) ];
changes.knee.postcAVmags = [ mean(changes.knee.postcmags) ...
    std( changes.knee.postcmags ) ];

% Hip flexion angle magnitudes and locations.
changes.hip.postalocs = locs_kneepostA - locs_kneeP;
changes.hip.postblocs = locs_kneepostB - locs_kneeP;
changes.hip.postclocs = locs_kneepostC - locs_kneeP;

changes.hip.postaAVlocs = [ mean(changes.hip.postalocs) ...
    std( changes.hip.postalocs ) ];
changes.hip.postbAVlocs = [ mean(changes.hip.postblocs) ...
    std( changes.hip.postblocs ) ];
changes.hip.postcAVlocs = [ mean(changes.hip.postclocs) ...
    std( changes.hip.postclocs ) ];

changes.hip.postamags = peaks_kneepostA - peaks_kneeP;
changes.hip.postbmags = peaks_kneepostB - peaks_kneeP;
changes.hip.postcmags = peaks_kneepostC - peaks_kneeP;

changes.hip.postaAVmags = [ mean(changes.hip.postamags) ...
    std( changes.hip.postalocs ) ];
changes.hip.postbAVmags = [ mean(changes.hip.postbmags) ...
    std( changes.hip.postblocs ) ];
changes.hip.postcAVmags = [ mean(changes.hip.postcmags)...
    std( changes.hip.postclocs ) ];
end

