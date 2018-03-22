function plotJASelected( vector, color )

plot(linspace(0, 100, length(vector)), vector, color);
xlabel('% Gait Cycle')
ylabel('Angle (degree)')

end