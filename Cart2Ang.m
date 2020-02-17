
function [theta1, theta2] = Cart2Ang(x, y, L1, L2) 
% compute the 2 angles of a 2 joints system wiht length L1 and L2 when the
% end of Link 2 is located at x,y 


ErrOut = ones(size(x)) + nan; 


%% Reacheability check... 
MaxReachableDistance = L1 + L2; 
if any(sqrt(x.^2 + y.^2) > MaxReachableDistance)
    theta1 = ErrOut;
    theta2 = ErrOut;
    warning('Trajectory passes at a non reachable position (too far)')
    return
end
MinReachableDistance = abs(L1 - L2); 
if any(sqrt(x.^2 + y.^2) < MinReachableDistance)
    theta1 = ErrOut;
    theta2 = ErrOut;
    warning('Trajectory passes at a non reachable position (too close)')
    return
end

%% Calculation of theta2 (from cosine laws = Al-Kashi theorem)
% From p 28 and 31 "Planar example" in 
% http://courses.csail.mit.edu/6.141/spring2011/pub/lectures/Lec14-Manipulation-II.pdf
theta2 = acos( ( (x.^2 + y.^2) - L1.^2 - L2.^2) ./ (2 * L1 * L2) ); 

%% Calculation of theta1 (from 2 embeded angles : see ref for picture) 
% From p 32 in  
% http://web.eecs.umich.edu/~ocj/courses/autorob/autorob_10_ik_closedform.pdf

% blue   = atan( y ./ x ) ;   
% green  = atan( L2 .* sin (theta2) ./ (L1 + L2 .* cos(theta2)) );

% better continuity with atan2 (same quadrant) 
blue   = atan2( y , x ) ;   
green  = atan2( L2 .* sin (theta2) , (L1 + L2 .* cos(theta2)) );
theta1 = blue - green ; 

end

