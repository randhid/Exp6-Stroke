function plotJTavgs(desired, planned, actual, joint)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

    GaitCycle = linspace(0, 100, size(desired, 1));

    if nargin < 3
        %Plot only averages
        for i = 0:4:size(desired, 2)
            plot(GaitCycle, desired(:, joint + i), 'k')
            plot(GaitCycle, actual(:, joint + i), 'b')
        end

    else
        % plot each cycle as well
        for i = 1:size(actual,2)
            hold on
            plot(GaitCycle, desired(:, joint + i), 'k')
            plot(GaitCycle, planned(:, joint + i), 'b')
            plot(GaitCycle, actual(:, joint + i), 'm')
        end
    end
end



