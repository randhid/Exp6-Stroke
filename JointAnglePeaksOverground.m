function [locs, mags, changes] = JointAnglePeaksOverground (Subject_List)
% Find the locations and magnitudes of peaks and their locations in the
% gait cycle for hip and knee flexion for all subjects in a subject list.
% Inputs: - subject lest a string vector 

res = [];

for i = 1:length(Subject_List)
     parentfolderavg = SelectFolder('clx_average', Subject_List(i) );
     [resi] = FindSbjPeaks(parentfolderavg);
     res= [res, resi];
end

%% Extracting peak times and magnitudes

for i = 1 : length(res)
    peaks_knee_ogA(i) = res(i).knee.ogpeaksA(end);
    locs_knee_ogA(i) = res(i).knee.oglocsA(end);
    peaks_knee_ogP(i) = res(i).knee.ogpeaksP(end);
    locs_knee_ogP(i) = res(i).knee.oglocsP(end);
end 

for i = 1 : length(res)
    peaks_knee_tmA(i) = res(i).knee.tmpeaksA(end);
    locs_knee_tmA(i) = res(i).knee.tmlocsA(end);
    peaks_knee_tmP(i) = res(i).knee.tmpeaksP(end);
    locs_knee_tmP(i) = res(i).knee.tmlocsP(end);
end 


for i = 1 : length(res)
    peaks_hip_ogA(i) = res(i).hip.ogpeaksA(end);
    locs_hip_ogA(i) = res(i).hip.oglocsA(end);
    peaks_hip_ogP(i) = res(i).hip.ogpeaksP(end);
    locs_hip_ogP(i) = res(i).hip.oglocsP(end);
end 

for i = 1 : length(res)
    peaks_hip_tmA(i) = res(i).hip.tmpeaksA(end);
    locs_hip_tmA(i) = res(i).hip.tmlocsA(end);
    peaks_hip_tmP(i) = res(i).hip.tmpeaksP(end);
    locs_hip_tmP(i) = res(i).hip.tmlocsP(end);
end 

%%
figure
subplot(221), hold on
plot(locs_knee_ogA, peaks_knee_ogA, '.r')
plot(locs_knee_ogP, peaks_knee_ogP, '.b')
legend('Active', 'Passive', 'Location', 'northeast'), title('OG Knee')

subplot(222), hold on
plot(locs_hip_ogA, peaks_hip_ogA, '.r')
plot(locs_hip_ogP, peaks_hip_ogP, '.b')
title('OG Hip')

subplot(223), hold on
plot(locs_knee_tmA, peaks_knee_tmA, '.r')
plot(locs_knee_tmP, peaks_knee_tmP, '.b')
title('TM Knee')

subplot(224), hold on
plot(locs_hip_tmA, peaks_hip_tmA, '.r')
plot(locs_hip_tmP, peaks_hip_tmP, '.b')
title('TM Hip')


%% Knee and Hip Locations
locs.og.KneeAav = mean(locs_knee_ogA); locs.og.KneeAsd = std(locs_knee_ogA);
locs.og.KneePav = mean(locs_knee_ogP); locs.og.KneePsd = std(locs_knee_ogP);

locs.tm.KneeAav = mean(locs_knee_tmA); locs.og.KneeAsd = std(locs_knee_tmA);
locs.tm.KneePav = mean(locs_knee_tmP); locs.og.KneePsd = std(locs_knee_tmP);

locs.og.HipAav = mean(locs_hip_ogA); locs.og.HipAsd = std(locs_hip_ogA);
locs.og.HipPav = mean(locs_hip_ogP); locs.og.HipPsd = std(locs_hip_ogP);

locs.tm.HipAav = mean(locs_hip_tmA); locs.og.HipAsd = std(locs_hip_tmA);
locs.tm.HipPav = mean(locs_hip_tmP); locs.og.HipPsd = std(locs_hip_tmP);

%% Knee And Hip Magnitudes and location vectors
mags.og.KneeA = peaks_knee_ogA;
mags.og.KneeP = peaks_knee_ogP;
mags.og.HipA = peaks_hip_ogA;
mags.og.HipP = peaks_hip_ogP;
mags.tm.KneeA = peaks_knee_tmA;
mags.tm.KneeP = peaks_knee_tmP;
mags.tm.HipA = peaks_hip_tmA;
mags.tm.HipP = peaks_hip_tmP;

locs.og.KneeA = locs_knee_ogA;
locs.og.KneeP = locs_knee_ogP;
locs.og.HipA = locs_hip_ogA;
locs.og.HipP = locs_hip_ogP;
locs.tm.KneeA = locs_knee_tmA;
locs.tm.KneeP = locs_knee_tmP;
locs.tm.HipA = locs_hip_tmA;
locs.tm.HipP = locs_hip_tmP;

%%

changes.knee.oglocs = locs_knee_ogA - locs_knee_ogP;
changes.knee.tmlocs = locs_knee_tmA - locs_knee_tmP;
changes.knee.oglocsav = mean(changes.knee.oglocs);
changes.knee.tmlocsav = mean(changes.knee.tmlocs);
changes.knee.oglocssd = std(changes.knee.oglocs);
changes.knee.tmlocssd = std(changes.knee.tmlocs);

changes.knee.ogmags = peaks_knee_ogA - peaks_knee_ogP;
changes.knee.tmmags = peaks_knee_tmA - peaks_knee_tmP;
changes.knee.ogmagsav = mean(changes.knee.ogmags);
changes.knee.tmmagsav = mean(changes.knee.tmmags);
changes.knee.ogmagssd = std(changes.knee.ogmags);
changes.knee.tmmagssd = std(changes.knee.tmmags);

changes.hip.oglocs = locs_hip_ogA - locs_hip_ogP;
changes.hip.tmlocs = locs_hip_tmA - locs_hip_tmP;
changes.hip.oglocsav = mean(changes.hip.oglocs);
changes.hip.tmlocsav = mean(changes.hip.tmlocs);
changes.hip.oglocssd = std(changes.hip.oglocs);
changes.hip.tmlocssd = std(changes.hip.tmlocs);

changes.hip.ogmags = peaks_hip_ogA - peaks_hip_ogP;
changes.hip.tmmags = peaks_hip_tmA - peaks_hip_tmP;
changes.hip.ogmagsav = mean(changes.hip.ogmags);
changes.hip.tmmagsav = mean(changes.hip.tmmags);
changes.hip.ogmagssd = std(changes.hip.ogmags);
changes.hip.tmmagssd = std(changes.hip.tmmags);

end

