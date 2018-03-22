
%get g from excel
figure, hold on
barh(g, 1, 'grouped', 'LineWidth', 1.5), xlim([-.18 .18]), ylim([0.5 8.5]) 
legend('Lap 1-3', 'Lap 1-6', 'Location', 'southeast'), legend('boxoff')
set(gca, 'FontSize', 16.0, 'LineWidth', 2)
ylabel('Subject number'), xlabel('% Change in Deviation Area')
