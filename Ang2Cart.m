
function [x2, y2, x1, y1] = Ang2Cart(theta1, theta2, L1, L2) 
% computes the position of extremes of Links 1 and 2 

% From "Planar example" in 
% http://courses.csail.mit.edu/6.141/spring2011/pub/lectures/Lec14-Manipulation-II.pdf

x1 = L1 .* cos(theta1);
y1 = L1 .* sin(theta1);
x2 = x1 + L2 .* cos(theta1+theta2);
y2 = y1 + L2 .* sin(theta1+theta2); 

end

