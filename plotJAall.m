function plotJAall(target, average, eachcycle)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    
    GaitCycle = linspace(0, 100, size(target, 1));
    
    figure 
    if nargin < 3
        %Plot only averages
        plot(GaitCycle, targetm, 'k')
        plot(GaitCycle, average, 'b')

    else
        % plot each cycle as well
        for i = 1:size(eachcycle,2)
            hold on
            plot(GaitCycle, eachcycle(:,i), 'y-');
            alpha(.1)
            plot(GaitCycle, target, 'r')
            plot(linspace(0, 100, size(average, 1)), average, 'b')
            ylabel('Angle (rad)')
            xlabel('% Gait Cycle')
            
            
        end
    end
end

