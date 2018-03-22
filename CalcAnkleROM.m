function [ anklerom ] = CalcAnkleROM( ankleTraj )
%CALCANKLEROM Calculate ankle RoM
%   In particular, the maximum Y is found at the early swing phase, to
%   prevent using the heel strike as the maximum Y
%%
ankleX=ankleTraj(:,1);
ankleY=ankleTraj(:,2);
ankleX_mid=(max(ankleX)+min(ankleX))/2;
ankleY_earlySwing=ankleY(ankleX<ankleX_mid);
anklerom=range(ankleTraj);
ankleY_max=max(ankleY_earlySwing);
anklerom(2)=ankleY_max-min(ankleY);
anklerom(3) = std(ankleX);
anklerom(4) = std(ankleY);

%% For test
% figure;
% plot(ankleX,ankleY);
% line(xlim,[ankleY_max,ankleY_max]);

end

