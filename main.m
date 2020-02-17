% simulation of a movement with minimun jerk in 2D

%initialisation
close all; clear all;

% characteristics of the two links system (geometry and mechanics)
% NB :Position of the root of the kinematic chain is [0, 0]
L1 = 0.45;   % m         length of first Link
L2 = 0.35;   % m         length of second Link
L3 = 0.25;   % m         length of third Link

L  = [ L1, L2, L3 ]; 



% M1 = 0.9;    % kg        mass of first Link
% M2 = 1.1;    % kg        mass of second Link
% S1 = 0.11;   % m         distance of inertia center of first link
% S2 = 0.15;   % m         distance of inertia center of second link
% I1 = 0.065;  % kg*m^2    momentum of inertia of first link
% I2 = 0.1;    % kg*m^2    momentum of inertia of second link
% b1 = 0.08;   % kg*m^2/s  viscosity coefficient of first link
% b2 = 0.08;   % kg*m^2/s  viscosity coefficient of first link

% characteristics of the (first) movement in time and space
tf = 0.75;   % s         time of end of movement
t0 = 0.00;   % s         time of start of movement
x0 = 0.20;   % m         position of start of movement along x
y0 = 0.38;   % m         position of start of movement along y
xf = 0.30;   % m         position of end of movement along x
yf = 0.25;   % m         position of end of movement along y


% Configuraiton of Link3 
phi =  0 ;       % orientation of Link3 (from vertical) 

% reasonable stating point 
phi = 0 ;  x0 = 0.6 ; y0 = 0.6; 


% END intialisation


% shift from last link to previous link (last link orientaion is fixed) 
xShift = L(3) .* cos(phi + pi()./2); % phi is from vertical axis
yShift = L(3) .* sin(phi + pi()./2); % phi is from vertical axis


% Computate arm trajectory 
[ArmX, ArmY] = ArmTrajectory(x0, y0, t0, xf, yf, tf, L, xShift, yShift);


%% plot animation showing the motion of the arm
figure
 

% define the reachable zone (with the 2 mobile links) betwen 2 circles
rMax = L1 + L2;         % max reachable circle (arm extended)
rMin = abs(L1 - L2);    % non reachable circle (too close to the root)

% shift the origin of reachable zone (due to the third link)
% rectangles are [x y w h] 
CircleTooClose = [-rMin + xShift, -rMin + yShift, 2*rMin, 2*rMin] ; 
CircleTooFar   = [-rMax + xShift, -rMax + yShift, 2*rMax, 2*rMax] ; 

% draw the background 
plot(0,0, '.k')     % first, we need a plot to configure... 

% set the limits to accomodate whatever orientation of the last link
set(gca, 'XLim',  [ -sum(L) sum(L)] + xShift); 
set(gca, 'YLim',  [ -sum(L) sum(L)] + yShift); 

% draw the reachable zone 
rectangle('Position', CircleTooFar,'Curvature',[1,1], ...
    'edgecolor', 'red');
rectangle('Position', CircleTooClose,'Curvature',[1,1], ...
    'edgecolor', 'red');
text(0, yShift + rMax/2, 'reachable zone', 'color', 'red', ...
    'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'Center')

% setup teh figure properly 
xlabel('x (m)'); ylabel('y (m)')
axis equal ; grid on

hold on   % We add the animation on the previous graph 

% Initial drawing of the links system
% make a stupid plot, just to set the links and colors
hArm = plot([0, 0 ], [0, 0 ], '.-k', [0, 0 ], [ 0 0 ], '.-b', [0, 0 ], [ 0 0 ], '.-c');
set(hArm, 'MarkerSize', 50, 'LineWidth', 6);

% move the arm to the first position
% MoveArmTo(hh2, Arm(1,:) );   
MoveArmTo(hArm, ArmX(1,:), ArmY(1,:) );   

% to allow for interactive positioning of endpoint with clic
set(gcf, 'WindowButtonUpFcn',{@UpdateMinJerk, hArm, [L1, L2, L3], phi, xShift, yShift, t0, tf } );
title('Clic to move the hand')

shg
