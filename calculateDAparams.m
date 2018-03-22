function [da_out, area_out, area_ref] = calculateDAparams(actx, acty, refx, refy, h_fig)
%multiple file sinputs to calculate Deviation areas of target vs actual
%gait trajectories.
%   Detailed explanation goes here

    [m, n] = size(actx);
    da_out = []; area_out = [];

    if nargin < 5
        for k = 1:n
        [da, area, area_ref, ~, ~] = find_da(actx(:,k), acty(:,k), refx, refy);
        da_out = [da_out; da];
        area_out = [area_out; area];
        end
    else
        for k = 1:n
        [da, area, area_ref , ~,  ~] = find_da(actx(:,k), acty(:,k), refx, refy, h_fig);
        da_out = [da_out; da];
        area_out = [area_out; area];
        end
    end

end

