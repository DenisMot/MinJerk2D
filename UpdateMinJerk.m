function UpdateMinJerk(~, ~, hDrawnArm, L, phi, xShift, yShift, t0, tf)
% callback for 'WindowButtonUpFcn' in figure
% update arm configuration with a movement towards the clicked position

% get the position of the clic
axes_handle = gca;
pt = get(axes_handle, 'CurrentPoint');

% set final position to the clicked point
xf = pt(1,1);
yf = pt(1,2);

% get the current position of the hand, from last segment
hLastLink = hDrawnArm(end);    % handle to last Link
xx = get(hLastLink, 'XData');  % all the Xdata
yy = get(hLastLink, 'YData');

% set initial position to the last x,y = previous end position
x0 = xx(end);
y0 = yy(end);

% Computate arm trajectory 
[ArmX, ArmY] = ArmTrajectory(x0, y0, t0, xf, yf, tf, L, xShift, yShift);

%% Animation :
shg;                    % should be useless...
hold on                 % add the animation on the previous graph

% show the trajectory as dotted line if "not reachable"
AtLeastOneNanInArm = any(isnan(ArmX(:))); 
if AtLeastOneNanInArm
 
    % crossing the non reacheable zone creates some nan 
    hp = plot([x0, xf], [y0, yf], '-.k');
    drawnow;            % draw
    pause(1);           % wait for one second
    delete(hp);         % and delete
else
    % animation of the 2 links system (every 10 lines)
    HH = [];                % (future) array of handles
    tic;                    % Time counter
    
    nTimeSamples = size(ArmX, 1);
    for i = 2:10:nTimeSamples
        % move the arm to the next position
        % MoveArmTo(hDrawnArm, Arm(i, :) );  % This is the animation
        MoveArmTo(hDrawnArm, ArmX(i,:), ArmY(i,:) );  % This is the animation

        
        pause(0.05)        % to get the right rhythm (on my machine)
        % draw a trace of the previous arm configurations
        HH = [HH; plot(ArmX(i, :), ArmY(i, :), '-k') ];
        drawnow             % display
    end
    fprintf('Animation (Movement time): %0.2f sec\n', toc);
    
    %% remove the trace of the movement
    pause(1)                % wait before cancelling the trace
    for i = 1:length(HH)
        delete(HH(i))
    end
    
end

end
