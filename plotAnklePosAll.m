function plotAnklePosAll(ref, ave, ec)
% Plots ankle positons of 
%   
    
    xlim( [ 1.5 * min(ref.TargetX) 1.8 * max(ref.TargetX)] )
    ylim( [ 1.1 * min(ref.TargetY) 0.8 * max(ref.TargetY)] )
    
    
    if nargin < 3
        %Plot only averages
        hold on,
        p1 = plot(ref.TargetX, ref.TargetY, 'r', 'Linewidth', 2);
        p2 = plot(ave.x, ave.y, 'b', 'LineWidth', 2);
        p3 = plot(ref.BaselineX, ref.BaselineY, 'g', 'LineWidth', 2);
        legend( [ p3, p1, p2 ], 'Baseline', 'Target', 'Average')
        set(gca, 'FontSize', 16.0, 'LineWidth', 2.0)
        hold off

    else
        % plot each cycle as well
        %figure
        hold on
        for i = 1:size(ec.x,2)
            p1 = plot(ec.x(:,i), ec.y(:,i), 'y-'); %yl;
            alpha(.1)
        end
        p2 = plot(ref.TargetX, ref.TargetY, 'r', 'Linewidth', 2); %yl;
        p3 = plot(ave.x, ave.y, 'b', 'Linewidth', 2); %yl;
        p4 = plot(ref.BaselineX, ref.BaselineY, 'g', 'Linewidth', 2); %yl;
        legend([p4,  p2, p3, p1], 'Baseline', 'Target', 'Average', 'Each Cycle')
        set(gca, 'FontSize', 16.0, 'LineWidth', 2.0)
        hold off
    end
    

    
end

