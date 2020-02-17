
function h =  MoveArmTo(h, X, Y)
% move the plot of the arm to the positions in XY 
% XY contains the time series of the coordinates of the points 
%   - within each raw : X, then Y cartesian coordinates 
%   - each row corresponds to a time along the trajectory  
% h is the handle to the corresponding plot
% NB : h should be initialized with the right number of points 


% XY coordinates are arranged into a line vector
% This allows to pile coordinates in a matrix, where each line is the
% coordinates at time t.
% In each line of XY, the first half is X and the second is Y 
% [r, c] = size(X); 
% nPoints = c ./ 2; 

[r, nPoints] = size(X); 

% X = XY(1, 1:nPoints );      % x coordinates of the points in the arm
% Y = XY(1, nPoints+1 : c );  % y coordinates of the points in the arm

% Security : check coherence before moving the arm in the plot... 
nLinks = nPoints - 1 ;
nLinksInPlot = size(h, 1); 
if nLinks ~= nLinksInPlot
    warning('Links are different in the plot and call to MoveArmTo...')
    nLinks = min([nLinks, nLinksInPlot]); 
end 

% move the arm in the plot

for i = 1 : nLinks
    % each link is from the current to the next point 
    set(h(i), 'XData', X(i:i+1), 'YData', Y(i:i+1) );
end

end
