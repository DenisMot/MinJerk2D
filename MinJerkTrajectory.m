function [x, y] = MinJerkTrajectory(t0, x0, y0, tf, xf, yf)
% computes the minimum jerk position timeseries in 2D over time t
%   x0, y0 : initial position,
%   xf, yf : final position
%   t0 : initial time 
%   tf : final time 
%
%   x,y  : position (sampled at 100Hz, column vector)
%   t    : time     (sampled at 100Hz, column vector)

[x, t] = MinJerkPositionTimeSeries(x0, xf, t0, tf);
[y, t] = MinJerkPositionTimeSeries(y0, yf, t0, tf);

end
