function plotJAall(target, average, eachcycle)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    
    GaitCycle = linspace(0, 100, size(target, 1));
    
    figure 
    if nargin < 3
        %Plot only averages
        plot(GaitCycle, rad2deg(target), 'k')
        plot(GaitCycle, rad2deg(average), 'b')

    else
        % plot each cycle as well
        for i = 1:size(eachcycle,2)
            hold on
            plot(GaitCycle, rad2deg(eachcycle(:,i)), 'y-');
            alpha(.1)
            plot(GaitCycle, rad2deg(target), 'r')
            plot(linspace(0, 100, size(average, 1)), rad2deg(average), 'b')
            ylabel('Angle (degree)')
            xlabel('% Gait Cycle')
            
            
        end
    end
end

