function plotJTavgs(desired, planned, actual, joint)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    figure
    if nargin < 3
        %Plot only averages
        for i = 0:4:size(desired, 2)-joint
            plot(desired(:, joint + i), 'k')
            plot(actual(:, joint + i), 'b')
        end

    else
        % plot each cycle as well
        for i = 0:4:size(actual,2)-joint
            hold on
            plot(desired(:, joint + i), 'k')
            plot(planned(:, joint + i), 'b')
            plot(actual(:, joint + i), 'm')
        end
    end
    xlabel('%Gait Cycle')
    ylabel('Torque')
end



