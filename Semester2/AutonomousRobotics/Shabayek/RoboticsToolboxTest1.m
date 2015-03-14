%% Navigation initial values
clear all;
close all;
clc;

goal = [50; 30];
start = [20; 10];

load map1;

%% Bug2 - Avoide obstacles
bug = Bug2(map);
bug.goal = goal;
%bug.visualize();
bug.plot();
%bug.path(start);
bug.path();

%% DXform Distance transform - Minumum distance
dx = DXform(map);
dx.plan(goal);
dx.plot();
dx.path(start); % show the motion
dx.plan(goal, 0.1); % shows the distance values propagat
% p = dx.path(start);
% dx.plot(p);
% numrows(p)

%% Dstar The distance trasnform navigation algorithm. This
% distance paths and facilitates incremental replanning
ds = Dstar(map);
% c = ds.costmap();
ds.plan(goal);
% ds.niter
ds.path(start);

for y = 78:85
    for x = 12:45
        ds.modify_cost([x, y], 2);
    end
end

ds.plan();

figure, ds.path(start);

%% Generalized Voronoi diagram
free = 1 - map; % Find the free space in the map (the complementary)

free(1, :) = 0;
free(100, :) = 0; % The boundry is also an

free(:, 1) = 0;
free(:, 100) = 0;

skeleton = ithin(free); % Apply morphological thinning

junctions = itriplepoint(skeleton);

subplot 221, imshow(map), title('Map')
subplot 222, imshow(free), title('free cells')
subplot 223, imshow(skeleton), title('skeleton')
subplot 224, imshow(junctions), title('junctions')

%% Voronoi
% sites = rand(10, 2);
% voronoi(sites(:, 1), sites(:, 2))

%% PRM Probabilistic roadmap navigation class
randinit;
prm = PRM(map);
prm.plan();
prm
prm.plot(); % visualize()
goal = [50; 30];
start = [20; 10];
prm.path(start, goal);
% p = prm.path(start, goal);
% numcols(p)
% randinit

% map_new = imorph(map, kcircle(3), 'max');
% figure, subplot 121, imagesc(map), subplot 122, imagesc(map_new);

%% RRT rapidly-exploring random tree navigation
rrt = RRT();
rrt.plan();
rrt.plot(); % visualize();
% p = rrt.path([-5 -4 0], [5 4 -0.5]);
% p = rrt.path([0 0 0], [0 2 0]); % a bug inside the PGraph
% about(p);
% figure, plot2(p');
% iprint('rrt_path2'); % iprint is missing

%% Ch 6 Localization
%% Dead Reckoning
V = diag([0.02, 2*pi/180].^2); % sigmad = 2cm, sigmaTheta  = 2
veh = Vehicle(V);
% odo = veh.step(1, 0.3); % speed of 1ms^-1, steering angle
% veh
% odo = veh.step(1, 0.3);
% veh
veh.add_driver(RandomPath(10)); % RandomPath is a class d
veh.run(); % Display an animation of the robot with its dri
% veh.Fx([0, 0, 0], [0.5, 01]) % Jakobian with respect to
P0 = diag([0.005, 0.005, 0.001].^2); % Covariance matrix fo
ekf = EKF(veh, V, P0);
ekf.run(1000); % run the filter for 1000 steps
veh.plot_xy(); % true path stored within the Vehicle of
hold on;
ekf.plot_xy('r'); % estimates path stored with the EKF
% P700 = ekf.history(700).P % Covariance matrix, diagonal
% sqrt(P700(1, 1)) % The standart deviation of the PDF
ekf.plot_ellipse([], 'g');
figure, ekf.plot_P(); % the total uncertainty, position

%% Using a Map
% Generating a man and modeling a sensor
map = Map(20, 10); % Contains N = 20 features uniformly randomly spread over
map.plot(); % Display the map
W = diag([0.1, 1*pi/180].^2); % sensor uncertainty segmaRange = 0.1m, sigma
sensor = RangeBearingSensor(veh, map, W); % Mod..
[z, i] = sensor.reading(); % Provides the range
map.feature(i); % the position of feature number

%% 
% Build an estimator that uses odometry and
map = Map(20);
veh = Vehicle([]); % error free vehicle
veh.add_driver(RandomPath(map.dim));
W = diag([0.1, 1*pi/180].^2);
sensor = RangeBearingSensor(veh, map, W);
ekf = EKF(veh, [], [], sensor, W, []);
ekf.run(1000); % Internally the EKF object
map.plot(); % true landmark positions 
ekf.plot_map(5, 'g'); % 5sigma confidence
veh.plot_xy('b'); % true path taken
figure, spy(ekf.P_est); % covariance matrix
% ekf.features(:, 10) % shows the location of
% ekf.x_est(19:20)' % estimated location
% ekf.P_est(19:20, 19:20) % estimated covariance

%% Simultaneous Localization and Mapping (SLAM)
P0 = diag([.01, .01, 0.005].^2); % The initial
map = Map(20);
W = diag([0.1, 1*pi/180].^2);
veh = Vehicle(W);
veh.add_driver(RandomPath(map.dim));
sensor = RangeBearingSensor(veh, map, W);
V = diag([0.02, 2*pi/180].^2);
ekf = EKF(veh, V, P0, sensor, W, []); % Empty
ekf.run(1000);
map.plot();
ekf.plot_map(5, 'c');
ekf.plot_xy('r');
ekf.plot_xy('b');
ekf.plot_ellipse([], 'g');
figure, spy(ekf.P_est);

% Monte Carlo - Particle Filter Localization

% no idea of its initial location
map = Map(20);
W = diag([0.1, 1*pi/180].^2);
veh = Vehicle(W); % Robot with noisy odometry
veh.add_driver(RandomPath(10));
V = diag([0.005, 0.5*pi/180].^2);
sensor = RangeBearingSensor(veh, map, V); %
% For the particle filter we need to define
Q = diag([0.1, 0.1, 1*pi/180].^2); % The cova
L = diag([0.1 0.1]); % Covariance of the like
pf = ParticleFilter(veh, sensor, Q, L, 1000);
pf.run(1000):
map.plot();
veh.plot_xy('b'); % True robot path
pf.plot_xy('r'); % Overly the mean of the part
% figure , plot(pf.std(1:100, :)); % standart 
% pf.plot_pdf();























