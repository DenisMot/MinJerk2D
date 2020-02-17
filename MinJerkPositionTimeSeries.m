function [x, t] = MinJerkPositionTimeSeries(x0, xf, t0, tf)
% computes the minimum jerk position timeseries x over t
%   x0 : initial position,
%   xf : final position
%   t0 : initial time 
%   tf : final time 
%
%   x : position (sampled at 100Hz, column vector)
%   t : time     (sampled at 100Hz, column vector)

% argument check
if ~isscalar(x0) error('x0 should be a scalar'); end
if ~isscalar(xf) error('xf should be a scalar'); end
if ~isscalar(t0) error('t0 should be a scalar'); end
if ~isscalar(tf) error('tf should be a scalar'); end


x0 = x0(1); % avoid vectors... if any (OPTION: manage vectors...)

% scale of the movement
MvtTime = tf - t0;    % distance in time
MvtDist = xf - x0;    % distance in space

% build time for the simulation
SamplingFreq  = 100;            % sampling frequency (100hz)
t = 0:1/SamplingFreq:MvtTime;   % time (in sec)
t = t';                         % easier to manipulate in plots etc...

taux= t/MvtTime;                % percentage of movement time (unitless)
t = t + t0;                     % time (in sec) ++ after computing taux!

% min jerk equation (depends only on unitless time)
Equation = 10 .* taux.^3 - 15 .* taux.^4 + 6 .* taux.^5 ;

% trajectory : rescale the equation wrt distance travelled
Trajectory  = MvtDist .* Equation;

% position : take care of starting coordinate
x = x0 + Trajectory;

if size(x, 2) > size(x,1) % to get column vector
    x = x';
end

end
