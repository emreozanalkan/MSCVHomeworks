%1DOF ROBOT LOCALIZATION IN A CIRCULAR HALLWAY USING A EKF
function KFPositionAndVelocity1DOFRobotInTheHallway
clear all; close all;
global frame figure_handle plot_handle firstTime ;

fprintf('Loading the animation data...\n');
load animation;
fprintf('Animation data loaded\n');

% Algorithm parameters
simpar.DEBUG=0;                                         % 1:yes, 0:no
simpar.circularHallway=1;                               % 1:yes, 0:no
simpar.animate=1;                                       % 1: Draw the animation of the gaussian. 0: do not draw (speed up the simulation)
simpar.nSteps=500;                                      % number of steps of the algorithm
simpar.domain = 850;                                    % Domain size (in centimeters)
simpar.xTrue_0=[mod(abs(ceil(simpar.domain*randn(1))),850); -20];
simpar.wk_stdev=1;                                      % stddev of the noise used in acceleration to simulate the robot movement.
simpar.door_locations = [222,326,611];                  % Position of the doors (in centimetres). This is the Map definition.
simpar.door_stdev=90/4;                                 % +-2sigma of the door observation is assumend to be 90 cm which is the wide of the door
simpar.odometry_stdev = 2;                              % Odometry uncertainty. Std. deviation of a Gaussian pdf. [cm]
simpar.sonar_stdev = 20;                              % Odometry uncertainty. Std. deviation of a Gaussian pdf. [cm]
simpar.T=0.5;                                             % Simulation sample time
simpar.failure_step=simpar.nSteps/2;               % a sonar failure will be included at that step
simpar.failure_gap=50;                                      % the sonar failure will elapse for this number of steps

% COMPLETE THIS LINES WITH THE CORRECT VALUES OF THE KF
simpar.Hk=1;                                               % Hk matrix of the KF
simpar.Ak=1;                                                % Ak matrix of the KF
simpar.Bk=1;                                                % Bk matrix of the KF
simpar.Qk=1;                                                % twice the real uncertainty of the odometry displacement [m]
simpar.Rk=1;                                                 %  twice the real uncertainty of the sonar measurement of the position [m]

% Fix the position of the figure to the up left corner
% Fix the size depending on the screen size
scrsz = get(0,'ScreenSize');
figure_handle=figure('Position',[0 0 scrsz(3)/3.5 scrsz(4)]);

firstTime=ones(5);                                      % needed for graphic potting

xTrue_k=simpar.xTrue_0;                           % initialize simulation
xTrue_k_1=xTrue_k;

Qk=simpar.Qk;
Rk=simpar.Rk;

% Initial Robot belief is generated from the normal distribution with a huge
% stdev aproximating hence a
xk = xTrue_k(1); xk_1=xk;                           % initialize estimation
Pk = (10000)^2; Pk_1=Pk;                             % big stdev means almost flat bell = unkonw robot pose

% The localization algorithm starts here %%%%%%%%%%%%%%%%%%%%%%%%%%%%
for k = 1:simpar.nSteps
    DrawRobot(xTrue_k(1), simpar);                   %Plots the robot

    xTrue_k_1=xTrue_k;
    xTrue_k=SimulateRobot(xTrue_k_1,simpar);  %Simulates the robot movement

    uk=get_odometry(xTrue_k,xTrue_k_1,simpar);
    
    zk=get_measurements(k,xTrue_k,xTrue_k_1,simpar); % ck=1 if door detected, 0 otherwise    
        
    if simpar.DEBUG, fprintf('main: xTrue_k=%d XTrue_k_1=%d zk=%d uk=%f \n',xTrue_k,xTrue_k_1,zk,uk); end

    % Aplies the KF  to localize the robot and draws the gaussians in the figure
    [xk, Pk]=KF(xk_1,Pk_1,uk,Qk,zk,Rk,simpar);
    
    xk_1=xk;
    Pk_1=Pk;
end
% The Localization Algorith ends here %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Simulate how the robot moves %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function xTrue_kNew=SimulateRobot(xTrue_k, simpar)
%We will need to update the robot position here taking into account the
%noise in acceleration
wk=randn(1)*simpar.wk_stdev;
xTrue_kNew = [1 simpar.T; 0 1]* xTrue_k + [simpar.T^2/2; simpar.T] * wk;

if simpar.circularHallway,
    % the hallway is assumed to be circular
    xTrue_kNew(1)=mod(xTrue_kNew(1),simpar.domain);
else
    % the hallway is assumed to be linear
    if xTrue_kNew(1)>simpar.domain
        xTrue_kNew(1) = simpar.domain-mod(xTrue_kNew(1),simpar.domain);
        xTrue_kNew(2) = -xTrue_kNew(2); % change direction of motion
    end
    if xTrue_kNew(1)<0
        xTrue_kNew(1) = -xTrue_kNew(1);
        xTrue_kNew(2) = -xTrue_kNew(2); % change direction of motion
    end
end

%Simulates the odometry measurements including noise%%%%%%%%%%%%%%%%%%
function uk=get_odometry(xTrue_k,xTrue_k_1,simpar)
uk=xTrue_k(1)-xTrue_k_1(1)+simpar.odometry_stdev*randn(1);

%Simulates the  absolute measurement of the robot pos using the sonar %%%%%%%%%%%%%%%%
function zk=get_measurements(k,xTrue_k,xTrue_k_1,simpar)
if k<simpar.failure_step || k>simpar.failure_step+simpar.failure_gap 
    zk = xTrue_k(1)+ sqrt(simpar.Rk) * randn(1);
else
    fprintf('get_measurements: SONAR FAILURE BEING SIMULATED\n');
    zk=[];
end

% Draws the robot
function DrawRobot(x, simpar)
global frame figure_handle

if simpar.animate
    figure(figure_handle);
    x = mod(x,simpar.domain);
    i=x*332/simpar.domain;

    % keep the frame within the correct boundaries
    if  i<1, i=1; end;
    if i>332, i=332; end;    if  i<1, i=1; end;

    subplot(5,1,1);
    image(frame(ceil(i)).image);  %axis equal;
end
drawnow;

%Plots a pdf %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Draw_pdf(sp,label,pdf_values,simpar)
global figure_handle

if simpar.animate
    figure(figure_handle);
    subplot(5,1,sp);
    plot([0:simpar.domain],pdf_values,'-b');
    axis([0 simpar.domain 0 max(pdf_values)]);
    xlabel(label);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%   COMPLETE THESE FUNCTION  %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Aplies the MCL algorithm and plots the results
function  [xk, Pk]=KF(xk_1,Pk_1,uk,Qk,zk,Rk,simpar);
% COMPLETE THIS FUNCTION
% This lines must be replaced by your solution to the EKF localization
% problem. They are provided only to allow for the execution of the program
% before solving the lab.
xk_hat=xk_1;
Pk_hat=Pk_1;
xk=xk_1;
Pk=Pk_1;


% plotting the pdfs for the animation
Draw_pdf(2,'prior',pdf('norm',0:simpar.domain,xk_1, sqrt(Pk_1)),simpar);
Draw_pdf(3,'predict',pdf('norm',0:simpar.domain,xk_hat, sqrt(Pk_hat)),simpar);
if ~isempty(zk),
    Draw_pdf(4,'measurement model',pdf('norm',0:simpar.domain,zk,sqrt(Rk)),simpar);
else
    Draw_pdf(4,'measurement model',pdf('uniform',0:simpar.domain,0,simpar.domain),simpar);
end
Draw_pdf(5,'update',pdf('norm',0:simpar.domain,xk_hat,sqrt(Pk_hat)),simpar);


