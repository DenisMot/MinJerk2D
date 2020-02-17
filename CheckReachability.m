function isAllwaysReachable = CheckReachability(x, y, L1, L2) 
% return true if the trajectory x y does stays allways within the reachable
% space for a 2 links arms with lengths L1, L2 (and root at 0 0) 

% initialisations
isAllwaysReachable = true; 
MaxReachableDistance = L1 + L2; 


if any(sqrt(x.^2 + y.^2) > MaxReachableDistance)
    theta1 = ErrOut;
    theta2 = ErrOut;
    warning('Trajectory passes at a non reachable position (too far)')
    isAllwaysReachable = false; 
end

MinReachableDistance = abs(L1 - L2); 
if any(sqrt(x.^2 + y.^2) < MinReachableDistance)
    theta1 = ErrOut;
    theta2 = ErrOut;
    warning('Trajectory passes at a non reachable position (too close)')
    isAllwaysReachable = false; 
end
    
end
