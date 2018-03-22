function [RMSE, RMSE_min, RMSE_max, RMSE_range] = RMSError( y, yhat )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

RMSE = sqrt(mean((y - yhat).^2));  % Root Mean Squared Error
RMSE_min = min(RMSE(:));
RMSE_max = max(RMSE(:));
RMSE_range = RMSE_max - RMSE_min;

end

