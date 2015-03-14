close all;
clear;
clc;

M = [0.8, 0.2, 0.0; 
     0.4, 0.4, 0.2;
     0.2, 0.6, 0.2];
 
M = M';

numberOfDays = 1000;
                       
initialCondition = [1; 0; 0];
                       
[days, stationary] = weather_simulation(M, numberOfDays, initialCondition);

%display(days);
display(stationary);


[u, s] = eig(M);

stationaryHat = u(:, 1) / sum(u(:, 1));

display(stationaryHat);

% Desire Board
% N = 1000
% s r c r r s s r c c c s r r

% stationary = [#s/N; #c/N; #r/N];

% eigenvalue of M, corresponding to delta = 1;

%----------

% Entropy ?
% grapy, that histogramized
% x = [x1; .. .. .. xn];

% H(x) = - SumSymbol(i=1 to n) x_{i} * log(x_{i})






