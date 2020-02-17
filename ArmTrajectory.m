function [ArmX, ArmY] = ArmTrajectory(x0, y0, t0, xf, yf, tf, L, xShift, yShift)
% computes the arm configuration time series over the trajectory
% computes the minimum jerk position timeseries in 2D over time t
%   x0, y0 : initial position,
%   xf, yf : final position
%   t0 : initial time 
%   tf : final time 
%   L  : length of each link 
%   xShift, yShift : coordinate shift due to constant link3 orientation
%
%   ArmX, ArmY : position of arm joints (sampled at 100Hz, column vector)


% simulation of end effector motion (time series in x and y)
[x, y] = MinJerkTrajectory(t0, x0, y0, tf, xf, yf); 

% compute the position of Link2, knowing, Link3 orientation and position
% Link3 has a fixed orientation => simple shift from Link3 to Link2 
x2 = x - xShift; 
y2 = y - yShift;

% compute angles (geometry) for Link1 and Link2
[th1, th2] = Cart2Ang(x2, y2, L(1), L(2)) ;

% arm root does not move over time
ArmRoot = zeros(size(x)); 

% compute the cartesian coordinates of the arm
[x2, y2, x1, y1] = Ang2Cart(th1, th2, L(1) , L(2)); 

% return in a format easier for plots etc...
ArmX = [ArmRoot, x1, x2, x]; 
ArmY = [ArmRoot, y1, y2, y]; 

end